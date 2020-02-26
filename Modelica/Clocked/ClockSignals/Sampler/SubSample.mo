within Modelica.Clocked.ClockSignals.Sampler;
block SubSample "Sub-sample the input clock and provide it as output clock"
  parameter Integer factor(min=1) "Sub-sampling factor (>= 1)" annotation(Evaluate=true);

  Clocked.ClockSignals.Interfaces.ClockInput u
    "Connector of a clock as input signal"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Clocked.ClockSignals.Interfaces.ClockOutput y
    "Connector of a clock as output signal (clock y is slower as clock of u)"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation
  y = subSample(u,factor);

  annotation (
   defaultComponentName="subSample1",
   Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        initialScale=0.06),
                     graphics={
        Line(
          points={{-100,0},{-80,0},{-80,-60},{60,-60},{60,0},{100,0}},
          pattern=LinePattern.Dot,
          color={95,95,95}),                       Line(
          points={{-80,-60},{-80,0},{-100,0}},
          color={95,95,95},
          pattern=LinePattern.Dot),
        Ellipse(
          extent={{-95,-45},{-65,-75}},
          lineColor={95,95,95},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{45,15},{75,-15}},
          lineColor={95,95,95},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-46,26},{-26,6}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{4,71},{24,51}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-83,-57},{-77,-63}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{57,3},{63,-3}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-36,-60},{-36,16},{14,16},{14,60},{60,60},{60,0}},
          color={175,175,175},
          pattern=LinePattern.Dot),
        Polygon(
          points={{25,0},{5,20},{5,10},{-25,10},{-25,-10},{5,-10},{5,-20},
              {25,0}},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          lineColor={95,95,95},
          origin={-75,55},
          rotation=-90),
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
This block sub-samples the input clock u and provides it as
output clock y.
</p>

<p>
To be more precise:
The clock y is factor-times slower than the clock u. The first activation of clock y coincides with the first activation of clock u. The sub-sampling factor is defined by Integer parameter <strong>factor</strong>.
</p>

<h4>Example</h4>

<p>
The following
<a href=\"modelica://Modelica.Clocked.Examples.Elementary.ClockSignals.SubSample\">example</a>
generates a periodic clock of 20 ms period, and
then sub-samples the resulting clock signal with a factor of 3:<br>
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica/Resources/Images/Clocked/ClockSignals/SubSample_Model.png\" alt=\"SubSample_Model.png\"></td>
    <td valign=\"bottom\">&nbsp;&nbsp;&nbsp;
                        <img src=\"modelica://Modelica/Resources/Images/Clocked/ClockSignals/SubSample_Result.png\" alt=\"SubSample_Result.png\"></td>
    </tr>
<tr><td></td>
    <td align=\"center\">model</td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>
<p>
As can be seen, subSample.y picks every third-value of periodicClock.y due to the
sub-sampling, and the sub-sampling factor = 3 is displayed in the icon of the
subSample block. Note the down-arrow in the icon of the subSample block indicates that
clock subSample.y is slower as clock subSample.u.
</p>
</html>"));
end SubSample;
