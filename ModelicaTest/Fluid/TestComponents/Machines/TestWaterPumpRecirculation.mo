within ModelicaTest.Fluid.TestComponents.Machines;
model TestWaterPumpRecirculation
  "Test pump with variable speed and recirculating flow"
  import Modelica.Fluid;
  extends Modelica.Icons.Example;

  Modelica.Blocks.Sources.Ramp N_pump(
    startTime=1,
    height=1500,
    offset=0,
    duration=1) annotation (Placement(transformation(extent={{-100,-8},{-80,12}})));
  Modelica.Fluid.Sources.Boundary_pT Source(nPorts=1,
    T=system.T_ambient,
    p=100000,
    redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
  annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));
  Modelica.Fluid.Sources.Boundary_pT Sink(nPorts=1,
    T=system.T_ambient,
    use_p_in=false,
    p=100000,
    redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
  annotation (Placement(transformation(extent={{62,-30},{42,-10}})));
  Modelica.Fluid.Machines.PrescribedPump pump(
    m_flow_start=1,
    redeclare function flowCharacteristic =
        Modelica.Fluid.Machines.BaseClasses.PumpCharacteristics.quadraticFlow (
          V_flow_nominal={0,0.001,0.0015}, head_nominal={100,50,0}),
    N_nominal=1500,
    use_N_in=true,
    V=0.1/1000,
    redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    p_a_start=100000,
    p_b_start=700000,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    massDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
                          annotation (Placement(transformation(extent={{-54,-44},
            {-26,-16}})));

  inner Modelica.Fluid.System system
                                   annotation (Placement(transformation(extent={{80,60},
            {100,80}})));
  Modelica.Fluid.Valves.ValveIncompressible V1(
    CvData=Modelica.Fluid.Types.CvTypes.OpPoint,
    m_flow_nominal=1,
    dp_nominal=800000,
    redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    annotation (Placement(transformation(extent={{-18,6},{-40,26}})));
  Modelica.Fluid.Valves.ValveIncompressible V2(
    CvData=Modelica.Fluid.Types.CvTypes.OpPoint,
    m_flow_nominal=1,
    dp_nominal=800000,
    redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    annotation (Placement(transformation(extent={{0,-30},{22,-10}})));
  Modelica.Blocks.Sources.Ramp V1_Opening(
    duration=1,
    height=-1,
    offset=1,
    startTime=5)
                annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
  Modelica.Blocks.Sources.Ramp V2_Opening(
    offset=0,
    height=1,
    duration=1,
    startTime=3)
                annotation (Placement(transformation(extent={{-100,70},{-80,90}})));
equation
  connect(pump.port_a,Source.ports[1])
                                     annotation (Line(points={{-54,-30},{-54,
          -30},{-80,-30}},    color={0,127,255}));
  connect(N_pump.y, pump.N_in) annotation (Line(
      points={{-79,2},{-40,2},{-40,-16}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(pump.port_b, V1.port_a) annotation (Line(
      points={{-26,-30},{-10,-30},{-10,16},{-18,16}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(V1.port_b, pump.port_a) annotation (Line(
      points={{-40,16},{-60,16},{-60,-30},{-54,-30}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pump.port_b, V2.port_a) annotation (Line(
      points={{-26,-30},{-10,-30},{-10,-20},{0,-20}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(V2.port_b, Sink.ports[1]) annotation (Line(
      points={{22,-20},{42,-20}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(V1_Opening.y, V1.opening) annotation (Line(
      points={{-79,50},{-29,50},{-29,24}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(V2_Opening.y, V2.opening) annotation (Line(
      points={{-79,80},{11,80},{11,-12}},
      color={0,0,127},
      smooth=Smooth.None));
annotation (
  experiment(StopTime=10, Tolerance=1e-006),
  Documentation(info=""));
end TestWaterPumpRecirculation;
