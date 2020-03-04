within Modelica.Blocks.Routing;
block Multiplex6 "Multiplexer block for six input connectors"
  extends Modelica.Blocks.Icons.Block;
  parameter Integer n1=1 "Dimension of input signal connector 1";
  parameter Integer n2=1 "Dimension of input signal connector 2";
  parameter Integer n3=1 "Dimension of input signal connector 3";
  parameter Integer n4=1 "Dimension of input signal connector 4";
  parameter Integer n5=1 "Dimension of input signal connector 5";
  parameter Integer n6=1 "Dimension of input signal connector 6";
  Modelica.Blocks.Interfaces.RealInput u1[n1]
    "Connector of Real input signals 1" annotation (Placement(transformation(
          extent={{-124,73},{-100,97}})));
  Modelica.Blocks.Interfaces.RealInput u2[n2]
    "Connector of Real input signals 2" annotation (Placement(transformation(
          extent={{-124,39},{-100,63}})));
  Modelica.Blocks.Interfaces.RealInput u3[n3]
    "Connector of Real input signals 3" annotation (Placement(transformation(
          extent={{-124,5},{-100,29}})));

  Modelica.Blocks.Interfaces.RealInput u4[n4]
    "Connector of Real input signals 4" annotation (Placement(transformation(
          extent={{-124,-29},{-100,-5}})));
  Modelica.Blocks.Interfaces.RealInput u5[n5]
    "Connector of Real input signals 5" annotation (Placement(transformation(
          extent={{-124,-63},{-100,-39}})));
  Modelica.Blocks.Interfaces.RealInput u6[n6]
    "Connector of Real input signals 6" annotation (Placement(transformation(
          extent={{-124,-97},{-100,-73}})));
  Modelica.Blocks.Interfaces.RealOutput y[n1 + n2 + n3 + n4 + n5 + n6]
    "Connector of Real output signals" annotation (Placement(transformation(
          extent={{100,-10},{120,10}})));

equation
  [y] = [u1; u2; u3; u4; u5; u6];
  annotation (
    Documentation(info="<html>
<p>
The output connector is the <strong>concatenation</strong> of the six input connectors.
Note, that the dimensions of the input connector signals have to be
explicitly defined via parameters n1, n2, n3, n4, n5 and n6.
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
        Line(points={{-100,85},{-60,85},{-3,10}}, color={0,0,127}),
        Line(points={{-100,51},{-60,51},{-7,6}}, color={0,0,127}),
        Line(points={{-100,-17},{-60,-17},{-10,-2}}, color={0,0,127}),
        Line(points={{-100,17},{-60,17},{-10,2}}, color={0,0,127}),
        Line(points={{-100,-51},{-60,-51},{-7,-6}}, color={0,0,127}),
        Line(points={{-100,-85},{-60,-85},{-3,-10}}, color={0,0,127})}));
end Multiplex6;
