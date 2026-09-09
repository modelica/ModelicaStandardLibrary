within ModelicaTest.Fluid.TestComponents.Pipes;
model DynamicPipeEnergyConservationCheck
  "Test DynamicPipe for energy conservation using each discretization scheme and number of control volumes"
  extends Modelica.Icons.Example;
  Modelica.Fluid.Pipes.DynamicPipe pipeAV_B4(
    length=100,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_T_start=false,
    h_start=3000e3,
    m_flow_start=1,
    diameter=0.3,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
          dp_nominal=100000, m_flow_nominal=1),
    nNodes=4,
    p_a_start=200000,
    p_b_start=100000,
    modelStructure=Modelica.Fluid.Types.ModelStructure.av_b,
    useInnerPortProperties=true)
    annotation (Placement(transformation(extent={{90,40},{110,60}})));
  inner Modelica.Fluid.System system(energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState)
    annotation (Placement(transformation(extent={{-140,80},{-120,100}})));
  Modelica.Fluid.Sources.MassFlowSource_h boundary(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    m_flow=1,
    h=3000e3) annotation (Placement(transformation(extent={{60,40},{80,60}})));
  Modelica.Fluid.Sources.FixedBoundary boundary1(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=100000) annotation (Placement(transformation(extent={{140,40},{120,60}})));
  Modelica.Fluid.Pipes.DynamicPipe pipeAV_B2(
    length=100,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_T_start=false,
    h_start=3000e3,
    m_flow_start=1,
    diameter=0.3,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
          dp_nominal=100000, m_flow_nominal=1),
    nNodes=2,
    p_a_start=200000,
    p_b_start=100000,
    modelStructure=Modelica.Fluid.Types.ModelStructure.av_b,
    useInnerPortProperties=true)
    annotation (Placement(transformation(extent={{-110,40},{-90,60}})));
  Modelica.Fluid.Sources.MassFlowSource_h boundary2(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    m_flow=1,
    h=3000e3) annotation (Placement(transformation(extent={{-140,40},{-120,60}})));
  Modelica.Fluid.Sources.FixedBoundary boundary3(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=100000) annotation (Placement(transformation(extent={{-60,40},{-80,60}})));
  Modelica.Fluid.Pipes.DynamicPipe pipeAV_B3(
    length=100,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_T_start=false,
    h_start=3000e3,
    m_flow_start=1,
    diameter=0.3,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
          dp_nominal=100000, m_flow_nominal=1),
    nNodes=3,
    p_a_start=200000,
    p_b_start=100000,
    modelStructure=Modelica.Fluid.Types.ModelStructure.av_b,
    useInnerPortProperties=true)
    annotation (Placement(transformation(extent={{-10,40},{10,60}})));
  Modelica.Fluid.Sources.MassFlowSource_h boundary4(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    m_flow=1,
    h=3000e3) annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
  Modelica.Fluid.Sources.FixedBoundary boundary5(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=100000) annotation (Placement(transformation(extent={{40,40},{20,60}})));
  Modelica.Fluid.Pipes.DynamicPipe pipeA_VB4(
    length=100,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_T_start=false,
    h_start=3000e3,
    m_flow_start=1,
    diameter=0.3,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
          dp_nominal=100000, m_flow_nominal=1),
    nNodes=4,
    p_a_start=200000,
    p_b_start=100000,
    modelStructure=Modelica.Fluid.Types.ModelStructure.a_vb,
    useInnerPortProperties=true)
    annotation (Placement(transformation(extent={{90,0},{110,20}})));
  Modelica.Fluid.Sources.MassFlowSource_h boundary6(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    m_flow=1,
    h=3000e3) annotation (Placement(transformation(extent={{60,0},{80,20}})));
  Modelica.Fluid.Sources.FixedBoundary boundary7(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=100000) annotation (Placement(transformation(extent={{140,0},{120,20}})));
  Modelica.Fluid.Pipes.DynamicPipe pipeA_VB2(
    length=100,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_T_start=false,
    h_start=3000e3,
    m_flow_start=1,
    diameter=0.3,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
          dp_nominal=100000, m_flow_nominal=1),
    nNodes=2,
    p_a_start=200000,
    p_b_start=100000,
    modelStructure=Modelica.Fluid.Types.ModelStructure.a_vb,
    useInnerPortProperties=true)
    annotation (Placement(transformation(extent={{-110,0},{-90,20}})));
  Modelica.Fluid.Sources.MassFlowSource_h boundary8(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    m_flow=1,
    h=3000e3) annotation (Placement(transformation(extent={{-140,0},{-120,20}})));
  Modelica.Fluid.Sources.FixedBoundary boundary9(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=100000) annotation (Placement(transformation(extent={{-60,0},{-80,20}})));
  Modelica.Fluid.Pipes.DynamicPipe pipeA_VB3(
    length=100,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_T_start=false,
    h_start=3000e3,
    m_flow_start=1,
    diameter=0.3,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
          dp_nominal=100000, m_flow_nominal=1),
    nNodes=3,
    p_a_start=200000,
    p_b_start=100000,
    modelStructure=Modelica.Fluid.Types.ModelStructure.a_vb,
    useInnerPortProperties=true)
    annotation (Placement(transformation(extent={{-10,0},{10,20}})));
  Modelica.Fluid.Sources.MassFlowSource_h boundary10(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    m_flow=1,
    h=3000e3) annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
  Modelica.Fluid.Sources.FixedBoundary boundary11(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=100000) annotation (Placement(transformation(extent={{40,0},{20,20}})));
  Modelica.Fluid.Pipes.DynamicPipe pipeAV_VB4(
    length=100,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_T_start=false,
    h_start=3000e3,
    m_flow_start=1,
    diameter=0.3,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
          dp_nominal=100000, m_flow_nominal=1),
    nNodes=4,
    p_a_start=200000,
    p_b_start=100000,
    modelStructure=Modelica.Fluid.Types.ModelStructure.av_vb,
    useInnerPortProperties=true)
    annotation (Placement(transformation(extent={{90,-40},{110,-20}})));
  Modelica.Fluid.Sources.MassFlowSource_h boundary12(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    m_flow=1,
    h=3000e3) annotation (Placement(transformation(extent={{60,-40},{80,-20}})));
  Modelica.Fluid.Sources.FixedBoundary boundary13(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=100000) annotation (Placement(transformation(extent={{140,-40},{120,-20}})));
  Modelica.Fluid.Pipes.DynamicPipe pipeAV_VB2(
    length=100,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_T_start=false,
    h_start=3000e3,
    m_flow_start=1,
    diameter=0.3,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
          dp_nominal=100000, m_flow_nominal=1),
    nNodes=2,
    p_a_start=200000,
    p_b_start=100000,
    modelStructure=Modelica.Fluid.Types.ModelStructure.av_vb,
    useInnerPortProperties=true)
    annotation (Placement(transformation(extent={{-110,-40},{-90,-20}})));
  Modelica.Fluid.Sources.MassFlowSource_h boundary14(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    m_flow=1,
    h=3000e3) annotation (Placement(transformation(extent={{-140,-40},{-120,-20}})));
  Modelica.Fluid.Sources.FixedBoundary boundary15(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=100000) annotation (Placement(transformation(extent={{-60,-40},{-80,-20}})));
  Modelica.Fluid.Pipes.DynamicPipe pipeAV_VB3(
    length=100,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_T_start=false,
    h_start=3000e3,
    m_flow_start=1,
    diameter=0.3,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
          dp_nominal=100000, m_flow_nominal=1),
    nNodes=3,
    p_a_start=200000,
    p_b_start=100000,
    modelStructure=Modelica.Fluid.Types.ModelStructure.av_vb,
    useInnerPortProperties=true)
    annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
  Modelica.Fluid.Sources.MassFlowSource_h boundary16(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    m_flow=1,
    h=3000e3) annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
  Modelica.Fluid.Sources.FixedBoundary boundary17(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=100000) annotation (Placement(transformation(extent={{40,-40},{20,-20}})));
  Modelica.Fluid.Pipes.DynamicPipe pipeA_V_B4(
    length=100,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_T_start=false,
    h_start=3000e3,
    m_flow_start=1,
    diameter=0.3,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
          dp_nominal=100000, m_flow_nominal=1),
    nNodes=4,
    p_a_start=200000,
    p_b_start=100000,
    modelStructure=Modelica.Fluid.Types.ModelStructure.a_v_b,
    useInnerPortProperties=true)
    annotation (Placement(transformation(extent={{90,-80},{110,-60}})));
  Modelica.Fluid.Sources.MassFlowSource_h boundary18(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    m_flow=1,
    h=3000e3) annotation (Placement(transformation(extent={{60,-80},{80,-60}})));
  Modelica.Fluid.Sources.FixedBoundary boundary19(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=100000) annotation (Placement(transformation(extent={{140,-80},{120,-60}})));
  Modelica.Fluid.Pipes.DynamicPipe pipeA_V_B2(
    length=100,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_T_start=false,
    h_start=3000e3,
    m_flow_start=1,
    diameter=0.3,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
          dp_nominal=100000, m_flow_nominal=1),
    nNodes=2,
    p_a_start=200000,
    p_b_start=100000,
    modelStructure=Modelica.Fluid.Types.ModelStructure.a_v_b,
    useInnerPortProperties=true)
    annotation (Placement(transformation(extent={{-110,-80},{-90,-60}})));
  Modelica.Fluid.Sources.MassFlowSource_h boundary20(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    m_flow=1,
    h=3000e3) annotation (Placement(transformation(extent={{-140,-80},{-120,-60}})));
  Modelica.Fluid.Sources.FixedBoundary boundary21(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=100000) annotation (Placement(transformation(extent={{-60,-80},{-80,-60}})));
  Modelica.Fluid.Pipes.DynamicPipe pipeA_V_B3(
    length=100,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_T_start=false,
    h_start=3000e3,
    m_flow_start=1,
    diameter=0.3,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
          dp_nominal=100000, m_flow_nominal=1),
    nNodes=3,
    p_a_start=200000,
    p_b_start=100000,
    modelStructure=Modelica.Fluid.Types.ModelStructure.a_v_b,
    useInnerPortProperties=true)
    annotation (Placement(transformation(extent={{-10,-80},{10,-60}})));
  Modelica.Fluid.Sources.MassFlowSource_h boundary22(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    m_flow=1,
    h=3000e3) annotation (Placement(transformation(extent={{-40,-80},{-20,-60}})));
  Modelica.Fluid.Sources.FixedBoundary boundary23(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=100000) annotation (Placement(transformation(extent={{40,-80},{20,-60}})));
