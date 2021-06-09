within ModelicaTest.Fluid.TestComponents.Sensors;
model TestFlowRate
  import Modelica.Fluid;
  extends Modelica.Icons.Example;
  Modelica.Fluid.Fittings.SimpleGenericOrifice simpleGenericOrifice(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    zeta=2,
    diameter=0.1) annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  Modelica.Blocks.Sources.Sine sine(f=1)
                                    annotation (Placement(transformation(extent=
           {{-100,0},{-80,20}})));
  Modelica.Fluid.Sources.MassFlowSource_T massFlowRate1(nPorts=1,
    use_m_flow_in=true,
    T=Modelica.Units.Conversions.from_degC(50),
    redeclare package Medium = Modelica.Media.Water.StandardWater)
                                    annotation (Placement(transformation(extent=
           {{-60,0},{-40,20}})));
  Modelica.Fluid.Sources.Boundary_ph boundary_fixed(nPorts=1,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=system.p_ambient,
    h=3000e3) annotation (Placement(transformation(extent={{100,-10},{80,10}})));
  inner Modelica.Fluid.System system  annotation (Placement(transformation(
          extent={{-100,-100},{-80,-80}})));
  Modelica.Fluid.Sensors.MassFlowRate massFlowRate(redeclare package Medium =
        Modelica.Media.Water.StandardWater) annotation (Placement(
        transformation(extent={{10,-10},{30,10}})));
  Modelica.Fluid.Sensors.VolumeFlowRate volumeFlowRate(redeclare package Medium
      = Modelica.Media.Water.StandardWater) annotation (Placement(
        transformation(extent={{50,-10},{70,10}})));
equation
  connect(sine.y, massFlowRate1.m_flow_in) annotation (Line(
      points={{-79,10},{-70,10},{-70,18},{-60,18}}, color={0,0,127}));
  connect(massFlowRate1.ports[1], simpleGenericOrifice.port_a)
                                                           annotation (Line(
      points={{-40,10},{-32,10},{-32,0},{-20,0}}, color={0,127,255}));
  connect(volumeFlowRate.port_b, boundary_fixed.ports[1])
                                                      annotation (Line(
      points={{70,0},{80,0}}, color={0,127,255}));
  connect(massFlowRate.port_b, volumeFlowRate.port_a) annotation (Line(
      points={{30,0},{50,0}}, color={0,127,255}));
  connect(simpleGenericOrifice.port_b, massFlowRate.port_a) annotation (Line(
      points={{0,0},{10,0}}, color={0,127,255}));
  annotation (
    experiment(StopTime=1.01, Tolerance=1e-006));
end TestFlowRate;
