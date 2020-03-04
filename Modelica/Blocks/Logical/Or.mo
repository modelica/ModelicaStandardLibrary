within Modelica.Blocks.Logical;
block Or "Logical 'or': y = u1 or u2"
  extends Blocks.Interfaces.partialBooleanSI2SO;
equation
  y = u1 or u2;
  annotation (
    defaultComponentName="or1",
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={Text(
          extent={{-90,40},{90,-40}},
          textString="or")}),
    Documentation(info="<html>
<p>
The output is <strong>true</strong> if at least one input is <strong>true</strong>, otherwise
the output is <strong>false</strong>.
</p>
</html>"));
end Or;
