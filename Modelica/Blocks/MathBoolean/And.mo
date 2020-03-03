within Modelica.Blocks.MathBoolean;
block And "Logical 'and': y = u[1] and u[2] and ... and u[nu]"
  extends Modelica.Blocks.Interfaces.PartialBooleanMISO;

equation
  y = Modelica.Math.BooleanVectors.andTrue(
                            u);
  annotation (defaultComponentName="and1", Icon(graphics={Text(
            extent={{-76,40},{60,-40}},
            textString="and")}),
    Documentation(info="<html>
<p>
The output is <strong>true</strong> if all inputs are <strong>true</strong>, otherwise
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
the output is set to <strong>true</strong>: y=true.
</p>
</html>"));
end And;
