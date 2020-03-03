within Modelica.Blocks.Routing;
block DeMultiplex3 "DeMultiplexer block for three output connectors"
  extends Modelica.Blocks.Icons.Block;
  parameter Integer n1=1 "Dimension of output signal connector 1";
  parameter Integer n2=1 "Dimension of output signal connector 2";
  parameter Integer n3=1 "Dimension of output signal connector 3";
  Modelica.Blocks.Interfaces.RealInput u[n1 + n2 + n3]
    "Connector of Real input signals" annotation (Placement(transformation(
          extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput y1[n1]
    "Connector of Real output signals 1" annotation (Placement(transformation(
          extent={{100,60},{120,80}})));
  Modelica.Blocks.Interfaces.RealOutput y2[n2]
    "Connector of Real output signals 2" annotation (Placement(transformation(
          extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealOutput y3[n3]
    "Connector of Real output signals 3" annotation (Placement(transformation(
          extent={{100,-80},{120,-60}})));

equation
  [u] = [y1; y2; y3];
  annotation (
    Documentation(info="<html>
<p>
The input connector is <strong>split</strong> into three output connectors.
Note, that the dimensions of the output connector signals have to be
explicitly defined via parameters n1, n2 and n3.
</p>
</html>"),
         Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Ellipse(
          extent={{-15,15},{15,-15}},
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,127}),
        Line(points={{-100,0},{-6,0}}, color={0,0,127}),
        Line(points={{100,70},{60,70},{0,0}}, color={0,0,127}),
        Line(points={{0,0},{100,0}}, color={0,0,127}),
        Line(points={{100,-70},{60,-70},{0,0}}, color={0,0,127})}));
end DeMultiplex3;
