within Modelica.Blocks.Routing;
block Multiplex "Multiplexer block for arbitrary number of input connectors"
  extends Modelica.Blocks.Icons.Block;
  parameter Integer n(min=0)=0 "Dimension of input signal connector" annotation(Dialog(connectorSizing=true), HideResult=true);
  Modelica.Blocks.Interfaces.RealVectorInput u[n]
    "Connector of Real input signals" annotation(Placement(transformation(extent={{-120,70},{-80,-70}})));
  Modelica.Blocks.Interfaces.RealOutput y[n+0]
    "Connector of Real output signals" annotation(Placement(transformation(extent={{100,-10},{120,10}})));

equation
    y = u;
  annotation (
    defaultComponentName="mux",
    Documentation(info="<html>
<p>
The output connector is the <strong>concatenation</strong> of the input connectors.
</p>
</html>"),
    Icon(
      coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}),
      graphics={
        Line(points={{8,0},{102,0}}, color={0,0,127}),
        Line(points={{-100,70},{-60,70},{-4,4}}, color={0,0,127}),
        Line(points={{-100,0},{-12,0}}, color={0,0,127}),
        Line(points={{-100,-70},{-60,-70},{-4,-4}}, color={0,0,127}),
        Ellipse(
          extent={{-15,15},{15,-15}},
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,127}),
        Line(points={{-100,0},{-6,0}}, color={0,0,127}),
        Text(
          extent={{-140,-90},{150,-50}},
          textString="n=%n")}));
end Multiplex;
