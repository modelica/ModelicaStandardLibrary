within Modelica.Mechanics.Rotational.Components;
model OneWayClutch "Parallel connection of freewheel and clutch"
  extends Modelica.Mechanics.Rotational.Icons.Clutch;
  extends Modelica.Mechanics.Rotational.Interfaces.PartialCompliantWithRelativeStates;

  import Modelica.Blocks.Types.{ExternalCombiTable1D, Extrapolation, Smoothness};
  import Modelica.Blocks.Tables.Internal.{getTable1DValue, getTable1DValueNoDer, getTable1DValueNoDer2};

  parameter Real mu_pos[:, 2] = [0, 0.5]
    "Positive sliding friction coefficient [-] as function of w_rel [rad/s] (w_rel>=0)";
  parameter Smoothness smoothness = Smoothness.LinearSegments
    "Smoothness of table interpolation in mu_pos";
  parameter Real peak(final min=1) = 1
    "Peak for maximum value of mu at w==0 (mu0_max = peak*mu_pos[1,2])";
  parameter Real cgeo(final min=0) = 1
    "Geometry constant containing friction distribution assumption";
  parameter SI.Force fn_max(final min=0, start=1) "Maximum normal force";
  parameter SI.AngularVelocity w_small=1e10
    "Relative angular velocity near to zero if jumps due to a reinit(..) of the velocity can occur (set to low value only if such impulses can occur)"
    annotation (Dialog(tab="Advanced"));
  extends Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPortWithoutT;

  Real u "Normalized force input signal (0..1)";
  Real mu "Friction coefficient";
  SI.Force fn "Normal force (fn=fn_max*inPort.signal)";
  Boolean startForward(start=false)
    "= true, if w_rel=0 and start of forward sliding or w_rel > w_small";
  Boolean locked(start=false) "= true, if w_rel=0 and not sliding";
  Boolean stuck(start=false) "w_rel=0 (locked or start forward sliding)";

protected
  SI.Torque tau0 "Friction torque for w=0 and sliding";
  SI.Torque tau0_max "Maximum friction torque for w=0 and locked";
  final parameter ExternalCombiTable1D tableID = ExternalCombiTable1D(
    tableName="NoName",
    fileName="NoName",
    table=mu_pos,
    columns={2},
    smoothness=smoothness,
    extrapolation=Extrapolation.LastTwoPoints,
    verboseRead=false) "External table object for sliding friction coefficient";
  final parameter Real mu0 =
    if     smoothness == Smoothness.ConstantSegments then getTable1DValueNoDer(tableID, 1, 0)
    elseif smoothness == Smoothness.LinearSegments   then getTable1DValueNoDer2(tableID, 1, 0)
    else                                                  getTable1DValue(tableID, 1, 0)
    "Friction coefficient for w=0 and sliding";
  Boolean free "= true, if frictional element is not active";
  Real sa(final unit="1")
    "Path parameter of tau = f(a_rel) Friction characteristic";
  constant Real eps0=1.0e-4 "Relative hysteresis epsilon";
  final parameter SI.Torque tau0_max_low = eps0*mu0*cgeo*fn_max
    "Lowest value for tau0_max";
  parameter Real peak2=max([peak, 1 + eps0]);
  constant SI.AngularAcceleration unitAngularAcceleration=1;
  constant SI.Torque unitTorque=1;

public
  Modelica.Blocks.Interfaces.RealInput f_normalized
    "Normalized force signal 0..1 (normal force = fn_max*f_normalized; clutch is engaged if > 0)"
    annotation (Placement(transformation(
        origin={0,110},
        extent={{20,-20},{-20,20}},
        rotation=90)));

