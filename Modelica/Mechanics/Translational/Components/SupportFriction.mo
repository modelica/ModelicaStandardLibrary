within Modelica.Mechanics.Translational.Components;
model SupportFriction "Coulomb friction in support"
  extends Modelica.Mechanics.Translational.Interfaces.PartialElementaryTwoFlangesAndSupport2;
  extends Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPortWithoutT;

  import Modelica.Blocks.Types.{ExternalCombiTable1D, Extrapolation, Smoothness};
  import Modelica.Blocks.Tables.Internal.{getTable1DValue, getTable1DValueNoDer, getTable1DValueNoDer2};

  parameter Real f_pos[:, 2]=[0, 1]
    "Positive sliding friction characteristic [N] as function of v [m/s] (v>=0)";
  parameter Smoothness smoothness = Smoothness.LinearSegments
    "Smoothness of interpolation in f_pos table";
  parameter Real peak(final min=1) = 1
    "Peak for maximum friction force at v==0 (f0_max = peak*f_pos[1,2])";

  extends Translational.Interfaces.PartialFriction;

  SI.Position s "= flange_a.s - support.s";
  SI.Force f "Friction force";
  SI.Velocity v "Absolute velocity of flange_a and flange_b";
  SI.Acceleration a "Absolute acceleration of flange_a and flange_b";

protected
  final parameter ExternalCombiTable1D tableID = ExternalCombiTable1D(
    tableName="NoName",
    fileName="NoName",
    table=f_pos,
    columns={2},
    smoothness=smoothness,
    extrapolation=Extrapolation.LastTwoPoints,
    verboseRead=false) "External table object for sliding friction coefficient";

  Real table_signs[2]
    "Signs for sliding friction coefficient table interpolation: [sign for v, sign for f]";

equation
  assert(size(f_pos, 1) > 0 and size(f_pos, 2) > 0, "Parameter f_pos is an empty matrix");

  // Constant auxiliary variables
  f0 =
    if     smoothness == Smoothness.ConstantSegments then getTable1DValueNoDer(tableID, 1, 0)
    elseif smoothness == Smoothness.LinearSegments   then getTable1DValueNoDer2(tableID, 1, 0)
    else                                                  getTable1DValue(tableID, 1, 0);
  f0_max = peak*f0;
  free = false;

  s = flange_a.s - s_support;
  flange_a.s = flange_b.s;

  // Velocity and acceleration of flanges
  v = der(s);
  a = der(v);
  v_relfric = v;
  a_relfric = a;

  // Force balance
  flange_a.f + flange_b.f - f = 0;

  // Friction force
  table_signs =
    if     startForward         then { 1, 1}
    elseif startBackward        then {-1,-1}
    elseif pre(mode) == Forward then { 1, 1}
    else                             {-1,-1};
  f = if locked then sa*unitForce else table_signs[2]*(
    if     smoothness == Smoothness.ConstantSegments then getTable1DValueNoDer(tableID, 1, table_signs[1]*v)
    elseif smoothness == Smoothness.LinearSegments   then getTable1DValueNoDer2(tableID, 1, table_signs[1]*v)
    else                                                  getTable1DValue(tableID, 1, table_signs[1]*v));

  lossPower = f*v_relfric;
  annotation (
    Documentation(info="<html>
<p>
This element describes <strong>Coulomb friction</strong> in <strong>support</strong>,
i.e., a frictional force acting between a flange and the housing.
The positive sliding friction force \"f\" has to be defined
by table \"f_pos\" as function of the absolute velocity \"v\".
E.g.
</p>
<blockquote><pre>
 v |   f
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
f_pos = [0, 0; 1, 2; 2, 5; 3, 8];
</pre></blockquote>
<p>
Outside of the table, extrapolation through the last
two table entries is used. It is assumed that the negative
sliding friction force has the same characteristic with negative
values. Friction is modelled in the following way:
</p>
<p>
When the absolute velocity \"v\" is not zero, the friction force
is a function of v and of a constant normal force. This dependency
is defined via table f_pos and can be determined by measurements,
e.g., by driving the gear with constant velocity and measuring the
needed driving force (= friction force).
</p>
<p>
When the absolute velocity becomes zero, the elements
connected by the friction element become stuck, i.e., the absolute
position remains constant. In this phase the friction force is
calculated from a force balance due to the requirement, that
the absolute acceleration shall be zero.  The elements begin
to slide when the friction force exceeds a threshold value,
called the maximum static friction force, computed via:
</p>
<blockquote><pre>
maximum_static_friction = <strong>peak</strong> * sliding_friction(v=0)  (<strong>peak</strong> >= 1)
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
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
      graphics={
        Polygon(
          points={{-50,-50},{-10,-90},{-10,-100},{10,-100},{10,-90},{50,-50},{-50,-50}},
          lineColor={95,95,95},
          fillColor={131,175,131},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-48,-10},{-28,-30}},
          lineColor={0,127,0},
          fillPattern=FillPattern.Sphere,
          fillColor={255,255,255}),
        Ellipse(
          extent={{-10,-10},{10,-30}},
          lineColor={0,127,0},
          fillPattern=FillPattern.Sphere,
          fillColor={255,255,255}),
        Ellipse(
          extent={{30,-10},{50,-30}},
          lineColor={0,127,0},
          fillPattern=FillPattern.Sphere,
          fillColor={255,255,255}),
        Ellipse(
          extent={{-50,30},{-30,10}},
          lineColor={0,127,0},
          fillPattern=FillPattern.Sphere,
          fillColor={255,255,255}),
        Ellipse(
          extent={{-10,30},{10,10}},
          lineColor={0,127,0},
          fillPattern=FillPattern.Sphere,
          fillColor={255,255,255}),
        Ellipse(
          extent={{30,30},{50,10}},
          lineColor={0,127,0},
          fillPattern=FillPattern.Sphere,
          fillColor={255,255,255}),
        Rectangle(
          extent={{-90,10},{90,-10}},
          lineColor={0,127,0},
          fillColor={160,215,160},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-150,100},{150,60}},
          textString="%name",
          textColor={0,0,255}),
        Polygon(
          points={{-60,30},{60,30},{60,20},{80,20},{80,50},{-80,50},{-80,20},{-60,20},{-60,30}},
          lineColor={95,95,95},
          fillPattern=FillPattern.Solid,
          fillColor={131,175,131}),
        Line(
          visible=useHeatPort,
          points={{-100,-100},{-100,-20},{0,-20}},
          color={191,0,0},
          pattern=LinePattern.Dot),
        Polygon(
          points={{-60,-30},{60,-30},{60,-20},{80,-20},{80,-50},{-80,-50},{-80,-20},{-60,-20},{-60,-30}},
          lineColor={95,95,95},
          fillPattern=FillPattern.Solid,
          fillColor={131,175,131})}));
end SupportFriction;
