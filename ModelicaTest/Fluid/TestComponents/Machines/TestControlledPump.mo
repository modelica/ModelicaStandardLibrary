within ModelicaTest.Fluid.TestComponents.Machines;
model TestControlledPump "Test controlled pump"
  import Modelica.Fluid;
  extends Modelica.Icons.Example;

  Modelica.Blocks.Sources.Sine massFlowRate(
    amplitude=0.5,
    offset=1,
    f=1/7) annotation (Placement(transformation(extent={{-70,60},{-50,80}})));
  Modelica.Fluid.Sources.Boundary_pT source(nPorts=1, redeclare package Medium
      = Modelica.Media.Water.StandardWater,
    T=system.T_ambient,
    p=100000)
  annotation (Placement(transformation(extent={{-90,20},{-70,40}})));
  Modelica.Fluid.Sources.Boundary_pT sink(nPorts=1,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    T=system.T_ambient,
    use_p_in=true,
    p=200000)
  annotation (Placement(transformation(extent={{50,20},{30,40}})));
  Modelica.Fluid.Machines.ControlledPump pump(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_m_flow_set=true,
    m_flow_nominal=1,
    p_a_nominal=100000,
    p_b_nominal=1000000)     annotation (Placement(transformation(extent={{-50,20},
            {-30,40}})));
  inner Modelica.Fluid.System system
                                   annotation (Placement(transformation(extent={{70,-90},
            {90,-70}})));
  Modelica.Fluid.Valves.ValveIncompressible valve(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    CvData=Modelica.Fluid.Types.CvTypes.OpPoint,
    m_flow_nominal=1,
    dp_nominal=200000)
    annotation (Placement(transformation(extent={{-10,20},{10,40}})));
  Modelica.Blocks.Sources.Ramp valveOpening(
    duration=1,
    startTime=3,
    height=-0.5,
    offset=1)   annotation (Placement(transformation(extent={{30,60},{10,80}})));
  Modelica.Blocks.Sources.Sine pressure1(
    amplitude=5e5,
    f=1/7,
    offset=10e5)
                annotation (Placement(transformation(extent={{-70,-40},{-50,-20}})));
  Modelica.Fluid.Sources.Boundary_pT source1(nPorts=1,redeclare package Medium
      = Modelica.Media.Water.StandardWater,
    T=system.T_ambient,
    p=100000)
  annotation (Placement(transformation(extent={{-90,-80},{-70,-60}})));
  Modelica.Fluid.Sources.Boundary_pT sink1(nPorts=1,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    T=system.T_ambient,
    use_p_in=true,
    p=200000)
  annotation (Placement(transformation(extent={{50,-80},{30,-60}})));
  Modelica.Fluid.Machines.ControlledPump pump1(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    control_m_flow=false,
    use_m_flow_set=false,
    use_p_set=true,
    m_flow_nominal=1,
    p_a_nominal=100000,
    p_b_nominal=1000000)
                        annotation (Placement(transformation(extent={{-50,-80},
            {-30,-60}})));
  Modelica.Fluid.Valves.ValveIncompressible valve1(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    CvData=Modelica.Fluid.Types.CvTypes.OpPoint,
    m_flow_nominal=1,
    dp_nominal=200000)
    annotation (Placement(transformation(extent={{-10,-80},{10,-60}})));
  Modelica.Blocks.Sources.Ramp valveOpening1(
    duration=1,
    startTime=3,
    height=-0.5,
    offset=1)   annotation (Placement(transformation(extent={{30,-40},{10,-20}})));
  Modelica.Blocks.Sources.Ramp sinkPressure(
    duration=1,
    height=-7e5,
    offset=8e5,
    startTime=3)
                annotation (Placement(transformation(extent={{90,60},{70,80}})));
equation
  connect(pump.port_a,source.ports[1])
                                     annotation (Line(points={{-50,30},{-70,30}}, color={0,127,255}));
  connect(pump.port_b, valve.port_a) annotation (Line(
      points={{-30,30},{-10,30}}, color={0,127,255}));
  connect(valve.port_b, sink.ports[1]) annotation (Line(
      points={{10,30},{30,30}}, color={0,127,255}));
  connect(valveOpening.y, valve.opening) annotation (Line(
      points={{9,70},{0,70},{0,38}}, color={0,0,127}));
  connect(massFlowRate.y, pump.m_flow_set) annotation (Line(
      points={{-49,70},{-45,70},{-45,38.2}}, color={0,0,127}));
  connect(pump1.port_a, source1.ports[1])
                                     annotation (Line(points={{-50,-70},{-70,
          -70}}, color={0,127,255}));
  connect(pump1.port_b, valve1.port_a)
                                     annotation (Line(
      points={{-30,-70},{-10,-70}}, color={0,127,255}));
  connect(valve1.port_b, sink1.ports[1])
                                       annotation (Line(
      points={{10,-70},{30,-70}}, color={0,127,255}));
  connect(valveOpening1.y, valve1.opening)
                                         annotation (Line(
      points={{9,-30},{0,-30},{0,-62}}, color={0,0,127}));
  connect(pressure1.y, pump1.p_set) annotation (Line(
      points={{-49,-30},{-35,-30},{-35,-61.8}}, color={0,0,127}));
  connect(sinkPressure.y, sink.p_in) annotation (Line(
      points={{69,70},{60,70},{60,38},{52,38}}, color={0,0,127}));
  connect(sinkPressure.y, sink1.p_in) annotation (Line(
      points={{69,70},{60,70},{60,-62},{52,-62}}, color={0,0,127}));
annotation (
  experiment(StopTime=7, Tolerance=1e-006),
  Documentation(info=""));
end TestControlledPump;
