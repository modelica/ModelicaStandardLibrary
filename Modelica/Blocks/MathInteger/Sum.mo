within Modelica.Blocks.MathInteger;
block Sum "Sum of Integers: y = k[1]*u[1] + k[2]*u[2] + ... + k[n]*u[n]"
   extends Modelica.Blocks.Interfaces.PartialIntegerMISO;
   parameter Integer k[nu] = fill(1,nu) "Input gains";
equation
  if size(u,1) > 0 then
     y = k*u;
  else
     y = 0;
  end if;
  annotation (Icon(graphics={Text(
            extent={{-200,-110},{200,-140}},
            textString="%k"), Text(
            extent={{-72,68},{92,-68}},
            textString="+")}), Documentation(info="<html>
<p>
This blocks computes the scalar Integer output \"y\" as sum of the elements of the
Integer input signal vector u:
</p>
<blockquote><pre>
y = k[1]*u[1] + k[2]*u[2] + ... k[N]*u[N];
</pre></blockquote>

<p>
The input connector is a vector of Integer input signals.
When a connection line is drawn, the dimension of the input
vector is enlarged by one and the connection is automatically
connected to this new free index (thanks to the
connectorSizing annotation).
</p>

<p>
The usage is demonstrated, e.g., in example
<a href=\"modelica://Modelica.Blocks.Examples.IntegerNetwork1\">Modelica.Blocks.Examples.IntegerNetwork1</a>.
</p>

<p>
If no connection to the input connector \"u\" is present,
the output is set to zero: y=0.
</p>
</html>"));
end Sum;
