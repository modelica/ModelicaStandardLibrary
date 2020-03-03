within Modelica.Blocks.Routing;
block DeMultiplex2 "DeMultiplexer block for two output connectors"
  extends Modelica.Blocks.Icons.Block;
  parameter Integer n1=1 "Dimension of output signal connector 1";
  parameter Integer n2=1 "Dimension of output signal connector 2";
  Modelica.Blocks.Interfaces.RealInput u[n1 + n2]
    "Connector of Real input signals" annotation (Placement(transformation(
          extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput y1[n1]
    "Connector of Real output signals 1" annotation (Placement(transformation(
          extent={{100,50},{120,70}})));
  Modelica.Blocks.Interfaces.RealOutput y2[n2]
    "Connector of Real output signals 2" annotation (Placement(transformation(
          extent={{100,-70},{120,-50}})));

equation
  [u] = [y1; y2];
  annotation (
    Documentation(info="<html>
<p>
The input connector is <strong>split</strong> up into two output connectors.
Note, that the dimensions of the output connector signals have to be
explicitly defined via parameters n1 and n2.
</p>
</html>"),
         Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}),
      graphics={
        Line(points={{100,60},{60,60},{0,0}}, color={0,0,127}),
        Ellipse(
          extent={{-15,15},{15,-15}},
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,127}),
        Line(points={{100,-60},{60,-60},{0,0}}, color={0,0,127}),
        Line(points={{-100,0},{-6,0}}, color={0,0,127})}));
end DeMultiplex2;
