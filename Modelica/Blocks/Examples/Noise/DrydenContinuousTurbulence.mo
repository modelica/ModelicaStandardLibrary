within Modelica.Blocks.Examples.Noise;
model DrydenContinuousTurbulence
  "Demonstrates how to model wind turbulence for aircraft with the BandLimitedWhiteNoise block (a simple model of vertical Dryden gust speed at low altitudes < 1000 ft)"
  extends Modelica.Icons.Example;

  import Modelica.Constants.pi;

  parameter SI.Velocity V =            140 * 0.5144
    "Airspeed of aircraft (typically 140kts during approach)";
  parameter SI.Velocity sigma = 0.1 *   30 * 0.5144
    "Turbulence intensity (=0.1 * wind at 20 ft, typically 30 kt)";
  parameter SI.Length   L =            600 * 0.3048
    "Scale length (= flight altitude)";

  Modelica.Blocks.Continuous.TransferFunction Hw(b=sigma*sqrt(L/pi/V)*{sqrt(3)*
        L/V,1}, a={L^2/V^2,2*L/V,1},
    initType=Modelica.Blocks.Types.Init.InitialState)
    "Transfer function of vertical turbulence speed according to MIL-F-8785C"
    annotation (Placement(transformation(extent={{-10,0},{10,20}})));
  Modelica.Blocks.Noise.BandLimitedWhiteNoise whiteNoise(samplePeriod=
       0.005)
    annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
  constant SI.Velocity unitVelocity = 1 annotation(HideResult=true);
  Modelica.Blocks.Math.Gain compareToSpeed(k=unitVelocity/V)
    annotation (Placement(transformation(extent={{40,0},{60,20}})));
  inner Modelica.Blocks.Noise.GlobalSeed globalSeed
    annotation (Placement(transformation(extent={{40,60},{60,80}})));
equation
  connect(whiteNoise.y, Hw.u) annotation (Line(
      points={{-39,10},{-12,10}}, color={0,0,127}));
  connect(Hw.y, compareToSpeed.u) annotation (Line(
      points={{11,10},{38,10}}, color={0,0,127}));
  annotation (experiment(StopTime=100),
 Documentation(info="<html>
<p>
This example shows how to use the
<a href=\"modelica://Modelica.Blocks.Noise.BandLimitedWhiteNoise\">BandLimitedWhiteNoise</a>
to feed a Dryden continuous turbulence model. This model is used to describe turbulent wind at low altitudes
that varies randomly in space
(see also <a href=\"https://en.wikipedia.org/wiki/Continuous_gusts\">wikipedia</a>).
</p>

<h4>
Turbulence model for vertical gust speed at low altitudes
</h4>

<p>
The turbulence model of the Dryden form is defined by the power spectral density of the vertical turbulent velocity:
</p>

<blockquote><p>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Examples/NoiseExamples/equation-erVWhiWU.png\" alt=\"Phi_w(Omega)=sigma^2*L_w/pi*((1+3*(L_w*Omega)^2)/(1+(L_w*Omega)^2)^2)\"/>
</p></blockquote>

<p>
The spectrum is parametrized with the following parameters:
</p>

<ul>
<li> Lw is the turbulence scale.<br>In low altitudes, it is equal to the flight altitude.</li>
<li> sigma is the turbulence intensity.<br>In low altitudes, it is equal to 1/10 of the
     wind speed at 20 ft altitude, which is 30 kts for medium turbulence.</li>
<li> Omega is the spatial frequency.<br> The turbulence model is thus defined in space and the aircraft experiences turbulence as it flies through the defined wind field.</li>
<li> Omega = s/V will be used to transform the spatial definition into a temporal definition, which can be realized as a state space system.</li>
<li> V is the airspeed of the aircraft.<br>It is approximately 150 kts during the approach (i.e. at low altitudes).</li>
</ul>

<p>
Using spectral factorization and a fixed airspeed V of the aircraft, a concrete forming filter for the vertical turbulence can be found as
</p>

<blockquote><p>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Examples/NoiseExamples/equation-W0zl2Gay.png\" alt=\"H_w(s) = sigma*sqrt(L_w/(pi*V)) * ((1 + sqrt(3)*L_w/V*s) / (1+L_w/V*s)^2)\"/>,
</p></blockquote>

<p>
for which V * (H_w(i Omega/V) * H_w(-i Omega/V) = Phi_w(Omega).
</p>

<h4>
The input to the filter
</h4>

<p>
The input to the filter is white noise with a normal distribution, zero mean, and a power spectral density of 1.
That means, for a sampling time of 1s, it is parameterized with mean=0 and variance=1.
However, in order to account for the change of noise power due to sampling, the noise must be scaled with sqrt(samplePeriod).
This is done automatically in the
<a href=\"modelica://Modelica.Blocks.Noise.BandLimitedWhiteNoise\">BandLimitedWhiteNoise</a> block.
</p>

<h4>Example output</h4>

<blockquote>
<p>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Examples/NoiseExamples/DrydenContinuousTurbulence.png\"/>
</p></blockquote>

<h4>
Reference
</h4>

<ol>
<li>Dryden Wind Turbulence model in US military standard
    <a href=\"http://everyspec.com/MIL-SPECS/MIL-SPECS-MIL-F/MIL-F-8785C_5295/\">MIL-F-8785</a>.</li>
</ol>
</html>"));
end DrydenContinuousTurbulence;
