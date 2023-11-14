within ModelicaTest.Fluid.TestComponents.Pipes;
model DynamicPipeEnergyConservationCheck2
  "Test DynamicPipe for total energy conservation using each discretization scheme"
  extends Modelica.Icons.Example;
  Real total_AV_B_a, total_AV_B_b;
  Real total_A_VB_a, total_A_VB_b;
  Real total_AV_VB_a, total_AV_VB_b;
  Real total_A_V_B_a, total_A_V_B_b;
  Modelica.Fluid.Pipes.DynamicPipe pipeAV_B(
    length=100,
    redeclare package Medium = Modelica.Media.Air.DryAirNasa,
    use_T_start=false,
    h_start=3000e3,
    m_flow_start=1,
    diameter=0.3,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
        useUpstreamScheme=false,
        use_Ib_flows=true,
        dp_nominal=100000,
        m_flow_nominal=1),
    nNodes=30,
    p_a_start=200000,
    p_b_start=100000,
    modelStructure=Modelica.Fluid.Types.ModelStructure.av_b,
    useInnerPortProperties=true)
    annotation (Placement(transformation(extent={{-10,40},{10,60}})));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Modelica.Fluid.Sources.MassFlowSource_h boundary(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Air.DryAirNasa,
    m_flow=1) annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
  Modelica.Fluid.Sources.FixedBoundary boundary1(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Air.DryAirNasa,
    p=100000) annotation (Placement(transformation(extent={{40,40},{20,60}})));
  Modelica.Fluid.Pipes.DynamicPipe pipeA_VB(
    length=100,
    redeclare package Medium = Modelica.Media.Air.DryAirNasa,
    use_T_start=false,
    h_start=3000e3,
    m_flow_start=1,
    diameter=0.3,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
        useUpstreamScheme=false,
        use_Ib_flows=true,
        dp_nominal=100000,
        m_flow_nominal=1),
    nNodes=30,
    p_a_start=200000,
    p_b_start=100000,
    modelStructure=Modelica.Fluid.Types.ModelStructure.a_vb,
    useInnerPortProperties=true)
    annotation (Placement(transformation(extent={{-10,0},{10,20}})));
  Modelica.Fluid.Sources.MassFlowSource_h boundary6(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Air.DryAirNasa,
    m_flow=1) annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
  Modelica.Fluid.Sources.FixedBoundary boundary7(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Air.DryAirNasa,
    p=100000) annotation (Placement(transformation(extent={{40,0},{20,20}})));
  Modelica.Fluid.Pipes.DynamicPipe pipeAV_VB(
    length=100,
    redeclare package Medium = Modelica.Media.Air.DryAirNasa,
    use_T_start=false,
    h_start=3000e3,
    m_flow_start=1,
    diameter=0.3,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
        useUpstreamScheme=false,
        use_Ib_flows=true,
        dp_nominal=100000,
        m_flow_nominal=1),
    nNodes=30,
    p_a_start=200000,
    p_b_start=100000,
    modelStructure=Modelica.Fluid.Types.ModelStructure.av_vb,
    useInnerPortProperties=true)
    annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
  Modelica.Fluid.Sources.MassFlowSource_h boundary12(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Air.DryAirNasa,
    m_flow=1) annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
  Modelica.Fluid.Sources.FixedBoundary boundary13(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Air.DryAirNasa,
    p=100000) annotation (Placement(transformation(extent={{40,-40},{20,-20}})));
  Modelica.Fluid.Pipes.DynamicPipe pipeA_V_B(
    length=100,
    redeclare package Medium = Modelica.Media.Air.DryAirNasa,
    use_T_start=false,
    h_start=3000e3,
    m_flow_start=1,
    diameter=0.3,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
        useUpstreamScheme=false,
        use_Ib_flows=true,
        dp_nominal=100000,
        m_flow_nominal=1),
    nNodes=30,
    p_a_start=200000,
    p_b_start=100000,
    modelStructure=Modelica.Fluid.Types.ModelStructure.a_v_b,
    useInnerPortProperties=true)
    annotation (Placement(transformation(extent={{-10,-80},{10,-60}})));
  Modelica.Fluid.Sources.MassFlowSource_h boundary18(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Air.DryAirNasa,
    m_flow=1) annotation (Placement(transformation(extent={{-40,-80},{-20,-60}})));
  Modelica.Fluid.Sources.FixedBoundary boundary19(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Air.DryAirNasa,
    p=100000) annotation (Placement(transformation(extent={{40,-80},{20,-60}})));
