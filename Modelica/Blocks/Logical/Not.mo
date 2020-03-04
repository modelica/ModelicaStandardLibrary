within Modelica.Blocks.Logical;
block Not "Logical 'not': y = not u"
  extends Blocks.Interfaces.partialBooleanSISO;

equation
  y = not u;
  annotation (
    defaultComponentName="not1",
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={Text(
          extent={{-90,40},{90,-40}},
          textString="not")}),
    Documentation(info="<html>
<p>
The output is <strong>true</strong> if the input is <strong>false</strong>, otherwise
the output is <strong>false</strong>.
</p>
</html>"));
end Not;
