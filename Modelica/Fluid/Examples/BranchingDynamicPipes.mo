within Modelica.Fluid.Examples;
model BranchingDynamicPipes
  "Multi-way connections of pipes with dynamic momentum balance, pressure wave and flow reversal"
extends Modelica.Icons.Example;
replaceable package Medium=Modelica.Media.Air.MoistAir constrainedby
    Modelica.Media.Interfaces.PartialMedium;
//replaceable package Medium=Modelica.Media.Water.StandardWater constrainedby Modelica.Media.Interfaces.PartialMedium;

  inner Modelica.Fluid.System system(energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
      momentumDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial)
    annotation (Placement(transformation(extent={{-90,70},{-70,90}})));
  Modelica.Fluid.Sources.Boundary_pT boundary1(nPorts=1,
    redeclare package Medium = Medium,
    p=150000) annotation (Placement(
        transformation(extent={{-10,-10},{10,10}},    rotation=90,
        origin={0,-80})));
  Pipes.DynamicPipe             pipe1(
    redeclare package Medium=Medium,
    use_T_start=true,
    nNodes=5,
    diameter=2.54e-2,
    m_flow_start=0.02,
    height_ab=50,
    length=50,
    p_a_start=150000,
    p_b_start=130000,
    modelStructure=Modelica.Fluid.Types.ModelStructure.a_v_b)
            annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=90,
        origin={0,-50})));
 Pipes.DynamicPipe             pipe2(
    redeclare package Medium = Medium,
    use_T_start=true,
    nNodes=5,
    redeclare model HeatTransfer =
        Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.LocalPipeFlowHeatTransfer,
    use_HeatTransfer=true,
    diameter=2.54e-2,
    m_flow_start=0.01,
    length=50,
    height_ab=25,
    p_a_start=130000,
    p_b_start=120000,
    modelStructure=Modelica.Fluid.Types.ModelStructure.av_vb)
            annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=90,
        origin={-20,-10})));

  Pipes.DynamicPipe             pipe3(
    redeclare package Medium=Medium,
    use_T_start=true,
    nNodes=5,
    diameter=2.54e-2,
    m_flow_start=0.01,
    length=25,
    height_ab=25,
    p_a_start=130000,
    p_b_start=120000,
    modelStructure=Modelica.Fluid.Types.ModelStructure.a_v_b)
            annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=90,
        origin={20,-10})));
  Pipes.DynamicPipe             pipe4(
    redeclare package Medium=Medium,
    use_T_start=true,
    nNodes=5,
    diameter=2.54e-2,
    m_flow_start=0.02,
    height_ab=50,
    length=50,
    p_a_start=120000,
    p_b_start=100000,
    modelStructure=Modelica.Fluid.Types.ModelStructure.a_v_b)
            annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=90,
        origin={0,30})));
  Modelica.Fluid.Sources.Boundary_pT boundary4(nPorts=1,
    redeclare package Medium = Medium,
    use_p_in=true,
    use_T_in=false,
    p=100000) annotation (Placement(
        transformation(extent={{10,-10},{-10,10}}, rotation=90,
        origin={0,60})));
  Modelica.Blocks.Sources.Step step1(
    offset=1e5,
    startTime=2,
    height=1e5) annotation (Placement(transformation(extent={{-40,70},{-20,90}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow[
                                              pipe2.nNodes] heat2(Q_flow=200*
        pipe2.dxs, alpha=-1e-2*ones(pipe2.n))
    annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));
equation
  connect(step1.y, boundary4.p_in) annotation (Line(
      points={{-19,80},{-8,80},{-8,72}},
      color={0,0,127},
      thickness=0.5));
  connect(boundary1.ports[1],pipe1. port_a) annotation (Line(
      points={{0,-70},{0,-70},{0,-60},{0,-60}},
      color={0,127,255},
      thickness=0.5));
  connect(pipe1.port_b,pipe2. port_a) annotation (Line(
      points={{0,-40},{0,-40},{0,-30},{-20,-30},{-20,-20}},
      color={0,127,255},
      thickness=0.5));
  connect(pipe1.port_b,pipe3. port_a) annotation (Line(
      points={{0,-40},{0,-40},{0,-30},{20,-30},{20,-20}},
      color={0,127,255},
      thickness=0.5));
  connect(pipe2.port_b,pipe4. port_a) annotation (Line(
      points={{-20,0},{-20,0},{-20,10},{0,10},{0,16},{0,20},{0,20}},
      color={0,127,255},
      thickness=0.5));
  connect(pipe3.port_b,pipe4. port_a) annotation (Line(
      points={{20,0},{20,0},{20,10},{0,10},{0,16},{0,20},{0,20}},
      color={0,127,255},
      thickness=0.5));
  connect(pipe4.port_b, boundary4.ports[1]) annotation (Line(
      points={{0,40},{0,50},{0,50}},
      color={0,127,255},
      thickness=0.5));
  connect(heat2.port,pipe2. heatPorts)
                                      annotation (Line(
      points={{-40,-10},{-24.4,-10},{-24.4,-9.9}},
      color={191,0,0},
      thickness=0.5));

    annotation (
    Documentation(info="<html>
<p>
This model demonstrates the use of distributed pipe models with dynamic energy, mass and momentum balances.
At time=2s the pressure of boundary4 jumps, which causes a pressure wave and flow reversal.
</p>
<p>
Change system.momentumDynamics on the Assumptions tab of the system object from SteadyStateInitial to SteadyState,
in order to assume a steady-state momentum balance. This is the default for all models of the library.
</p>
<p>
Change the Medium from MoistAir to StandardWater, in order to investigate a medium with significantly different density.
Note the static head caused by the elevation of the pipes.
</p>
<p>
Note the appropriate use of the modelStructure of the DynamicPipe models (Advanced tab).
The default modelStructure is av_vb, i.e. volumes with a pressure state are exposed at both ports.
In many cases this gives good numerical performance, avoiding algebraic loops in connections,
e.g. if a pipe is connected to a valve or to a vessel with portsData configured.
The price to pay is a high-index DAE if two pipes are connected or if a pipe is connected to a boundary with prescribed pressure.
In such cases one might consider changing the modelStructure.
</p>
<p>
In the BranchingDynamicPipes example, {pipe1,pipe3,pipe4}.modelStructure are configured to a_v_b, while pipe2.modelStructure remains av_vb.
This avoids a high-index DAE and overdetermined initial conditions.
</p>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Examples/BranchingDynamicPipes.png\" border=\"1\"
     alt=\"BranchingDynamicPipes.png\">
</html>"), experiment(StopTime=10),
    __Dymola_Commands(file(ensureSimulated=true)=
        "modelica://Modelica/Resources/Scripts/Dymola/Fluid/BranchingDynamicPipes/plotResults.mos"
        "plotResults"));
end BranchingDynamicPipes;
