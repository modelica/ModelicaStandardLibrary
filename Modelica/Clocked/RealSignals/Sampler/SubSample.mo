within Modelica.Clocked.RealSignals.Sampler;
block SubSample
  "Sub-sample the clocked Real input signal and provide it as clocked output signal"
  parameter Boolean inferFactor=true
    "= true, if sub-sampling factor is inferred"  annotation(Evaluate=true, choices(checkBox=true));
  parameter Integer factor(min=1)=1
    "Sub-sampling factor >= 1 (ignored if inferFactor=true)"
                                                            annotation(Evaluate=true, Dialog(enable=not inferFactor));

  Modelica.Blocks.Interfaces.RealInput u
    "Connector of clocked, Real input signal"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput y
    "Connector of clocked, Real output signal (clock of y is slower as clock of u)"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation
  if inferFactor then
     y = subSample(u);
  else
     y = subSample(u,factor);
  end if;

  annotation (
   defaultComponentName="subSample1",
   Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        initialScale=0.06),
        graphics={
        Line(
          points={{-100,0},{-80,0},{-80,-60},{60,-60},{60,0},{100,0}},
          pattern=LinePattern.Dot,
          color={0,0,127}),                        Line(
          points={{-80,-60},{-80,0},{-100,0}},
          color={0,0,127},
          pattern=LinePattern.Dot),
        Ellipse(
          extent={{-95,-45},{-65,-75}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{45,15},{75,-15}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-46,-20},{-26,-40}},
          lineColor={0,0,127},
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{4,71},{24,51}},
          lineColor={0,0,127},
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-83,-57},{-77,-63}},
          lineColor={0,0,127},
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{57,3},{63,-3}},
          lineColor={0,0,127},
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-36,-60},{-36,-30},{14,-30},{14,60},{60,60},{60,0}},
          color={215,215,215},
          pattern=LinePattern.Dot),
        Polygon(
          points={{25,0},{5,20},{5,10},{-25,10},{-25,-10},{5,-10},{5,-20},
              {25,0}},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          lineColor={95,95,95},
          origin={-51,26},
          rotation=-90),
        Text(
          extent={{-150,150},{150,110}},
          textString="%name",
          textColor={0,0,255}),
        Text(
          visible=not inferFactor,
          extent={{-150,-100},{150,-140}},
          textString="%factor",
          textColor={0,0,0})}),
    Documentation(info="<html>
<p>
This block sub-samples the clocked Real input signal u and provides it as
clocked output signal y.
</p>

<p>
To be more precise:
The clock of y is factor-times slower than the clock of u. At every factor ticks of the clock of u, the output y returns the value of u. The first activation of the clock of y coincides with the first activation of the clock of u. By default, the sub-sampling factor is inferred,
that is, it must be defined somewhere else. If parameter <strong>inferFactor</strong> = false,
then the sub-sampling factor is defined by Integer parameter <strong>factor</strong>.
</p>

<h4>Example</h4>

<p>
The following
<a href=\"modelica://Modelica.Clocked.Examples.Elementary.RealSignals.SubSample\">example</a>
samples a sine signal with a periodic clock of 20 ms period, and
then sub-samples the resulting clocked signal with a factor of 3:<br>
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/SubSample_Model.png\" alt=\"SubSample_Model.png\"></td>
    <td valign=\"bottom\">&nbsp;&nbsp;&nbsp;
                        <img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/SubSample_Result.png\" alt=\"SubSample_Result.png\"></td>
    </tr>
<tr><td></td>
    <td align=\"center\">model</td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>
<p>
As can be seen, subSample.y picks every third-value of sample.y due to the
sub-sampling, and the sub-sampling factor = 3 is displayed in the icon of the
subSample block. Note the down-arrow in the icon of the subSample block indicates that the
clock of subSample.y is slower as the clock of subSample.u.
</p>
</html>"));
end SubSample;
