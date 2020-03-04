within Modelica.Blocks.Routing;
block Multiplex2 "Multiplexer block for two input connectors"
  extends Modelica.Blocks.Icons.Block;
  parameter Integer n1=1 "Dimension of input signal connector 1";
  parameter Integer n2=1 "Dimension of input signal connector 2";
  Modelica.Blocks.Interfaces.RealInput u1[n1]
    "Connector of Real input signals 1" annotation (Placement(transformation(
          extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Interfaces.RealInput u2[n2]
    "Connector of Real input signals 2" annotation (Placement(transformation(
          extent={{-140,-80},{-100,-40}})));
  Modelica.Blocks.Interfaces.RealOutput y[n1 + n2]
    "Connector of Real output signals" annotation (Placement(transformation(
          extent={{100,-10},{120,10}})));

equation
  [y] = [u1; u2];
  annotation (
    Documentation(info="<html>
<p>
The output connector is the <strong>concatenation</strong> of the two input connectors.
Note, that the dimensions of the input connector signals have to be
explicitly defined via parameters n1 and n2.
</p>
</html>"),
         Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Line(points={{8,0},{102,0}}, color={0,0,127}),
        Ellipse(
          extent={{-15,15},{15,-15}},
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,127}),
        Line(points={{-100,60},{-60,60},{0,0}}, color={0,0,127}),
        Line(points={{-100,-60},{-60,-60},{0,0}}, color={0,0,127})}));
end Multiplex2;
