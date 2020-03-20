within Modelica.Magnetic.QuasiStatic.FluxTubes.Examples.Leakage;
model CylinderLeakage "Testing cylinder leakage models"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  parameter SI.RelativePermeability mu_rConst = 100
  "Relative permeability";
  Shapes.Leakage.QuarterCylinder quarterCylinder1(l=2*pi*0.1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Shapes.FixedShape.HollowCylinderAxialFlux hollowCylinderAxialFlux1(
    r_i=0,
    r_o=0.04,
    l=0.1,
    mu_rConst=mu_rConst)
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Shapes.FixedShape.HollowCylinderAxialFlux hollowCylinderAxialFlux2(
    r_i=0,
    l=0.1,
    r_o=0.05,
    mu_rConst=mu_rConst)
           annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Shapes.Leakage.QuarterCylinder quarterCylinder2(l=2*pi*0.1)
    annotation (Placement(transformation(extent={{50,-10},{70,10}})));
  Sources.ConstantMagneticFlux constantSource(
    gamma(fixed=true, start=0), f=50, Phi=Complex(re=5E-3, im=0))
    annotation (Placement(transformation(extent={{-50,-10},{-70,10}})));
  Basic.Ground ground1 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-90,0})));
  Shapes.FixedShape.HollowCylinderAxialFlux hollowCylinderAxialAir1(
    r_i=0,
    r_o=0.04,
    l=0.01) annotation (Placement(transformation(extent={{-10,-30},{10,-10}})));
  Shapes.FixedShape.HollowCylinderAxialFlux hollowCylinderAxialAir2(
    r_i=0,
    r_o=0.04,
    l=0.01) annotation (Placement(transformation(extent={{50,-30},{70,-10}})));
Sensors.MagneticPotentialSensor magneticPotentialSensor annotation (
    Placement(transformation(
      extent={{-10,-10},{10,10}},
      rotation=270,
      origin={-40,-80})));
Sensors.MagneticPotentialDifferenceSensor
  magneticPotentialDifferenceSensor
  annotation (Placement(transformation(extent={{-50,-40},{-70,-20}})));
Sensors.MagneticFluxSensor magneticFluxSensor
  annotation (Placement(transformation(extent={{-50,40},{-70,20}})));
Sensors.ReferenceSensor referenceSensor
  annotation (Placement(transformation(extent={{-20,-70},{0,-50}})));
Sensors.FrequencySensor frequencySensor
  annotation (Placement(transformation(extent={{-60,-70},{-80,-50}})));
equation
  connect(quarterCylinder2.port_p, hollowCylinderAxialFlux2.port_n) annotation (
     Line(
      points={{50,0},{40,0}},
      color={255,170,85}));
  connect(hollowCylinderAxialFlux2.port_p, quarterCylinder1.port_n) annotation (
     Line(
      points={{20,0},{10,0}},
      color={255,170,85}));
  connect(quarterCylinder1.port_p, hollowCylinderAxialFlux1.port_n) annotation (
     Line(
      points={{-10,0},{-20,0}},
      color={255,170,85}));
  connect(hollowCylinderAxialAir2.port_n, quarterCylinder2.port_n) annotation (
      Line(
      points={{70,-20},{80,-20},{80,0},{70,0}},
      color={255,170,85}));
  connect(hollowCylinderAxialAir2.port_p, hollowCylinderAxialFlux2.port_n)
    annotation (Line(
      points={{50,-20},{40,-20},{40,0}},
      color={255,170,85}));
  connect(hollowCylinderAxialAir1.port_n, hollowCylinderAxialFlux2.port_p)
    annotation (Line(
      points={{10,-20},{20,-20},{20,0}},
      color={255,170,85}));
  connect(hollowCylinderAxialAir1.port_p, hollowCylinderAxialFlux1.port_n)
    annotation (Line(
      points={{-10,-20},{-20,-20},{-20,0}},
      color={255,170,85}));
connect(ground1.port, constantSource.port_n) annotation (Line(
    points={{-80,0},{-76,0},{-76,0},{-70,0}},
    color={255,170,85}));
connect(constantSource.port_p, hollowCylinderAxialFlux1.port_p)
  annotation (Line(
    points={{-50,0},{-40,0}},
    color={255,170,85}));
connect(ground1.port, magneticPotentialDifferenceSensor.port_n)
  annotation (Line(
    points={{-80,0},{-80,-30},{-70,-30}},
    color={255,170,85}));
connect(magneticPotentialDifferenceSensor.port_p,
  hollowCylinderAxialFlux1.port_p) annotation (Line(
    points={{-50,-30},{-40,-30},{-40,0}},
    color={255,170,85}));
connect(hollowCylinderAxialFlux1.port_p, magneticPotentialSensor.port)
  annotation (Line(
    points={{-40,0},{-40,-70}},
    color={255,170,85}));
connect(magneticFluxSensor.port_n, ground1.port) annotation (Line(
    points={{-70,30},{-80,30},{-80,0}},
    color={255,170,85}));
connect(magneticFluxSensor.port_p, quarterCylinder2.port_n) annotation (
    Line(
    points={{-50,30},{80,30},{80,0},{70,0}},
    color={255,170,85}));
connect(frequencySensor.port, hollowCylinderAxialFlux1.port_p)
  annotation (Line(
    points={{-60,-60},{-40,-60},{-40,0}},
    color={255,170,85}));
connect(referenceSensor.port, hollowCylinderAxialFlux1.port_p)
  annotation (Line(
    points={{-20,-60},{-40,-60},{-40,0}},
    color={255,170,85}));
  annotation (experiment(StopTime=1,Interval=0.001),
  Documentation(info="<html>
<p>Test of one source and cylindrical components with leakage and various sensors.</p>
</html>"));
end CylinderLeakage;
