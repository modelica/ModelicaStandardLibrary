within Modelica.Mechanics.Rotational.Components;
model BearingFriction "Coulomb friction in bearings"
  extends Modelica.Mechanics.Rotational.Interfaces.PartialElementaryTwoFlangesAndSupport2;

  import Modelica.Blocks.Types.{ExternalCombiTable1D, Extrapolation, Smoothness};
  import Modelica.Blocks.Tables.Internal.{getTable1DValue, getTable1DValueNoDer, getTable1DValueNoDer2};

  parameter Real tau_pos[:, 2]=[0, 1]
    "Positive sliding friction characteristic [N.m] as function of w [rad/s] (w>=0)";
  parameter Smoothness smoothness = Smoothness.LinearSegments
    "Smoothness of interpolation in tau_pos table";
  parameter Real peak(final min=1) = 1
    "Peak for maximum friction torque at w==0 (tau0_max = peak*tau_pos[1,2])";

  extends Rotational.Interfaces.PartialFriction;
  extends
    Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPortWithoutT;

  SI.Angle phi
    "Angle between shaft flanges (flange_a, flange_b) and support";
  SI.Torque tau "Friction torque";
  SI.AngularVelocity w "Absolute angular velocity of flange_a and flange_b";
  SI.AngularAcceleration a
    "Absolute angular acceleration of flange_a and flange_b";

protected
  final parameter ExternalCombiTable1D tableID = ExternalCombiTable1D(
    tableName="NoName",
    fileName="NoName",
    table=tau_pos,
    columns={2},
    smoothness=smoothness,
    extrapolation=Extrapolation.LastTwoPoints,
    verboseRead=false) "External table object for sliding friction coefficient";

  Real table_signs[2]
    "Signs for sliding friction coefficient table interpolation: [sign for w, sign for tau]";

