within ModelicaTest.Fluid.TestComponents.Machines;
model TestWaterPumpDefault "Test pump with default options"
  import Modelica.Fluid;
  extends Modelica.Icons.Example;
  Modelica.Fluid.Sources.Boundary_pT Source(nPorts=1, redeclare package Medium
      = Modelica.Media.Water.StandardWater, p=1e5,
    T=system.T_ambient)
  annotation (Placement(transformation(extent={{-100,20},{-80,40}}, rotation=0)));
  Modelica.Fluid.Sources.Boundary_pT Sink(nPorts=1,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=5e5,
    T=system.T_ambient,
    use_p_in=true)
  annotation (Placement(transformation(extent={{34,26},{14,46}}, rotation=0)));
  Modelica.Fluid.Machines.PrescribedPump pump(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    m_flow_start=1,
    redeclare function flowCharacteristic =
        Modelica.Fluid.Machines.BaseClasses.PumpCharacteristics.quadraticFlow (
          V_flow_nominal={0,0.001,0.0015}, head_nominal={100,50,0}),
    N_nominal=1500,
    p_a_start=100000,
    p_b_start=700000)     annotation (Placement(transformation(extent={{-66,20},
            {-34,50}}, rotation=0)));
  Modelica.Blocks.Sources.Constant valveOpening(k=1)
  annotation (Placement(transformation(extent={{-60,60},{-40,80}}, rotation=0)));
  Modelica.Fluid.Valves.ValveIncompressible Valve(
                                             redeclare package Medium =
        Modelica.Media.Water.StandardWater,
    m_flow_nominal=1,
    CvData=Modelica.Fluid.Types.CvTypes.OpPoint,
    dp_nominal=20000)
  annotation (Placement(transformation(extent={{-16,26},{2,46}}, rotation=0)));
  Modelica.Blocks.Sources.Ramp downstreamPressure(
    startTime=1,
    duration=5,
    offset=1e5,
    height=10e5)
                annotation (Placement(transformation(extent={{4,74},{24,94}},
          rotation=0)));

  inner Modelica.Fluid.System system
                                   annotation (Placement(transformation(extent=
            {{64,-4},{84,16}}, rotation=0)));
equation
  connect(Valve.port_b, Sink.ports[1])       annotation (Line(points={{2,36},{14,36}},
        color={0,127,255}));
  connect(Valve.port_a, pump.port_b)      annotation (Line(points={{-16,36},{
          -26,36},{-26,35},{-34,35}},       color={0,127,255}));
  connect(pump.port_a, Source.ports[1])  annotation (Line(points={{-66,35},{-70,35},
          {-70,30},{-80,30}}, color={0,127,255}));
  connect(downstreamPressure.y, Sink.p_in)
                                annotation (Line(points={{25,84},{58,84},{58,44},
          {36,44}}, color={0,0,127}));
  connect(valveOpening.y, Valve.opening) annotation (Line(
      points={{-39,70},{-7,70},{-7,44}},
      color={0,0,127},
      smooth=Smooth.None));
annotation (
  Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,
            -100},{100,100}}),
          graphics),
  experiment(StopTime=10, Tolerance=1e-006),
  Documentation(info=""));
end TestWaterPumpDefault;
