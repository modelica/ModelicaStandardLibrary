within Modelica.Mechanics.Translational.Components;
model IdealGear "Ideal gear without mass"
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
      graphics={                  Line(points={{70,0},{100,0}},  color={0,127,0}),
                                  Line(points={{-100,0},{-70,0}},color={0,127,0}),
        Ellipse(
          extent={{-38,38},{38,-38}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          lineColor={95,95,95}),
        Ellipse(
          extent={{-16,16},{16,-16}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          lineColor={95,95,95}),
        Polygon(
          points={{76,-10},{76,0},{76,24},{-42,24},{-42,16},{56,16},{66,-10},{76,-10}},
          lineColor={0,127,0},
          fillColor={160,215,160},
          fillPattern=FillPattern.Solid),
        Line(
          points={{0,-54},{0,0}},
          color={0,127,0}),
        Line(
          points={{0,-100},{0,-78}},
          color={0,127,0}),
        Ellipse(
          extent={{-4,4},{4,-4}},
          lineColor={0,127,0},
          fillColor={160,215,160},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-150,100},{150,60}},
          textColor={0,0,255},
          textString="%name"),
        Text(
          extent={{-100,-50},{100,-80}},
          textString="ratio=%ratio"),
        Polygon(
          points={{50,48},{50,38},{-52,38},{-66,-10},{-76,-10},{-76,48},{50,48}},
          lineColor={95,95,95},
          fillColor={131,175,131},
          fillPattern=FillPattern.Solid)}));
end IdealGear;
