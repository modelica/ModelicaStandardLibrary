within Modelica.Blocks.Interfaces;
connector IntegerOutput = output Integer "'output Integer' as connector"
  annotation (
  defaultComponentName="y",
  Icon(coordinateSystem(
      preserveAspectRatio=true,
      extent={{-100,-100},{100,100}}), graphics={Polygon(
        points={{-100,100},{100,0},{-100,-100},{-100,100}},
        lineColor={255,127,0},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid)}),
  Diagram(coordinateSystem(
      preserveAspectRatio=true,
      extent={{-100,-100},{100,100}}), graphics={Polygon(
        points={{-100,50},{0,0},{-100,-50},{-100,50}},
        lineColor={255,127,0},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid), Text(
        extent={{30,110},{30,60}},
        textColor={255,127,0},
        textString="%name")}),
  Documentation(info="<html>
<p>
Connector with one output signal of type Integer.
</p>
</html>"));
