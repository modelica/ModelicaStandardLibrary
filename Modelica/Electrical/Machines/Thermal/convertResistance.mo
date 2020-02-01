within Modelica.Electrical.Machines.Thermal;
function convertResistance
  "Converts resistance from reference temperature to an actual temperature"
  extends Modelica.Icons.Function;
  input SI.Resistance RRef "Resistance at TRef";
  input SI.Temperature TRef "Reference temperature";
  input SI.LinearTemperatureCoefficient alpha20
    "Temperature coefficient at 20 degC";
  input SI.Temperature T "Actual temperature";
  output SI.Resistance R "Actual resistance at T";
algorithm
  R := RRef*(1 + Machines.Thermal.convertAlpha(alpha20, TRef)*(T - TRef));
  annotation (Inline=true,Documentation(info="<html>
<p>
From the temperature coefficient <code>alpha20</code> at 20 degC (equals to 293.15 K) the parameter <code>alphaRef</code> at <code>TRef</code>
</p>
<blockquote><pre>
                      alpha20
alphaRef = -------------------------------
            1 + alpha20 * (TRef - 293.15)
</pre></blockquote>
<p>
is determined; using this value, actual resistance <code>R</code> with respect to the actual temperature <code>T</code> is calculated by
</p>
<blockquote><pre>
  R
------ = 1 + alphaRef * (T - TRef)
 RRef
</pre></blockquote>
<p>
where <code>RRef</code> is the resistance at the reference temperature <code>TRef</code>.
</p>
</html>"));
end convertResistance;