equation
  assert(size(tau_pos, 1) > 0 and size(tau_pos, 2) > 0, "Parameter tau_pos is an empty matrix");

  // Constant auxiliary variables
  tau0 =
    if     smoothness == Smoothness.ConstantSegments then getTable1DValueNoDer(tableID, 1, 0)
    elseif smoothness == Smoothness.LinearSegments   then getTable1DValueNoDer2(tableID, 1, 0)
    else                                                  getTable1DValue(tableID, 1, 0);
  tau0_max = peak*tau0;
  free = false;

  phi = flange_a.phi - phi_support;
  flange_b.phi = flange_a.phi;

  // Angular velocity and angular acceleration of flanges
  w = der(phi);
  a = der(w);
  w_relfric = w;
  a_relfric = a;

  // Friction torque
  flange_a.tau + flange_b.tau - tau = 0;

  // Friction torque
  table_signs =
    if     startForward         then { 1, 1}
    elseif startBackward        then {-1,-1}
    elseif pre(mode) == Forward then { 1, 1}
    else                             {-1,-1};
  tau = if locked then sa*unitTorque else table_signs[2]*(
    if     smoothness == Smoothness.ConstantSegments then getTable1DValueNoDer(tableID, 1, table_signs[1]*w)
    elseif smoothness == Smoothness.LinearSegments   then getTable1DValueNoDer2(tableID, 1, table_signs[1]*w)
    else                                                  getTable1DValue(tableID, 1, table_signs[1]*w));
  lossPower = tau*w_relfric;
  annotation (Documentation(info="<html>
<p>
This element describes <strong>Coulomb friction</strong> in <strong>bearings</strong>,
i.e., a frictional torque acting between a flange and the housing.
The positive sliding friction torque \"tau\" has to be defined
by table \"tau_pos\" as function of the absolute angular velocity \"w\".
E.g.
</p>
<blockquote><pre>
 w | tau
---+-----
 0 |   0
 1 |   2
 2 |   5
 3 |   8
</pre></blockquote>
<p>
gives the following table:
</p>
<blockquote><pre>
tau_pos = [0, 0; 1, 2; 2, 5; 3, 8];
</pre></blockquote>
<p>
Outside of the table, extrapolation through the last
two table entries is used. It is assumed that the negative
sliding friction force has the same characteristic with negative
values. Friction is modelled in the following way:
</p>
<p>
When the absolute angular velocity \"w\" is not zero, the friction torque
is a function of w and of a constant normal force. This dependency
is defined via table tau_pos and can be determined by measurements,
e.g., by driving the gear with constant velocity and measuring the
needed motor torque (= friction torque).
</p>
<p>
When the absolute angular velocity becomes zero, the elements
connected by the friction element become stuck, i.e., the absolute
angle remains constant. In this phase the friction torque is
calculated from a torque balance due to the requirement, that
the absolute acceleration shall be zero.  The elements begin
to slide when the friction torque exceeds a threshold value,
called the maximum static friction torque, computed via:
</p>
<blockquote><pre>
maximum_static_friction = <strong>peak</strong> * sliding_friction(w=0)  (<strong>peak</strong> >= 1)
</pre></blockquote>
<p>
This procedure is implemented in a \"clean\" way by state events and
leads to continuous/discrete systems of equations if friction elements
are dynamically coupled which have to be solved by appropriate
numerical methods. The method is described in
(see also a short sketch in <a href=\"modelica://Modelica.Mechanics.Rotational.UsersGuide.ModelingOfFriction\">UsersGuide.ModelingOfFriction</a>):
</p>
<dl>
<dt>Otter M., Elmqvist H., and Mattsson S.E. (1999):</dt>
<dd><strong>Hybrid Modeling in Modelica based on the Synchronous
    Data Flow Principle</strong>. CACSD'99, Aug. 22.-26, Hawaii.</dd>
</dl>
<p>
More precise friction models take into account the elasticity of the
material when the two elements are \"stuck\", as well as other effects,
like hysteresis. This has the advantage that the friction element can
be completely described by a differential equation without events. The
drawback is that the system becomes stiff (about 10-20 times slower
simulation) and that more material constants have to be supplied which
requires more sophisticated identification. For more details, see the
following references, especially (Armstrong and Canudas de Wit 1996):
</p>
<dl>
<dt>Armstrong B. (1991):</dt>
<dd><strong>Control of Machines with Friction</strong>. Kluwer Academic
    Press, Boston MA.<br></dd>
<dt>Armstrong B., and Canudas de Wit C. (1996):</dt>
<dd><strong>Friction Modeling and Compensation.</strong>
    The Control Handbook, edited by W.S.Levine, CRC Press,
    pp. 1369-1382.<br></dd>
<dt>Canudas de Wit C., Olsson H., &Aring;str&ouml;m K.J., and Lischinsky P. (1995):</dt>
<dd><strong>A new model for control of systems with friction.</strong>
    IEEE Transactions on Automatic Control, Vol. 40, No. 3, pp. 419-425.</dd>
</dl>
</html>"),
       Icon(
    coordinateSystem(preserveAspectRatio=true,
      extent={{-100.0,-100.0},{100.0,100.0}}),
      graphics={
    Rectangle(lineColor={64,64,64},
      fillColor={192,192,192},
      fillPattern=FillPattern.HorizontalCylinder,
      extent={{-100.0,-10.0},{100.0,10.0}}),
    Rectangle(extent={{-60.0,-60.0},{60.0,-10.0}}),
    Rectangle(fillColor={192,192,192},
      fillPattern=FillPattern.Solid,
      extent={{-60.0,-25.0},{60.0,-10.0}}),
    Rectangle(fillColor={192,192,192},
      fillPattern=FillPattern.Solid,
      extent={{-60.0,-61.0},{60.0,-45.0}}),
    Rectangle(fillColor={255,255,255},
      fillPattern=FillPattern.Solid,
      extent={{-50.0,-50.0},{50.0,-18.0}}),
    Polygon(fillColor={160,160,164},
      fillPattern=FillPattern.Solid,
      points={{60.0,-60.0},{60.0,-70.0},{75.0,-70.0},{75.0,-80.0},{-75.0,-80.0},{-75.0,-70.0},{-60.0,-70.0},{-60.0,-60.0},{60.0,-60.0}}),
    Line(points={{-75.0,-10.0},{-75.0,-70.0}}),
    Line(points={{75.0,-10.0},{75.0,-70.0}}),
    Rectangle(extent={{-60.0,10.0},{60.0,60.0}}),
    Rectangle(fillColor={192,192,192},
      fillPattern=FillPattern.Solid,
      extent={{-60.0,45.0},{60.0,60.0}}),
    Rectangle(fillColor={192,192,192},
      fillPattern=FillPattern.Solid,
      extent={{-60.0,10.0},{60.0,25.0}}),
    Rectangle(fillColor={255,255,255},
      fillPattern=FillPattern.Solid,
      extent={{-50.0,19.0},{50.0,51.0}}),
    Line(points={{-75.0,70.0},{-75.0,10.0}}),
    Polygon(fillColor={160,160,164},
      fillPattern=FillPattern.Solid,
      points={{60.0,60.0},{60.0,70.0},{75.0,70.0},{75.0,80.0},{-75.0,80.0},{-75.0,70.0},{-60.0,70.0},{-60.0,60.0},{60.0,60.0}}),
    Line(points={{75.0,70.0},{75.0,10.0}}),
    Text(textColor={0,0,255},
      extent={{-150.0,90.0},{150.0,130.0}},
      textString="%name"),
    Line(points={{0.0,-80.0},{0.0,-100.0}}),
    Line(visible=useHeatPort,
      points={{-100.0,-100.0},{-100.0,-35.0},{2.0,-35.0}},
      color={191,0,0},
      pattern=LinePattern.Dot)}));
end BearingFriction;
