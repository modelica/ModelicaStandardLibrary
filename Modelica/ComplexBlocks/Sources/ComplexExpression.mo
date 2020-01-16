within Modelica.ComplexBlocks.Sources;
block ComplexExpression
  "Set output signal to a time varying Complex expression"

  Modelica.ComplexBlocks.Interfaces.ComplexOutput y=Complex(0)
    "Value of Complex output" annotation (Dialog(group=
          "Time varying output signal"), Placement(transformation(extent={{
            100,-10},{120,10}})));

  annotation (defaultComponentName="complexExpr",
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={Rectangle(
              extent={{-100,40},{100,-40}},
              lineThickness=5.0,
              fillColor={235,235,235},
              fillPattern=FillPattern.Solid,
              borderPattern=BorderPattern.Raised),Text(
              extent={{-96,15},{96,-15}},
              textString="%y"),Text(
              extent={{-150,90},{140,50}},
              textString="%name",
              textColor={0,0,255})}), Documentation(info="<html>
<p>
The (time varying) Complex output signal of this block can be defined in its
parameter menu via variable <strong>y</strong>. The purpose is to support the
easy definition of Complex expressions in a block diagram.
Note, that \"time\" is a built-in variable that is always
accessible and represents the \"model time\" and that
Variable <strong>y</strong> is both a variable and a connector.
</p>
</html>"));

end ComplexExpression;
