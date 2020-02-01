within Modelica.Electrical.Machines.Thermal;
function linearTemperatureDependency
  "Converts a value (e.g. resistance) from reference temperature to an actual temperature"
  extends Modelica.Icons.Function;
  input Real RRef "Value at TRef";
  input SI.Temperature TRef "Reference temperature";
  input SI.LinearTemperatureCoefficient alpha20
    "Temperature coefficient at 20 degC";
  input SI.Temperature T "Actual temperature";
  output Real R "Actual value at T";
algorithm
  R := RRef*(1 + Machines.Thermal.convertAlpha(alpha20, TRef)*(T - TRef));
  annotation (Inline=true,Documentation(info="<html>
<p>
This is the same function as Modelica.Electrical.Machines.Thermal.convertResistance but without physical units for input RRef and result R.
This avoids problems if the function is used to calculate linear temperature dependency for other values than resistances.
</p>
<p>
From the temperature coefficient <code>alpha20</code> at 20 degC (equals to 293.15 K) the parameter <code>alphaRef</code> at <code>TRef</code>
</p>
<blockquote><pre>
                      alpha20
alphaRef = -------------------------------
            1 + alpha20 * (TRef - 293.15)
</pre></blockquote>
<p>
is determined; using this value, actual value (e.g. resistance <code>R</code>) with respect to the actual temperature <code>T</code> is calculated by
</p>
<blockquote><pre>
  R
------ = 1 + alphaRef * (T - TRef)
 RRef
</pre></blockquote>
<p>
where <code>RRef</code> is the value (e.g. resistance) at the reference temperature <code>TRef</code>.
</p>
</html>"));
end linearTemperatureDependency;
