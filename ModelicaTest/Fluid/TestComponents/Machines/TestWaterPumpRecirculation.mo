within ModelicaTest.Fluid.TestComponents.Machines;
model TestWaterPumpRecirculation
  "Test pump with variable speed and recirculating flow"
  import Modelica.Fluid;
  extends Modelica.Icons.Example;

  Modelica.Blocks.Sources.Ramp N_pump(
    startTime=1,
    height=1500,
    offset=0,
    duration=1) annotation (Placement(transformation(extent={{-100,-8},{-80,12}},
          rotation=0)));
  Modelica.Fluid.Sources.Boundary_pT Source(nPorts=1,
    T=system.T_ambient,
    p=100000,
    redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
  annotation (Placement(transformation(extent={{-100,-38},{-80,-18}},
                                                                    rotation=0)));
  Modelica.Fluid.Sources.Boundary_pT Sink(nPorts=1,
    T=system.T_ambient,
    use_p_in=false,
    p=100000,
    redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
  annotation (Placement(transformation(extent={{62,-30},{42,-10}},
                                                                 rotation=0)));
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
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial)
                          annotation (Placement(transformation(extent={{-46,-40},
            {-14,-10}},rotation=0)));

  inner Modelica.Fluid.System system
                                   annotation (Placement(transformation(extent={{80,60},
            {100,80}},         rotation=0)));
  Modelica.Fluid.Valves.ValveIncompressible V1(
    CvData=Modelica.Fluid.Types.CvTypes.OpPoint,
    m_flow_nominal=1,
    dp_nominal=800000,
    redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    annotation (Placement(transformation(extent={{-28,6},{-50,26}})));
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
                annotation (Placement(transformation(extent={{-100,40},{-80,60}},
          rotation=0)));
  Modelica.Blocks.Sources.Ramp V2_Opening(
    offset=0,
    height=1,
    duration=1,
    startTime=3)
                annotation (Placement(transformation(extent={{-100,70},{-80,90}},
          rotation=0)));
equation
  connect(pump.port_a,Source.ports[1])
                                     annotation (Line(points={{-46,-25},{-46,
          -25},{-80,-28}},    color={0,127,255}));
  connect(N_pump.y, pump.N_in) annotation (Line(
      points={{-79,2},{-30,2},{-30,-10}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(pump.port_b, V1.port_a) annotation (Line(
      points={{-14,-25},{-20,14},{-20,16},{-28,16}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(V1.port_b, pump.port_a) annotation (Line(
      points={{-50,16},{-60,16},{-60,-25},{-46,-25}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pump.port_b, V2.port_a) annotation (Line(
      points={{-14,-25},{-10.2,-25},{-10.2,-20},{0,-20}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(V2.port_b, Sink.ports[1]) annotation (Line(
      points={{22,-20},{42,-20}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(V1_Opening.y, V1.opening) annotation (Line(
      points={{-79,50},{-39,50},{-39,24}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(V2_Opening.y, V2.opening) annotation (Line(
      points={{-79,80},{11,80},{11,-12}},
      color={0,0,127},
      smooth=Smooth.None));
annotation (
  Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{100,
            100}}),
          graphics),
  experiment(StopTime=10, Tolerance=1e-006),
  Documentation(info=""));
end TestWaterPumpRecirculation;
