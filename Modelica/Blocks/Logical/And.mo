within Modelica.Blocks.Logical;
block And "Logical 'and': y = u1 and u2"
  extends Blocks.Interfaces.partialBooleanSI2SO;
equation
  y = u1 and u2;
  annotation (
    defaultComponentName="and1",
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={Text(
          extent={{-90,40},{90,-40}},
          textString="and")}),
    Documentation(info="<html>
<p>
The output is <strong>true</strong> if all inputs are <strong>true</strong>, otherwise
the output is <strong>false</strong>.
</p>
</html>"));
end And;
