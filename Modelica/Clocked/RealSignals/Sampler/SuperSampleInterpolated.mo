within Modelica.Clocked.RealSignals.Sampler;
block SuperSampleInterpolated
  "Super-sample the clocked Real input signal and provide it linearly interpolated as clocked output signal (this is also called an Interpolator)"

  parameter Boolean inferFactor=true
    "= true, if super-sampling factor is inferred"  annotation(Evaluate=true, choices(checkBox=true));
  parameter Integer factor(min=1)=1
    "Super-sampling factor >= 1 (if inferFactor=false)"
                                                annotation(Evaluate=true, Dialog(enable=not inferFactor));
  Modelica.Blocks.Interfaces.RealInput u
    "Connector of clocked, Real input signal"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput y
    "Connector of clocked, Real output signal"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
protected
  Real uu(start=0.0);
  Real u_super;
  Real u_pre;
  Real u_preSuper;
  Integer usedFactor = if inferFactor then integer( (superSample(interval(u))/interval(u_super)) + 0.5) else factor;
  Integer ticks(start=0);
  Boolean first(start=true);
equation
  when Clock() then  // clock of u
     uu = u;
     first = false;
     u_pre = if previous(first) then u else previous(uu);
  end when;

  when Clock() then  // clock of y
     if inferFactor then
        u_super = superSample(u);
     else
        u_super = superSample(u,factor);
     end if;
     u_preSuper = superSample(u_pre);
     ticks = if previous(ticks) < usedFactor then previous(ticks) + 1 else 1;
     y = u_preSuper + ticks/usedFactor*(u_super - u_preSuper);
  end when;

  annotation (
   defaultComponentName="superSampleIpo1",
   Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        initialScale=0.06),
                     graphics={
        Line(
          points={{-100,0},{-40,0},{-40,-60},{16,-60},{16,0},{74,0},{74,80},{110,
              80},{110,80},{110,80},{110,80},{120,80}},
          color={0,0,127},
          pattern=LinePattern.Dot),
        Ellipse(
          extent={{-55,-43},{-25,-73}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{59,94},{89,64}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-2,16},{28,-14}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-89,-51},{-71,-69}},
          lineColor={0,0,127},
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{7,88},{25,70}},
          lineColor={0,0,127},
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{25,0},{5,20},{5,10},{-25,10},{-25,-10},{5,-10},{5,-20},
              {25,0}},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          lineColor={95,95,95},
          origin={-61,46},
          rotation=90),
        Text(
          visible=not inferFactor,
          extent={{-150,-100},{150,-140}},
          textString="%factor",
          textColor={0,0,0}),
        Text(
          extent={{-150,150},{150,110}},
          textString="%name",
          textColor={0,0,255})}),
    Documentation(info="<html>
<p>
This block super-samples the clocked Real input signal u and provides it
linearly interpolated between the u-values as
clocked output signal y.
</p>

<p>
To be more precise:
The clock of y is factor-times faster than the clock of u. At every tick of the clock of y, the value of y is set to
the value of the linearly interpolated value between the last available values of u.
The first activation of the clock of y coincides with the first activation of the clock of u.
By default, the super-sampling factor is inferred,
that is, it must be defined somewhere else. If parameter <strong>inferFactor</strong> = false,
then the super-sampling factor is defined by Integer parameter <strong>factor</strong>.
</p>

<p>
For control applications, this block is better suited as block
<a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.SuperSample\">SuperSample</a>
since it does not induce \"vibrations\".
</p>

<h4>Example</h4>

<p>
The following
<a href=\"modelica://Modelica.Clocked.Examples.Elementary.RealSignals.SuperSampleInterpolated\">example</a>
samples a sine signal with a periodic clock of 20 ms period, and
then super-samples the resulting clocked signal with a factor of 3
and interpolates the result linearly:<br>
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/SuperSampleInterpolated_Model.png\" alt=\"SuperSampleInterpolated_Model.png\"></td>
    <td valign=\"bottom\">&nbsp;&nbsp;&nbsp;
                        <img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/SuperSampleInterpolated_Result.png\" alt=\"SuperSampleInterpolated_Result.png\"></td>
    </tr>
<tr><td></td>
    <td align=\"center\">model</td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>
<p>
As can be seen, block superSampleIpo introduces 3 additional clock ticks for the
output y and determines the values at these clock ticks, so that the last two available
values of the input u are linearly interpolated. The super-sampling factor = 3 is displayed in the icon of the
superSampleIpo block. Note the up-arrow in the icon of the SuperSampleInterpolation block indicates that the
clock of superSampleIpo.y is faster as the clock of superSampleIpo.u.
</p>
</html>"));
end SuperSampleInterpolated;
