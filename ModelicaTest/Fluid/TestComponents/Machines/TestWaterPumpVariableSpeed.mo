within ModelicaTest.Fluid.TestComponents.Machines;
model TestWaterPumpVariableSpeed
  "Test pump with variable speed (starting from zero)"
  import Modelica.Fluid;
  extends Modelica.Icons.Example;

  Modelica.Blocks.Sources.Ramp N_pump(
    startTime=1,
    duration=5,
    height=1500,
    offset=0)   annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
  Modelica.Fluid.Sources.Boundary_pT Source(nPorts=1, redeclare package Medium
      = Modelica.Media.Water.StandardWater,
    T=system.T_ambient,
    p=100000)
  annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
  Modelica.Fluid.Sources.Boundary_pT Sink(nPorts=1,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    T=system.T_ambient,
    use_p_in=false,
    p=100000)
  annotation (Placement(transformation(extent={{34,26},{14,46}})));
  Modelica.Fluid.Machines.PrescribedPump pump(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    m_flow_start=1,
    redeclare function flowCharacteristic =
        Modelica.Fluid.Machines.BaseClasses.PumpCharacteristics.quadraticFlow (
          V_flow_nominal={0,0.001,0.0015}, head_nominal={100,50,0}),
    N_nominal=1500,
    use_N_in=true,
    p_a_start=100000,
    p_b_start=700000)      annotation (Placement(transformation(extent={{-64,16},
            {-36,44}})));
  Modelica.Blocks.Sources.Ramp valveOpening(
    height=-1,
    duration=1,
    offset=1,
    startTime=8)
  annotation (Placement(transformation(extent={{-40,80},{-20,60}})));
  Modelica.Fluid.Valves.ValveIncompressible Valve(
                                             redeclare package Medium =
        Modelica.Media.Water.StandardWater,
    m_flow_nominal=1,
    CvData=Modelica.Fluid.Types.CvTypes.OpPoint,
    dp_nominal=1000000)
  annotation (Placement(transformation(extent={{-16,26},{2,46}})));
  inner Modelica.Fluid.System system
                                   annotation (Placement(transformation(extent={{64,-4},
            {84,16}})));
equation
  connect(Valve.port_b,Sink.ports[1])    annotation (Line(points={{2,36},{14,36}},
        color={0,127,255}));
  connect(Valve.port_a,pump.port_b)      annotation (Line(points={{-16,36},{-26,
          36},{-26,30},{-36,30}},           color={0,127,255}));
  connect(pump.port_a,Source.ports[1])
                                     annotation (Line(points={{-64,30},{-64,30},
          {-80,30}},          color={0,127,255}));
  connect(N_pump.y, pump.N_in) annotation (Line(
      points={{-79,70},{-50,70},{-50,44}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(valveOpening.y, Valve.opening) annotation (Line(
      points={{-19,70},{-7,70},{-7,44}},
      color={0,0,127},
      smooth=Smooth.None));
annotation (
  experiment(StopTime=10, Tolerance=1e-006),
  Documentation(info=""));
end TestWaterPumpVariableSpeed;
