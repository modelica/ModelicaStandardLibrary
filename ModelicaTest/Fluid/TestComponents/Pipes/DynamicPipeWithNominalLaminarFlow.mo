within ModelicaTest.Fluid.TestComponents.Pipes;
model DynamicPipeWithNominalLaminarFlow
  "Test NominalLaminarFlow model subject to varying nNodes and nParallel"
  extends Modelica.Icons.Example;
  Modelica.Fluid.Pipes.DynamicPipe pipeN10(
    nParallel=1,
    length=100,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_T_start=false,
    h_start=3000e3,
    m_flow_start=1,
    diameter=0.3,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
          dp_nominal=100000, m_flow_nominal=1),
    nNodes=10,
    p_a_start=200000,
    p_b_start=100000)
    annotation (Placement(transformation(extent={{-10,30},{10,50}})));
  inner Modelica.Fluid.System system(
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
    massDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
    momentumDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial)
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Modelica.Fluid.Sources.MassFlowSource_h boundary(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    m_flow=1,
    h=3000e3) annotation (Placement(transformation(extent={{-70,30},{-50,50}})));
  Modelica.Fluid.Sources.FixedBoundary boundary1(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=100000) annotation (Placement(transformation(extent={{70,30},{50,50}})));
  Modelica.Fluid.Pipes.DynamicPipe pipeN20(
    nParallel=1,
    length=100,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_T_start=false,
    h_start=3000e3,
    m_flow_start=1,
    diameter=0.3,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
          dp_nominal=100000, m_flow_nominal=1),
    p_a_start=200000,
    p_b_start=100000,
    nNodes=20)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Fluid.Sources.MassFlowSource_h boundary2(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    m_flow=1,
    h=3000e3)
    annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
  Modelica.Fluid.Sources.FixedBoundary boundary3(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=100000) annotation (Placement(transformation(extent={{70,-10},{50,10}})));
  Modelica.Fluid.Pipes.DynamicPipe pipeN10nParallel10(
    length=100,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_T_start=false,
    h_start=3000e3,
    m_flow_start=1,
    diameter=0.3,
    nNodes=10,
    nParallel=10,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
          dp_nominal=100000, m_flow_nominal=10),
    p_a_start=200000,
    p_b_start=100000)
    annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
  Modelica.Fluid.Sources.MassFlowSource_h boundary4(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    h=3000e3,
    m_flow=10)
    annotation (Placement(transformation(extent={{-70,-50},{-50,-30}})));
  Modelica.Fluid.Sources.FixedBoundary boundary5(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=100000) annotation (Placement(transformation(extent={{70,-50},{50,-30}})));
equation
  assert(abs(pipeN10.port_a.p - pipeN20.port_a.p) < 1, "!!!Incorrect pressure for modified nNodes!!!");
  assert(abs(pipeN10.port_a.p - pipeN10nParallel10.port_a.p) < 1, "!!!Incorrect pressure for nParallel>1!!!");
  connect(boundary.ports[1], pipeN10.port_a) annotation (Line(
      points={{-50,40},{-10,40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pipeN10.port_b, boundary1.ports[1]) annotation (Line(
      points={{10,40},{50,40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(boundary2.ports[1], pipeN20.port_a) annotation (Line(
      points={{-50,0},{-10,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pipeN20.port_b, boundary3.ports[1]) annotation (Line(
      points={{10,0},{50,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(boundary4.ports[1], pipeN10nParallel10.port_a) annotation (Line(
      points={{-50,-40},{-10,-40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pipeN10nParallel10.port_b, boundary5.ports[1]) annotation (Line(
      points={{10,-40},{50,-40}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(
          preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics));
end DynamicPipeWithNominalLaminarFlow;