equation
  assert(size(mu_pos, 1) > 0 and size(mu_pos, 2) > 0, "Parameter mu_pos is an empty matrix");

  // Normal force and friction torque for w_rel=0
  u = f_normalized;
  free = u <= 0;
  fn = if free then 0 else fn_max*u;
  tau0 = mu0*cgeo*fn;
  tau0_max = if free then tau0_max_low else peak2*tau0;

  /* Friction characteristic
       (locked is introduced to help the Modelica translator determining
       the different structural configurations, if for each configuration
       special code shall be generated)
    */
  startForward = pre(stuck) and (sa > tau0_max/unitTorque or pre(
    startForward) and sa > tau0/unitTorque or w_rel > w_small) or initial()
     and (w_rel > 0);
  locked = pre(stuck) and not startForward;

  // Acceleration and friction torque
  mu =
    if     smoothness == Smoothness.ConstantSegments then getTable1DValueNoDer(tableID, 1, w_rel)
    elseif smoothness == Smoothness.LinearSegments   then getTable1DValueNoDer2(tableID, 1, w_rel)
    else                                                  getTable1DValue(tableID, 1, w_rel);
  a_rel = unitAngularAcceleration*(if locked then 0 else sa - tau0/unitTorque);
  tau = if locked then sa*unitTorque elseif free then 0 else mu*cgeo*fn;

  // Determine configuration
  stuck = locked or w_rel <= 0;

  lossPower = if stuck then 0 else tau*w_rel;
  annotation (
    Icon(
        coordinateSystem(preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}),
          graphics={
        Text(extent={{-150,-110},{150,-70}},
          textString="%name",
          textColor={0,0,255}),
        Polygon(points={{-10,30},{50,0},{-10,-30},{-10,30}},
          fillPattern=FillPattern.Solid),
        Line(visible=useHeatPort,
          points={{-100,-99},{-100,-40},{0,-40}},
          color={191,0,0},
          pattern=LinePattern.Dot)}), Documentation(info="<html>
<p>
This component models a <strong>one-way clutch</strong>, i.e., a component with
two flanges where friction is present between the two flanges
and these flanges are pressed together via a normal force. These
flanges may be sliding with respect to each other.
</p>
<p>
A one-way-clutch is an element where a&nbsp;clutch is connected in parallel
to a&nbsp;free wheel. This special element is provided, because such
a parallel connection introduces an ambiguity into the model
(the constraint torques are not uniquely defined when both
elements are stuck) and this element resolves it by introducing
<strong>one</strong> constraint torque only instead of two constraints.
</p>
<p>
Note, initial values have to be chosen for the model such that the
relative speed of the one-way-clutch &ge;&nbsp;0. Otherwise, the configuration
is physically not possible and an error occurs.
</p>
<p>
The normal force&nbsp;fn has to be provided as input signal f_normalized in a normalized form
(0&nbsp;&le;&nbsp;f_normalized&nbsp;&le;&nbsp;1),
fn&nbsp;=&nbsp;fn_max&nbsp;*&nbsp;f_normalized, where fn_max has to be provided as parameter.
</p>
<p>
The friction in the clutch is modeled in the following way.
When the relative angular velocity is positive, the friction torque is a
function of the velocity dependent friction coefficient mu(w_rel), of
the normal force&nbsp;fn, and of a geometry constant cgeo which takes into
account the geometry of the device and the assumptions on the friction
distributions:
</p>

<blockquote><pre>
frictional_torque = <strong>cgeo</strong> * <strong>mu</strong>(w_rel) * <strong>fn</strong>
</pre></blockquote>

<p>
Typical values of coefficients of friction <strong>mu</strong>:
</p>
<ul>
  <li>0.2&nbsp;&hellip;&nbsp;0.4 for dry operation,</li>
  <li>0.05&nbsp;&hellip;&nbsp;0.1 when operating in oil.</li>
</ul>

<p>
The geometry constant is calculated - under the
assumption of a uniform rate of wear at the friction surfaces - in the following way:
</p>

<blockquote><pre>
<strong>cgeo</strong> = <strong>N</strong>*(<strong>r0</strong> + <strong>ri</strong>)/2
</pre></blockquote>

<p>
where <strong>ri</strong> is the inner radius,
<strong>ro</strong> is the outer radius and&nbsp;<strong>N</strong> is the number of friction interfaces,
</p>

<p>
The positive part of the friction characteristic <strong>mu</strong>(w_rel),
w_rel&nbsp;>=&nbsp;0, is defined via table mu_pos (first column = w_rel,
second column = mu).
</p>
<p>
When the relative angular velocity w_rel becomes zero, the elements
connected by the friction element become stuck, i.e., the relative
angle remains constant. In this phase the friction torque is
calculated from a torque balance due to the requirement that
the relative acceleration shall be zero. The elements begin
to slide when the friction torque exceeds a threshold value,
called the maximum static friction torque, computed via:
</p>

<blockquote><pre>
frictional_torque = <strong>peak</strong> * <strong>cgeo</strong> * <strong>mu</strong>(w_rel=0) * <strong>fn</strong>,   (<strong>peak</strong> >= 1)
</pre></blockquote>

<p>
This procedure is implemented in a \"clean\" way by state events and
leads to continuous/discrete systems of equations if friction elements
are dynamically coupled. The method is described in
(see also a short sketch in <a href=\"modelica://Modelica.Mechanics.Rotational.UsersGuide.ModelingOfFriction\">UsersGuide.ModelingOfFriction</a>):
</p>
<dl>
<dt>Otter M., Elmqvist H., and Mattsson S.E. (1999):</dt>
<dd><strong>Hybrid Modeling in Modelica based on the Synchronous
    Data Flow Principle</strong>. CACSD'99, Aug. 22.-26, Hawaii.</dd>
</dl>

<p>
See also the discussion
<a href=\"modelica://Modelica.Mechanics.Rotational.UsersGuide.StateSelection\">State Selection</a>
in the User's Guide of the Rotational library.
</p>
</html>"));
end OneWayClutch;
