within Modelica.Clocked.RealSignals.Sampler.Utilities.Internal;
block UniformNoiseXorshift64star
  "Add band-limited uniform noise based on a xorshift64* number generator"
  extends Clocked.RealSignals.Interfaces.PartialNoise;
  parameter Real noiseMax=0.1 "Upper limit of noise band";
  parameter Real noiseMin=-noiseMax "Lower limit of noise band";

  parameter Integer globalSeed = 30020 "Global seed to initialize random number generator";
  // Random number generators with exposed state
  parameter Integer localSeed = 614657 "Local seed to initialize random number generator";
  output Real r64(start=0) "Random number generated with Xorshift64star";
protected
  discrete Integer state64[2](start=Modelica.Math.Random.Generators.Xorshift64star.initialState(localSeed, globalSeed));

equation
  (r64, state64) = Modelica.Math.Random.Generators.Xorshift64star.random(previous(state64));
   y = u + noiseMin + (noiseMax - noiseMin)*r64;

  annotation (Documentation(info="<html>
<p>This block adds uniformly distributed noise in the range noiseMin&nbsp;&hellip;&nbsp;noiseMax to the clocked Real input signal and provides the sum as clocked Real output signal. </p>
<p>
It is based on the xorshift64* algorithm.
For more details, see the documentation to
<a href=\"modelica://Modelica.Math.Random.Generators.Xorshift64star\">Xorshift64star</a>.
</p>
<h4>Example</h4>
<p>
The following
<a href=\"modelica://Modelica.Clocked.Examples.Elementary.RealSignals.UniformNoiseXorshift64star\">example</a>
samples zero signal with a periodic clock of 20 ms period, and adds
noise in the range from -0.1&nbsp;&hellip;&nbsp;0.1:<br>
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/UniformNoiseXorshift64star_Model.png\" alt=\"UniformNoiseXorshift64star_Model.png\"></td>
    <td valign=\"bottom\">&nbsp;&nbsp;&nbsp;
                        <img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/UniformNoiseXorshift64star_Result.png\" alt=\"UniformNoiseXorshift64star_Result.png\"></td>
    </tr>
<tr><td></td>
    <td align=\"center\">model</td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>
</html>"),
    Icon(graphics={
        Polygon(
          points={{-81,90},{-89,68},{-73,68},{-81,90}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-74,92},{90,68}},
          textColor={175,175,175},
          textString="%noiseMax"),
        Line(points={{-81,78},{-81,-90}}, color={192,192,192}),
        Line(points={{-89,62},{85,62}}, color={175,175,175}),
        Line(points={{-81,-17},{-67,-17},{-67,-1},{-59,-1},{-59,-49},{
              -51,-49},{-51,-27},{-43,-27},{-43,57},{-35,57},{-35,25}},
                                                               color={0,0,
              127},
          pattern=LinePattern.Dot),
        Line(points={{-35,25},{-35,-35},{-25,-35},{-25,-17},{-15,-17},{
              -15,-45},{-5,-45},{-5,37},{1,37},{1,51},{7,51},{7,-5},{17,
              -5},{17,7},{23,7},{23,-23},{33,-23},{33,49},{43,49},{43,
              15},{51,15},{51,-51},{61,-51}},
            color={0,0,127},
          pattern=LinePattern.Dot),
        Line(points={{-90,-23},{82,-23}}, color={192,192,192}),
        Polygon(
          points={{91,-22},{69,-14},{69,-30},{91,-22}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-90,-54},{84,-54}}, color={175,175,175}),
        Ellipse(
          extent={{-84,-13},{-78,-19}},
          lineColor={0,0,127},
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-70,3},{-64,-3}},
          lineColor={0,0,127},
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-62,-47},{-56,-53}},
          lineColor={0,0,127},
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-54,-23},{-48,-29}},
          lineColor={0,0,127},
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-46,59},{-40,53}},
          lineColor={0,0,127},
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-38,-33},{-32,-39}},
          lineColor={0,0,127},
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-28,-15},{-22,-21}},
          lineColor={0,0,127},
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-18,-41},{-12,-47}},
          lineColor={0,0,127},
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-8,39},{-2,33}},
          lineColor={0,0,127},
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-2,53},{4,47}},
          lineColor={0,0,127},
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{4,-1},{10,-7}},
          lineColor={0,0,127},
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{14,9},{20,3}},
          lineColor={0,0,127},
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{20,-19},{26,-25}},
          lineColor={0,0,127},
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{30,53},{36,47}},
          lineColor={0,0,127},
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{40,19},{46,13}},
          lineColor={0,0,127},
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{48,-47},{54,-53}},
          lineColor={0,0,127},
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-80,-62},{98,-84}},
          textColor={175,175,175},
          textString="%noiseMin")}));
end UniformNoiseXorshift64star;
