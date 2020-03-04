within Modelica.Blocks.Interfaces;
connector IntegerInput = input Integer "'input Integer' as connector"
  annotation (
  defaultComponentName="u",
  Icon(graphics={Polygon(
        points={{-100,100},{100,0},{-100,-100},{-100,100}},
        lineColor={255,127,0},
        fillColor={255,127,0},
        fillPattern=FillPattern.Solid)}, coordinateSystem(
      extent={{-100,-100},{100,100}},
      preserveAspectRatio=true,
      initialScale=0.2)),
  Diagram(coordinateSystem(
      preserveAspectRatio=true,
      initialScale=0.2,
      extent={{-100,-100},{100,100}}), graphics={Polygon(
        points={{0,50},{100,0},{0,-50},{0,50}},
        lineColor={255,127,0},
        fillColor={255,127,0},
        fillPattern=FillPattern.Solid), Text(
        extent={{-10,85},{-10,60}},
        textColor={255,127,0},
        textString="%name")}),
  Documentation(info="<html>
<p>
Connector with one input signal of type Integer.
</p>
</html>"));
