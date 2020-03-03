within Modelica.Blocks.Routing;
block DeMultiplex5 "DeMultiplexer block for five output connectors"

  extends Modelica.Blocks.Icons.Block;
  parameter Integer n1=1 "Dimension of output signal connector 1";
  parameter Integer n2=1 "Dimension of output signal connector 2";
  parameter Integer n3=1 "Dimension of output signal connector 3";
  parameter Integer n4=1 "Dimension of output signal connector 4";
  parameter Integer n5=1 "Dimension of output signal connector 5";
  Modelica.Blocks.Interfaces.RealInput u[n1 + n2 + n3 + n4 + n5]
    "Connector of Real input signals" annotation (Placement(transformation(
          extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput y1[n1]
    "Connector of Real output signals 1" annotation (Placement(transformation(
          extent={{100,70},{120,90}})));
  Modelica.Blocks.Interfaces.RealOutput y2[n2]
    "Connector of Real output signals 2" annotation (Placement(transformation(
          extent={{100,30},{120,50}})));
  Modelica.Blocks.Interfaces.RealOutput y3[n3]
    "Connector of Real output signals 3" annotation (Placement(transformation(
          extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealOutput y4[n4]
    "Connector of Real output signals 4" annotation (Placement(transformation(
          extent={{100,-50},{120,-30}})));
  Modelica.Blocks.Interfaces.RealOutput y5[n5]
    "Connector of Real output signals 5" annotation (Placement(transformation(
          extent={{100,-90},{120,-70}})));

equation
  [u] = [y1; y2; y3; y4; y5];
  annotation (
    Documentation(info="<html>
<p>
The input connector is <strong>split</strong> into five output connectors.
Note, that the dimensions of the output connector signals have to be
explicitly defined via parameters n1, n2, n3, n4 and n5.</p>
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
        Line(points={{100,80},{60,80},{0,0}}, color={0,0,127}),
        Line(points={{100,40},{60,40},{8,4}}, color={0,0,127}),
        Line(points={{100,0},{10,0}}, color={0,0,127}),
        Line(points={{100,-40},{60,-40},{8,-4}}, color={0,0,127}),
        Line(points={{100,-80},{60,-80},{0,0}}, color={0,0,127})}));
end DeMultiplex5;
