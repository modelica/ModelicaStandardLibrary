within ModelicaTest.Fluid.TestComponents.Vessels;
model TestMixingVolumesPressureStates
  "Test case where in one of the mixing volumes a pressure state appears"
  import Modelica.Fluid;
  extends Modelica.Icons.Example;
  package Medium = Modelica.Media.Water.StandardWater;
  Modelica.Fluid.Vessels.ClosedVolume mixingVolume1(
    V=1e-3,
    redeclare package Medium = Medium,
    p_start=system.p_ambient,
    use_T_start=true,
    T_start=system.T_ambient,
    nPorts=2,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
    massDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
    use_portsData=false)
                 annotation (Placement(transformation(extent={{-30,38},{-10,58}},
          rotation=0)));

  Modelica.Fluid.Sources.MassFlowSource_h flowSource2(nPorts=1,
    m_flow=1,
    h=2e5,
    redeclare package Medium = Medium)
                   annotation (Placement(transformation(extent={{-100,30},{-80,
            50}}, rotation=0)));
  Modelica.Fluid.Vessels.ClosedVolume mixingVolume2(
    V=1e-3,
    p_start=system.p_ambient,
    use_T_start=false,
    h_start=1e5,
    redeclare package Medium = Medium,
    nPorts=2,
    use_portsData=false)
                 annotation (Placement(transformation(extent={{10,38},{30,58}},
          rotation=0)));
  Modelica.Fluid.Sensors.Temperature Tmix_in(
                                         redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-50,70},{-30,90}}, rotation=0)));
  Modelica.Fluid.Sensors.Temperature Tmix_out(
                                          redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{30,68},{50,88}}, rotation=0)));
  Modelica.Fluid.Sources.Boundary_ph sink2(nPorts=1,             redeclare
      package Medium =
               Medium,
    h=Medium.h_default,
    p=101325)
    annotation (Placement(transformation(extent={{100,30},{80,50}}, rotation=0)));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{-100,-100},{-80,-80}},
          rotation=0)));
  Modelica.Fluid.Pipes.BaseClasses.WallFriction.TestWallFrictionAndGravity
    simpleGenericOrifice2(
    redeclare package Medium = Medium,
    diameter=0.2,
    length=1,
    redeclare package WallFriction =
        Modelica.Fluid.Pipes.BaseClasses.WallFriction.Laminar)
                                annotation (Placement(transformation(extent={{
            50,30},{70,50}}, rotation=0)));
  Modelica.Fluid.Pipes.BaseClasses.WallFriction.TestWallFrictionAndGravity
    simpleGenericOrifice1(
    redeclare package Medium = Medium,
    diameter=0.2,
    length=1,
    redeclare package WallFriction =
        Modelica.Fluid.Pipes.BaseClasses.WallFriction.Laminar)
                                annotation (Placement(transformation(extent={{
            -70,30},{-50,50}}, rotation=0)));
equation
  connect(simpleGenericOrifice2.port_b,sink2. ports[1])
                                                    annotation (Line(
      points={{70,40},{80,40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(flowSource2.ports[1],simpleGenericOrifice1.port_a)
                                                          annotation (Line(
      points={{-80,40},{-70,40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(simpleGenericOrifice1.port_b, Tmix_in.port) annotation (Line(
      points={{-50,40},{-40,40},{-40,70}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(Tmix_out.port, simpleGenericOrifice2.port_a) annotation (Line(
      points={{40,68},{40,40},{50,40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(simpleGenericOrifice1.port_b, mixingVolume1.ports[1]) annotation (
      Line(
      points={{-50,40},{-36,40},{-36,38},{-22,38}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(mixingVolume1.ports[2], mixingVolume2.ports[2]) annotation (Line(
      points={{-18,38},{-18,34},{22,34},{22,38}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(mixingVolume2.ports[1], simpleGenericOrifice2.port_a) annotation (
      Line(
      points={{18,38},{34,38},{34,40},{50,40}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}),
                      graphics),
                       experiment(StopTime=10));
end TestMixingVolumesPressureStates;
