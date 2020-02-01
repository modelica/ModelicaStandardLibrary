within Modelica.Electrical.Machines.Thermal;
function convertAlpha
  "Converts alpha from temperature 1 (default 20 degC) to temperature 2"
  extends Modelica.Icons.Function;
  input SI.LinearTemperatureCoefficient alpha1
    "Temperature coefficient at temperature 1 (default: 20 degC)";
  input SI.Temperature T2 "Temperature 2";
  input SI.Temperature T1=293.15
    "Temperature 1 (default: 20 degC)";
  output SI.LinearTemperatureCoefficient alpha2
    "Temperature coefficient at TRef";
algorithm
  alpha2 := alpha1/(1 + alpha1*(T2 - T1));
  annotation (Inline=true,Documentation(info="<html>
<p>
From the temperature coefficient <code>alpha1</code> at temperature <code>T1</code> (default 20 degC = 293.15 K)
the temperature coefficient <code>alpha2</code> at temperature <code>T2</code> is calculated:
</p>
<blockquote><pre>
              alpha1
alpha2 = ------------------------
          1 + alpha1 * (T2 - T1)
</pre></blockquote>
</html>"));
end convertAlpha;
