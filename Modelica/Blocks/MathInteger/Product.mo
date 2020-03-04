within Modelica.Blocks.MathInteger;
block Product "Product of Integer: y = u[1]*u[2]* ... *u[n]"
   extends Modelica.Blocks.Interfaces.PartialIntegerMISO;
equation
  if size(u,1) > 0 then
     y = product(u);
  else
     y = 0;
  end if;

  annotation (Icon(graphics={Text(
            extent={{-74,50},{94,-94}},
            textString="*")}), Documentation(info="<html>
<p>
This blocks computes the scalar Integer output \"y\" as product of the elements of the
Integer input signal vector u:
</p>
<blockquote><pre>
y = u[1]*u[2]* ... *u[N];
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
end Product;
