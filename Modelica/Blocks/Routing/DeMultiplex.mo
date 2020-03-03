within Modelica.Blocks.Routing;
block DeMultiplex "DeMultiplexer block for arbitrary number of output connectors"
  extends Modelica.Blocks.Icons.Block;
  parameter Integer n(min=0)=0 "Dimension of output signal connector" annotation(Dialog(connectorSizing=true), HideResult=true);
  Modelica.Blocks.Interfaces.RealInput u[n+0]
    "Connector of Real input signals" annotation(Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealVectorOutput y[n]
    "Connector of Real output signals"
                                      annotation(Placement(transformation(extent={{80,70},{120,-70}})));

equation
    y = u;
  annotation (
    defaultComponentName="demux",
    Documentation(info="<html>
<p>
The input connector is <strong>split</strong> up into output connectors.
</p>
</html>"),
    Icon(
      coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}),
      graphics={
        Line(points={{8,0},{102,0}}, color={0,0,127}),
        Ellipse(
          extent={{-15,15},{15,-15}},
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,127}),
        Line(points={{-100,0},{-6,0}}, color={0,0,127}),
        Line(points={{100,70},{60,70},{4,4}}, color={0,0,127}),
        Line(points={{0,0},{100,0}}, color={0,0,127}),
        Line(points={{100,-70},{60,-70},{4,-4}}, color={0,0,127}),
        Text(
          extent={{-140,-90},{150,-50}},
          textString="n=%n")}));
end DeMultiplex;
