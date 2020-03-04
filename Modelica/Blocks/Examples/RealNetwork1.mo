within Modelica.Blocks.Examples;
model RealNetwork1 "Demonstrates the usage of blocks from Modelica.Blocks.Math"

  extends Modelica.Icons.Example;

  Modelica.Blocks.Math.MultiSum add(nu=2)
    annotation (Placement(transformation(extent={{-14,64},{-2,76}})));
  Sources.Sine sine(amplitude=3, f=0.1)
    annotation (Placement(transformation(extent={{-96,60},{-76,80}})));
  Sources.Step integerStep(height=3, startTime=2)
    annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
  Sources.Constant integerConstant(k=1)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Blocks.Interaction.Show.RealValue showValue
    annotation (Placement(transformation(extent={{66,60},{86,80}})));
  Math.MultiProduct product(nu=2)
    annotation (Placement(transformation(extent={{6,24},{18,36}})));
  Modelica.Blocks.Interaction.Show.RealValue showValue1(significantDigits=2)
    annotation (Placement(transformation(extent={{64,20},{84,40}})));
  Sources.BooleanPulse booleanPulse1(period=1)
    annotation (Placement(transformation(extent={{-12,-30},{8,-10}})));
  Math.MultiSwitch multiSwitch(
    nu=2,
    expr={4,6},
    y_default=2)
    annotation (Placement(transformation(extent={{28,-60},{68,-40}})));
  Sources.BooleanPulse booleanPulse2(period=2, width=80)
    annotation (Placement(transformation(extent={{-12,-70},{8,-50}})));
  Modelica.Blocks.Interaction.Show.RealValue showValue3(
    use_numberPort=false,
    number=multiSwitch.y,
    significantDigits=1)
    annotation (Placement(transformation(extent={{40,-84},{60,-64}})));
  Math.LinearDependency linearDependency1(
    y0=1,
    k1=2,
    k2=3) annotation (Placement(transformation(extent={{40,80},{60,100}})));
  Math.MinMax minMax(nu=2)
    annotation (Placement(transformation(extent={{58,-16},{78,4}})));
equation
  connect(booleanPulse1.y, multiSwitch.u[1]) annotation (Line(
      points={{9,-20},{18,-20},{18,-48},{28,-48},{28,-48.5}}, color={255,0,255}));
  connect(booleanPulse2.y, multiSwitch.u[2]) annotation (Line(
      points={{9,-60},{18,-60},{18,-52},{28,-52},{28,-51.5}}, color={255,0,255}));
  connect(sine.y, add.u[1]) annotation (Line(
      points={{-75,70},{-46.5,70},{-46.5,72.1},{-14,72.1}}, color={0,0,127}));
  connect(integerStep.y, add.u[2]) annotation (Line(
      points={{-39,40},{-28,40},{-28,67.9},{-14,67.9}}, color={0,0,127}));
  connect(add.y, showValue.numberPort) annotation (Line(
      points={{-0.98,70},{64.5,70}}, color={0,0,127}));
  connect(integerStep.y, product.u[1]) annotation (Line(
      points={{-39,40},{-20,40},{-20,32.1},{6,32.1}}, color={0,0,127}));
  connect(integerConstant.y, product.u[2]) annotation (Line(
      points={{-39,0},{-20,0},{-20,27.9},{6,27.9}}, color={0,0,127}));
  connect(product.y, showValue1.numberPort) annotation (Line(
      points={{19.02,30},{62.5,30}}, color={0,0,127}));
  connect(add.y, linearDependency1.u1) annotation (Line(
      points={{-0.98,70},{20,70},{20,96},{38,96}}, color={0,0,127}));
  connect(product.y, linearDependency1.u2) annotation (Line(
      points={{19.02,30},{30,30},{30,84},{38,84}}, color={0,0,127}));
  connect(add.y, minMax.u[1]) annotation (Line(
      points={{-0.98,70},{48,70},{48,-2.5},{58,-2.5}}, color={0,0,127}));
  connect(product.y, minMax.u[2]) annotation (Line(
      points={{19.02,30},{40,30},{40,-9.5},{58,-9.5}}, color={0,0,127}));
  annotation (
    experiment(StopTime=10),
    Documentation(info="<html>
<p>
This example demonstrates a network of mathematical Real blocks.
from package <a href=\"modelica://Modelica.Blocks.Math\">Modelica.Blocks.Math</a>.
Note, that
</p>

<ul>
<li> at the right side of the model, several Math.ShowValue blocks
     are present, that visualize the actual value of the respective Real
     signal in a diagram animation.</li>

<li> the Boolean values of the input and output signals are visualized
     in the diagram animation, by the small \"circles\" close to the connectors.
     If a \"circle\" is \"white\", the signal is <strong>false</strong>. If a
     \"circle\" is \"green\", the signal is <strong>true</strong>.</li>
</ul>

</html>"));
end RealNetwork1;
