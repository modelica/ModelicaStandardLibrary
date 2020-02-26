within Modelica.Clocked.ClockSignals.Sampler;
block SuperSample
  "Super-sample the input clock and provide it as output clock"
  parameter Integer factor(min=1) "Super-sampling factor (>= 1)" annotation(Evaluate=true);

  Clocked.ClockSignals.Interfaces.ClockInput u
    "Connector of a clock as input signal"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Clocked.ClockSignals.Interfaces.ClockOutput y
    "Connector of a clock as output signal (clock y is faster as clock of u)"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation
  y = superSample(u,factor);

  annotation (
   defaultComponentName="superSample1",
   Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        initialScale=0.06),
                     graphics={Line(points={{-80,-60},{-40,-60},{-40,-60},{0,-60},
              {0,-60},{0,-60},{0,80},{40,80},{40,80},{80,80},{80,0},{80,0},{80,0},
              {100,0}},          color={95,95,95},
          pattern=LinePattern.Dot,
          thickness=0.5),                          Line(
          points={{-80,-60},{-80,0},{-100,0}},
          color={95,95,95},
          pattern=LinePattern.Dot,
          thickness=0.5),
        Ellipse(
          extent={{-95,-45},{-65,-75}},
          lineColor={175,175,175},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-83,-57},{-77,-63}},
          lineColor={175,175,175},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.Dot),
        Ellipse(
          extent={{-15,96},{15,66}},
          lineColor={175,175,175},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-3,83},{3,77}},
          lineColor={175,175,175},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.Dot),
        Ellipse(
          extent={{65,16},{95,-14}},
          lineColor={175,175,175},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{77,3},{83,-3}},
          lineColor={175,175,175},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.Dot),
        Ellipse(
          extent={{-48,-46},{-18,-76}},
          lineColor={175,175,175},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{34,96},{64,66}},
          lineColor={175,175,175},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{25,0},{5,20},{5,10},{-25,10},{-25,-10},{5,-10},{5,-20},
              {25,0}},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          lineColor={95,95,95},
          origin={-43,18},
          rotation=90),
        Text(
          extent={{-150,150},{150,110}},
          textString="%name",
          textColor={0,0,255}),
        Text(
          extent={{-150,-90},{150,-130}},
          textString="%factor",
          textColor={0,0,0})}),
    Documentation(info="<html>
<p>
This block super-samples the clock input signal u and provides it as
clock output signal y.
</p>

<p>
To be more precise:
Clock y is factor-times faster than clock u. The first activation of clock y coincides with the first activation of clock u. The super-sampling factor is defined by Integer parameter <strong>factor</strong>.
</p>

<h4>Example</h4>

<p>
The following
<a href=\"modelica://Modelica.Clocked.Examples.Elementary.ClockSignals.SuperSample\">example</a>
generates a periodic clock of 20 ms period, and
then super-samples the resulting clock with a factor of 3:<br>
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica/Resources/Images/Clocked/ClockSignals/SuperSample_Model.png\" alt=\"SuperSample_Model.png\"></td>
    <td valign=\"bottom\">&nbsp;&nbsp;&nbsp;
                        <img src=\"modelica://Modelica/Resources/Images/Clocked/ClockSignals/SuperSample_Result.png\" alt=\"SuperSample_Result.png\"></td>
    </tr>
<tr><td></td>
    <td align=\"center\">model</td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>
<p>
As can be seen, superSample introduces factor-1 additional clock ticks for the
output clock y. The super-sampling factor = 3 is displayed in the icon of the
superSample block. Note the up-arrow in the icon of the superSample block indicates that
clock superSample.y is faster as clock superSample.u.
</p>
</html>"));
end SuperSample;
