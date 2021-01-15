within Modelica.Mechanics.Translational.Components;
model Brake "Brake based on Coulomb friction"
  extends Modelica.Mechanics.Translational.Interfaces.PartialElementaryTwoFlangesAndSupport2;
  extends Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPortWithoutT;

  import Modelica.Blocks.Types.{ExternalCombiTable1D, Extrapolation, Smoothness};
  import Modelica.Blocks.Tables.Internal.{getTable1DValue, getTable1DValueNoDer, getTable1DValueNoDer2};

  parameter Real mu_pos[:, 2]=[0, 0.5]
    "Positive sliding friction coefficient [-] as function of v [m/s] (v>=0)";
  parameter Smoothness smoothness = Smoothness.LinearSegments
    "Smoothness of interpolation in mu_pos table";
  parameter Real peak(final min=1) = 1
    "Peak for maximum value of mu at v==0 (mu0_max = peak*mu_pos[1,2])";
  parameter Real cgeo(final min=0) = 1
    "Geometry constant containing friction distribution assumption";
  parameter SI.Force fn_max(final min=0, start=1) "Maximum normal force";

  extends Translational.Interfaces.PartialFriction;

  SI.Position s "Absolute position of flange_a and of flange_b";
  SI.Force f "Brake friction force";
  SI.Velocity v "Absolute velocity of flange_a and flange_b";
  SI.Acceleration a "Absolute acceleration of flange_a and flange_b";

  Real mu "Friction coefficient";
  SI.Force fn "Normal force (=fn_max*f_normalized)";
  Modelica.Blocks.Interfaces.RealInput f_normalized
    "Normalized force signal 0..1 (normal force = fn_max*f_normalized; brake is active if > 0)"
    annotation (Placement(transformation(
        origin={0,110},
        extent={{20,-20},{-20,20}},
        rotation=90)));

protected
  final parameter ExternalCombiTable1D tableID = ExternalCombiTable1D(
    tableName="NoName",
    fileName="NoName",
    table=mu_pos,
    columns={2},
    smoothness=smoothness,
    extrapolation=Extrapolation.LastTwoPoints,
    verboseRead=false) "External table object for sliding friction coefficient";
  final parameter Real mu0=
    if     smoothness == Smoothness.ConstantSegments then getTable1DValueNoDer(tableID, 1, 0)
    elseif smoothness == Smoothness.LinearSegments   then getTable1DValueNoDer2(tableID, 1, 0)
    else                                                  getTable1DValue(tableID, 1, 0)
    "Friction coefficient for v=0 and forward sliding";

  Real table_signs[2]
    "Signs for sliding friction coefficient table interpolation: [sign for v, sign for mu]";

