within ModelicaTest.Fluid.TestComponents.Sensors;
model TestSpecificEntropy
  import Modelica.Fluid;
  extends Modelica.Icons.Example;
  inner Modelica.Fluid.System system  annotation (Placement(transformation(
          extent={{-100,-100},{-80,-80}})));
  Modelica.Fluid.Sources.Boundary_ph boundary_prescriberho_1(nPorts=1,
    use_h_in=true,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=system.p_ambient) annotation (Placement(transformation(extent={{
            -40,10},{-20,30}})));
  Modelica.Fluid.Sensors.SpecificEntropy specificEntropy(redeclare package
      Medium =         Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-10,20},{10,40}})));
  Modelica.Fluid.Sources.Boundary_ph boundary_prescriberho_2(nPorts=1,
    use_h_in=true,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=system.p_ambient) annotation (Placement(transformation(extent={{
            -40,-30},{-20,-10}})));
  Modelica.Fluid.Sensors.SpecificEntropyTwoPort specificEntropy1(redeclare
      package Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-10,-30},{10,-10}})));
  Modelica.Blocks.Sources.Sine sine1(amplitude=1600e3, offset=1800e3,
    freqHz=1)                       annotation (Placement(transformation(extent=
           {{-80,-10},{-60,10}})));
equation
  connect(boundary_prescriberho_1.ports[1], specificEntropy.port)
                                                            annotation (Line(
      points={{-20,20},{0,20}}, color={0,127,255}));
  connect(sine1.y, boundary_prescriberho_1.h_in) annotation (Line(
      points={{-59,0},{-52,0},{-52,24},{-42,24}}, color={0,0,127}));
  connect(sine1.y, boundary_prescriberho_2.h_in) annotation (Line(
      points={{-59,0},{-52,0},{-52,-16},{-42,-16}}, color={0,0,127}));
  connect(boundary_prescriberho_2.ports[1], specificEntropy1.port_a)
                                                               annotation (Line(
      points={{-20,-20},{-10,-20}}, color={0,127,255}));
  annotation (
    experiment(StopTime=1.01, Tolerance=1e-006));
end TestSpecificEntropy;
