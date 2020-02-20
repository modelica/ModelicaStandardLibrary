within Modelica.Clocked.RealSignals.Sampler;
block SuperSample
  "Super-sample the clocked Real input signal and provide it as clocked output signal"
  parameter Boolean inferFactor=true
    "= true, if super-sampling factor is inferred"  annotation(Evaluate=true, choices(checkBox=true));
  parameter Integer factor(min=1)=1
    "Super-sampling factor >= 1 (ignored if inferFactor=true)"
                                                annotation(Evaluate=true, Dialog(enable=not inferFactor));

  Modelica.Blocks.Interfaces.RealInput u
    "Connector of clocked, Real input signal"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput y
    "Connector of clocked, Real output signal (clock of y is faster as clock of u)"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation
  if inferFactor then
     y = superSample(u);
  else
     y = superSample(u,factor);
  end if;

  annotation (
   defaultComponentName="superSample1",
   Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        initialScale=0.06),
                     graphics={Line(points={{-80,-60},{-40,-60},{-40,-60},
              {0,-60},{0,-60},{0,-60},{0,80},{40,80},{40,80},{80,80},{80,
              0},{80,0},{80,0},{100,0}},
                                 color={0,0,127},
          pattern=LinePattern.Dot),                Line(
          points={{-80,-60},{-80,0},{-100,0}},
          color={0,0,127},
          pattern=LinePattern.Dot),
        Ellipse(
          extent={{-95,-45},{-65,-75}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-83,-57},{-77,-63}},
          lineColor={0,0,127},
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-15,96},{15,66}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-3,83},{3,77}},
          lineColor={0,0,127},
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{65,16},{95,-14}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{77,3},{83,-3}},
          lineColor={0,0,127},
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-48,-46},{-18,-76}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{34,96},{64,66}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{25,0},{5,20},{5,10},{-25,10},{-25,-10},{5,-10},{5,-20},
              {25,0}},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          lineColor={95,95,95},
          origin={-49,26},
          rotation=90),
        Text(
          visible=not inferFactor,
          extent={{-150,-100},{150,-140}},
          textString="%factor"),
        Text(
          extent={{-150,150},{150,110}},
          textString="%name",
          textColor={0,0,255})}),
    Documentation(info="<html>
<p>
This block super-samples the clocked Real input signal u and provides it as
clocked output signal y.
</p>

<p>
To be more precise:
The clock of y is factor-times faster than the clock of u. At every tick of the clock of y, the value of y is set to
the value of u from the last tick of the clock of u. The first activation of the clock of y coincides with the first activation of the clock of u. By default, the super-sampling factor is inferred,
that is, it must be defined somewhere else. If parameter <strong>inferFactor</strong> = false,
then the super-sampling factor is defined by Integer parameter <strong>factor</strong>.
</p>

<p>
For control applications this block introduces unnecessary \"vibrations\".
In such a case it is better to use block
<a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.SuperSampleInterpolated\">SuperSampleInterpolated</a>
instead.
</p>

<h4>Example</h4>

<p>
The following
<a href=\"modelica://Modelica.Clocked.Examples.Elementary.RealSignals.SuperSample\">example</a>
samples a sine signal with a periodic clock of 20 ms period, and
then super-samples the resulting clocked signal with a factor of 3:<br>
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/SuperSample_Model.png\" alt=\"SuperSample_Model.png\"></td>
    <td valign=\"bottom\">&nbsp;&nbsp;&nbsp;
                        <img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/SuperSample_Result.png\" alt=\"SuperSample_Result.png\"></td>
    </tr>
<tr><td></td>
    <td align=\"center\">model</td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>
<p>
As can be seen, superSample introduces factor-1 additional clock ticks for the
output y. The super-sampling factor = 3 is displayed in the icon of the
superSample block. Note the up-arrow in the icon of the superSample block indicates that the
clock of superSample.y is faster as the clock of superSample.u.
</p>
</html>"));
end SuperSample;
