within Modelica.Blocks.Interfaces;
connector RealVectorOutput = output Real
  "Real output connector used for vector of connectors" annotation (
  defaultComponentName="y",
  Icon(graphics={Ellipse(
        extent={{-100,100},{100,-100}},
        lineColor={0,0,127},
        fillColor={0,0,127},
        fillPattern=FillPattern.Solid)}, coordinateSystem(
      extent={{-100,-100},{100,100}},
      preserveAspectRatio=true,
      initialScale=0.2)),
  Diagram(coordinateSystem(
      preserveAspectRatio=false,
      initialScale=0.2,
      extent={{-100,-100},{100,100}}), graphics={Text(
        extent={{-10,85},{-10,60}},
        textColor={0,0,127},
        textString="%name"), Ellipse(
        extent={{-50,50},{50,-50}},
        lineColor={0,0,127},
        fillColor={0,0,127},
        fillPattern=FillPattern.Solid)}),
  Documentation(info="<html>
<p>
Real output connector that is used for a vector of connectors,
for example <a href=\"modelica://Modelica.Blocks.Routing.DeMultiplex\">DeMultiplex</a>,
and has therefore a different icon as RealOutput connector.
</p>
</html>"));
