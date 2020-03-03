within Modelica.Blocks.MathBoolean;
block Nand "Logical 'nand': y = not ( u[1] and u[2] and ... and u[nu] )"
  extends Modelica.Blocks.Interfaces.PartialBooleanMISO;

equation
  y = not Modelica.Math.BooleanVectors.andTrue(
                                u);
  annotation (defaultComponentName="nand1", Icon(graphics={Text(
            extent={{-78,36},{64,-30}},
            textString="nand")}),
    Documentation(info="<html>
<p>
The output is <strong>true</strong> if at least one input is <strong>false</strong>, otherwise
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
end Nand;
