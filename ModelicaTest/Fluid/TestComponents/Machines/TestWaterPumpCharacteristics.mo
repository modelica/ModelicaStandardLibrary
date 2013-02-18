within ModelicaTest.Fluid.TestComponents.Machines;
model TestWaterPumpCharacteristics
  "Test pump with default options and different selections of flowCharacteristic"
  import Modelica.Fluid;
  extends Modelica.Icons.Example;
  Modelica.Fluid.Sources.Boundary_pT Source(nPorts=4, redeclare package Medium
      = Modelica.Media.Water.StandardWater,
    T=system.T_ambient,
    p=200000)
  annotation (Placement(transformation(extent={{-100,20},{-80,40}}, rotation=0)));
  Modelica.Fluid.Sources.Boundary_pT Sink(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=5e5,
    T=system.T_ambient,
    use_p_in=true,
    nPorts=4)
  annotation (Placement(transformation(extent={{34,20},{14,40}}, rotation=0)));
  Modelica.Fluid.Machines.PrescribedPump pump(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    m_flow_start=1,
    N_nominal=1500,
    p_a_start=100000,
    p_b_start=700000,
    redeclare function flowCharacteristic =
        Modelica.Fluid.Machines.BaseClasses.PumpCharacteristics.quadraticFlow (
          head_nominal={100,50,0}, V_flow_nominal={0,0.001,0.0015}))
                        annotation (Placement(transformation(extent={{-64,16},{-36,
            44}},      rotation=0)));
  Modelica.Blocks.Sources.Ramp downstreamPressure(
    startTime=1,
    duration=5,
    offset=1e5,
    height=12e5)
                annotation (Placement(transformation(extent={{14,60},{34,80}},
          rotation=0)));

  inner Modelica.Fluid.System system
                                   annotation (Placement(transformation(extent=
            {{64,-4},{84,16}}, rotation=0)));
  Modelica.Fluid.Machines.PrescribedPump pumpPolynomial(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    m_flow_start=1,
    N_nominal=1500,
    p_a_start=100000,
    p_b_start=700000,
    redeclare function flowCharacteristic =
        Modelica.Fluid.Machines.BaseClasses.PumpCharacteristics.polynomialFlow
        (V_flow_nominal={0,0.001,0.0015}, head_nominal={100,50,0}))
                        annotation (Placement(transformation(extent={{-64,-20},{
            -36,8}},   rotation=0)));
  Modelica.Fluid.Machines.PrescribedPump pumpQuadraticLinear(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    m_flow_start=1,
    N_nominal=1500,
    redeclare function flowCharacteristic =
        Modelica.Fluid.Machines.BaseClasses.PumpCharacteristics.quadraticFlow (
          V_flow_nominal={0,0.00075,0.0015}, head_nominal={100,50,0}),
    p_a_start=100000,
    p_b_start=700000) "quadratic implementation for linear characteristics"
                        annotation (Placement(transformation(extent={{-64,-56},{
            -36,-28}}, rotation=0)));
  Modelica.Fluid.Machines.PrescribedPump pumpLinear(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    m_flow_start=1,
    N_nominal=1500,
    p_a_start=100000,
    p_b_start=700000,
    redeclare function flowCharacteristic =
        Modelica.Fluid.Machines.BaseClasses.PumpCharacteristics.linearFlow (
          V_flow_nominal={0,0.0015}, head_nominal={100,0}))
                        annotation (Placement(transformation(extent={{-64,-92},{
            -36,-64}}, rotation=0)));
equation
  assert(pump.m_flow - pumpPolynomial.m_flow < 1e-10, "Quadratic and Polynomial characteristic differ");
  assert(pumpQuadraticLinear.m_flow - pumpLinear.m_flow < 1e-10, "QuadraticLinear and Linear characteristic differ");
  connect(Source.ports[1], pump.port_a)  annotation (Line(points={{-80,33},{-80,
          32},{-66,32},{-66,30},{-64,30}},
                              color={0,127,255}));
  connect(downstreamPressure.y, Sink.p_in)
                                annotation (Line(points={{35,70},{58,70},{58,38},
          {36,38}}, color={0,0,127}));
  connect(pump.port_b, Sink.ports[1]) annotation (Line(
      points={{-36,30},{-11,30},{-11,33},{14,33}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(Source.ports[2], pumpPolynomial.port_a)
                                              annotation (Line(
      points={{-80,31},{-72,31},{-72,-6},{-64,-6}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(Source.ports[3], pumpQuadraticLinear.port_a)
                                                  annotation (Line(
      points={{-80,29},{-74,29},{-74,-42},{-64,-42}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pumpPolynomial.port_b, Sink.ports[2])
                                            annotation (Line(
      points={{-36,-6},{-6,-6},{-6,31},{14,31}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pumpQuadraticLinear.port_b, Sink.ports[3])
                                                annotation (Line(
      points={{-36,-42},{0,-42},{0,29},{14,29}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(Source.ports[4], pumpLinear.port_a) annotation (Line(
      points={{-80,27},{-76,27},{-76,-78},{-64,-78}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pumpLinear.port_b, Sink.ports[4]) annotation (Line(
      points={{-36,-78},{6,-78},{6,27},{14,27}},
      color={0,127,255},
      smooth=Smooth.None));
annotation (
  experiment(StopTime=10, Tolerance=1e-006),
  Documentation(info="<html>The simulation results of two times two pumps being parameterized identically are compared.
  The test includes extrapolation for heads ranging from about -10m to 110m, while the pump curves only cover 0m to 100m<p/> </html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}),     graphics));
end TestWaterPumpCharacteristics;
