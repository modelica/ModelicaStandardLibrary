within Modelica.Mechanics.Translational.Examples.Utilities;
function GenerateStribeckFrictionTable
  "Generate Stribeck friction table for example Friction for the SupportFriction"
  extends Modelica.Icons.Function;
  input Real F_prop(final unit="N.s/m", final min=0)
    "Velocity dependent friction coefficient";
  input SI.Force F_Coulomb
    "Constant friction: Coulomb force";
  input SI.Force F_Stribeck "Stribeck effect";
  input Real fexp(final unit="s/m", final min=0) "Exponential decay";
  input Real v_max "Generate table from v=0 ... v_max";
  input Integer nTable(min=2) = 100 "Number of table points";
  output Real table[nTable, 2] "Friction table";
algorithm
  for i in 1:nTable loop
    table[i, 1] := v_max*(i - 1)/(nTable - 1);
    table[i, 2] := F_Coulomb + F_prop*table[i, 1] + F_Stribeck*Modelica.Math.exp(-fexp*
      table[i, 1]);
  end for;
  annotation (Documentation(info="<html>
<p>
Returns a table with the friction characteristic
table[nTable,&nbsp;2]&nbsp;=&nbsp;[0,&nbsp;f1;&nbsp;&hellip;;&nbsp;v_max,&nbsp;fn],
where the first column is the velocity&nbsp;v in the range 0&nbsp;&hellip;&nbsp;v_max
and the second column is the friction force according to the Stribeck curve:
</p>

<blockquote><pre>
f = F_Coulomb + F_prop*v + F_Stribeck*exp(-fexp*v);
</pre></blockquote>
</html>"));
end GenerateStribeckFrictionTable;
