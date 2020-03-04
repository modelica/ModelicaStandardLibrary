within Modelica.Blocks.MathBoolean;
block Not "Logical 'not': y = not u"
  extends Modelica.Blocks.Interfaces.PartialBooleanSISO_small;

equation
  y = not u;
  annotation (defaultComponentName="not1", Icon(graphics={Text(
            extent={{-98,40},{42,-40}},
            textString="not")}),
    Documentation(info="<html>
<p>
The output is <strong>false</strong> if at least one input is <strong>true</strong>, otherwise
the output is <strong>true</strong>.
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
</html>"));
end Not;