equation
  assert(size(mu_pos, 1) > 0 and size(mu_pos, 2) > 0, "Parameter mu_pos is an empty matrix");

  s = s_a;
  s = s_b;

  // Velocity and acceleration of flanges flange_a and flange_b
  v = der(s);
  a = der(v);
  v_relfric = v;
  a_relfric = a;

  // Friction force, normal force and friction force for v=0
  flange_a.f + flange_b.f - f = 0;
  fn = fn_max*f_normalized;
  f0 = mu0*cgeo*fn;
  f0_max = peak*f0;
  free = fn <= 0;

  // Friction force
  table_signs =
    if     startForward         then { 1, 1}
    elseif startBackward        then {-1,-1}
    elseif pre(mode) == Forward then { 1, 1}
    else                             {-1,-1};
  mu = table_signs[2]*(
    if     smoothness == Smoothness.ConstantSegments then getTable1DValueNoDer(tableID, 1, table_signs[1]*v)
    elseif smoothness == Smoothness.LinearSegments   then getTable1DValueNoDer2(tableID, 1, table_signs[1]*v)
    else                                                  getTable1DValue(tableID, 1, table_signs[1]*v));
  f = if locked then sa*unitForce else if free then 0 else mu*cgeo*fn;

  lossPower = f*v_relfric;
  annotation (Documentation(info="<html>
<p>
This component models a <strong>brake</strong>, i.e., a component where a frictional
force is acting between the housing and a flange and a controlled normal
force presses the flange to the housing in order to increase friction.
The normal force fn has to be provided as input signal f_normalized in a normalized form
(0 &le; f_normalized &le; 1),
fn = fn_max*f_normalized, where fn_max has to be provided as parameter.
Friction in the brake is modelled in the following way:
</p>
<p>
When the absolute velocity \"v\" is not zero, the friction force
is a function of the velocity dependent friction coefficient mu(v), of
the normal force \"fn\", and of a geometry constant \"cgeo\" which takes into
account the geometry of the device and the assumptions on the friction
distributions:
</p>
<blockquote><pre>
frictional_force = <strong>cgeo</strong> * <strong>mu</strong>(v) * <strong>fn</strong>
</pre></blockquote>
<p>
   Typical values of coefficients of friction <strong>mu</strong>:
</p>
<ul>
  <li>0.2&nbsp;&hellip;&nbsp;0.4 for dry operation,</li>
  <li>0.05&nbsp;&hellip;&nbsp;0.1 when operating in oil.</li>
</ul>
<p>
    The positive part of the friction characteristic <strong>mu</strong>(v),
    v >= 0, is defined via table mu_pos (first column = v,
    second column = mu).
</p>
<p>
   When the absolute velocity becomes zero, the elements
   connected by the friction element become stuck, i.e., the absolute
   position remains constant. In this phase the friction force is
   calculated from a force balance due to the requirement, that
   the absolute acceleration shall be zero. The elements begin
   to slide when the friction force exceeds a threshold value,
   called the maximum static friction force, computed via:
</p>
<blockquote><pre>
frictional_force = <strong>peak</strong> * <strong>cgeo</strong> * <strong>mu</strong>(v=0) * <strong>fn</strong>,   (<strong>peak</strong> >= 1)
</pre></blockquote>
<p>
This procedure is implemented in a \"clean\" way by state events and
leads to continuous/discrete systems of equations if friction elements
are dynamically coupled. The method is described in:
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
    Press, Boston MA.<br><br></dd>
<dt>Armstrong B., and Canudas de Wit C. (1996):</dt>
<dd><strong>Friction Modeling and Compensation.</strong>
    The Control Handbook, edited by W.S.Levine, CRC Press,
    pp. 1369-1382.<br><br></dd>
<dt>Canudas de Wit C., Olsson H., &Aring;str&ouml;m K.J., and Lischinsky P. (1995):</dt>
<dd><strong>A new model for control of systems with friction.</strong>
    IEEE Transactions on Automatic Control, Vol. 40, No. 3, pp. 419-425.<br><br></dd>
</dl>
</html>"),
       Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {100,100}}), graphics={Rectangle(
          extent={{-90,10},{90,-10}},
          lineColor={0,127,0},
          fillColor={160,215,160},
          fillPattern=FillPattern.Solid),    Polygon(
              points={{0,-30},{10,-50},{-10,-50},{0,-30}},
              lineColor={0,0,127},
              fillColor={0,0,127},
              fillPattern=FillPattern.Solid),Polygon(
              points={{10,50},{-10,50},{0,30},{10,50}},
              lineColor={0,0,127},
              fillColor={0,0,127},
              fillPattern=FillPattern.Solid),Line(
              points={{0,90},{0,50}}, color={0,0,127}),
                                      Rectangle(
              extent={{20,28},{30,22}},
              lineColor={175,190,175},
              fillColor={175,190,175},
              fillPattern=FillPattern.Solid),Rectangle(
              extent={{20,-22},{30,-28}},
              lineColor={175,190,175},
              fillColor={175,190,175},
              fillPattern=FillPattern.Solid),Rectangle(
              extent={{30,28},{36,-102}},
              lineColor={175,190,175},
              fillColor={175,190,175},
              fillPattern=FillPattern.Solid),Rectangle(
              extent={{14,-96},{30,-102}},
              lineColor={175,190,175},
              fillColor={175,190,175},
              fillPattern=FillPattern.Solid),Line(
              points={{0,-50},{0,-60},{-40,-50},{-40,48},{0,60},{0,90}}, color={0,0,127}),
                                                                         Text(
              extent={{-150,-120},{150,-160}},
              textString="%name",
              textColor={0,0,255}),Line(
              visible=useHeatPort,
              points={{-100,-102},{-100,-16},{0,-16}},
              color={191,0,0},
              pattern=LinePattern.Dot),      Rectangle(
              extent={{-20,30},{20,20}},
              fillPattern=FillPattern.Solid),Rectangle(
              extent={{-20,-20},{20,-30}},
              fillPattern=FillPattern.Solid)}));
end Brake;