equation
  assert(Modelica.Math.isEqual(pipeAV_B2.state_a.h, pipeAV_B2.state_b.h, 1e-12), "Energy not conserved!");
  assert(Modelica.Math.isEqual(pipeAV_B3.state_a.h, pipeAV_B3.state_b.h, 1e-12), "Energy not conserved!");
  assert(Modelica.Math.isEqual(pipeAV_B4.state_a.h, pipeAV_B4.state_b.h, 1e-12), "Energy not conserved!");
  assert(Modelica.Math.isEqual(pipeA_VB2.state_a.h, pipeA_VB2.state_b.h, 1e-12), "Energy not conserved!");
  assert(Modelica.Math.isEqual(pipeA_VB3.state_a.h, pipeA_VB3.state_b.h, 1e-12), "Energy not conserved!");
  assert(Modelica.Math.isEqual(pipeA_VB4.state_a.h, pipeA_VB4.state_b.h, 1e-12), "Energy not conserved!");
  assert(Modelica.Math.isEqual(pipeAV_VB2.state_a.h, pipeAV_VB2.state_b.h, 1e-12), "Energy not conserved!");
  assert(Modelica.Math.isEqual(pipeAV_VB3.state_a.h, pipeAV_VB3.state_b.h, 1e-12), "Energy not conserved!");
  assert(Modelica.Math.isEqual(pipeAV_VB4.state_a.h, pipeAV_VB4.state_b.h, 1e-12), "Energy not conserved!");
  assert(Modelica.Math.isEqual(pipeA_V_B2.state_a.h, pipeA_V_B2.state_b.h, 1e-12), "Energy not conserved!");
  assert(Modelica.Math.isEqual(pipeA_V_B3.state_a.h, pipeA_V_B3.state_b.h, 1e-12), "Energy not conserved!");
  assert(Modelica.Math.isEqual(pipeA_V_B4.state_a.h, pipeA_V_B4.state_b.h, 1e-12), "Energy not conserved!");
  connect(boundary.ports[1], pipeAV_B4.port_a)
    annotation (Line(points={{80,50},{90,50}}, color={0,127,255}));
  connect(pipeAV_B4.port_b, boundary1.ports[1])
    annotation (Line(points={{110,50},{120,50}}, color={0,127,255}));
  connect(boundary2.ports[1], pipeAV_B2.port_a)
    annotation (Line(points={{-120,50},{-110,50}}, color={0,127,255}));
  connect(pipeAV_B2.port_b, boundary3.ports[1])
    annotation (Line(points={{-90,50},{-80,50}}, color={0,127,255}));
  connect(boundary4.ports[1], pipeAV_B3.port_a)
    annotation (Line(points={{-20,50},{-10,50}}, color={0,127,255}));
  connect(pipeAV_B3.port_b, boundary5.ports[1])
    annotation (Line(points={{10,50},{20,50}}, color={0,127,255}));
  connect(boundary6.ports[1], pipeA_VB4.port_a)
    annotation (Line(points={{80,10},{90,10}}, color={0,127,255}));
  connect(pipeA_VB4.port_b, boundary7.ports[1])
    annotation (Line(points={{110,10},{120,10}}, color={0,127,255}));
  connect(boundary8.ports[1], pipeA_VB2.port_a)
    annotation (Line(points={{-120,10},{-110,10}}, color={0,127,255}));
  connect(pipeA_VB2.port_b, boundary9.ports[1])
    annotation (Line(points={{-90,10},{-80,10}}, color={0,127,255}));
  connect(boundary10.ports[1], pipeA_VB3.port_a)
    annotation (Line(points={{-20,10},{-10,10}}, color={0,127,255}));
  connect(pipeA_VB3.port_b, boundary11.ports[1])
    annotation (Line(points={{10,10},{20,10}}, color={0,127,255}));
  connect(boundary12.ports[1], pipeAV_VB4.port_a)
    annotation (Line(points={{80,-30},{90,-30}}, color={0,127,255}));
  connect(pipeAV_VB4.port_b, boundary13.ports[1])
    annotation (Line(points={{110,-30},{120,-30}}, color={0,127,255}));
  connect(boundary14.ports[1], pipeAV_VB2.port_a)
    annotation (Line(points={{-120,-30},{-110,-30}}, color={0,127,255}));
  connect(pipeAV_VB2.port_b, boundary15.ports[1])
    annotation (Line(points={{-90,-30},{-80,-30}}, color={0,127,255}));
  connect(boundary16.ports[1], pipeAV_VB3.port_a)
    annotation (Line(points={{-20,-30},{-10,-30}}, color={0,127,255}));
  connect(pipeAV_VB3.port_b, boundary17.ports[1])
    annotation (Line(points={{10,-30},{20,-30}}, color={0,127,255}));
  connect(boundary18.ports[1], pipeA_V_B4.port_a)
    annotation (Line(points={{80,-70},{90,-70}}, color={0,127,255}));
  connect(pipeA_V_B4.port_b, boundary19.ports[1])
    annotation (Line(points={{110,-70},{120,-70}}, color={0,127,255}));
  connect(boundary20.ports[1], pipeA_V_B2.port_a)
    annotation (Line(points={{-120,-70},{-110,-70}}, color={0,127,255}));
  connect(pipeA_V_B2.port_b, boundary21.ports[1])
    annotation (Line(points={{-90,-70},{-80,-70}}, color={0,127,255}));
  connect(boundary22.ports[1], pipeA_V_B3.port_a)
    annotation (Line(points={{-20,-70},{-10,-70}}, color={0,127,255}));
  connect(pipeA_V_B3.port_b, boundary23.ports[1])
    annotation (Line(points={{10,-70},{20,-70}}, color={0,127,255}));
  annotation (experiment(StopTime=1),
  Documentation(info="<html>
  Test of energy conservation in dynamic pipes.
</html>"),
    Diagram(coordinateSystem(extent={{-140,-100},{140,100}})),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}})));
end DynamicPipeEnergyConservationCheck;