equation
  total_AV_B_a = pipeAV_B.H_flows[1] + pipeAV_B.m_flows[1]*pipeAV_B.flowModel.vs[1]^2/2;
  total_AV_B_b = pipeAV_B.H_flows[end] + pipeAV_B.m_flows[end]*pipeAV_B.flowModel.vs[end]^2/2;
  total_A_VB_a = pipeA_VB.H_flows[1] + pipeA_VB.m_flows[1]*pipeA_VB.flowModel.vs[1]^2/2;
  total_A_VB_b = pipeA_VB.H_flows[end] + pipeA_VB.m_flows[end]*pipeA_VB.flowModel.vs[end]^2/2;
  total_AV_VB_a = pipeAV_VB.H_flows[1] + pipeAV_VB.m_flows[1]*pipeAV_VB.flowModel.vs[1]^2/2;
  total_AV_VB_b = pipeAV_VB.H_flows[end] + pipeAV_VB.m_flows[end]*pipeAV_VB.flowModel.vs[end]^2/2;
  total_A_V_B_a = pipeA_V_B.H_flows[1] + pipeA_V_B.m_flows[1]*pipeA_V_B.flowModel.vs[1]^2/2;
  total_A_V_B_b = pipeA_V_B.H_flows[end] + pipeA_V_B.m_flows[end]*pipeA_V_B.flowModel.vs[end]^2/2;
  assert(time < 500 or Modelica.Math.isEqual(total_AV_B_a, total_AV_B_b, 1), "Energy not conserved!");
  assert(time < 500 or Modelica.Math.isEqual(total_A_VB_a, total_A_VB_b, 1), "Energy not conserved!");
  assert(time < 500 or Modelica.Math.isEqual(total_AV_VB_a, total_AV_VB_b, 1), "Energy not conserved!");
  assert(time < 500 or Modelica.Math.isEqual(total_A_V_B_a, total_A_V_B_b, 1), "Energy not conserved!");
  connect(boundary.ports[1], pipeAV_B.port_a)
    annotation (Line(points={{-20,50},{-10,50}}, color={0,127,255}));
  connect(pipeAV_B.port_b, boundary1.ports[1])
    annotation (Line(points={{10,50},{20,50}}, color={0,127,255}));
  connect(boundary6.ports[1], pipeA_VB.port_a)
    annotation (Line(points={{-20,10},{-10,10}}, color={0,127,255}));
  connect(pipeA_VB.port_b, boundary7.ports[1])
    annotation (Line(points={{10,10},{20,10}}, color={0,127,255}));
  connect(boundary12.ports[1], pipeAV_VB.port_a)
    annotation (Line(points={{-20,-30},{-10,-30}}, color={0,127,255}));
  connect(pipeAV_VB.port_b, boundary13.ports[1])
    annotation (Line(points={{10,-30},{20,-30}}, color={0,127,255}));
  connect(boundary18.ports[1], pipeA_V_B.port_a)
    annotation (Line(points={{-20,-70},{-10,-70}}, color={0,127,255}));
  connect(pipeA_V_B.port_b, boundary19.ports[1])
    annotation (Line(points={{10,-70},{20,-70}}, color={0,127,255}));
  annotation (experiment(StopTime=500),
  Documentation(info="<html>
  Test of energy conservation in dynamic pipes.
</html>"),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}})),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}})));
end DynamicPipeEnergyConservationCheck2;
