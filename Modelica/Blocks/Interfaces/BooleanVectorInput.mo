within Modelica.Blocks.Interfaces;
connector BooleanVectorInput = input Boolean
  "Boolean input connector used for vector of connectors" annotation (
  defaultComponentName="u",
  Icon(graphics={Ellipse(
        extent={{-100,-100},{100,100}},
        lineColor={255,0,255},
        fillColor={255,0,255},
        fillPattern=FillPattern.Solid)}, coordinateSystem(
      extent={{-100,-100},{100,100}},
      preserveAspectRatio=false,
      initialScale=0.2)),
  Diagram(coordinateSystem(
      preserveAspectRatio=false,
      initialScale=0.2,
      extent={{-100,-100},{100,100}}), graphics={Text(
        extent={{-10,85},{-10,60}},
        textColor={255,0,255},
        textString="%name"), Ellipse(
        extent={{-50,50},{50,-50}},
        lineColor={255,0,255},
        fillColor={255,0,255},
        fillPattern=FillPattern.Solid)}),
  Documentation(info="<html>
<p>
Boolean input connector that is used for a vector of connectors,
for example <a href=\"modelica://Modelica.Blocks.Interfaces.PartialBooleanMISO\">PartialBooleanMISO</a>,
and has therefore a different icon as BooleanInput connector.
</p>
</html>"));
