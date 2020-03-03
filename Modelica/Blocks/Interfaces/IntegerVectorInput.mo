within Modelica.Blocks.Interfaces;
connector IntegerVectorInput = input Integer
  "Integer input connector used for vector of connectors" annotation (
  defaultComponentName="u",
  Icon(graphics={Ellipse(
        extent={{-100,100},{100,-100}},
        lineColor={255,128,0},
        fillColor={255,128,0},
        fillPattern=FillPattern.Solid)}, coordinateSystem(
      extent={{-100,-100},{100,100}},
      preserveAspectRatio=true,
      initialScale=0.2)),
  Diagram(coordinateSystem(
      preserveAspectRatio=false,
      initialScale=0.2,
      extent={{-100,-100},{100,100}}), graphics={Text(
        extent={{-10,85},{-10,60}},
        textColor={255,128,0},
        textString="%name"), Ellipse(
        extent={{-50,50},{50,-50}},
        lineColor={255,128,0},
        fillColor={255,128,0},
        fillPattern=FillPattern.Solid)}),
  Documentation(info="<html>

<p>
Integer input connector that is used for a vector of connectors,
for example <a href=\"modelica://Modelica.Blocks.Interfaces.PartialIntegerMISO\">PartialIntegerMISO</a>,
and has therefore a different icon as IntegerInput connector.
</p>
</html>"));
