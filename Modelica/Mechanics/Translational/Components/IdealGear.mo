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
This element characterizes any type of gear which is fixed in the
ground and which has one driving flange and one driven flange.
The gear is <strong>ideal</strong>, i.e., it does not have mass, elasticity, damping
or backlash. If these effects have to be considered, the gear has to be
connected to other elements in an appropriate way.
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
