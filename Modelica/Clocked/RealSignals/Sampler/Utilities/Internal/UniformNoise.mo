within Modelica.Clocked.RealSignals.Sampler.Utilities.Internal;
block UniformNoise "Add band-limited uniform noise using a variant of the Wichmann-Hill algorithm"
  extends Clocked.RealSignals.Interfaces.PartialNoise;
  parameter Real noiseMax=0.1 "Upper limit of noise band";
  parameter Real noiseMin=-noiseMax "Lower limit of noise band";
  parameter Integer firstSeed[3](each min=0, each max=255) = {23,87,187}
    "Integer[3] defining random sequence; required element range: 0..255";
protected
  Integer seedState[3](start=firstSeed, each fixed=true)
    "State of seed" annotation(HideResult=true);
  Real noise "Noise in the range 0..1" annotation(HideResult=true);
equation
  (noise,seedState) =
    Clocked.RealSignals.Sampler.Utilities.Internal.random(previous(
    seedState));
    y = u + noiseMin + (noiseMax - noiseMin)*noise;

  annotation (Documentation(info="<html>
<p>
This block adds uniformly distributed noise
in the range noiseMin&nbsp;&hellip;&nbsp;noiseMax to the clocked Real input signal
and provides the sum as clocked Real output signal.
</p>

<p>
The Integer[3] parameter vector <strong>firstSeed</strong> is used to initialize the
basic random number generator. The 3 elements of firstSeed need
to be in the range [0, 255]. The use of the same seed vector
will lead to the same sequence of numbers when these are computed serially.
This is usually not desired. Therefore, for every usage of block
<strong>Noise</strong> a different firstSeed should be defined.
</p>

<p>
This noise generator is based on a function that generates
a random real number uniformly in the semi-open range [0.0, 1.0).
The function uses the standard Wichmann-Hill generator,
combining three pure multiplicative congruential generators of
modulus 30269, 30307 and 30323. Its period (how many numbers it
generates before repeating the sequence exactly) is 6,953,607,871,644.
While of much higher quality than the rand() function supplied by
most C libraries, the theoretical properties are much the same
as for a single linear congruential generator of large modulus.
For more details, see the underlying function
<a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.Utilities.Internal.random\">Internal.random</a>.
</p>

<h4>Example</h4>
<p>
The following
<a href=\"modelica://Modelica.Clocked.Examples.Elementary.RealSignals.UniformNoise\">example</a>
samples zero signal with a periodic clock of 20 ms period, and adds
noise in the range from -0.1&nbsp;&hellip;&nbsp;0.1:<br>
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/UniformNoise_Model.png\" alt=\"UniformNoise_Model.png\"></td>
    <td valign=\"bottom\">&nbsp;&nbsp;&nbsp;
                        <img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/UniformNoise_Result.png\" alt=\"UniformNoise_Result.png\"></td>
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
             color={0,0,127},
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
end UniformNoise;
