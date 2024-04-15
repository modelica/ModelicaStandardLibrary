within Modelica.Mechanics.Translational.Components;
model IdealLever "Ideal lever without mass"
  extends Modelica.Mechanics.Translational.Interfaces.PartialElementaryTwoFlangesAndSupport2;
  parameter Real ratio(start=1)
    "Transmission ratio (flange_a.s/flange_b.s)";

equation
  if abs(ratio) < Modelica.Constants.eps then
    flange_a.f = 0;
    flange_b.f = 0;
  else
    s_a = ratio*s_b;
    0 = ratio*flange_a.f + flange_b.f;
  end if;

  annotation (
    Documentation(info="<html>
<p>
This element characterizes any type of lever which is fixed in the
ground and which has one driving flange and one driven flange.
The lever is <strong>ideal</strong>, i.e., it does not have mass, elasticity, damping
or backlash. If these effects have to be considered, the lever has to be
connected to other elements in an appropriate way.
</p>

<h4>Classification of lever</h4>
<p>
Generally, a&nbsp;lever is classified by its ratio&nbsp;<var>i</var> which is the ratio
between the driving flange position and the driven flange position. The type of lever is,
then, given by the magnitude of <var>i</var> as follows:
</p>
<ul>
  <li>
    <var>i</var>&nbsp;&lt;&nbsp;0: <em>1st class lever</em>; the lever&apos;s pivot is
    located between the driving and the driven flange.
  </li>
  <li>
    <var>i</var>&nbsp;&gt;&nbsp;1: <em>2nd class lever</em>; the driven
    flange is located between the driving flange and the lever&apos;s pivot.
  </li>
  <li>
    0&nbsp;&lt;&nbsp;<var>i</var>&nbsp;&lt;&nbsp;1: <em>3rd class lever</em>; the
    driving flange is located between the driven flange and the lever&apos;s pivot.
  </li>
</ul>
<p>
Applying the abovementioned to this element, the parameter <code>ratio</code> can be considered equal
to <var>i</var> only when <code>flange_a</code> is the driving flange.
</p>
</html>"),
    Icon(
      coordinateSystem(preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}),
      graphics={
        Polygon(
          points={{-6,-30},{-6,50},{0,50},{6,50},{6,-30},{-6,-30}},
          lineColor={0,0,0},
          fillColor={160,215,160},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-20,-10},{20,-50}},
          fillColor={160,215,160},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Ellipse(
          extent={{-20,-10},{20,-50}},
          startAngle=-73,
          endAngle=253,
          closure=EllipseClosure.None),
        Ellipse(
          extent={{-10,-20},{10,-40}},
          fillColor={175,190,175},
          fillPattern=FillPattern.Solid),
        Line(
          points={{0,-54},{0,-30}},
          color={0,127,0}),
        Line(
          points={{0,-100},{0,-78}},
          color={0,127,0}),
        Line(
         points={{-98,0},{0,50}},
         color={0,127,0}),
        Line(
          points={{0,20},{100,0}},
          color={0,127,0}),
        Ellipse(
          extent={{-4,54},{4,46}},
          lineColor={0,127,0},
          fillColor={160,215,160},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-4,24},{4,16}},
          lineColor={0,127,0},
          fillColor={160,215,160},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-150,100},{150,60}},
          textColor={0,0,255},
          textString="%name"),
        Text(
          extent={{-100,-50},{100,-80}},
          textString="ratio=%ratio")}));
end IdealLever;
