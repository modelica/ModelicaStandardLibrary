within ModelicaTest.Fluid;
package TestPipesAndValves
  "Collection of test cases which might be critical for the solvers"
extends Modelica.Icons.ExamplesPackage;
  model DynamicPipeClosingValve "This test demonstrates the importance of smooth regularization of fluid properties for reversing flow.
 A DynamicPipe model with switching port densities and viscosities would generate lots of events as the valve closes at time 2."
   extends Modelica.Icons.Example;
    Modelica.Fluid.Sources.FixedBoundary source(nPorts=1,redeclare package
        Medium =
          Modelica.Media.Water.StandardWater, p=200000)
      annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
    Modelica.Fluid.Pipes.DynamicPipe pipe(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      length=1,
      diameter=0.32,
      use_T_start=false,
      modelStructure=Modelica.Fluid.Types.ModelStructure.a_vb,
      p_a_start=200000,
      p_b_start=200000,
      nNodes=1)
      annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
    Modelica.Fluid.Valves.ValveIncompressible valve(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      m_flow_nominal=10,
      Av=1e-3,
      dp_nominal=100000)
      annotation (Placement(transformation(extent={{0,-10},{20,10}})));
    Modelica.Fluid.Sources.FixedBoundary sink(nPorts=1,redeclare package Medium
        = Modelica.Media.Water.StandardWater, p=100000)
                annotation (Placement(transformation(extent={{60,-10},{40,10}})));
    Modelica.Blocks.Sources.Ramp ramp(
      height=-1,
      offset=1,
      duration=1,
      startTime=1)
                annotation (Placement(transformation(extent={{46,30},{26,50}})));
    inner Modelica.Fluid.System system(energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial)
      annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  equation
    connect(source.ports[1], pipe.port_a)         annotation (Line(
        points={{-60,6.66134e-16},{-55,6.66134e-16},{-55,1.27676e-15},{-50,
            1.27676e-15},{-50,6.10623e-16},{-40,6.10623e-16}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(pipe.port_b, valve.port_a)               annotation (Line(
        points={{-20,6.10623e-16},{-15,6.10623e-16},{-15,1.22125e-15},{-10,
            1.22125e-15},{-10,6.10623e-16},{-5.55112e-16,6.10623e-16}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(valve.port_b, sink.ports[1])                          annotation (Line(
        points={{20,6.10623e-16},{25,6.10623e-16},{25,1.27676e-15},{30,
            1.27676e-15},{30,6.66134e-16},{40,6.66134e-16}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(ramp.y, valve.opening)               annotation (Line(
        points={{25,40},{10,40},{10,8}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (      experiment(StopTime=3));
  end DynamicPipeClosingValve;

  model DynamicPipeInitialization
    "Steady-state initialization of a dynamic pipe"
    extends Modelica.Icons.Example;
    Modelica.Fluid.Sources.FixedBoundary source(nPorts=1,
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      use_T=false,
      p=10000000,
      h=2e6)
      annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
    Modelica.Fluid.Pipes.DynamicPipe pipe(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      nNodes=5,
      h_start=2e6,
      diameter=0.05,
      length=200,
      use_T_start=false,
      p_a_start=10000000,
      p_b_start=9900000,
      modelStructure=Modelica.Fluid.Types.ModelStructure.a_vb)
      annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
    Modelica.Fluid.Valves.ValveCompressible valve(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      Av=1e-3,
      m_flow_nominal=10,
      dp_nominal=10000000,
      p_nominal=10000000)
      annotation (Placement(transformation(extent={{0,-10},{20,10}})));
    Modelica.Fluid.Sources.FixedBoundary sink(nPorts=1,redeclare package Medium
        = Modelica.Media.Water.StandardWaterOnePhase, p=9500000)
                annotation (Placement(transformation(extent={{60,-10},{40,10}})));
    Modelica.Blocks.Sources.Ramp ramp(
      offset=1,
      duration=0.1,
      height=-0.5,
      startTime=2)
                annotation (Placement(transformation(extent={{46,30},{26,50}})));
    inner Modelica.Fluid.System system(energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial)
      annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
    discrete Modelica.SIunits.MassFlowRate m_flow_initial;
  equation
    when time > 0.1 then
      m_flow_initial = valve.port_a.m_flow;
    end when;
    if pipe.energyDynamics >= Modelica.Fluid.Types.Dynamics.SteadyStateInitial and
       pipe.massDynamics >= Modelica.Fluid.Types.Dynamics.SteadyStateInitial then
      when time > 1 then
        assert(abs(valve.port_a.m_flow - m_flow_initial) < 1e-3, "!!!THE SIMULATION DID NOT START IN STEADY-STATE!!!");
      end when;
    end if;
    connect(source.ports[1], pipe.port_a)         annotation (Line(
        points={{-60,6.66134e-16},{-55,6.66134e-16},{-55,1.27676e-15},{-50,
            1.27676e-15},{-50,6.10623e-16},{-40,6.10623e-16}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(pipe.port_b, valve.port_a)               annotation (Line(
        points={{-20,6.10623e-16},{-15,6.10623e-16},{-15,1.22125e-15},{-10,
            1.22125e-15},{-10,6.10623e-16},{-5.55112e-16,6.10623e-16}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(valve.port_b, sink.ports[1])                          annotation (Line(
        points={{20,6.10623e-16},{25,6.10623e-16},{25,1.27676e-15},{30,
            1.27676e-15},{30,6.66134e-16},{40,6.66134e-16}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(ramp.y, valve.opening)               annotation (Line(
        points={{25,40},{10,40},{10,8}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (      experiment(StopTime=4),
      Documentation(info="<html>
The simulation shall start in steady-state (see system.energyDynamics on the Assumptions tab).
This requires the solution of an equation system with complex non-linear expressions for the
pipe wall friction and compressible valve characteristics. A ValveCompressible defined with Modelica.Fluid.Utilities.regRoot2 for the treatment of flow reversal
(cf. Modelica.Fluid Stream beta3) leads to wrong initial values. It works with Modelica.Fluid.Utilities.regRoot and a smooth(0, ...) expression for flow reversal.
<p>
The steady-state initial values are observed by an assertion.
</p>
</html>"));
  end DynamicPipeInitialization;

  model BranchingPipes1
    extends Modelica.Icons.Example;
    //replaceable package Medium = Modelica.Media.Water.StandardWater;
    replaceable package Medium =
        Modelica.Media.Water.StandardWater;
         //Modelica.Media.Water.ConstantPropertyLiquidWater;
    Modelica.Fluid.Sources.Boundary_pT source(nPorts=1,
      redeclare package Medium = Medium,
      T=300,
      p=2.2e5)
             annotation (Placement(transformation(extent={{-100,0},{-88,12}},
            rotation=0)));
    Modelica.Fluid.Pipes.DynamicPipe pipe1(
      redeclare package Medium = Medium,
      use_T_start=true,
      length=10,
      diameter=2.54e-2,
      redeclare model FlowModel =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
      nNodes=1,
      p_a_start=200000,
      p_b_start=150000,
      T_start=300,
      modelStructure=Modelica.Fluid.Types.ModelStructure.a_v_b)
                     annotation (Placement(transformation(extent={{-72,-4},{
              -52,16}}, rotation=0)));
    Modelica.Fluid.Valves.ValveIncompressible valve1(
      redeclare package Medium = Medium,
      CvData=Modelica.Fluid.Types.CvTypes.OpPoint,
      m_flow_nominal=1,
      rho_nominal=1000,
      dp_nominal=200000,
      filteredOpening=true,
      leakageOpening=0.01)
                  annotation (Placement(transformation(extent={{10,36},{30,56}},
            rotation=0)));
    Modelica.Fluid.Valves.ValveIncompressible valve2(
      redeclare package Medium = Medium,
      CvData=Modelica.Fluid.Types.CvTypes.OpPoint,
      m_flow_nominal=1,
      rho_nominal=1000,
      dp_nominal=200000,
      filteredOpening=true,
      leakageOpening=0.01)
                  annotation (Placement(transformation(extent={{8,-50},{28,-30}},
            rotation=0)));
    Modelica.Fluid.Sources.Boundary_pT sink(
      redeclare package Medium = Medium,
      nPorts=2,
      p=100000,
      T=300)   annotation (Placement(transformation(extent={{74,-20},{62,-8}},
            rotation=0)));
    Modelica.Fluid.Pipes.DynamicPipe pipe2(
      redeclare package Medium = Medium,
      use_T_start=true,
      length=10,
      diameter=2.54e-2,
      redeclare model FlowModel =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
      nNodes=1,
      p_a_start=150000,
      p_b_start=100000,
      T_start=300,
      modelStructure=Modelica.Fluid.Types.ModelStructure.a_vb)
                     annotation (Placement(transformation(extent={{-40,36},{-20,
              56}},     rotation=0)));
    Modelica.Fluid.Pipes.DynamicPipe pipe3(
      redeclare package Medium = Medium,
      use_T_start=true,
      length=10,
      diameter=2.54e-2,
      redeclare model FlowModel =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
      nNodes=1,
      p_a_start=150000,
      p_b_start=100000,
      T_start=300,
      modelStructure=Modelica.Fluid.Types.ModelStructure.a_vb)
                     annotation (Placement(transformation(extent={{-40,-50},
              {-20,-30}}, rotation=0)));
    Modelica.Blocks.Sources.TimeTable valveOpening1(offset=0, table=[0,1; 1,1;
          1,0; 100,0]) annotation (Placement(transformation(extent={{-20,70},{0,
              90}}, rotation=0)));
    Modelica.Blocks.Sources.TimeTable valveOpening2(offset=0, table=[0,1; 2,1;
          2,0; 100,0]) annotation (Placement(transformation(extent={{-20,-10},{
              0,10}}, rotation=0)));
    inner Modelica.Fluid.System system(energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
                                                                           annotation (Placement(transformation(extent={{-100,60},
              {-80,80}}, rotation=0)));
  equation
    connect(source.ports[1], pipe1.port_a) annotation (Line(points={{-88,6},{-80,6},
            {-72,6}},
          color={0,127,255}));
    connect(valve2.port_b, sink.ports[2])               annotation (Line(points={{28,-40},
            {46,-40},{46,-15.2},{62,-15.2}},     color={0,127,255}));
    connect(valve1.port_b, sink.ports[1])              annotation (Line(points={{30,46},
            {46,46},{46,-12.8},{62,-12.8}}, color={0,127,255}));
    connect(pipe3.port_b, valve2.port_a)               annotation (Line(points={{-20,-40},
            {8,-40}},            color={0,127,255}));
    connect(pipe2.port_b, valve1.port_a)              annotation (Line(points={{-20,46},
            {-6,46},{10,46}},  color={0,127,255}));
    connect(pipe2.port_a, pipe1.port_b) annotation (Line(points={{-40,46},{-46,
            46},{-46,6},{-52,6}}, color={0,127,255}));
    connect(pipe1.port_b, pipe3.port_a) annotation (Line(points={{-52,6},{-46,6},
            {-46,-40},{-40,-40}}, color={0,127,255}));
    connect(valveOpening1.y, valve1.opening)              annotation (Line(
          points={{1,80},{20,80},{20,54}}, color={0,0,127}));
    connect(valveOpening2.y, valve2.opening)               annotation (Line(
          points={{1,6.10623e-16},{18,6.10623e-16},{18,-32}},
                                          color={0,0,127}));
    annotation (
              experiment(
        StopTime=5,
        Interval=1e-3,
        Tolerance=1e-006),
      Documentation(info="<html>
Simulation starts with both valves open. At t=1, valve 1 closes; at t=2 valve 2 closes.
</html>"));
  end BranchingPipes1;

  model BranchingPipes2
    extends Modelica.Icons.Example;
    replaceable package Medium = Modelica.Media.Water.StandardWater;
    Modelica.Fluid.Sources.Boundary_pT source(nPorts=1,
      redeclare package Medium = Medium,
      p=5.0e5,
      T=300) annotation (Placement(transformation(extent={{-100,0},{-88,12}},
            rotation=0)));
    Modelica.Fluid.Pipes.DynamicPipe pipe1(
      redeclare package Medium = Medium,
      use_T_start=true,
      redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.TurbulentPipeFlow,
      length=10,
      diameter=2.54e-2,
      nNodes=1,
      p_a_start=500000,
      p_b_start=500000,
      modelStructure=Modelica.Fluid.Types.ModelStructure.a_v_b)
                        annotation (Placement(transformation(extent={{-72,-4},{
              -52,16}}, rotation=0)));
    Modelica.Fluid.Valves.ValveIncompressible valveIncompressible(
      redeclare package Medium = Medium,
      CvData=Modelica.Fluid.Types.CvTypes.OpPoint,
      dp_nominal=4.0e5,
      m_flow_nominal=1,
      rho_nominal=1000) annotation (Placement(transformation(extent={{10,36},{30,56}},
            rotation=0)));
    Modelica.Fluid.Valves.ValveIncompressible valveIncompressible1(
      redeclare package Medium = Medium,
      CvData=Modelica.Fluid.Types.CvTypes.OpPoint,
      dp_nominal=4.0e5,
      m_flow_nominal=1,
      rho_nominal=1000) annotation (Placement(transformation(extent={{8,-50},{28,-30}},
            rotation=0)));
    Modelica.Fluid.Sources.Boundary_pT sink(
      redeclare package Medium = Medium,
      nPorts=2,
      p=100000,
      T=300)   annotation (Placement(transformation(extent={{74,-20},{62,-8}},
            rotation=0)));
    Modelica.Fluid.Pipes.DynamicPipe pipe2(
      redeclare package Medium = Medium,
      use_T_start=true,
      redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.TurbulentPipeFlow,
      length=10,
      diameter=2.54e-2,
      nNodes=1,
      p_a_start=500000,
      p_b_start=500000,
      modelStructure=Modelica.Fluid.Types.ModelStructure.a_vb)
                        annotation (Placement(transformation(extent={{-40,36},{
              -20,56}}, rotation=0)));
    Modelica.Fluid.Pipes.DynamicPipe pipe3(
      redeclare package Medium = Medium,
      use_T_start=true,
      redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.TurbulentPipeFlow,
      length=10,
      diameter=2.54e-2,
      nNodes=1,
      p_a_start=500000,
      p_b_start=500000,
      modelStructure=Modelica.Fluid.Types.ModelStructure.a_vb)
                        annotation (Placement(transformation(extent={{-40,-50},
              {-20,-30}}, rotation=0)));
    Modelica.Blocks.Sources.TimeTable valveOpening1(offset=0, table=[0,0; 1,0;
          1,1; 100,1]) annotation (Placement(transformation(extent={{-20,70},{0,
              90}}, rotation=0)));
    Modelica.Blocks.Sources.TimeTable valveOpening2(offset=0, table=[0,0; 2,0;
          2,1; 100,1]) annotation (Placement(transformation(extent={{-20,-10},{
              0,10}}, rotation=0)));
    inner Modelica.Fluid.System system(energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
                          annotation (Placement(transformation(extent={{-100,60},
              {-80,80}}, rotation=0)));
  equation
    connect(source.ports[1], pipe1.port_a) annotation (Line(points={{-88,6},{-80,6},
            {-72,6}},
          color={0,127,255}));
    connect(valveIncompressible1.port_b, sink.ports[2]) annotation (Line(points={{28,-40},
            {46,-40},{46,-15.2},{62,-15.2}},     color={0,127,255}));
    connect(valveIncompressible.port_b, sink.ports[1]) annotation (Line(points={{30,46},
            {46,46},{46,-12.8},{62,-12.8}}, color={0,127,255}));
    connect(pipe3.port_b, valveIncompressible1.port_a) annotation (Line(points={{-20,-40},
            {8,-40}},            color={0,127,255}));
    connect(pipe2.port_b, valveIncompressible.port_a) annotation (Line(points={
            {-20,46},{10,46}}, color={0,127,255}));
    connect(pipe2.port_a, pipe1.port_b) annotation (Line(points={{-40,46},{-46,
            46},{-46,6},{-52,6}}, color={0,127,255}));
    connect(pipe1.port_b, pipe3.port_a) annotation (Line(points={{-52,6},{-46,6},
            {-46,-40},{-40,-40}}, color={0,127,255}));
    connect(valveOpening1.y, valveIncompressible.opening) annotation (Line(
          points={{1,80},{20,80},{20,54}}, color={0,0,127}));
    connect(valveOpening2.y, valveIncompressible1.opening) annotation (Line(
          points={{1,6.10623e-16},{18,6.10623e-16},{18,-32}},
                                          color={0,0,127}));
    annotation (
              experiment(StopTime=5),
      Documentation(info="<html>
Simulation starts with both valves closed. At t=1, valve 1 opens; at t=2 valve 2 opens.
</html>"));
  end BranchingPipes2;

  model BranchingPipes3
    extends Modelica.Icons.Example;
    replaceable package Medium = Modelica.Media.Water.StandardWater;
    Modelica.Fluid.Sources.Boundary_pT source(nPorts=1,
      redeclare package Medium = Medium,
      p=5.0e5,
      T=300) annotation (Placement(transformation(extent={{-100,0},{-88,12}},
            rotation=0)));
    Modelica.Fluid.Pipes.DynamicPipe pipe1(
      redeclare package Medium = Medium,
      use_T_start=true,
      redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.TurbulentPipeFlow,
      length=10,
      diameter=2.54e-2,
      p_a_start=500000,
      p_b_start=500000,
      nNodes=1,
      modelStructure=Modelica.Fluid.Types.ModelStructure.a_v_b)
                        annotation (Placement(transformation(extent={{-80,-4},{
              -60,16}}, rotation=0)));
    Modelica.Fluid.Valves.ValveIncompressible valveIncompressible(
      redeclare package Medium = Medium,
      CvData=Modelica.Fluid.Types.CvTypes.OpPoint,
      dp_nominal=4.0e5,
      m_flow_nominal=1,
      rho_nominal=1000) annotation (Placement(transformation(extent={{10,36},{30,56}},
            rotation=0)));
    Modelica.Fluid.Valves.ValveIncompressible valveIncompressible1(
      redeclare package Medium = Medium,
      CvData=Modelica.Fluid.Types.CvTypes.OpPoint,
      dp_nominal=4.0e5,
      m_flow_nominal=1,
      rho_nominal=1000) annotation (Placement(transformation(extent={{8,-50},{28,-30}},
            rotation=0)));
    Modelica.Fluid.Sources.Boundary_pT sink(
      redeclare package Medium = Medium,
      nPorts=2,
      p=100000,
      T=300)   annotation (Placement(transformation(extent={{74,-20},{62,-8}},
            rotation=0)));
    Modelica.Fluid.Pipes.DynamicPipe pipe2(
      redeclare package Medium = Medium,
      use_T_start=true,
      redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.TurbulentPipeFlow,
      length=10,
      diameter=2.54e-2,
      p_a_start=500000,
      p_b_start=500000,
      nNodes=1,
      modelStructure=Modelica.Fluid.Types.ModelStructure.a_vb)
                        annotation (Placement(transformation(extent={{-40,36},{
              -20,56}}, rotation=0)));
    Modelica.Fluid.Pipes.DynamicPipe pipe3(
      redeclare package Medium = Medium,
      use_T_start=true,
      redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.TurbulentPipeFlow,
      length=10,
      diameter=2.54e-2,
      p_a_start=500000,
      p_b_start=500000,
      nNodes=1,
      modelStructure=Modelica.Fluid.Types.ModelStructure.a_vb)
                        annotation (Placement(transformation(extent={{-40,-50},
              {-20,-30}}, rotation=0)));
    Modelica.Blocks.Sources.TimeTable valveOpening1(offset=0, table=[0,0; 1,0;
          1,1; 100,1]) annotation (Placement(transformation(extent={{-20,70},{0,
              90}}, rotation=0)));
    Modelica.Blocks.Sources.TimeTable valveOpening2(offset=0, table=[0,0; 2,0;
          2,1; 100,1]) annotation (Placement(transformation(extent={{-20,-10},{
              0,10}}, rotation=0)));
    inner Modelica.Fluid.System system(energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
                          annotation (Placement(transformation(extent={{-100,60},
              {-80,80}}, rotation=0)));
    Modelica.Fluid.Fittings.TeeJunctionIdeal splitter(
                                     redeclare package Medium = Medium)
      annotation (Placement(transformation(
          origin={-43,6},
          extent={{-6,-7},{6,7}},
          rotation=90)));
  equation
    connect(source.ports[1], pipe1.port_a) annotation (Line(points={{-88,6},{-84,6},
            {-80,6}},
          color={0,127,255}));
    connect(valveIncompressible1.port_b, sink.ports[2]) annotation (Line(points={{28,-40},
            {46,-40},{46,-15.2},{62,-15.2}},     color={0,127,255}));
    connect(valveIncompressible.port_b, sink.ports[1]) annotation (Line(points={{30,46},
            {46,46},{46,-12.8},{62,-12.8}}, color={0,127,255}));
    connect(pipe3.port_b, valveIncompressible1.port_a) annotation (Line(points={{-20,-40},
            {8,-40}},            color={0,127,255}));
    connect(pipe2.port_b, valveIncompressible.port_a) annotation (Line(points={
            {-20,46},{10,46}}, color={0,127,255}));
    connect(valveOpening1.y, valveIncompressible.opening) annotation (Line(
          points={{1,80},{20,80},{20,54}}, color={0,0,127}));
    connect(valveOpening2.y, valveIncompressible1.opening) annotation (Line(
          points={{1,6.10623e-16},{18,6.10623e-16},{18,-32}},
                                          color={0,0,127}));
    connect(pipe1.port_b, splitter.port_3) annotation (Line(points={{-60,6},{-55,6},
            {-50,6}},color={0,127,255}));
    connect(pipe2.port_a, splitter.port_2) annotation (Line(points={{-40,46},{
            -43,46},{-43,12}}, color={0,127,255}));
    connect(splitter.port_1, pipe3.port_a) annotation (Line(points={{-43,
            -1.16573e-15},{-43,-40.3},{-40,-40.3},{-40,-40}},
                                               color={0,127,255}));
    annotation (
              experiment(StopTime=5),
      Documentation(info="<html>
Simulation starts with both valves open. At t=1, valve 1 closes; at t=2 valve 2 closes.
</html>"));
  end BranchingPipes3;

  model BranchingPipes4
    extends Modelica.Icons.Example;
    replaceable package Medium = Modelica.Media.Water.StandardWater;
    Modelica.Fluid.Sources.Boundary_pT source(nPorts=1,
      redeclare package Medium = Medium,
      p=5.0e5,
      T=300) annotation (Placement(transformation(extent={{-100,0},{-88,12}},
            rotation=0)));
    Modelica.Fluid.Pipes.DynamicPipe pipe1(
      redeclare package Medium = Medium,
      use_T_start=true,
      length=10,
      diameter=2.54e-2,
      redeclare model FlowModel =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
      p_a_start=500000,
      p_b_start=500000,
      nNodes=1,
      modelStructure=Modelica.Fluid.Types.ModelStructure.a_v_b)
                        annotation (Placement(transformation(extent={{-80,-4},{
              -60,16}}, rotation=0)));
    Modelica.Fluid.Valves.ValveIncompressible valveIncompressible(
      redeclare package Medium = Medium,
      CvData=Modelica.Fluid.Types.CvTypes.OpPoint,
      dp_nominal=4.0e5,
      m_flow_nominal=1,
      rho_nominal=1000) annotation (Placement(transformation(extent={{10,36},{30,56}},
            rotation=0)));
    Modelica.Fluid.Valves.ValveIncompressible valveIncompressible1(
      redeclare package Medium = Medium,
      CvData=Modelica.Fluid.Types.CvTypes.OpPoint,
      dp_nominal=4.0e5,
      m_flow_nominal=1,
      rho_nominal=1000) annotation (Placement(transformation(extent={{8,-50},{28,-30}},
            rotation=0)));
    Modelica.Fluid.Sources.Boundary_pT sink(
      redeclare package Medium = Medium,
      nPorts=2,
      p=100000,
      T=300)   annotation (Placement(transformation(extent={{74,-20},{62,-8}},
            rotation=0)));
    Modelica.Fluid.Pipes.DynamicPipe pipe2(
      redeclare package Medium = Medium,
      use_T_start=true,
      length=10,
      diameter=2.54e-2,
      redeclare model FlowModel =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
      modelStructure=Modelica.Fluid.Types.ModelStructure.a_vb,
      p_a_start=500000,
      p_b_start=500000,
      nNodes=1)         annotation (Placement(transformation(extent={{-40,36},{
              -20,56}}, rotation=0)));
    Modelica.Fluid.Pipes.DynamicPipe pipe3(
      redeclare package Medium = Medium,
      use_T_start=true,
      length=10,
      diameter=2.54e-2,
      redeclare model FlowModel =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
      modelStructure=Modelica.Fluid.Types.ModelStructure.a_vb,
      p_a_start=500000,
      p_b_start=500000,
      nNodes=1)         annotation (Placement(transformation(extent={{-40,-50},
              {-20,-30}}, rotation=0)));
    Modelica.Blocks.Sources.TimeTable valveOpening1(offset=0, table=[0,0; 1,0;
          1,1; 100,1]) annotation (Placement(transformation(extent={{-20,70},{0,
              90}}, rotation=0)));
    Modelica.Blocks.Sources.TimeTable valveOpening2(offset=0, table=[0,0; 2,0;
          2,1; 100,1]) annotation (Placement(transformation(extent={{-20,-10},{
              0,10}}, rotation=0)));
    inner Modelica.Fluid.System system(energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
                          annotation (Placement(transformation(extent={{-100,60},
              {-80,80}}, rotation=0)));
    Modelica.Fluid.Fittings.TeeJunctionVolume splitter(
                                      redeclare package Medium = Medium,
      V=0.0002,
      energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
      massDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
      p_start=500000)
      annotation (Placement(transformation(
          origin={-43,6},
          extent={{-6,-7},{6,7}},
          rotation=90)));
  equation
    connect(source.ports[1], pipe1.port_a) annotation (Line(points={{-88,6},{
            -84,6},{-80,6}},
          color={0,127,255}));
    connect(valveIncompressible1.port_b, sink.ports[2]) annotation (Line(points={{28,-40},
            {46,-40},{46,-15.2},{62,-15.2}},     color={0,127,255}));
    connect(valveIncompressible.port_b, sink.ports[1]) annotation (Line(points={{30,46},
            {46,46},{46,-12.8},{62,-12.8}}, color={0,127,255}));
    connect(pipe3.port_b, valveIncompressible1.port_a) annotation (Line(points={{-20,-40},
            {8,-40}},            color={0,127,255}));
    connect(pipe2.port_b, valveIncompressible.port_a) annotation (Line(points={
            {-20,46},{10,46}}, color={0,127,255}));
    connect(valveOpening1.y, valveIncompressible.opening) annotation (Line(
          points={{1,80},{20,80},{20,54}}, color={0,0,127}));
    connect(valveOpening2.y, valveIncompressible1.opening) annotation (Line(
          points={{1,6.10623e-16},{18,6.10623e-16},{18,-32}},
                                          color={0,0,127}));
    connect(pipe1.port_b, splitter.port_3) annotation (Line(points={{-60,6},{
            -55,6},{-50,6}},
                     color={0,127,255}));
    connect(pipe2.port_a, splitter.port_2) annotation (Line(points={{-40,46},{
            -43,46},{-43,12}}, color={0,127,255}));
    connect(splitter.port_1, pipe3.port_a) annotation (Line(points={{-43,
            -1.16573e-15},{-43,-40.3},{-40,-40.3},{-40,-40}},
                                               color={0,127,255}));
    annotation (
              experiment(StopTime=5),
      Documentation(info="<html>
Uses dynamic splitter. Simulation starts with both valves open. At t=1, valve 1 closes; at t=2 valve 2 closes. The simulation fails at t=0 due to lack of initialization of the splitter state variables.
</html>"));
  end BranchingPipes4;

  model BranchingPipes12
    extends Modelica.Icons.Example;
    replaceable package Medium = Modelica.Media.Water.StandardWater;
    Modelica.Fluid.Sources.Boundary_pT source(nPorts=1,
      redeclare package Medium = Medium,
      p=5.0e5,
      T=300) annotation (Placement(transformation(extent={{-100,0},{-88,12}},
            rotation=0)));
    Modelica.Fluid.Pipes.DynamicPipe pipe1(
      redeclare package Medium = Medium,
      use_T_start=true,
      length=10,
      diameter=2.54e-2,
      redeclare model FlowModel =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
      p_a_start=500000,
      p_b_start=495000,
      nNodes=1,
      modelStructure=Modelica.Fluid.Types.ModelStructure.a_v_b)
                        annotation (Placement(transformation(extent={{-78,-4},{
              -58,16}}, rotation=0)));
    Modelica.Fluid.Valves.ValveIncompressible valveIncompressible(
      redeclare package Medium = Medium,
      CvData=Modelica.Fluid.Types.CvTypes.OpPoint,
      dp_nominal=4.0e5,
      m_flow_nominal=1,
      rho_nominal=1000,
      filteredOpening=true,
      riseTime=0.1,
      leakageOpening=0.001)
                        annotation (Placement(transformation(extent={{10,36},{30,56}},
            rotation=0)));
    Modelica.Fluid.Valves.ValveIncompressible valveIncompressible1(
      redeclare package Medium = Medium,
      CvData=Modelica.Fluid.Types.CvTypes.OpPoint,
      dp_nominal=4.0e5,
      m_flow_nominal=1,
      rho_nominal=1000,
      filteredOpening=true,
      riseTime=0.1,
      leakageOpening=0.001)
                        annotation (Placement(transformation(extent={{8,-50},{28,-30}},
            rotation=0)));
    Modelica.Fluid.Sources.Boundary_pT sink(
      redeclare package Medium = Medium,
      nPorts=2,
      p=100000,
      T=300)   annotation (Placement(transformation(extent={{74,-20},{62,-8}},
            rotation=0)));
    Modelica.Fluid.Pipes.DynamicPipe pipe2(
      redeclare package Medium = Medium,
      use_T_start=true,
      length=10,
      diameter=2.54e-2,
      redeclare model FlowModel =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
      p_a_start=495000,
      p_b_start=490000,
      nNodes=1,
      modelStructure=Modelica.Fluid.Types.ModelStructure.a_vb)
                        annotation (Placement(transformation(extent={{-40,36},{
              -20,56}}, rotation=0)));
    Modelica.Fluid.Pipes.DynamicPipe pipe3(
      redeclare package Medium = Medium,
      use_T_start=true,
      length=10,
      diameter=2.54e-2,
      redeclare model FlowModel =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
      p_a_start=495000,
      p_b_start=490000,
      nNodes=1,
      modelStructure=Modelica.Fluid.Types.ModelStructure.a_vb)
                        annotation (Placement(transformation(extent={{-40,-50},
              {-20,-30}}, rotation=0)));
    Modelica.Blocks.Sources.TimeTable valveOpening1(offset=0, table=[0,1; 1,1;
          1,0; 100,0]) annotation (Placement(transformation(extent={{-20,70},{0,
              90}}, rotation=0)));
    Modelica.Blocks.Sources.TimeTable valveOpening2(offset=0, table=[0,1; 2,1;
          2,0; 100,0]) annotation (Placement(transformation(extent={{-20,-10},{
              0,10}}, rotation=0)));
    inner Modelica.Fluid.System system(energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
                          annotation (Placement(transformation(extent={{-100,60},
              {-80,80}}, rotation=0)));
  equation
    connect(source.ports[1], pipe1.port_a) annotation (Line(points={{-88,6},{-83,6},
            {-78,6}},
          color={0,127,255}));
    connect(valveIncompressible1.port_b, sink.ports[2]) annotation (Line(points={{28,-40},
            {46,-40},{46,-15.2},{62,-15.2}},     color={0,127,255}));
    connect(valveIncompressible.port_b, sink.ports[1]) annotation (Line(points={{30,46},
            {46,46},{46,-12.8},{62,-12.8}}, color={0,127,255}));
    connect(pipe3.port_b, valveIncompressible1.port_a) annotation (Line(points={{-20,-40},
            {8,-40}},            color={0,127,255}));
    connect(pipe2.port_b, valveIncompressible.port_a) annotation (Line(points={
            {-20,46},{10,46}}, color={0,127,255}));
    connect(pipe2.port_a, pipe1.port_b) annotation (Line(points={{-40,46},{-46,
            46},{-46,6},{-58,6}}, color={0,127,255}));
    connect(pipe1.port_b, pipe3.port_a) annotation (Line(points={{-58,6},{-46,6},
            {-46,-40},{-40,-40}}, color={0,127,255}));
    connect(valveOpening1.y, valveIncompressible.opening) annotation (Line(
          points={{1,80},{20,80},{20,54}}, color={0,0,127}));
    connect(valveOpening2.y, valveIncompressible1.opening) annotation (Line(
          points={{1,6.10623e-16},{18,6.10623e-16},{18,-32}},
                                          color={0,0,127}));
    annotation (
      experiment(StopTime=5),
      Documentation(info="<html>
Simulation starts with both valves open. At t=1, valve 1 closes; at t=2 valve 2 closes.
</html>"));
  end BranchingPipes12;

  model BranchingPipes13
    extends Modelica.Icons.Example;
    // replaceable package Medium = Modelica.Media.Air.SimpleAir;
    replaceable package Medium = Modelica.Media.Water.StandardWater;
    Modelica.Fluid.Sources.Boundary_pT source(nPorts=1,
      redeclare package Medium = Medium,
      p=5.0e5,
      T=300) annotation (Placement(transformation(extent={{-100,0},{-88,12}},
            rotation=0)));
    Modelica.Fluid.Pipes.DynamicPipe pipe1(
      redeclare package Medium = Medium,
      use_T_start=true,
      length=10,
      diameter=2.54e-2,
      redeclare model FlowModel =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
      nNodes=1,
      p_a_start=500000,
      p_b_start=495000,
      modelStructure=Modelica.Fluid.Types.ModelStructure.a_vb)
                        annotation (Placement(transformation(extent={{-78,-4},{
              -58,16}}, rotation=0)));
    Modelica.Fluid.Valves.ValveIncompressible valveIncompressible(
      redeclare package Medium = Medium,
      CvData=Modelica.Fluid.Types.CvTypes.OpPoint,
      m_flow_nominal=1,
      rho_nominal=5,
      dp_nominal=400000)
                  annotation (Placement(transformation(extent={{10,36},{30,56}},
            rotation=0)));
    Modelica.Fluid.Valves.ValveIncompressible valveIncompressible1(
      redeclare package Medium = Medium,
      CvData=Modelica.Fluid.Types.CvTypes.OpPoint,
      m_flow_nominal=1,
      rho_nominal=5,
      dp_nominal=400000)
                  annotation (Placement(transformation(extent={{8,-50},{28,-30}},
            rotation=0)));
    Modelica.Fluid.Sources.Boundary_pT sink(
      redeclare package Medium = Medium,
      nPorts=2,
      p=100000,
      T=300)   annotation (Placement(transformation(extent={{74,-20},{62,-8}},
            rotation=0)));
    Modelica.Fluid.Pipes.DynamicPipe pipe2(
      redeclare package Medium = Medium,
      use_T_start=true,
      length=10,
      diameter=2.54e-2,
      redeclare model FlowModel =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
      p_a_start=495000,
      p_b_start=490000,
      nNodes=1,
      modelStructure=Modelica.Fluid.Types.ModelStructure.a_vb)
                        annotation (Placement(transformation(extent={{-34,36},{
              -14,56}}, rotation=0)));
    Modelica.Fluid.Pipes.DynamicPipe pipe3(
      redeclare package Medium = Medium,
      use_T_start=true,
      length=10,
      diameter=2.54e-2,
      redeclare model FlowModel =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
      p_a_start=495000,
      p_b_start=490000,
      nNodes=1,
      modelStructure=Modelica.Fluid.Types.ModelStructure.a_vb)
                        annotation (Placement(transformation(extent={{-30,-50},
              {-10,-30}}, rotation=0)));
    Modelica.Blocks.Sources.TimeTable valveOpening1(offset=0, table=[0,1; 1,1;
          1,0; 100,0]) annotation (Placement(transformation(extent={{-20,70},{0,
              90}}, rotation=0)));
    Modelica.Blocks.Sources.TimeTable valveOpening2(offset=0, table=[0,1; 2,1;
          2,0.001; 100,0])
                       annotation (Placement(transformation(extent={{-20,-10},{
              0,10}}, rotation=0)));
    inner Modelica.Fluid.System system(energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
                          annotation (Placement(transformation(extent={{-100,60},
              {-80,80}}, rotation=0)));
    Modelica.Fluid.Fittings.TeeJunctionIdeal junctionIdeal(
                                          redeclare package Medium = Medium)
      annotation (Placement(transformation(
          origin={-38,6},
          extent={{-10,-10},{10,10}},
          rotation=90)));
  equation
    connect(source.ports[1], pipe1.port_a) annotation (Line(points={{-88,6},{-83,6},
            {-78,6}},
          color={0,127,255}));
    connect(valveIncompressible1.port_b, sink.ports[2]) annotation (Line(points={{28,-40},
            {46,-40},{46,-15.2},{62,-15.2}},     color={0,127,255}));
    connect(valveIncompressible.port_b, sink.ports[1]) annotation (Line(points={{30,46},
            {46,46},{46,-12.8},{62,-12.8}}, color={0,127,255}));
    connect(pipe3.port_b, valveIncompressible1.port_a) annotation (Line(points={{-10,-40},
            {8,-40}},            color={0,127,255}));
    connect(pipe2.port_b, valveIncompressible.port_a) annotation (Line(points={
            {-14,46},{10,46}}, color={0,127,255}));
    connect(valveOpening1.y, valveIncompressible.opening) annotation (Line(
          points={{1,80},{20,80},{20,54}}, color={0,0,127}));
    connect(valveOpening2.y, valveIncompressible1.opening) annotation (Line(
          points={{1,6.10623e-16},{18,6.10623e-16},{18,-32}},
                                          color={0,0,127}));
    connect(pipe1.port_b, junctionIdeal.port_3) annotation (Line(points={{-58,6},{
            -53,6},{-48,6}},              color={0,127,255}));
    connect(pipe2.port_a, junctionIdeal.port_2) annotation (Line(points={{-34,
            46},{-38,46},{-38,16}}, color={0,127,255}));
    connect(junctionIdeal.port_1, pipe3.port_a) annotation (Line(points={{-38,-4},
            {-38,-40},{-30,-40}},     color={0,127,255}));
    annotation (
      experiment(StopTime=5),
      Documentation(info="<html>
Simulation starts with both valves open. At t=1, valve 1 closes; at t=2 valve 2 closes.
</html>"));
  end BranchingPipes13;

  model BranchingPipes14
    extends Modelica.Icons.Example;
    // replaceable package Medium = Modelica.Media.Air.SimpleAir;
    replaceable package Medium = Modelica.Media.Water.StandardWater;
    Modelica.Fluid.Sources.Boundary_pT source(nPorts=1,
      redeclare package Medium = Medium,
      p=5.0e5,
      T=300) annotation (Placement(transformation(extent={{-100,0},{-88,12}},
            rotation=0)));
    Modelica.Fluid.Pipes.DynamicPipe pipe1(
      redeclare package Medium = Medium,
      use_T_start=true,
      redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.TurbulentPipeFlow,
      length=10,
      diameter=2.54e-2,
      p_a_start=500000,
      p_b_start=495000,
      nNodes=1,
      modelStructure=Modelica.Fluid.Types.ModelStructure.a_v_b)
                        annotation (Placement(transformation(extent={{-78,-4},{
              -58,16}}, rotation=0)));
    Modelica.Fluid.Valves.ValveIncompressible valve1(
      redeclare package Medium = Medium,
      CvData=Modelica.Fluid.Types.CvTypes.OpPoint,
       dp_nominal=4.0e5,
      m_flow_nominal=1,
      rho_nominal=5)    annotation (Placement(transformation(extent={{10,36},{30,56}},
            rotation=0)));
    Modelica.Fluid.Valves.ValveIncompressible valve2(
      redeclare package Medium = Medium,
      CvData=Modelica.Fluid.Types.CvTypes.OpPoint,
      dp_nominal=4.0e5,
      m_flow_nominal=1,
      rho_nominal=5)    annotation (Placement(transformation(extent={{8,-50},{28,-30}},
            rotation=0)));
    Modelica.Fluid.Sources.Boundary_pT sink(
      redeclare package Medium = Medium,
      nPorts=2,
      p=100000,
      T=300)   annotation (Placement(transformation(extent={{74,-20},{62,-8}},
            rotation=0)));
    Modelica.Fluid.Pipes.DynamicPipe pipe2(
      redeclare package Medium = Medium,
      use_T_start=true,
      redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.TurbulentPipeFlow,
      length=10,
      diameter=2.54e-2,
      p_a_start=495000,
      p_b_start=490000,
      nNodes=1,
      modelStructure=Modelica.Fluid.Types.ModelStructure.a_vb)
                        annotation (Placement(transformation(extent={{-34,36},{
              -14,56}}, rotation=0)));
    Modelica.Fluid.Pipes.DynamicPipe pipe3(
      redeclare package Medium = Medium,
      use_T_start=true,
      redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.TurbulentPipeFlow,
      length=10,
      diameter=2.54e-2,
      p_a_start=495000,
      p_b_start=490000,
      nNodes=1,
      modelStructure=Modelica.Fluid.Types.ModelStructure.a_vb)
                        annotation (Placement(transformation(extent={{-30,-50},
              {-10,-30}}, rotation=0)));
    Modelica.Blocks.Sources.TimeTable valveOpening1(offset=0, table=[0,1; 1,1;
          2,1e-2; 100,1e-2])
                       annotation (Placement(transformation(extent={{-20,72},{0,
              92}}, rotation=0)));
    Modelica.Blocks.Sources.TimeTable valveOpening2(offset=0, table=[0,1; 3,1;
          4,1e-2; 100,1e-2])
                       annotation (Placement(transformation(extent={{-20,-10},{
              0,10}}, rotation=0)));
    inner Modelica.Fluid.System system(energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
                          annotation (Placement(transformation(extent={{-100,60},
              {-80,80}}, rotation=0)));
    Modelica.Fluid.Fittings.TeeJunctionVolume junctionIdeal(
                                          redeclare package Medium = Medium,
      V=1e-3,
      energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
      massDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
      p_start=500000,
      T_start=300)
      annotation (Placement(transformation(
          origin={-38,6},
          extent={{-10,-10},{10,10}},
          rotation=90)));
  equation
    connect(source.ports[1], pipe1.port_a) annotation (Line(points={{-88,6},{-83,6},
            {-78,6}},
          color={0,127,255}));
    connect(valve2.port_b, sink.ports[2])               annotation (Line(points={{28,-40},
            {46,-40},{46,-15.2},{62,-15.2}},     color={0,127,255}));
    connect(valve1.port_b, sink.ports[1])              annotation (Line(points={{30,46},
            {46,46},{46,-12.8},{62,-12.8}}, color={0,127,255}));
    connect(pipe3.port_b, valve2.port_a)               annotation (Line(points={{-10,-40},
            {8,-40}},            color={0,127,255}));
    connect(pipe2.port_b, valve1.port_a)              annotation (Line(points={
            {-14,46},{10,46}}, color={0,127,255}));
    connect(valveOpening1.y, valve1.opening)              annotation (Line(
          points={{1,82},{20,82},{20,54}}, color={0,0,127}));
    connect(valveOpening2.y, valve2.opening)               annotation (Line(
          points={{1,6.10623e-16},{18,6.10623e-16},{18,-32}},
                                          color={0,0,127}));
    connect(pipe1.port_b, junctionIdeal.port_3) annotation (Line(points={{-58,6},{
            -48,6}},                      color={0,127,255}));
    connect(pipe2.port_a, junctionIdeal.port_2) annotation (Line(points={{-34,
            46},{-38,46},{-38,16}}, color={0,127,255}));
    connect(junctionIdeal.port_1, pipe3.port_a) annotation (Line(points={{-38,-4},
            {-38,-40},{-30,-40}},     color={0,127,255}));
    annotation (
      experiment(StopTime=5),
      Documentation(info="<html>
Simulation starts with both valves open. At t=1, valve 1 closes; at t=2 valve 2 closes.
</html>"));
  end BranchingPipes14;

  model BranchingPipes15
    extends Modelica.Icons.Example;
    replaceable package Medium = Modelica.Media.Air.DryAirNasa;
    // replaceable package Medium = Modelica.Media.Air.SimpleAir;
    // replaceable package Medium = Modelica.Media.Water.StandardWater;
    Modelica.Fluid.Sources.Boundary_pT source(nPorts=1,
      redeclare package Medium = Medium,
      p=5.0e5,
      T=300) annotation (Placement(transformation(extent={{-100,0},{-88,12}},
            rotation=0)));
    Modelica.Fluid.Pipes.DynamicPipe pipe1(
      redeclare package Medium = Medium,
      use_T_start=true,
      redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.TurbulentPipeFlow (   dp_small=10),
      length=10,
      diameter=2.54e-2,
      p_a_start=500000,
      p_b_start=495000,
      nNodes=1,
      modelStructure=Modelica.Fluid.Types.ModelStructure.a_v_b)
                             annotation (Placement(transformation(extent={{-78,-4},{
              -58,16}}, rotation=0)));
    Modelica.Fluid.Valves.ValveIncompressible valve1(
      redeclare package Medium = Medium,
      CvData=Modelica.Fluid.Types.CvTypes.OpPoint,
      dp_nominal=4.0e5,
      m_flow_nominal=1,
      rho_nominal=5)    annotation (Placement(transformation(extent={{10,36},{30,56}},
            rotation=0)));
    Modelica.Fluid.Valves.ValveIncompressible valve2(
      redeclare package Medium = Medium,
      CvData=Modelica.Fluid.Types.CvTypes.OpPoint,
      dp_nominal=4.0e5,
      m_flow_nominal=1,
      rho_nominal=5)    annotation (Placement(transformation(extent={{8,-50},{28,-30}},
            rotation=0)));
    Modelica.Fluid.Sources.Boundary_pT sink(
      redeclare package Medium = Medium,
      nPorts=2,
      p=100000,
      T=300)   annotation (Placement(transformation(extent={{74,-20},{62,-8}},
            rotation=0)));
    Modelica.Fluid.Pipes.DynamicPipe pipe2(
      redeclare package Medium = Medium,
      use_T_start=true,
      redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.TurbulentPipeFlow (   dp_small=10),
      length=10,
      diameter=2.54e-2,
      p_a_start=495000,
      p_b_start=490000,
      nNodes=1,
      modelStructure=Modelica.Fluid.Types.ModelStructure.a_vb)
                             annotation (Placement(transformation(extent={{-34,36},{
              -14,56}}, rotation=0)));
    Modelica.Fluid.Pipes.DynamicPipe pipe3(
      redeclare package Medium = Medium,
      use_T_start=true,
      redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.TurbulentPipeFlow (   dp_small=10),
      length=10,
      diameter=2.54e-2,
      p_a_start=495000,
      p_b_start=490000,
      nNodes=1,
      modelStructure=Modelica.Fluid.Types.ModelStructure.a_vb)
                             annotation (Placement(transformation(extent={{-30,-50},
              {-10,-30}}, rotation=0)));
    Modelica.Blocks.Sources.TimeTable valveOpening1(offset=0, table=[0,1; 1,1; 2,
          1e-3; 100,1e-3])
                       annotation (Placement(transformation(extent={{-20,72},{0,
              92}}, rotation=0)));
    Modelica.Blocks.Sources.TimeTable valveOpening2(offset=0, table=[0,1; 3,1; 4,
          1e-3; 100,1e-3])
                       annotation (Placement(transformation(extent={{-20,-10},{
              0,10}}, rotation=0)));
    inner Modelica.Fluid.System system(energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
                          annotation (Placement(transformation(extent={{-100,60},
              {-80,80}}, rotation=0)));
    Modelica.Fluid.Fittings.TeeJunctionVolume junctionIdeal(
                                          redeclare package Medium = Medium,
      V=1e-3,
      energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
      massDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
      p_start=500000,
      T_start=300)
      annotation (Placement(transformation(
          origin={-38,6},
          extent={{-10,-10},{10,10}},
          rotation=90)));
  equation
    connect(source.ports[1], pipe1.port_a) annotation (Line(points={{-88,6},{-83,6},
            {-78,6}},
          color={0,127,255}));
    connect(valve2.port_b, sink.ports[2])               annotation (Line(points={{28,-40},
            {46,-40},{46,-15.2},{62,-15.2}},     color={0,127,255}));
    connect(valve1.port_b, sink.ports[1])              annotation (Line(points={{30,46},
            {46,46},{46,-12.8},{62,-12.8}}, color={0,127,255}));
    connect(pipe3.port_b, valve2.port_a)               annotation (Line(points={{-10,-40},
            {8,-40}},            color={0,127,255}));
    connect(pipe2.port_b, valve1.port_a)              annotation (Line(points={
            {-14,46},{10,46}}, color={0,127,255}));
    connect(valveOpening1.y, valve1.opening)              annotation (Line(
          points={{1,82},{20,82},{20,54}}, color={0,0,127}));
    connect(valveOpening2.y, valve2.opening)               annotation (Line(
          points={{1,6.10623e-16},{18,6.10623e-16},{18,-32}},
                                          color={0,0,127}));
    connect(pipe1.port_b, junctionIdeal.port_3) annotation (Line(points={{-58,6},{
            -48,6}},                      color={0,127,255}));
    connect(pipe2.port_a, junctionIdeal.port_2) annotation (Line(points={{-34,
            46},{-38,46},{-38,16}}, color={0,127,255}));
    connect(junctionIdeal.port_1, pipe3.port_a) annotation (Line(points={{-38,-4},
            {-38,-40},{-30,-40}},     color={0,127,255}));
    annotation (
      experiment(StopTime=5),
      Documentation(info="<html>
Simulation starts with both valves open. At t=1, valve 1 closes; at t=2 valve 2 closes.
</html>"));
  end BranchingPipes15;

  model BranchingPipes16
    extends Modelica.Icons.Example;
    replaceable package Medium = Modelica.Media.Air.DryAirNasa;
    // replaceable package Medium = Modelica.Media.Air.SimpleAir;
    // replaceable package Medium = Modelica.Media.Water.StandardWater;
    Modelica.Fluid.Sources.Boundary_pT source(nPorts=1,
      redeclare package Medium = Medium,
      p=5.0e5,
      T=300) annotation (Placement(transformation(extent={{-100,0},{-88,12}},
            rotation=0)));
    Modelica.Fluid.Pipes.DynamicPipe pipe1(
      redeclare package Medium = Medium,
      use_T_start=true,
      redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.TurbulentPipeFlow (   dp_small=10),
      length=10,
      diameter=2.54e-2,
      p_a_start=500000,
      p_b_start=495000,
      nNodes=1,
      modelStructure=Modelica.Fluid.Types.ModelStructure.a_v_b)
                             annotation (Placement(transformation(extent={{-78,-4},{
              -58,16}}, rotation=0)));
    Modelica.Fluid.Valves.ValveIncompressible valve1(
      redeclare package Medium = Medium,
      CvData=Modelica.Fluid.Types.CvTypes.OpPoint,
      dp_nominal=4.0e5,
      m_flow_nominal=1,
      rho_nominal=5)    annotation (Placement(transformation(extent={{10,36},{30,56}},
            rotation=0)));
    Modelica.Fluid.Valves.ValveIncompressible valve2(
      redeclare package Medium = Medium,
      CvData=Modelica.Fluid.Types.CvTypes.OpPoint,
      dp_nominal=4.0e5,
      m_flow_nominal=1,
      rho_nominal=5)    annotation (Placement(transformation(extent={{8,-50},{28,-30}},
            rotation=0)));
    Modelica.Fluid.Sources.Boundary_pT sink(
      redeclare package Medium = Medium,
      nPorts=2,
      p=100000,
      T=300)   annotation (Placement(transformation(extent={{74,-20},{62,-8}},
            rotation=0)));
    Modelica.Fluid.Pipes.DynamicPipe pipe2(
      redeclare package Medium = Medium,
      use_T_start=true,
      redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.TurbulentPipeFlow (   dp_small=10),
      length=10,
      diameter=2.54e-2,
      p_a_start=495000,
      p_b_start=490000,
      nNodes=1,
      modelStructure=Modelica.Fluid.Types.ModelStructure.a_vb)
                             annotation (Placement(transformation(extent={{-34,36},{
              -14,56}}, rotation=0)));
    Modelica.Fluid.Pipes.DynamicPipe pipe3(
      redeclare package Medium = Medium,
      use_T_start=true,
      redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.TurbulentPipeFlow (   dp_small=10),
      length=10,
      diameter=2.54e-2,
      p_a_start=495000,
      p_b_start=490000,
      nNodes=1,
      modelStructure=Modelica.Fluid.Types.ModelStructure.a_vb)
                             annotation (Placement(transformation(extent={{-30,-50},
              {-10,-30}}, rotation=0)));
    Modelica.Blocks.Sources.TimeTable valveOpening1(offset=0, table=[0,1; 1,1;
          2,0; 100,0]) annotation (Placement(transformation(extent={{-20,72},{0,
              92}}, rotation=0)));
    Modelica.Blocks.Sources.TimeTable valveOpening2(offset=0, table=[0,1; 3,1;
          4,0; 100,0]) annotation (Placement(transformation(extent={{-20,-12},{
              0,8}}, rotation=0)));
    inner Modelica.Fluid.System system(energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
                          annotation (Placement(transformation(extent={{-100,60},
              {-80,80}}, rotation=0)));
    Modelica.Fluid.Fittings.TeeJunctionVolume junctionIdeal(
                                          redeclare package Medium = Medium,
      V=1e-3,
      energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
      massDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
      p_start=500000,
      T_start=300)
      annotation (Placement(transformation(
          origin={-38,6},
          extent={{-10,-10},{10,10}},
          rotation=90)));
  equation
    connect(source.ports[1], pipe1.port_a) annotation (Line(points={{-88,6},{-83,6},
            {-78,6}},
          color={0,127,255}));
    connect(valve2.port_b, sink.ports[2])               annotation (Line(points={{28,-40},
            {46,-40},{46,-15.2},{62,-15.2}},     color={0,127,255}));
    connect(valve1.port_b, sink.ports[1])              annotation (Line(points={{30,46},
            {46,46},{46,-12.8},{62,-12.8}}, color={0,127,255}));
    connect(pipe3.port_b, valve2.port_a)               annotation (Line(points={{-10,-40},
            {8,-40}},            color={0,127,255}));
    connect(pipe2.port_b, valve1.port_a)              annotation (Line(points={
            {-14,46},{10,46}}, color={0,127,255}));
    connect(valveOpening1.y, valve1.opening)              annotation (Line(
          points={{1,82},{20,82},{20,54}}, color={0,0,127}));
    connect(valveOpening2.y, valve2.opening)               annotation (Line(
          points={{1,-2},{18,-2},{18,-32}}, color={0,0,127}));
    connect(pipe1.port_b, junctionIdeal.port_3) annotation (Line(points={{-58,6},{
            -48,6}},                      color={0,127,255}));
    connect(pipe2.port_a, junctionIdeal.port_2) annotation (Line(points={{-34,
            46},{-38,46},{-38,16}}, color={0,127,255}));
    connect(junctionIdeal.port_1, pipe3.port_a) annotation (Line(points={{-38,-4},
            {-38,-40},{-30,-40}},     color={0,127,255}));
    annotation (
      experiment(StopTime=5),
      Documentation(info="<html>
Simulation starts with both valves open. At t=1, valve 1 closes; at t=2 valve 2 closes.
</html>"));
  end BranchingPipes16;

  model BranchingPipes17
    extends Modelica.Icons.Example;
    replaceable package Medium = Modelica.Media.Air.DryAirNasa;
    // replaceable package Medium = Modelica.Media.Air.SimpleAir;
    // replaceable package Medium = Modelica.Media.Water.StandardWater;
    Modelica.Fluid.Sources.Boundary_pT source(nPorts=1,
      redeclare package Medium = Medium,
      p=5.0e5,
      T=300) annotation (Placement(transformation(extent={{-100,0},{-88,12}},
            rotation=0)));
    Modelica.Fluid.Pipes.DynamicPipe pipe1(
      redeclare package Medium = Medium,
      use_T_start=true,
      redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.TurbulentPipeFlow (   dp_small=10),
      length=10,
      diameter=2.54e-2,
      p_a_start=500000,
      p_b_start=495000,
      nNodes=1,
      modelStructure=Modelica.Fluid.Types.ModelStructure.a_v_b)
                             annotation (Placement(transformation(extent={{-78,-4},{
              -58,16}}, rotation=0)));
    Modelica.Fluid.Valves.ValveIncompressible valve1(
      redeclare package Medium = Medium,
      CvData=Modelica.Fluid.Types.CvTypes.OpPoint,
      dp_nominal=4.0e5,
      m_flow_nominal=1,
      rho_nominal=5,
      dp(start=10))
                  annotation (Placement(transformation(extent={{10,36},{30,56}},
            rotation=0)));
    Modelica.Fluid.Valves.ValveIncompressible valve2(
      redeclare package Medium = Medium,
      CvData=Modelica.Fluid.Types.CvTypes.OpPoint,
      dp_nominal=4.0e5,
      m_flow_nominal=1,
      rho_nominal=5)    annotation (Placement(transformation(extent={{8,-50},{28,-30}},
            rotation=0)));
    Modelica.Fluid.Sources.Boundary_pT sink(nPorts=1,
      redeclare package Medium = Medium,
      T=300,
      p=1.0e5) annotation (Placement(transformation(extent={{94,-18},{82,-6}},
            rotation=0)));
    Modelica.Fluid.Pipes.DynamicPipe pipe2(
      redeclare package Medium = Medium,
      use_T_start=true,
      redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.TurbulentPipeFlow (   dp_small=10),
      length=10,
      diameter=2.54e-2,
      p_a_start=495000,
      p_b_start=490000,
      nNodes=1,
      modelStructure=Modelica.Fluid.Types.ModelStructure.a_vb)
                             annotation (Placement(transformation(extent={{-34,36},{
              -14,56}}, rotation=0)));
    Modelica.Fluid.Pipes.DynamicPipe pipe3(
      redeclare package Medium = Medium,
      use_T_start=true,
      redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.TurbulentPipeFlow (   dp_small=10),
      length=10,
      diameter=2.54e-2,
      p_a_start=495000,
      p_b_start=490000,
      nNodes=1,
      modelStructure=Modelica.Fluid.Types.ModelStructure.a_vb)
                             annotation (Placement(transformation(extent={{-30,-50},
              {-10,-30}}, rotation=0)));
    Modelica.Blocks.Sources.TimeTable valveOpening1(offset=0, table=[0,1; 1,1;
          2,0; 100,0]) annotation (Placement(transformation(extent={{-20,72},{0,
              92}}, rotation=0)));
    Modelica.Blocks.Sources.TimeTable valveOpening2(offset=0, table=[0,1; 3,1;
          4,0; 100,0]) annotation (Placement(transformation(extent={{-18,-12},{
              2,8}}, rotation=0)));
    inner Modelica.Fluid.System system(energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
                          annotation (Placement(transformation(extent={{-100,60},
              {-80,80}}, rotation=0)));
    Modelica.Fluid.Fittings.TeeJunctionVolume junctionIdeal(
                                          redeclare package Medium = Medium,
      V=1e-3,
      energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
      massDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
      p_start=500000,
      T_start=300)
      annotation (Placement(transformation(
          origin={-40,6},
          extent={{-10,-10},{10,10}},
          rotation=90)));
    Modelica.Fluid.Fittings.TeeJunctionVolume junctionVolume(
                                            redeclare package Medium = Medium,
        V=1e-3,
      massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial)
                annotation (Placement(transformation(
          origin={56,-12},
          extent={{-10,10},{10,-10}},
          rotation=90)));
  equation
    connect(source.ports[1], pipe1.port_a) annotation (Line(points={{-88,6},{-83,6},
            {-78,6}},
          color={0,127,255}));
    connect(pipe3.port_b, valve2.port_a)               annotation (Line(points={{-10,-40},
            {8,-40}},            color={0,127,255}));
    connect(pipe2.port_b, valve1.port_a)              annotation (Line(points={
            {-14,46},{10,46}}, color={0,127,255}));
    connect(valveOpening1.y, valve1.opening)              annotation (Line(
          points={{1,82},{20,82},{20,54}}, color={0,0,127}));
    connect(valveOpening2.y, valve2.opening)               annotation (Line(
          points={{3,-2},{18,-2},{18,-32}}, color={0,0,127}));
    connect(pipe1.port_b, junctionIdeal.port_3) annotation (Line(points={{-58,6},{
            -50,6}},                      color={0,127,255}));
    connect(pipe2.port_a, junctionIdeal.port_2) annotation (Line(points={{-34,
            46},{-40,46},{-40,16}}, color={0,127,255}));
    connect(junctionIdeal.port_1, pipe3.port_a) annotation (Line(points={{-40,-4},
            {-40,-40},{-30,-40}},     color={0,127,255}));
    connect(junctionVolume.port_3, sink.ports[1]) annotation (Line(points={{66,-12},
            {82,-12}}, color={0,127,255}));
    connect(valve2.port_b, junctionVolume.port_1) annotation (Line(points={{28,
            -40},{56,-40},{56,-22}}, color={0,127,255}));
    connect(valve1.port_b, junctionVolume.port_2) annotation (Line(points={{30,46},
            {56,46},{56,-2}},     color={0,127,255}));
    annotation (
      experiment(StopTime=5, Tolerance=1e-007),
      Documentation(info="<html>
Simulation starts with both valves open. At t=1, valve 1 closes; at t=2 valve 2 closes.
</html>"));
  end BranchingPipes17;

  model BranchingPipes18
    extends Modelica.Icons.Example;
    // replaceable package Medium = Modelica.Media.Air.DryAirNasa;
    // replaceable package Medium = Modelica.Media.Air.SimpleAir;
    replaceable package Medium = Modelica.Media.Water.StandardWater;
    Modelica.Fluid.Sources.Boundary_pT source(nPorts=1,
      redeclare package Medium = Medium,
      p=5.0e5,
      T=300) annotation (Placement(transformation(extent={{-100,0},{-88,12}},
            rotation=0)));
    Modelica.Fluid.Pipes.DynamicPipe pipe1(
      redeclare package Medium = Medium,
      use_T_start=true,
      redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.TurbulentPipeFlow (   dp_small=10),
      length=10,
      diameter=2.54e-2,
      p_a_start=500000,
      p_b_start=495000,
      nNodes=1,
      modelStructure=Modelica.Fluid.Types.ModelStructure.a_v_b)
                             annotation (Placement(transformation(extent={{-78,-4},{
              -58,16}}, rotation=0)));
    Modelica.Fluid.Valves.ValveIncompressible valve1(
      redeclare package Medium = Medium,
      CvData=Modelica.Fluid.Types.CvTypes.OpPoint,
      dp_nominal=4.0e5,
      m_flow_nominal=1,
      rho_nominal=5)    annotation (Placement(transformation(extent={{10,36},{30,56}},
            rotation=0)));
    Modelica.Fluid.Valves.ValveIncompressible valve2(
      redeclare package Medium = Medium,
      CvData=Modelica.Fluid.Types.CvTypes.OpPoint,
      dp_nominal=4.0e5,
      m_flow_nominal=1,
      rho_nominal=5)    annotation (Placement(transformation(extent={{8,-50},{28,-30}},
            rotation=0)));
    Modelica.Fluid.Sources.Boundary_pT sink(nPorts=1,
      redeclare package Medium = Medium,
      T=300,
      p=1.0e5) annotation (Placement(transformation(extent={{94,-18},{82,-6}},
            rotation=0)));
    Modelica.Fluid.Pipes.DynamicPipe pipe2(
      redeclare package Medium = Medium,
      use_T_start=true,
      redeclare model FlowModel =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.TurbulentPipeFlow (   dp_small=10),
      length=10,
      diameter=2.54e-2,
      p_a_start=495000,
      p_b_start=490000,
      nNodes=1,
      modelStructure=Modelica.Fluid.Types.ModelStructure.a_vb)
                             annotation (Placement(transformation(extent={{-34,36},{
              -14,56}}, rotation=0)));
    Modelica.Fluid.Pipes.DynamicPipe pipe3(
      redeclare package Medium = Medium,
      use_T_start=true,
      redeclare model FlowModel =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.TurbulentPipeFlow (   dp_small=10),
      length=10,
      diameter=2.54e-2,
      p_a_start=495000,
      p_b_start=490000,
      nNodes=1,
      modelStructure=Modelica.Fluid.Types.ModelStructure.a_vb)
                             annotation (Placement(transformation(extent={{-30,-50},
              {-10,-30}}, rotation=0)));
    Modelica.Blocks.Sources.TimeTable valveOpening1(offset=0, table=[0,1; 1,1; 2,
          0; 100,0])   annotation (Placement(transformation(extent={{-20,72},{0,
              92}}, rotation=0)));
    Modelica.Blocks.Sources.TimeTable valveOpening2(offset=0, table=[0,1; 3,1; 4,
          0; 100,0])   annotation (Placement(transformation(extent={{-18,-12},{
              2,8}}, rotation=0)));
    inner Modelica.Fluid.System system(energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
                          annotation (Placement(transformation(extent={{-100,60},
              {-80,80}}, rotation=0)));
    Modelica.Fluid.Fittings.TeeJunctionVolume junctionIdeal(
                                          redeclare package Medium = Medium,
      V=1e-3,
      energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
      massDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
      p_start=500000,
      T_start=300)
      annotation (Placement(transformation(
          origin={-40,6},
          extent={{-10,-10},{10,10}},
          rotation=90)));
    Modelica.Fluid.Fittings.TeeJunctionVolume junctionVolume(
                                            redeclare package Medium = Medium, V=
          1e-3,
      massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial)
                annotation (Placement(transformation(
          origin={56,-12},
          extent={{-10,10},{10,-10}},
          rotation=90)));
  equation
    connect(source.ports[1], pipe1.port_a) annotation (Line(points={{-88,6},{-83,6},
            {-78,6}},
          color={0,127,255}));
    connect(pipe3.port_b, valve2.port_a)               annotation (Line(points={{-10,-40},
            {8,-40}},            color={0,127,255}));
    connect(pipe2.port_b, valve1.port_a)              annotation (Line(points={
            {-14,46},{10,46}}, color={0,127,255}));
    connect(valveOpening1.y, valve1.opening)              annotation (Line(
          points={{1,82},{20,82},{20,54}}, color={0,0,127}));
    connect(valveOpening2.y, valve2.opening)               annotation (Line(
          points={{3,-2},{18,-2},{18,-32}}, color={0,0,127}));
    connect(pipe1.port_b, junctionIdeal.port_3) annotation (Line(points={{-58,6},{
            -54,6},{-50,6}},              color={0,127,255}));
    connect(pipe2.port_a, junctionIdeal.port_2) annotation (Line(points={{-34,46},
            {-40,46},{-40,16}},     color={0,127,255}));
    connect(junctionIdeal.port_1, pipe3.port_a) annotation (Line(points={{-40,-4},
            {-40,-40},{-30,-40}},     color={0,127,255}));
    connect(junctionVolume.port_3, sink.ports[1]) annotation (Line(points={{66,-12},
            {82,-12}}, color={0,127,255}));
    connect(valve2.port_b, junctionVolume.port_1) annotation (Line(points={{28,
            -40},{56,-40},{56,-22}}, color={0,127,255}));
    connect(valve1.port_b, junctionVolume.port_2) annotation (Line(points={{30,46},
            {56,46},{56,-2}},     color={0,127,255}));
    annotation (
      experiment(StopTime=5),
      Documentation(info="<html>
Simulation starts with both valves open. At t=1, valve 1 closes; at t=2 valve 2 closes.
</html>"));
  end BranchingPipes18;

  model LumpedPipeInitialization "Steady-state initialization of a lumped pipe"
    extends Modelica.Icons.Example;
    Modelica.Fluid.Sources.FixedBoundary source(nPorts=1,
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      use_T=false,
      p=10000000,
      h=2e6)
      annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
    BaseClasses.LumpedPipe           pipe(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      h_start=2e6,
      diameter=0.05,
      length=200,
      use_T_start=false,
      p_a_start=10000000,
      p_b_start=9900000)
      annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
    Modelica.Fluid.Valves.ValveCompressible valve(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      Av=1e-3,
      m_flow_nominal=10,
      dp_nominal=10000000,
      p_nominal=10000000)
      annotation (Placement(transformation(extent={{0,-10},{20,10}})));
    Modelica.Fluid.Sources.FixedBoundary sink(nPorts=1,redeclare package Medium
        = Modelica.Media.Water.StandardWaterOnePhase, p=9500000)
                annotation (Placement(transformation(extent={{60,-10},{40,10}})));
    Modelica.Blocks.Sources.Ramp ramp(
      offset=1,
      duration=0.1,
      height=-0.5,
      startTime=2)
                annotation (Placement(transformation(extent={{46,30},{26,50}})));
    inner Modelica.Fluid.System system(energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial)
      annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
    discrete Modelica.SIunits.MassFlowRate m_flow_initial;
  equation
    when time > 0.1 then
      m_flow_initial = valve.port_a.m_flow;
    end when;
    if pipe.energyDynamics >= Modelica.Fluid.Types.Dynamics.SteadyStateInitial and
       pipe.massDynamics >= Modelica.Fluid.Types.Dynamics.SteadyStateInitial then
      when time > 1 then
        assert(abs(valve.port_a.m_flow - m_flow_initial) < 1e-3, "!!!THE SIMULATION DID NOT START IN STEADY-STATE!!!");
      end when;
    end if;
    connect(source.ports[1], pipe.port_a)         annotation (Line(
        points={{-60,6.66134e-16},{-55,6.66134e-16},{-55,1.27676e-15},{-50,
            1.27676e-15},{-50,6.10623e-16},{-40,6.10623e-16}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(pipe.port_b, valve.port_a)               annotation (Line(
        points={{-20,6.10623e-16},{-15,6.10623e-16},{-15,1.22125e-15},{-10,
            1.22125e-15},{-10,6.10623e-16},{-5.55112e-16,6.10623e-16}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(valve.port_b, sink.ports[1])                          annotation (Line(
        points={{20,6.10623e-16},{25,6.10623e-16},{25,1.27676e-15},{30,
            1.27676e-15},{30,6.66134e-16},{40,6.66134e-16}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(ramp.y, valve.opening)               annotation (Line(
        points={{25,40},{10,40},{10,8}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (      experiment(StopTime=4));
  end LumpedPipeInitialization;

  model SeriesPipes1
    extends Modelica.Icons.Example;
    replaceable package Medium = Modelica.Media.Water.StandardWater;
    Modelica.Fluid.Sources.Boundary_pT source(nPorts=1,
      redeclare package Medium = Medium,
      p=500000,
      T=300) annotation (Placement(transformation(extent={{-100,-6},{-88,6}},
            rotation=0)));
    Modelica.Fluid.Pipes.DynamicPipe pipe1(
      use_T_start=true,
      length=10,
      diameter=2.5e-2,
      redeclare package Medium = Medium,
      p_a_start=500000,
      p_b_start=500000,
      nNodes=1,
      modelStructure=Modelica.Fluid.Types.ModelStructure.a_vb)
                                         annotation (Placement(transformation(
            extent={{-76,-10},{-56,10}}, rotation=0)));
    Modelica.Fluid.Valves.ValveIncompressible valve(
      CvData=Modelica.Fluid.Types.CvTypes.OpPoint,
      m_flow_nominal=1,
      rho_nominal=1000,
      redeclare package Medium = Medium,
      dp_nominal=400000,
      filteredOpening=true,
      leakageOpening=0.001)           annotation (Placement(transformation(
            extent={{52,-10},{72,10}}, rotation=0)));
    Modelica.Fluid.Sources.Boundary_pT sink(nPorts=1,
      redeclare package Medium = Medium,
      p=100000,
      T=300)                             annotation (Placement(transformation(
            extent={{94,-6},{82,6}}, rotation=0)));
    Modelica.Fluid.Pipes.DynamicPipe pipe2(
      use_T_start=true,
      length=10,
      diameter=2.5e-2,
      redeclare package Medium = Medium,
      p_a_start=500000,
      p_b_start=500000)                  annotation (Placement(transformation(
            extent={{-14,-10},{6,10}}, rotation=0)));
    Modelica.Blocks.Sources.TimeTable valveOpening1(offset=0, table=[0,1; 1,1;
          1,0; 100,0]) annotation (Placement(transformation(extent={{-20,70},{0,
              90}}, rotation=0)));
    inner Modelica.Fluid.System system(energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
                          annotation (Placement(transformation(extent={{-90,70},{
              -70,90}},  rotation=0)));
    Modelica.Fluid.Fittings.SimpleGenericOrifice simpleGenericOrifice(
      zeta=0.4,
      diameter=2.5e-2,
      redeclare package Medium = Medium) annotation (Placement(transformation(
            extent={{-46,-10},{-26,10}}, rotation=0)));
    Modelica.Fluid.Pipes.DynamicPipe pipe3(
      use_T_start=true,
      length=10,
      diameter=2.5e-2,
      redeclare package Medium = Medium,
      p_a_start=500000,
      p_b_start=500000,
      nNodes=1,
      modelStructure=Modelica.Fluid.Types.ModelStructure.a_vb)
                                         annotation (Placement(transformation(
            extent={{16,-10},{36,10}}, rotation=0)));
  equation
    connect(source.ports[1], pipe1.port_a) annotation (Line(points={{-88,
            -4.44089e-16},{-85,-4.44089e-16},{-85,1.66534e-16},{-82,1.66534e-16},
            {-82,6.10623e-16},{-76,6.10623e-16}},
          color={0,127,255}));
    connect(valve.port_b, sink.ports[1])
      annotation (Line(points={{72,6.10623e-16},{74.5,6.10623e-16},{74.5,
            1.66534e-16},{77,1.66534e-16},{77,-4.44089e-16},{82,-4.44089e-16}},
                                               color={0,127,255}));
    connect(valveOpening1.y, valve.opening)               annotation (Line(
          points={{1,80},{62,80},{62,8}}, color={0,0,127}));
    connect(pipe1.port_b, simpleGenericOrifice.port_a) annotation (Line(points={{-56,
            6.10623e-16},{-53.5,6.10623e-16},{-53.5,1.22125e-15},{-51,
            1.22125e-15},{-51,6.10623e-16},{-46,6.10623e-16}},
                               color={0,127,255}));
    connect(pipe2.port_a, simpleGenericOrifice.port_b) annotation (Line(points={{-14,
            6.10623e-16},{-17,6.10623e-16},{-17,1.22125e-15},{-20,1.22125e-15},
            {-20,6.10623e-16},{-26,6.10623e-16}},
                               color={0,127,255}));
    connect(pipe2.port_b, pipe3.port_a)
      annotation (Line(points={{6,6.10623e-16},{8.5,6.10623e-16},{8.5,
            1.22125e-15},{11,1.22125e-15},{11,6.10623e-16},{16,6.10623e-16}},
                                              color={0,127,255}));
    connect(pipe3.port_b, valve.port_a)
      annotation (Line(points={{36,6.10623e-16},{40,6.10623e-16},{40,
            1.22125e-15},{44,1.22125e-15},{44,6.10623e-16},{52,6.10623e-16}},
                                               color={0,127,255}));
    annotation (
      experiment(StopTime=5),
      Documentation(info="<html>
Simulation starts with the valve open. At t=1, the valve is closed.
</html>"));
  end SeriesPipes1;

  model SeriesPipes12
    extends SeriesPipes1(
      system(energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial));
    annotation (Documentation(info="<html>
Same as SeriesPipes1, but with steady-state initial conditions. Equal start attributes
for pressures.
</html>"));
  end SeriesPipes12;

  model SeriesPipes13
    extends SeriesPipes1(
      pipe2(p_a_start=495000, p_b_start=495000),
      pipe3(p_a_start=490000, p_b_start=490000));
    annotation (Documentation(info="<html>
Same as SeriesPipes1, but with steady-state initial conditions. Start attributes for
pressure in order to get positive flow rates.
</html>"));
  end SeriesPipes13;

  model SeriesPipes2
    extends Modelica.Icons.Example;
    // replaceable package Medium = Modelica.Media.Air.SimpleAir;
    replaceable package Medium = Modelica.Media.Water.StandardWater;
    Modelica.Fluid.Sources.Boundary_pT source(nPorts=1,
      redeclare package Medium = Medium,
      p=5.0e5,
      T=300) annotation (Placement(transformation(extent={{-100,0},{-88,12}},
            rotation=0)));
    Modelica.Fluid.Pipes.DynamicPipe pipe1(
      redeclare package Medium = Medium,
      p_a_start=5.0e5,
      use_T_start=true,
      length=10,
      diameter=2.54e-2,
      p_b_start=4.95e5,
      redeclare model FlowModel =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
      nNodes=1,
      modelStructure=Modelica.Fluid.Types.ModelStructure.a_vb)
                        annotation (Placement(transformation(extent={{-78,-4},{
              -58,16}}, rotation=0)));
    Modelica.Fluid.Valves.ValveIncompressible valveIncompressible1(
      redeclare package Medium = Medium,
      CvData=Modelica.Fluid.Types.CvTypes.OpPoint,
      m_flow_nominal=1,
      rho_nominal=5,
      dp(start=400000),
      dp_nominal=400000,
      filteredOpening=true,
      riseTime=0.1)
                  annotation (Placement(transformation(extent={{8,-50},{28,-30}},
            rotation=0)));
    Modelica.Fluid.Sources.Boundary_pT sink(nPorts=1,
      redeclare package Medium = Medium,
      T=300,
      p=1.0e5) annotation (Placement(transformation(extent={{74,-20},{62,-8}},
            rotation=0)));
    Modelica.Fluid.Pipes.DynamicPipe pipe3(
      redeclare package Medium = Medium,
      use_T_start=true,
      length=10,
      diameter=2.54e-2,
      p_a_start=4.95e5,
      p_b_start=4.90e5,
      redeclare model FlowModel =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
      nNodes=1,
      modelStructure=Modelica.Fluid.Types.ModelStructure.a_vb)
                        annotation (Placement(transformation(extent={{-30,-50},
              {-10,-30}}, rotation=0)));
    Modelica.Blocks.Sources.TimeTable valveOpening1(offset=0, table=[0,1; 1,1;
          1,0; 100,0]) annotation (Placement(transformation(extent={{-20,-10},{
              0,10}},
                    rotation=0)));
    inner Modelica.Fluid.System system(energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
                          annotation (Placement(transformation(extent={{-100,60},
              {-80,80}}, rotation=0)));
  equation
    connect(source.ports[1], pipe1.port_a) annotation (Line(points={{-88,6},{-83,6},
            {-78,6}},
          color={0,127,255}));
    connect(valveIncompressible1.port_b, sink.ports[1]) annotation (Line(points={{
            28,-40},{46,-40},{46,-14},{62,-14}}, color={0,127,255}));
    connect(pipe3.port_b, valveIncompressible1.port_a) annotation (Line(points={{-10,-40},
            {8,-40}},            color={0,127,255}));
    connect(pipe1.port_b, pipe3.port_a) annotation (Line(points={{-58,6},{-44,6},
            {-44,-40},{-30,-40}}, color={0,127,255}));
    connect(valveOpening1.y, valveIncompressible1.opening) annotation (Line(
        points={{1,6.10623e-16},{18,6.10623e-16},{18,-32}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (
      experiment(StopTime=5),
      Documentation(info="<html>
Simulation starts with valve 1 open. At t=1, valve 1 closes.
</html>"));
  end SeriesPipes2;
end TestPipesAndValves;
