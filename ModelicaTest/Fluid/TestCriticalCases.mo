within ModelicaTest.Fluid;
package TestCriticalCases
  "Collection of test cases which might be critical for the solvers"
extends Modelica.Icons.ExamplesPackage;
  model IdealMixing1 "Test properties of ideal mixing"
    // package Medium =  Modelica.Fluid.Media.Water.ConstantPropertyLiquidWater;
    // Modelica.Media.IdealGases.MixtureGases.FlueGasSixComponents,package Medium = Modelica.Media.Air.DryAirNasa;
    package Medium =
        Modelica.Media.IdealGases.MixtureGases.FlueGasSixComponents;

    Modelica.Fluid.Pipes.StaticPipe pipeFriction1(
      length=1,
      diameter=0.2,
      redeclare package Medium = Medium) annotation (Placement(transformation(
            extent={{-32,-40},{-12,-20}}, rotation=0)));
    Modelica.Fluid.Pipes.StaticPipe pipeFriction2(
      length=1,
      diameter=0.2,
      redeclare package Medium = Medium) annotation (Placement(transformation(
            extent={{12,-40},{32,-20}}, rotation=0)));
    Modelica.Fluid.Pipes.StaticPipe pipeFriction3(
      length=1,
      diameter=0.2,
      redeclare package Medium = Medium)
      annotation (Placement(transformation(
          origin={0,0},
          extent={{-10,-10},{10,10}},
          rotation=90)));
    Modelica.Fluid.Sources.Boundary_pT boundary1(nPorts=1,
      use_p_in=true,
      use_T_in=true,
      redeclare package Medium = Medium) annotation (Placement(transformation(
            extent={{-68,-40},{-48,-20}}, rotation=0)));
    Modelica.Fluid.Sources.Boundary_pT boundary2(nPorts=1,
      use_p_in=false,
      use_T_in=false,
      p=101000,
      T=320,
      redeclare package Medium = Medium) annotation (Placement(transformation(
            extent={{66,-40},{46,-20}}, rotation=0)));
    Modelica.Fluid.Sources.Boundary_pT boundary3(nPorts=1,
      use_p_in=true,
      use_T_in=false,
      T=340,
      redeclare package Medium = Medium)
      annotation (Placement(transformation(
          origin={0,30},
          extent={{-10,10},{10,-10}},
          rotation=270)));
    Modelica.Blocks.Sources.Sine sine1(
      amplitude=0.05e5,
      freqHz=2,
      offset=1e5,
      phase=0.013962634015955) annotation (Placement(transformation(extent={{
              -100,-20},{-80,0}}, rotation=0)));
    Modelica.Blocks.Sources.Sine sine2(
      amplitude=10,
      freqHz=1,
      phase=0.0017453292519943,
      offset=300) annotation (Placement(transformation(extent={{-100,-58},{-80,
              -38}}, rotation=0)));
    Modelica.Blocks.Sources.Sine sine3(
      amplitude=0.05e5,
      freqHz=2,
      offset=1e5) annotation (Placement(transformation(
          origin={0,70},
          extent={{10,-10},{-10,10}},
          rotation=90)));
    inner Modelica.Fluid.System system
                          annotation (Placement(transformation(extent={{-88,60},
              {-68,80}}, rotation=0)));
   Modelica.Fluid.Sensors.Temperature temperature(redeclare package Medium = Medium)
      annotation (Placement(transformation(extent={{-10,-60},{10,-80}},
            rotation=0)));
  equation
    connect(pipeFriction1.port_b, pipeFriction2.port_a) annotation (Line(
        points={{-12,-30},{12,-30}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(pipeFriction3.port_a, pipeFriction1.port_b) annotation (Line(
        points={{-6.12323e-016,-10},{0,-10},{0,-30},{-12,-30}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(boundary1.ports[1], pipeFriction1.port_a)
                                                  annotation (Line(
        points={{-48,-30},{-32,-30}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(boundary2.ports[1], pipeFriction2.port_b)
                                                  annotation (Line(
        points={{46,-30},{32,-30}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(boundary3.ports[1], pipeFriction3.port_b)
                                                  annotation (Line(
        points={{-1.9984e-015,20},{-1.9984e-015,10},{6.12323e-016,10}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(sine1.y, boundary1.p_in) annotation (Line(
        points={{-79,-10},{-76,-10},{-76,-22},{-70,-22}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(sine2.y, boundary1.T_in) annotation (Line(
        points={{-79,-48},{-76,-48},{-76,-26},{-70,-26}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(sine3.y, boundary3.p_in) annotation (Line(
        points={{-6.73556e-016,59},{-6.73556e-016,50.5},{-8,50.5},{-8,42}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(temperature.port, pipeFriction3.port_a) annotation (Line(
        points={{0,-60},{0,-10},{-6.12323e-016,-10}},
        color={0,127,255},
        smooth=Smooth.None));
    annotation (
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}}), graphics),
      experiment(StopTime=10),
      experimentSetupOutput);
  end IdealMixing1;

  model DynamicPipeClosingValve "This test demonstrates the importance of smooth regularization of fluid properties for reversing flow.
 A DynamicPipe model with switching port densities and viscosities would generate lots of events as the valve closes at time 2."

    Modelica.Fluid.Sources.FixedBoundary source(nPorts=1,redeclare package
        Medium =
          Modelica.Media.Water.StandardWater, p=200000)
      annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
    Modelica.Fluid.Pipes.DynamicPipe pipe(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      length=1,
      diameter=0.32,
      use_T_start=false,
      p_a_start=200000,
      p_b_start=200000)
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
        points={{-60,0},{-40,0}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(pipe.port_b, valve.port_a)               annotation (Line(
        points={{-20,0},{0,0}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(valve.port_b, sink.ports[1])                          annotation (Line(
        points={{20,0},{40,0}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(ramp.y, valve.opening)               annotation (Line(
        points={{25,40},{10,40},{10,8}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=true,
            extent={{-100,-100},{100,100}}), graphics),
      experiment(StopTime=3));
  end DynamicPipeClosingValve;

  model DynamicPipeInitialization
    "Steady-state initialization of a dynamic pipe"

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
      dp_nominal=10000000,
      m_flow_nominal=10)
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
        points={{-60,0},{-40,0}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(pipe.port_b, valve.port_a)               annotation (Line(
        points={{-20,0},{0,0}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(valve.port_b, sink.ports[1])                          annotation (Line(
        points={{20,0},{40,0}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(ramp.y, valve.opening)               annotation (Line(
        points={{25,40},{10,40},{10,8}},
        color={0,0,127},
        smooth=Smooth.None));

    annotation (Diagram(coordinateSystem(preserveAspectRatio=true,
            extent={{-100,-100},{100,100}}), graphics),
      experiment(StopTime=4),
      experimentSetupOutput,
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
    //replaceable package Medium = Modelica.Media.Water.StandardWater;
    replaceable package Medium =
        Modelica.Media.Water.StandardWater;

    Modelica.Fluid.Sources.Boundary_pT source(nPorts=1,
      redeclare package Medium = Medium,
      p=200000,
      T=300) annotation (Placement(transformation(extent={{-100,0},{-88,12}},
            rotation=0)));
    ModelicaTest.Fluid.BaseClasses.LumpedPipe pipe1(
      redeclare package Medium = Medium,
      use_T_start=true,
      length=10,
      diameter=2.54e-2,
      p_b_start=100000,
      redeclare model FlowModel =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
      p_a_start=200000,
      T_start=300)      annotation (Placement(transformation(extent={{-72,-4},{
              -52,16}}, rotation=0)));

    Modelica.Fluid.Valves.ValveIncompressible valve1(
      redeclare package Medium = Medium,
      CvData=Modelica.Fluid.Types.CvTypes.OpPoint,
      m_flow_nominal=1,
      rho_nominal=1000,
      dp_nominal=200000)
                  annotation (Placement(transformation(extent={{10,36},{30,56}},
            rotation=0)));
    Modelica.Fluid.Valves.ValveIncompressible valve2(
      redeclare package Medium = Medium,
      CvData=Modelica.Fluid.Types.CvTypes.OpPoint,
      m_flow_nominal=1,
      rho_nominal=1000,
      dp_nominal=200000)
                  annotation (Placement(transformation(extent={{8,-50},{28,-30}},
            rotation=0)));
    Modelica.Fluid.Sources.Boundary_pT sink(
      redeclare package Medium = Medium,
      nPorts=2,
      p=100000,
      T=300)   annotation (Placement(transformation(extent={{74,-20},{62,-8}},
            rotation=0)));
    ModelicaTest.Fluid.BaseClasses.LumpedPipe pipe2(
      redeclare package Medium = Medium,
      use_T_start=true,
      length=10,
      diameter=2.54e-2,
      redeclare model FlowModel =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
      p_a_start=200000,
      p_b_start=100000,
      T_start=300)      annotation (Placement(transformation(extent={{-40,36},{
              -20,56}}, rotation=0)));

    ModelicaTest.Fluid.BaseClasses.LumpedPipe pipe3(
      redeclare package Medium = Medium,
      use_T_start=true,
      length=10,
      diameter=2.54e-2,
      redeclare model FlowModel =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
      p_a_start=200000,
      p_b_start=100000,
      T_start=300)      annotation (Placement(transformation(extent={{-40,-50},
              {-20,-30}}, rotation=0)));

    Modelica.Blocks.Sources.TimeTable valveOpening1(offset=0, table=[0,1; 1,1;
          1,0; 100,0]) annotation (Placement(transformation(extent={{-20,70},{0,
              90}}, rotation=0)));
    Modelica.Blocks.Sources.TimeTable valveOpening2(offset=0, table=[0,1; 2,1;
          2,0; 100,0]) annotation (Placement(transformation(extent={{-20,-10},{
              0,10}}, rotation=0)));
    inner Modelica.Fluid.System system(energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
        massDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial)
                          annotation (Placement(transformation(extent={{-100,60},
              {-80,80}}, rotation=0)));
  equation
    connect(source.ports[1], pipe1.port_a) annotation (Line(points={{-88,6},{-72,6}},
          color={0,127,255}));
    connect(valve2.port_b, sink.ports[2])               annotation (Line(points={{28,-40},
            {46,-40},{46,-15.2},{62,-15.2}},     color={0,127,255}));
    connect(valve1.port_b, sink.ports[1])              annotation (Line(points={{30,46},
            {46,46},{46,-12.8},{62,-12.8}}, color={0,127,255}));
    connect(pipe3.port_b, valve2.port_a)               annotation (Line(points=
            {{-20,-40},{8,-40}}, color={0,127,255}));
    connect(pipe2.port_b, valve1.port_a)              annotation (Line(points={
            {-20,46},{10,46}}, color={0,127,255}));
    connect(pipe2.port_a, pipe1.port_b) annotation (Line(points={{-40,46},{-46,
            46},{-46,6},{-52,6}}, color={0,127,255}));
    connect(pipe1.port_b, pipe3.port_a) annotation (Line(points={{-52,6},{-46,6},
            {-46,-40},{-40,-40}}, color={0,127,255}));
    connect(valveOpening1.y, valve1.opening)              annotation (Line(
          points={{1,80},{20,80},{20,54}}, color={0,0,127}));
    connect(valveOpening2.y, valve2.opening)               annotation (Line(
          points={{1,0},{18,0},{18,-32}}, color={0,0,127}));
    annotation (
      Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{
              100,100}}),
              graphics),
      experiment(StopTime=5),
      experimentSetupOutput(equdistant=false),
      Documentation(info="<html>
Simulation starts with both valves open. At t=1, valve 1 closes; at t=2 valve 2 closes, and the simulation fails.
</html>"));
  end BranchingPipes1;

  model BranchingPipes2
    replaceable package Medium = Modelica.Media.Water.StandardWater;

    Modelica.Fluid.Sources.Boundary_pT source(nPorts=1,
      redeclare package Medium = Medium,
      p=5.0e5,
      T=300) annotation (Placement(transformation(extent={{-100,0},{-88,12}},
            rotation=0)));
    ModelicaTest.Fluid.BaseClasses.LumpedPipe pipe1(
      redeclare package Medium = Medium,
      use_T_start=true,
      redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.TurbulentPipeFlow,
      length=10,
      diameter=2.54e-2,
      p_a_start=5.0e5,
      p_b_start=5.0e5)  annotation (Placement(transformation(extent={{-72,-4},{
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
    ModelicaTest.Fluid.BaseClasses.LumpedPipe pipe2(
      redeclare package Medium = Medium,
      use_T_start=true,
      redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.TurbulentPipeFlow,
      length=10,
      diameter=2.54e-2,
      p_a_start=5.0e5,
      p_b_start=5.0e5)  annotation (Placement(transformation(extent={{-40,36},{
              -20,56}}, rotation=0)));

    ModelicaTest.Fluid.BaseClasses.LumpedPipe pipe3(
      redeclare package Medium = Medium,
      use_T_start=true,
      redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.TurbulentPipeFlow,
      length=10,
      diameter=2.54e-2,
      p_a_start=5.0e5,
      p_b_start=5.0e5)  annotation (Placement(transformation(extent={{-40,-50},
              {-20,-30}}, rotation=0)));

    Modelica.Blocks.Sources.TimeTable valveOpening1(offset=0, table=[0,0; 1,0;
          1,1; 100,1]) annotation (Placement(transformation(extent={{-20,70},{0,
              90}}, rotation=0)));
    Modelica.Blocks.Sources.TimeTable valveOpening2(offset=0, table=[0,0; 2,0;
          2,1; 100,1]) annotation (Placement(transformation(extent={{-20,-10},{
              0,10}}, rotation=0)));
    inner Modelica.Fluid.System system
                          annotation (Placement(transformation(extent={{-100,60},
              {-80,80}}, rotation=0)));
  equation
    connect(source.ports[1], pipe1.port_a) annotation (Line(points={{-88,6},{-72,6}},
          color={0,127,255}));
    connect(valveIncompressible1.port_b, sink.ports[2]) annotation (Line(points={{28,-40},
            {46,-40},{46,-15.2},{62,-15.2}},     color={0,127,255}));
    connect(valveIncompressible.port_b, sink.ports[1]) annotation (Line(points={{30,46},
            {46,46},{46,-12.8},{62,-12.8}}, color={0,127,255}));
    connect(pipe3.port_b, valveIncompressible1.port_a) annotation (Line(points=
            {{-20,-40},{8,-40}}, color={0,127,255}));
    connect(pipe2.port_b, valveIncompressible.port_a) annotation (Line(points={
            {-20,46},{10,46}}, color={0,127,255}));
    connect(pipe2.port_a, pipe1.port_b) annotation (Line(points={{-40,46},{-46,
            46},{-46,6},{-52,6}}, color={0,127,255}));
    connect(pipe1.port_b, pipe3.port_a) annotation (Line(points={{-52,6},{-46,6},
            {-46,-40},{-40,-40}}, color={0,127,255}));
    connect(valveOpening1.y, valveIncompressible.opening) annotation (Line(
          points={{1,80},{20,80},{20,54}}, color={0,0,127}));
    connect(valveOpening2.y, valveIncompressible1.opening) annotation (Line(
          points={{1,0},{18,0},{18,-32}}, color={0,0,127}));
    annotation (
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}}),
              graphics),
      experiment(StopTime=5),
      experimentSetupOutput(equdistant=false),
      Documentation(info="<html>
Simulation starts with both valves open. At t=1, valve 1 closes; at t=2 valve 2 closes, and the simulation fails.
</html>"));
  end BranchingPipes2;

  model BranchingPipes3
    replaceable package Medium = Modelica.Media.Water.StandardWater;

    Modelica.Fluid.Sources.Boundary_pT source(nPorts=1,
      redeclare package Medium = Medium,
      p=5.0e5,
      T=300) annotation (Placement(transformation(extent={{-100,0},{-88,12}},
            rotation=0)));
    ModelicaTest.Fluid.BaseClasses.LumpedPipe pipe1(
      redeclare package Medium = Medium,
      p_a_start=5.0e5,
      p_b_start=5.0e5,
      use_T_start=true,
      redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.TurbulentPipeFlow,
      length=10,
      diameter=2.54e-2) annotation (Placement(transformation(extent={{-80,-4},{
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
    ModelicaTest.Fluid.BaseClasses.LumpedPipe pipe2(
      redeclare package Medium = Medium,
      p_a_start=5.0e5,
      p_b_start=5.0e5,
      use_T_start=true,
      redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.TurbulentPipeFlow,
      length=10,
      diameter=2.54e-2) annotation (Placement(transformation(extent={{-40,36},{
              -20,56}}, rotation=0)));

    ModelicaTest.Fluid.BaseClasses.LumpedPipe pipe3(
      redeclare package Medium = Medium,
      p_a_start=5.0e5,
      p_b_start=5.0e5,
      use_T_start=true,
      redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.TurbulentPipeFlow,
      length=10,
      diameter=2.54e-2) annotation (Placement(transformation(extent={{-40,-50},
              {-20,-30}}, rotation=0)));

    Modelica.Blocks.Sources.TimeTable valveOpening1(offset=0, table=[0,0; 1,0;
          1,1; 100,1]) annotation (Placement(transformation(extent={{-20,70},{0,
              90}}, rotation=0)));
    Modelica.Blocks.Sources.TimeTable valveOpening2(offset=0, table=[0,0; 2,0;
          2,1; 100,1]) annotation (Placement(transformation(extent={{-20,-10},{
              0,10}}, rotation=0)));
    inner Modelica.Fluid.System system
                          annotation (Placement(transformation(extent={{-100,60},
              {-80,80}}, rotation=0)));
    Modelica.Fluid.Fittings.TeeJunctionIdeal splitter(
                                     redeclare package Medium = Medium)
      annotation (Placement(transformation(
          origin={-43,6},
          extent={{-6,-7},{6,7}},
          rotation=90)));
  equation
    connect(source.ports[1], pipe1.port_a) annotation (Line(points={{-88,6},{-80,6}},
          color={0,127,255}));
    connect(valveIncompressible1.port_b, sink.ports[2]) annotation (Line(points={{28,-40},
            {46,-40},{46,-15.2},{62,-15.2}},     color={0,127,255}));
    connect(valveIncompressible.port_b, sink.ports[1]) annotation (Line(points={{30,46},
            {46,46},{46,-12.8},{62,-12.8}}, color={0,127,255}));
    connect(pipe3.port_b, valveIncompressible1.port_a) annotation (Line(points=
            {{-20,-40},{8,-40}}, color={0,127,255}));
    connect(pipe2.port_b, valveIncompressible.port_a) annotation (Line(points={
            {-20,46},{10,46}}, color={0,127,255}));
    connect(valveOpening1.y, valveIncompressible.opening) annotation (Line(
          points={{1,80},{20,80},{20,54}}, color={0,0,127}));
    connect(valveOpening2.y, valveIncompressible1.opening) annotation (Line(
          points={{1,0},{18,0},{18,-32}}, color={0,0,127}));
    connect(pipe1.port_b, splitter.port_3) annotation (Line(points={{-60,6},{
            -55,6},{-55,6},{-50,6}},
                     color={0,127,255}));
    connect(pipe2.port_a, splitter.port_2) annotation (Line(points={{-40,46},{
            -43,46},{-43,12}}, color={0,127,255}));
    connect(splitter.port_1, pipe3.port_a) annotation (Line(points={{-43,0},{
            -43,-40.3},{-40,-40.3},{-40,-40}}, color={0,127,255}));
    annotation (
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}}),
              graphics),
      experiment(StopTime=5),
      experimentSetupOutput(equdistant=false),
      Documentation(info="<html>
Simulation starts with both valves open. At t=1, valve 1 closes; at t=2 valve 2 closes, and the simulation fails.
</html>"));
  end BranchingPipes3;

  model BranchingPipes4
    replaceable package Medium = Modelica.Media.Water.StandardWater;

    Modelica.Fluid.Sources.Boundary_pT source(nPorts=1,
      redeclare package Medium = Medium,
      p=5.0e5,
      T=300) annotation (Placement(transformation(extent={{-100,0},{-88,12}},
            rotation=0)));
    ModelicaTest.Fluid.BaseClasses.LumpedPipe pipe1(
      redeclare package Medium = Medium,
      use_T_start=true,
      length=10,
      diameter=2.54e-2,
      redeclare model FlowModel =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
      p_a_start=500000,
      p_b_start=500000) annotation (Placement(transformation(extent={{-80,-4},{
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
    ModelicaTest.Fluid.BaseClasses.LumpedPipe pipe2(
      redeclare package Medium = Medium,
      use_T_start=true,
      length=10,
      diameter=2.54e-2,
      redeclare model FlowModel =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
      p_a_start=500000,
      p_b_start=500000) annotation (Placement(transformation(extent={{-40,36},{
              -20,56}}, rotation=0)));

    ModelicaTest.Fluid.BaseClasses.LumpedPipe pipe3(
      redeclare package Medium = Medium,
      use_T_start=true,
      length=10,
      diameter=2.54e-2,
      redeclare model FlowModel =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
      p_a_start=500000,
      p_b_start=500000) annotation (Placement(transformation(extent={{-40,-50},
              {-20,-30}}, rotation=0)));

    Modelica.Blocks.Sources.TimeTable valveOpening1(offset=0, table=[0,0; 1,0;
          1,1; 100,1]) annotation (Placement(transformation(extent={{-20,70},{0,
              90}}, rotation=0)));
    Modelica.Blocks.Sources.TimeTable valveOpening2(offset=0, table=[0,0; 2,0;
          2,1; 100,1]) annotation (Placement(transformation(extent={{-20,-10},{
              0,10}}, rotation=0)));
    inner Modelica.Fluid.System system
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
    connect(source.ports[1], pipe1.port_a) annotation (Line(points={{-88,6},{-80,6}},
          color={0,127,255}));
    connect(valveIncompressible1.port_b, sink.ports[2]) annotation (Line(points={{28,-40},
            {46,-40},{46,-15.2},{62,-15.2}},     color={0,127,255}));
    connect(valveIncompressible.port_b, sink.ports[1]) annotation (Line(points={{30,46},
            {46,46},{46,-12.8},{62,-12.8}}, color={0,127,255}));
    connect(pipe3.port_b, valveIncompressible1.port_a) annotation (Line(points=
            {{-20,-40},{8,-40}}, color={0,127,255}));
    connect(pipe2.port_b, valveIncompressible.port_a) annotation (Line(points={
            {-20,46},{10,46}}, color={0,127,255}));
    connect(valveOpening1.y, valveIncompressible.opening) annotation (Line(
          points={{1,80},{20,80},{20,54}}, color={0,0,127}));
    connect(valveOpening2.y, valveIncompressible1.opening) annotation (Line(
          points={{1,0},{18,0},{18,-32}}, color={0,0,127}));
    connect(pipe1.port_b, splitter.port_3) annotation (Line(points={{-60,6},{
            -55,6},{-55,6},{-50,6}},
                     color={0,127,255}));
    connect(pipe2.port_a, splitter.port_2) annotation (Line(points={{-40,46},{
            -43,46},{-43,12}}, color={0,127,255}));
    connect(splitter.port_1, pipe3.port_a) annotation (Line(points={{-43,0},{
            -43,-40.3},{-40,-40.3},{-40,-40}}, color={0,127,255}));
    annotation (
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}}),
              graphics),
      experiment(StopTime=5),
      experimentSetupOutput(equdistant=false),
      Documentation(info="<html>
Uses dynamic splitter. Simulation starts with both valves open. At t=1, valve 1 closes; at t=2 valve 2 closes. The simulation fails at t=0 due to lack of initialization of the splitter state variables.
</html>"));
  end BranchingPipes4;

  model SeriesPipes1
    replaceable package Medium = Modelica.Media.Water.StandardWater;

    Modelica.Fluid.Sources.Boundary_pT source(nPorts=1,
      redeclare package Medium = Medium,
      p=500000,
      T=300) annotation (Placement(transformation(extent={{-100,-6},{-88,6}},
            rotation=0)));
    ModelicaTest.Fluid.BaseClasses.LumpedPipe pipe1(
      use_T_start=true,
      length=10,
      diameter=2.5e-2,
      redeclare package Medium = Medium,
      p_a_start=500000,
      p_b_start=500000)                  annotation (Placement(transformation(
            extent={{-76,-10},{-56,10}}, rotation=0)));

    Modelica.Fluid.Valves.ValveIncompressible valveIncompressible(
      CvData=Modelica.Fluid.Types.CvTypes.OpPoint,
      m_flow_nominal=1,
      rho_nominal=1000,
      redeclare package Medium = Medium,
      dp_nominal=400000)              annotation (Placement(transformation(
            extent={{52,-10},{72,10}}, rotation=0)));
    Modelica.Fluid.Sources.Boundary_pT sink(nPorts=1,
      redeclare package Medium = Medium,
      p=100000,
      T=300)                             annotation (Placement(transformation(
            extent={{94,-6},{82,6}}, rotation=0)));
    ModelicaTest.Fluid.BaseClasses.LumpedPipe pipe2(
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
    ModelicaTest.Fluid.BaseClasses.LumpedPipe pipe3(
      use_T_start=true,
      length=10,
      diameter=2.5e-2,
      redeclare package Medium = Medium,
      p_a_start=500000,
      p_b_start=500000)                  annotation (Placement(transformation(
            extent={{16,-10},{36,10}}, rotation=0)));

  equation
    connect(source.ports[1], pipe1.port_a) annotation (Line(points={{-88,0},{-76,0}},
          color={0,127,255}));
    connect(valveIncompressible.port_b, sink.ports[1])
      annotation (Line(points={{72,0},{82,0}}, color={0,127,255}));
    connect(valveOpening1.y, valveIncompressible.opening) annotation (Line(
          points={{1,80},{62,80},{62,8}}, color={0,0,127}));
    connect(pipe1.port_b, simpleGenericOrifice.port_a) annotation (Line(points=
            {{-56,0},{-46,0}}, color={0,127,255}));
    connect(pipe2.port_a, simpleGenericOrifice.port_b) annotation (Line(points=
            {{-14,0},{-26,0}}, color={0,127,255}));
    connect(pipe2.port_b, pipe3.port_a)
      annotation (Line(points={{6,0},{16,0}}, color={0,127,255}));
    connect(pipe3.port_b, valveIncompressible.port_a)
      annotation (Line(points={{36,0},{52,0}}, color={0,127,255}));
    annotation (
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}}),
              graphics),
      experiment(StopTime=5),
      experimentSetupOutput(equdistant=false),
      Documentation(info="<html>
Simulation starts with the valve open. At t=1, the valve is closed, and the simulation fails.
</html>"));
  end SeriesPipes1;

  model SeriesPipes12
    extends SeriesPipes1(
      system(energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial));
  equation

    annotation (Documentation(info="<html>
Same as SeriesPipes1, but with steady-state initial conditions. Equal start attributes
for pressures. Initialization fails.
</html>"));
  end SeriesPipes12;

  model SeriesPipes13
    extends SeriesPipes1(
      pipe2(p_a_start=495000, p_b_start=495000),
      pipe3(p_a_start=490000, p_b_start=490000));
  equation

    annotation (Documentation(info="<html>
Same as SeriesPipes1, but with steady-state initial conditions. Start attributes for
pressure in order to get positive flow rates. Initialization succeeds, then the simulation
fails for zero flow rate.
</html>"),
         Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
              {100,100}}),       graphics));
  end SeriesPipes13;

  model BranchingPipes12
    replaceable package Medium = Modelica.Media.Water.StandardWater;

    Modelica.Fluid.Sources.Boundary_pT source(nPorts=1,
      redeclare package Medium = Medium,
      p=5.0e5,
      T=300) annotation (Placement(transformation(extent={{-100,0},{-88,12}},
            rotation=0)));
    ModelicaTest.Fluid.BaseClasses.LumpedPipe pipe1(
      redeclare package Medium = Medium,
      p_a_start=5.0e5,
      use_T_start=true,
      length=10,
      diameter=2.54e-2,
      p_b_start=4.95e5,
      redeclare model FlowModel =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow)
                        annotation (Placement(transformation(extent={{-78,-4},{
              -58,16}}, rotation=0)));

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
    ModelicaTest.Fluid.BaseClasses.LumpedPipe pipe2(
      redeclare package Medium = Medium,
      use_T_start=true,
      length=10,
      diameter=2.54e-2,
      p_a_start=4.95e5,
      p_b_start=4.90e5,
      redeclare model FlowModel =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow)
                        annotation (Placement(transformation(extent={{-40,36},{
              -20,56}}, rotation=0)));

    ModelicaTest.Fluid.BaseClasses.LumpedPipe pipe3(
      redeclare package Medium = Medium,
      use_T_start=true,
      length=10,
      diameter=2.54e-2,
      p_a_start=4.95e5,
      p_b_start=4.90e5,
      redeclare model FlowModel =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow)
                        annotation (Placement(transformation(extent={{-40,-50},
              {-20,-30}}, rotation=0)));

    Modelica.Blocks.Sources.TimeTable valveOpening1(offset=0, table=[0,1; 1,1;
          1,0; 100,0]) annotation (Placement(transformation(extent={{-20,70},{0,
              90}}, rotation=0)));
    Modelica.Blocks.Sources.TimeTable valveOpening2(offset=0, table=[0,1; 2,1;
          2,0; 100,0]) annotation (Placement(transformation(extent={{-20,-10},{
              0,10}}, rotation=0)));
    inner Modelica.Fluid.System system
                          annotation (Placement(transformation(extent={{-100,60},
              {-80,80}}, rotation=0)));
  equation
    connect(source.ports[1], pipe1.port_a) annotation (Line(points={{-88,6},{-78,6}},
          color={0,127,255}));
    connect(valveIncompressible1.port_b, sink.ports[2]) annotation (Line(points={{28,-40},
            {46,-40},{46,-15.2},{62,-15.2}},     color={0,127,255}));
    connect(valveIncompressible.port_b, sink.ports[1]) annotation (Line(points={{30,46},
            {46,46},{46,-12.8},{62,-12.8}}, color={0,127,255}));
    connect(pipe3.port_b, valveIncompressible1.port_a) annotation (Line(points=
            {{-20,-40},{8,-40}}, color={0,127,255}));
    connect(pipe2.port_b, valveIncompressible.port_a) annotation (Line(points={
            {-20,46},{10,46}}, color={0,127,255}));
    connect(pipe2.port_a, pipe1.port_b) annotation (Line(points={{-40,46},{-46,
            46},{-46,6},{-58,6}}, color={0,127,255}));
    connect(pipe1.port_b, pipe3.port_a) annotation (Line(points={{-58,6},{-46,6},
            {-46,-40},{-40,-40}}, color={0,127,255}));
    connect(valveOpening1.y, valveIncompressible.opening) annotation (Line(
          points={{1,80},{20,80},{20,54}}, color={0,0,127}));
    connect(valveOpening2.y, valveIncompressible1.opening) annotation (Line(
          points={{1,0},{18,0},{18,-32}}, color={0,0,127}));
    annotation (
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}}),
              graphics),
      experiment(StopTime=5),
      experimentSetupOutput(equdistant=false),
      Documentation(info="<html>
Simulation starts with both valves open. At t=1, valve 1 closes; at t=2 valve 2 closes, and the simulation fails.
</html>"));
  end BranchingPipes12;

  model BranchingPipes13
    // replaceable package Medium = Modelica.Media.Air.SimpleAir;
    replaceable package Medium = Modelica.Media.Water.StandardWater;

    Modelica.Fluid.Sources.Boundary_pT source(nPorts=1,
      redeclare package Medium = Medium,
      p=5.0e5,
      T=300) annotation (Placement(transformation(extent={{-100,0},{-88,12}},
            rotation=0)));
    ModelicaTest.Fluid.BaseClasses.LumpedPipe pipe1(
      redeclare package Medium = Medium,
      p_a_start=5.0e5,
      use_T_start=true,
      length=10,
      diameter=2.54e-2,
      p_b_start=4.95e5,
      redeclare model FlowModel =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow)
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
    ModelicaTest.Fluid.BaseClasses.LumpedPipe pipe2(
      redeclare package Medium = Medium,
      use_T_start=true,
      length=10,
      diameter=2.54e-2,
      p_a_start=4.95e5,
      p_b_start=4.90e5,
      redeclare model FlowModel =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow)
                        annotation (Placement(transformation(extent={{-34,36},{
              -14,56}}, rotation=0)));

    ModelicaTest.Fluid.BaseClasses.LumpedPipe pipe3(
      redeclare package Medium = Medium,
      use_T_start=true,
      length=10,
      diameter=2.54e-2,
      p_a_start=4.95e5,
      p_b_start=4.90e5,
      redeclare model FlowModel =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow)
                        annotation (Placement(transformation(extent={{-30,-50},
              {-10,-30}}, rotation=0)));

    Modelica.Blocks.Sources.TimeTable valveOpening1(offset=0, table=[0,1; 1,1;
          1,0; 100,0]) annotation (Placement(transformation(extent={{-20,70},{0,
              90}}, rotation=0)));
    Modelica.Blocks.Sources.TimeTable valveOpening2(offset=0, table=[0,1; 2,1;
          2,0.001; 100,0])
                       annotation (Placement(transformation(extent={{-20,-10},{
              0,10}}, rotation=0)));
    inner Modelica.Fluid.System system
                          annotation (Placement(transformation(extent={{-100,60},
              {-80,80}}, rotation=0)));
    Modelica.Fluid.Fittings.TeeJunctionIdeal junctionIdeal(
                                          redeclare package Medium = Medium)
      annotation (Placement(transformation(
          origin={-38,6},
          extent={{-10,-10},{10,10}},
          rotation=90)));
  equation
    connect(source.ports[1], pipe1.port_a) annotation (Line(points={{-88,6},{-78,6}},
          color={0,127,255}));
    connect(valveIncompressible1.port_b, sink.ports[2]) annotation (Line(points={{28,-40},
            {46,-40},{46,-15.2},{62,-15.2}},     color={0,127,255}));
    connect(valveIncompressible.port_b, sink.ports[1]) annotation (Line(points={{30,46},
            {46,46},{46,-12.8},{62,-12.8}}, color={0,127,255}));
    connect(pipe3.port_b, valveIncompressible1.port_a) annotation (Line(points=
            {{-10,-40},{8,-40}}, color={0,127,255}));
    connect(pipe2.port_b, valveIncompressible.port_a) annotation (Line(points={
            {-14,46},{10,46}}, color={0,127,255}));
    connect(valveOpening1.y, valveIncompressible.opening) annotation (Line(
          points={{1,80},{20,80},{20,54}}, color={0,0,127}));
    connect(valveOpening2.y, valveIncompressible1.opening) annotation (Line(
          points={{1,0},{18,0},{18,-32}}, color={0,0,127}));
    connect(pipe1.port_b, junctionIdeal.port_3) annotation (Line(points={{-58,6},
            {-53,6},{-53,6},{-48,6}},     color={0,127,255}));
    connect(pipe2.port_a, junctionIdeal.port_2) annotation (Line(points={{-34,
            46},{-38,46},{-38,16}}, color={0,127,255}));
    connect(junctionIdeal.port_1, pipe3.port_a) annotation (Line(points={{-38,
            -4},{-38,-40},{-30,-40}}, color={0,127,255}));
    annotation (
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}}),
              graphics),
      experiment(StopTime=5),
      experimentSetupOutput(equdistant=false),
      Documentation(info="<html>
Simulation starts with both valves open. At t=1, valve 1 closes; at t=2 valve 2 closes, and the simulation fails.
</html>"));
  end BranchingPipes13;

  model BranchingPipes14
    // replaceable package Medium = Modelica.Media.Air.SimpleAir;
    replaceable package Medium = Modelica.Media.Water.StandardWater;

    Modelica.Fluid.Sources.Boundary_pT source(nPorts=1,
      redeclare package Medium = Medium,
      p=5.0e5,
      T=300) annotation (Placement(transformation(extent={{-100,0},{-88,12}},
            rotation=0)));
    ModelicaTest.Fluid.BaseClasses.LumpedPipe pipe1(
      redeclare package Medium = Medium,
      p_a_start=5.0e5,
      use_T_start=true,
      redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.TurbulentPipeFlow,
      length=10,
      diameter=2.54e-2,
      p_b_start=4.95e5) annotation (Placement(transformation(extent={{-78,-4},{
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
    ModelicaTest.Fluid.BaseClasses.LumpedPipe pipe2(
      redeclare package Medium = Medium,
      use_T_start=true,
      redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.TurbulentPipeFlow,
      length=10,
      diameter=2.54e-2,
      p_a_start=4.95e5,
      p_b_start=4.90e5) annotation (Placement(transformation(extent={{-34,36},{
              -14,56}}, rotation=0)));

    ModelicaTest.Fluid.BaseClasses.LumpedPipe pipe3(
      redeclare package Medium = Medium,
      use_T_start=true,
      redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.TurbulentPipeFlow,
      length=10,
      diameter=2.54e-2,
      p_a_start=4.95e5,
      p_b_start=4.90e5) annotation (Placement(transformation(extent={{-30,-50},
              {-10,-30}}, rotation=0)));

    Modelica.Blocks.Sources.TimeTable valveOpening1(offset=0, table=[0,1; 1,1;
          2,1e-2; 100,1e-2])
                       annotation (Placement(transformation(extent={{-20,72},{0,
              92}}, rotation=0)));
    Modelica.Blocks.Sources.TimeTable valveOpening2(offset=0, table=[0,1; 3,1;
          4,1e-2; 100,1e-2])
                       annotation (Placement(transformation(extent={{-20,-10},{
              0,10}}, rotation=0)));
    inner Modelica.Fluid.System system
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
    connect(source.ports[1], pipe1.port_a) annotation (Line(points={{-88,6},{-78,6}},
          color={0,127,255}));
    connect(valve2.port_b, sink.ports[2])               annotation (Line(points={{28,-40},
            {46,-40},{46,-15.2},{62,-15.2}},     color={0,127,255}));
    connect(valve1.port_b, sink.ports[1])              annotation (Line(points={{30,46},
            {46,46},{46,-12.8},{62,-12.8}}, color={0,127,255}));
    connect(pipe3.port_b, valve2.port_a)               annotation (Line(points=
            {{-10,-40},{8,-40}}, color={0,127,255}));
    connect(pipe2.port_b, valve1.port_a)              annotation (Line(points={
            {-14,46},{10,46}}, color={0,127,255}));
    connect(valveOpening1.y, valve1.opening)              annotation (Line(
          points={{1,82},{20,82},{20,54}}, color={0,0,127}));
    connect(valveOpening2.y, valve2.opening)               annotation (Line(
          points={{1,0},{18,0},{18,-32}}, color={0,0,127}));
    connect(pipe1.port_b, junctionIdeal.port_3) annotation (Line(points={{-58,6},
            {-48,6},{-48,6}},             color={0,127,255}));
    connect(pipe2.port_a, junctionIdeal.port_2) annotation (Line(points={{-34,
            46},{-38,46},{-38,16}}, color={0,127,255}));
    connect(junctionIdeal.port_1, pipe3.port_a) annotation (Line(points={{-38,
            -4},{-38,-40},{-30,-40}}, color={0,127,255}));
    annotation (
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}}),
              graphics),
      experiment(StopTime=5),
      experimentSetupOutput(equdistant=false),
      Documentation(info="<html>
Simulation starts with both valves open. At t=1, valve 1 closes; at t=2 valve 2 closes, and the simulation fails.
</html>"));
  end BranchingPipes14;

  model BranchingPipes15
    replaceable package Medium = Modelica.Media.Air.DryAirNasa;
    // replaceable package Medium = Modelica.Media.Air.SimpleAir;
    // replaceable package Medium = Modelica.Media.Water.StandardWater;

    Modelica.Fluid.Sources.Boundary_pT source(nPorts=1,
      redeclare package Medium = Medium,
      p=5.0e5,
      T=300) annotation (Placement(transformation(extent={{-100,0},{-88,12}},
            rotation=0)));
    ModelicaTest.Fluid.BaseClasses.LumpedPipe pipe1(
      redeclare package Medium = Medium,
      use_T_start=true,
      redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.TurbulentPipeFlow (   dp_small=10),
      length=10,
      diameter=2.54e-2,
      p_a_start=500000,
      p_b_start=495000)      annotation (Placement(transformation(extent={{-78,-4},{
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
    ModelicaTest.Fluid.BaseClasses.LumpedPipe pipe2(
      redeclare package Medium = Medium,
      use_T_start=true,
      redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.TurbulentPipeFlow (   dp_small=10),
      length=10,
      diameter=2.54e-2,
      p_a_start=4.95e5,
      p_b_start=4.90e5)      annotation (Placement(transformation(extent={{-34,36},{
              -14,56}}, rotation=0)));

    ModelicaTest.Fluid.BaseClasses.LumpedPipe pipe3(
      redeclare package Medium = Medium,
      use_T_start=true,
      redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.TurbulentPipeFlow (   dp_small=10),
      length=10,
      diameter=2.54e-2,
      p_a_start=4.95e5,
      p_b_start=4.90e5)      annotation (Placement(transformation(extent={{-30,-50},
              {-10,-30}}, rotation=0)));

    Modelica.Blocks.Sources.TimeTable valveOpening1(offset=0, table=[0,1; 1,1; 2,
          1e-3; 100,1e-3])
                       annotation (Placement(transformation(extent={{-20,72},{0,
              92}}, rotation=0)));
    Modelica.Blocks.Sources.TimeTable valveOpening2(offset=0, table=[0,1; 3,1; 4,
          1e-3; 100,1e-3])
                       annotation (Placement(transformation(extent={{-20,-10},{
              0,10}}, rotation=0)));
    inner Modelica.Fluid.System system
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
    connect(source.ports[1], pipe1.port_a) annotation (Line(points={{-88,6},{-78,6}},
          color={0,127,255}));
    connect(valve2.port_b, sink.ports[2])               annotation (Line(points={{28,-40},
            {46,-40},{46,-15.2},{62,-15.2}},     color={0,127,255}));
    connect(valve1.port_b, sink.ports[1])              annotation (Line(points={{30,46},
            {46,46},{46,-12.8},{62,-12.8}}, color={0,127,255}));
    connect(pipe3.port_b, valve2.port_a)               annotation (Line(points=
            {{-10,-40},{8,-40}}, color={0,127,255}));
    connect(pipe2.port_b, valve1.port_a)              annotation (Line(points={
            {-14,46},{10,46}}, color={0,127,255}));
    connect(valveOpening1.y, valve1.opening)              annotation (Line(
          points={{1,82},{20,82},{20,54}}, color={0,0,127}));
    connect(valveOpening2.y, valve2.opening)               annotation (Line(
          points={{1,0},{18,0},{18,-32}}, color={0,0,127}));
    connect(pipe1.port_b, junctionIdeal.port_3) annotation (Line(points={{-58,6},
            {-48,6},{-48,6}},             color={0,127,255}));
    connect(pipe2.port_a, junctionIdeal.port_2) annotation (Line(points={{-34,
            46},{-38,46},{-38,16}}, color={0,127,255}));
    connect(junctionIdeal.port_1, pipe3.port_a) annotation (Line(points={{-38,
            -4},{-38,-40},{-30,-40}}, color={0,127,255}));
    annotation (
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}}),
              graphics),
      experiment(StopTime=5),
      experimentSetupOutput(equdistant=false),
      Documentation(info="<html>
Simulation starts with both valves open. At t=1, valve 1 closes; at t=2 valve 2 closes, and the simulation fails.
</html>"));
  end BranchingPipes15;

  model BranchingPipes16
    replaceable package Medium = Modelica.Media.Air.DryAirNasa;
    // replaceable package Medium = Modelica.Media.Air.SimpleAir;
    // replaceable package Medium = Modelica.Media.Water.StandardWater;

    Modelica.Fluid.Sources.Boundary_pT source(nPorts=1,
      redeclare package Medium = Medium,
      p=5.0e5,
      T=300) annotation (Placement(transformation(extent={{-100,0},{-88,12}},
            rotation=0)));
    ModelicaTest.Fluid.BaseClasses.LumpedPipe pipe1(
      redeclare package Medium = Medium,
      p_a_start=5.0e5,
      use_T_start=true,
      redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.TurbulentPipeFlow (   dp_small=10),
      length=10,
      diameter=2.54e-2,
      p_b_start=4.95e5)      annotation (Placement(transformation(extent={{-78,-4},{
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
    ModelicaTest.Fluid.BaseClasses.LumpedPipe pipe2(
      redeclare package Medium = Medium,
      use_T_start=true,
      redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.TurbulentPipeFlow (   dp_small=10),
      length=10,
      diameter=2.54e-2,
      p_a_start=4.95e5,
      p_b_start=4.90e5)      annotation (Placement(transformation(extent={{-34,36},{
              -14,56}}, rotation=0)));

    ModelicaTest.Fluid.BaseClasses.LumpedPipe pipe3(
      redeclare package Medium = Medium,
      use_T_start=true,
      redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.TurbulentPipeFlow (   dp_small=10),
      length=10,
      diameter=2.54e-2,
      p_a_start=4.95e5,
      p_b_start=4.90e5)      annotation (Placement(transformation(extent={{-30,-50},
              {-10,-30}}, rotation=0)));

    Modelica.Blocks.Sources.TimeTable valveOpening1(offset=0, table=[0,1; 1,1;
          2,0; 100,0]) annotation (Placement(transformation(extent={{-20,72},{0,
              92}}, rotation=0)));
    Modelica.Blocks.Sources.TimeTable valveOpening2(offset=0, table=[0,1; 3,1;
          4,0; 100,0]) annotation (Placement(transformation(extent={{-20,-12},{
              0,8}}, rotation=0)));
    inner Modelica.Fluid.System system
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
    connect(source.ports[1], pipe1.port_a) annotation (Line(points={{-88,6},{-78,6}},
          color={0,127,255}));
    connect(valve2.port_b, sink.ports[2])               annotation (Line(points={{28,-40},
            {46,-40},{46,-15.2},{62,-15.2}},     color={0,127,255}));
    connect(valve1.port_b, sink.ports[1])              annotation (Line(points={{30,46},
            {46,46},{46,-12.8},{62,-12.8}}, color={0,127,255}));
    connect(pipe3.port_b, valve2.port_a)               annotation (Line(points=
            {{-10,-40},{8,-40}}, color={0,127,255}));
    connect(pipe2.port_b, valve1.port_a)              annotation (Line(points={
            {-14,46},{10,46}}, color={0,127,255}));
    connect(valveOpening1.y, valve1.opening)              annotation (Line(
          points={{1,82},{20,82},{20,54}}, color={0,0,127}));
    connect(valveOpening2.y, valve2.opening)               annotation (Line(
          points={{1,-2},{18,-2},{18,-32}}, color={0,0,127}));
    connect(pipe1.port_b, junctionIdeal.port_3) annotation (Line(points={{-58,6},
            {-48,6},{-48,6}},             color={0,127,255}));
    connect(pipe2.port_a, junctionIdeal.port_2) annotation (Line(points={{-34,
            46},{-38,46},{-38,16}}, color={0,127,255}));
    connect(junctionIdeal.port_1, pipe3.port_a) annotation (Line(points={{-38,
            -4},{-38,-40},{-30,-40}}, color={0,127,255}));
    annotation (
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}}),
              graphics),
      experiment(StopTime=5),
      experimentSetupOutput(equdistant=false),
      Documentation(info="<html>
Simulation starts with both valves open. At t=1, valve 1 closes; at t=2 valve 2 closes, and the simulation fails.
</html>"));
  end BranchingPipes16;

  model BranchingPipes17
    replaceable package Medium = Modelica.Media.Air.DryAirNasa;
    // replaceable package Medium = Modelica.Media.Air.SimpleAir;
    // replaceable package Medium = Modelica.Media.Water.StandardWater;

    Modelica.Fluid.Sources.Boundary_pT source(nPorts=1,
      redeclare package Medium = Medium,
      p=5.0e5,
      T=300) annotation (Placement(transformation(extent={{-100,0},{-88,12}},
            rotation=0)));
    ModelicaTest.Fluid.BaseClasses.LumpedPipe pipe1(
      redeclare package Medium = Medium,
      p_a_start=5.0e5,
      use_T_start=true,
      redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.TurbulentPipeFlow (   dp_small=10),
      length=10,
      diameter=2.54e-2,
      p_b_start=4.95e5)      annotation (Placement(transformation(extent={{-78,-4},{
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
    ModelicaTest.Fluid.BaseClasses.LumpedPipe pipe2(
      redeclare package Medium = Medium,
      use_T_start=true,
      redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.TurbulentPipeFlow (   dp_small=10),
      length=10,
      diameter=2.54e-2,
      p_a_start=4.95e5,
      p_b_start=4.90e5)      annotation (Placement(transformation(extent={{-34,36},{
              -14,56}}, rotation=0)));

    ModelicaTest.Fluid.BaseClasses.LumpedPipe pipe3(
      redeclare package Medium = Medium,
      use_T_start=true,
      redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.TurbulentPipeFlow (   dp_small=10),
      length=10,
      diameter=2.54e-2,
      p_a_start=4.95e5,
      p_b_start=4.90e5)      annotation (Placement(transformation(extent={{-30,-50},
              {-10,-30}}, rotation=0)));

    Modelica.Blocks.Sources.TimeTable valveOpening1(offset=0, table=[0,1; 1,1;
          2,0; 100,0]) annotation (Placement(transformation(extent={{-20,72},{0,
              92}}, rotation=0)));
    Modelica.Blocks.Sources.TimeTable valveOpening2(offset=0, table=[0,1; 3,1;
          4,0; 100,0]) annotation (Placement(transformation(extent={{-18,-12},{
              2,8}}, rotation=0)));
    inner Modelica.Fluid.System system
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
        V=1e-3) annotation (Placement(transformation(
          origin={56,-12},
          extent={{-10,10},{10,-10}},
          rotation=90)));
  equation
    connect(source.ports[1], pipe1.port_a) annotation (Line(points={{-88,6},{-78,6}},
          color={0,127,255}));
    connect(pipe3.port_b, valve2.port_a)               annotation (Line(points=
            {{-10,-40},{8,-40}}, color={0,127,255}));
    connect(pipe2.port_b, valve1.port_a)              annotation (Line(points={
            {-14,46},{10,46}}, color={0,127,255}));
    connect(valveOpening1.y, valve1.opening)              annotation (Line(
          points={{1,82},{20,82},{20,54}}, color={0,0,127}));
    connect(valveOpening2.y, valve2.opening)               annotation (Line(
          points={{3,-2},{18,-2},{18,-32}}, color={0,0,127}));
    connect(pipe1.port_b, junctionIdeal.port_3) annotation (Line(points={{-58,6},
            {-50,6},{-50,6}},             color={0,127,255}));
    connect(pipe2.port_a, junctionIdeal.port_2) annotation (Line(points={{-34,
            46},{-40,46},{-40,16}}, color={0,127,255}));
    connect(junctionIdeal.port_1, pipe3.port_a) annotation (Line(points={{-40,
            -4},{-40,-40},{-30,-40}}, color={0,127,255}));
    connect(junctionVolume.port_3, sink.ports[1]) annotation (Line(points={{66,-12},
            {82,-12}}, color={0,127,255}));
    connect(valve2.port_b, junctionVolume.port_1) annotation (Line(points={{28,
            -40},{56,-40},{56,-22}}, color={0,127,255}));
    connect(valve1.port_b, junctionVolume.port_2) annotation (Line(points={{30,
            46},{56,46},{56,-2}}, color={0,127,255}));
    annotation (
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}}),
              graphics),
      experiment(StopTime=5, Tolerance=1e-007),
      experimentSetupOutput(equdistant=false),
      Documentation(info="<html>
Simulation starts with both valves open. At t=1, valve 1 closes; at t=2 valve 2 closes, and the simulation fails.
</html>"));
  end BranchingPipes17;

  model BranchingPipes18
    // replaceable package Medium = Modelica.Media.Air.DryAirNasa;
    // replaceable package Medium = Modelica.Media.Air.SimpleAir;
    replaceable package Medium = Modelica.Media.Water.StandardWater;

    Modelica.Fluid.Sources.Boundary_pT source(nPorts=1,
      redeclare package Medium = Medium,
      p=5.0e5,
      T=300) annotation (Placement(transformation(extent={{-100,0},{-88,12}},
            rotation=0)));
    ModelicaTest.Fluid.BaseClasses.LumpedPipe pipe1(
      redeclare package Medium = Medium,
      p_a_start=5.0e5,
      use_T_start=true,
      redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.TurbulentPipeFlow (   dp_small=10),
      length=10,
      diameter=2.54e-2,
      p_b_start=4.95e5)      annotation (Placement(transformation(extent={{-78,-4},{
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
    ModelicaTest.Fluid.BaseClasses.LumpedPipe pipe2(
      redeclare package Medium = Medium,
      use_T_start=true,
      redeclare model FlowModel =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.TurbulentPipeFlow (   dp_small=10),
      length=10,
      diameter=2.54e-2,
      p_a_start=4.95e5,
      p_b_start=4.90e5)      annotation (Placement(transformation(extent={{-34,36},{
              -14,56}}, rotation=0)));

    ModelicaTest.Fluid.BaseClasses.LumpedPipe pipe3(
      redeclare package Medium = Medium,
      use_T_start=true,
      redeclare model FlowModel =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.TurbulentPipeFlow (   dp_small=10),
      length=10,
      diameter=2.54e-2,
      p_a_start=4.95e5,
      p_b_start=4.90e5)      annotation (Placement(transformation(extent={{-30,-50},
              {-10,-30}}, rotation=0)));

    Modelica.Blocks.Sources.TimeTable valveOpening1(offset=0, table=[0,1; 1,1; 2,
          0; 100,0])   annotation (Placement(transformation(extent={{-20,72},{0,
              92}}, rotation=0)));
    Modelica.Blocks.Sources.TimeTable valveOpening2(offset=0, table=[0,1; 3,1; 4,
          0; 100,0])   annotation (Placement(transformation(extent={{-18,-12},{
              2,8}}, rotation=0)));
    inner Modelica.Fluid.System system
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
          1e-3) annotation (Placement(transformation(
          origin={56,-12},
          extent={{-10,10},{10,-10}},
          rotation=90)));
  equation
    connect(source.ports[1], pipe1.port_a) annotation (Line(points={{-88,6},{-78,6}},
          color={0,127,255}));
    connect(pipe3.port_b, valve2.port_a)               annotation (Line(points=
            {{-10,-40},{8,-40}}, color={0,127,255}));
    connect(pipe2.port_b, valve1.port_a)              annotation (Line(points={
            {-14,46},{10,46}}, color={0,127,255}));
    connect(valveOpening1.y, valve1.opening)              annotation (Line(
          points={{1,82},{20,82},{20,54}}, color={0,0,127}));
    connect(valveOpening2.y, valve2.opening)               annotation (Line(
          points={{3,-2},{18,-2},{18,-32}}, color={0,0,127}));
    connect(pipe1.port_b, junctionIdeal.port_3) annotation (Line(points={{-58,6},
            {-54,6},{-54,6},{-50,6}},     color={0,127,255}));
    connect(pipe2.port_a, junctionIdeal.port_2) annotation (Line(points={{-34,46},
            {-40,46},{-40,16}},     color={0,127,255}));
    connect(junctionIdeal.port_1, pipe3.port_a) annotation (Line(points={{-40,-4},
            {-40,-40},{-30,-40}},     color={0,127,255}));
    connect(junctionVolume.port_3, sink.ports[1]) annotation (Line(points={{66,-12},
            {82,-12}}, color={0,127,255}));
    connect(valve2.port_b, junctionVolume.port_1) annotation (Line(points={{28,
            -40},{56,-40},{56,-22}}, color={0,127,255}));
    connect(valve1.port_b, junctionVolume.port_2) annotation (Line(points={{30,
            46},{56,46},{56,-2}}, color={0,127,255}));
    annotation (
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}}),
              graphics),
      experiment(StopTime=5),
      experimentSetupOutput(equdistant=false),
      Documentation(info="<html>
Simulation starts with both valves open. At t=1, valve 1 closes; at t=2 valve 2 closes, and the simulation fails.
</html>"));
  end BranchingPipes18;

  model BranchingPipes131
    // replaceable package Medium = Modelica.Media.Air.SimpleAir;
    replaceable package Medium = Modelica.Media.Water.StandardWater;

    Modelica.Fluid.Sources.Boundary_pT source(nPorts=1,
      redeclare package Medium = Medium,
      p=5.0e5,
      T=300) annotation (Placement(transformation(extent={{-100,0},{-88,12}},
            rotation=0)));
    ModelicaTest.Fluid.BaseClasses.LumpedPipe pipe1(
      redeclare package Medium = Medium,
      p_a_start=5.0e5,
      use_T_start=true,
      length=10,
      diameter=2.54e-2,
      p_b_start=4.95e5,
      redeclare model FlowModel =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow)
                        annotation (Placement(transformation(extent={{-78,-4},{
              -58,16}}, rotation=0)));

    Modelica.Fluid.Valves.ValveIncompressible valveIncompressible1(
      redeclare package Medium = Medium,
      CvData=Modelica.Fluid.Types.CvTypes.OpPoint,
      m_flow_nominal=1,
      rho_nominal=5,
      dp(start=400000),
      dp_nominal=400000)
                  annotation (Placement(transformation(extent={{8,-50},{28,-30}},
            rotation=0)));
    Modelica.Fluid.Sources.Boundary_pT sink(nPorts=1,
      redeclare package Medium = Medium,
      T=300,
      p=1.0e5) annotation (Placement(transformation(extent={{74,-20},{62,-8}},
            rotation=0)));

    ModelicaTest.Fluid.BaseClasses.LumpedPipe pipe3(
      redeclare package Medium = Medium,
      use_T_start=true,
      length=10,
      diameter=2.54e-2,
      p_a_start=4.95e5,
      p_b_start=4.90e5,
      redeclare model FlowModel =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow)
                        annotation (Placement(transformation(extent={{-30,-50},
              {-10,-30}}, rotation=0)));

    Modelica.Blocks.Sources.TimeTable valveOpening1(offset=0, table=[0,1; 1,1;
          1,0; 100,0]) annotation (Placement(transformation(extent={{-20,70},{0,
              90}}, rotation=0)));
    Modelica.Blocks.Sources.TimeTable valveOpening2(offset=0, table=[0,1; 2,1;
          2.01,1e-6; 100,0])
                       annotation (Placement(transformation(extent={{-20,-8},{0,
              12}}, rotation=0)));
    inner Modelica.Fluid.System system
                          annotation (Placement(transformation(extent={{-100,60},
              {-80,80}}, rotation=0)));
  equation
    connect(source.ports[1], pipe1.port_a) annotation (Line(points={{-88,6},{-78,6}},
          color={0,127,255}));
    connect(valveIncompressible1.port_b, sink.ports[1]) annotation (Line(points={{
            28,-40},{46,-40},{46,-14},{62,-14}}, color={0,127,255}));
    connect(pipe3.port_b, valveIncompressible1.port_a) annotation (Line(points=
            {{-10,-40},{8,-40}}, color={0,127,255}));
    connect(valveOpening2.y, valveIncompressible1.opening) annotation (Line(
          points={{1,2},{18,2},{18,-32}}, color={0,0,127}));
    connect(pipe1.port_b, pipe3.port_a) annotation (Line(points={{-58,6},{-44,6},
            {-44,-40},{-30,-40}}, color={0,127,255}));
    annotation (
      Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{
              100,100}}),
              graphics),
      experiment(StopTime=5),
      experimentSetupOutput(equdistant=false),
      Documentation(info="<html>
Simulation starts with both valves open. At t=1, valve 1 closes; at t=2 valve 2 closes, and the simulation fails.
</html>"));
  end BranchingPipes131;

  model LumpedPipeInitialization "Steady-state initialization of a lumped pipe"

    Modelica.Fluid.Sources.FixedBoundary source(nPorts=1,
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      use_T=false,
      p=10000000,
      h=2e6)
      annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
    ModelicaTest.Fluid.BaseClasses.LumpedPipe pipe(
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
      dp_nominal=10000000,
      m_flow_nominal=10)
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
    inner Modelica.Fluid.System system(energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState)
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
        points={{-60,0},{-40,0}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(pipe.port_b, valve.port_a)               annotation (Line(
        points={{-20,0},{0,0}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(valve.port_b, sink.ports[1])                          annotation (Line(
        points={{20,0},{40,0}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(ramp.y, valve.opening)               annotation (Line(
        points={{25,40},{10,40},{10,8}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=true,
            extent={{-100,-100},{100,100}}), graphics),
      experiment(StopTime=4),
      experimentSetupOutput);
  end LumpedPipeInitialization;

end TestCriticalCases;
