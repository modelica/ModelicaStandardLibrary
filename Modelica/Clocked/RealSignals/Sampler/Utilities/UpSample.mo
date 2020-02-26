within Modelica.Clocked.RealSignals.Sampler.Utilities;
block UpSample
  "Upsample the clocked Real input signal and provide it as clocked output signal"

  parameter Boolean inferFactor=true
    "= true, if upsampling factor is inferred"  annotation(Evaluate=true, choices(checkBox=true));
  parameter Integer factor(min=1)=1
    "Upsampling factor >= 1 (if inferFactor=false)" annotation(Evaluate=true, Dialog(enable=not inferFactor));
  Modelica.Blocks.Interfaces.RealInput u
    "Connector of clocked, Real input signal"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput y
    "Connector of clocked, Real output signal (clock of y is faster as clock of u)"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
protected
  Real dummy annotation(HideResult=true);
  Boolean b(start=false);
  Boolean b_super(start=false);
  Real u_super;
equation
  when Clock() then // clock of u
     dummy = u;
     b = not previous(b);
  end when;

  when Clock() then // clock of y
     b_super = superSample(b);
     if inferFactor then
        u_super = superSample(u);
     else
        u_super = superSample(u,factor);
     end if;
     y = if b_super <> previous(b_super) then u_super else 0.0;
  end when;

  annotation (
   defaultComponentName="upSample1",
   Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        initialScale=0.06),
                     graphics={
        Line(
          points={{-78,-60},{40,-60},{40,0},{40,0}},
          color={215,215,215},
          pattern=LinePattern.Dot), Line(points={{-80,-60},{-40,-60},{-40,-60},{-40,0},
              {-40,0},{0,0},{40,0},{40,80},{40,80},{40,80},{80,80},{80,0},{80,0},
              {100,0}},          color={0,0,127},
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
          extent={{25,96},{55,66}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{37,83},{43,77}},
          lineColor={0,0,127},
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-55,16},{-25,-14}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-6,16},{24,-14}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{64,16},{94,-14}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          visible=not inferFactor,
          extent={{-150,-100},{150,-140}},
          textString="%factor",
          textColor={0,0,0}),
        Line(
          points={{80,80},{120,80}},
          color={215,215,215},
          pattern=LinePattern.Dot),
        Polygon(
          points={{25,0},{5,20},{5,10},{-25,10},{-25,-10},{5,-10},{5,-20},
              {25,0}},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          lineColor={95,95,95},
          origin={-71,52},
          rotation=90),
        Text(
          extent={{-150,150},{150,110}},
          textString="%name",
          textColor={0,0,255})}),
    Documentation(info="<html>
<p>
This block upsamples the clocked Real input signal u and provides it as clocked output signal y.
</p>

<p>
To be more precise:
The clock of y is factor-times faster than the clock of u. At every tick of the clock of u, the value of y is set to
the value of u, at intermediate ticks of clock y, the value of y is set to zero. The first activation of the clock of y coincides with the first activation of the clock of u. By default, the upsampling factor is inferred,that is, it must be defined somewhere else. If parameter <strong>inferFactor</strong> = false, then the upsampling factor is defined by the Integer parameter <strong>factor</strong>.
</p>

<p>
For signal interpolation an <em>upsample</em> should be followed by an appropriate filter (anti-imaging).
</p>

<h4>Examples</h4>

<p>
The following
<a href=\"modelica://Modelica.Clocked.Examples.Elementary.RealSignals.UpSample1\">example</a>
samples a sine signal with a periodic clock of 20 ms period, and
then upsamples the resulting clocked signal with a factor of 3:<br>
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/UpSample1_Model.png\" alt=\"UpSample1_Model.png\"></td>
    <td valign=\"bottom\">&nbsp;&nbsp;&nbsp;
                        <img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/UpSample1_Result.png\" alt=\"UpSample1_Result.png\"></td>
    </tr>
<tr><td></td>
    <td align=\"center\">model</td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>
<p>
The upsampling factor is explicitly given at the upSample2 block, which also makes the factor visible in the icon. For the upSample1 block the factor is inferred.
As can be seen, upsample1 introduces 3 additional clock ticks for the
output y. Note, the up-arrow in the icon of the upSample blocks indicates that the
clocks of their outputs is faster than the clocks of their inputs.
</p>

<p>
The following
<a href=\"modelica://Modelica.Clocked.Examples.Elementary.RealSignals.UpSample2\">example</a>
samples a sine signal with a periodic clock of 20 ms period,
upsamples the resulting clocked signal with a factor of 3
and applies varies filters on this signal:<br>
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/UpSample2_Model.png\" alt=\"UpSample2_Model.png\"></td>
    </tr>
<tr><td></td>
    <td align=\"center\">model<br></td>
   </tr>
<tr><td></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/UpSample2_Result1.png\" alt=\"UpSample2_Result1.png\"></td>
    </tr>
<tr><td></td>
    <td align=\"center\">simulation result 1<br></td>
   </tr>
<tr><td></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/UpSample2_Result2.png\" alt=\"UpSample2_Result2.png\"></td>
    </tr>
<tr><td></td>
    <td align=\"center\">simulation result 2</td>
   </tr>
</table>

<p>
This model shows various possibilities to operate on an up-sampled signal:
When filtering the upsampled signal with filter block FIR1
using FIR coefficients {1,1,1}, then the result is identical to a super-sampled
signal (see signal FIR1.y in figure \"simulation result 1\").
On the other hand, when filtering the upsampled signal with filter
block FIR2 using FIR coefficients {1/3, 2/3, 1, 2/3, 1/3}, then
the result is a linearly interpolated super-sampled signal
(see signal FIR2.y in figure \"simulation result 2\").
The same result can be achieved with block
<a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.SuperSampleInterpolated\">SuperSampleInterpolated</a>
(see signal superSampleIpo1.y in figure \"simulation result 2\").
The only difference are the first clock ticks, since the FIR2 signal is
initialized a bit differently.
</p>
</html>"));
end UpSample;
