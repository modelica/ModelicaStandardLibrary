within Modelica.Blocks.MathBoolean;
block Or "Logical 'or': y = u[1] or u[2] or ... or u[nu]"
  extends Modelica.Blocks.Interfaces.PartialBooleanMISO;

equation
  y = Modelica.Math.BooleanVectors.anyTrue(
                            u);
  annotation (defaultComponentName="or1", Icon(graphics={Text(
            extent={{-80,40},{60,-40}},
            textString="or")}),
    Documentation(info="<html>
<p>
The output is <strong>true</strong> if at least one input is <strong>true</strong>, otherwise
the output is <strong>false</strong>.
</p>

<p>
The input connector is a vector of Boolean input signals.
When a connection line is drawn, the dimension of the input
vector is enlarged by one and the connection is automatically
connected to this new free index (thanks to the
connectorSizing annotation).
</p>

<p>
The usage is demonstrated, e.g., in example
<a href=\"modelica://Modelica.Blocks.Examples.BooleanNetwork1\">Modelica.Blocks.Examples.BooleanNetwork1</a>.
</p>

<p>
If no connection to the input connector \"u\" is present,
the output is set to <strong>false</strong>: y=false.
</p>

</html>"));
end Or;
