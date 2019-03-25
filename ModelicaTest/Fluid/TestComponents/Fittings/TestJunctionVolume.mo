within ModelicaTest.Fluid.TestComponents.Fittings;
model TestJunctionVolume
  extends Modelica.Icons.Example;

  Modelica.Fluid.Fittings.TeeJunctionVolume junction(           redeclare
      package Medium =
        Modelica.Media.Air.DryAirNasa, V=20e-6,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
    massDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
    p_start=300000)                         annotation (Placement(
        transformation(extent={{20,-30},{40,-10}})));

  Modelica.Fluid.Sources.Boundary_pT source2(nPorts=1,
    redeclare package Medium = Modelica.Media.Air.DryAirNasa,
    p=500000,
    T=278.15)
    annotation (Placement(transformation(
        origin={90,-20},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  Modelica.Fluid.Sources.Boundary_pT source3(nPorts=1,
    redeclare package Medium = Modelica.Media.Air.DryAirNasa,
    p=200000,
    T=283.15)
    annotation (Placement(transformation(
        origin={30,70},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Modelica.Fluid.Sources.Boundary_pT source1(nPorts=1,          p=5e5,
      redeclare package Medium = Modelica.Media.Air.DryAirNasa,
    T=system.T_ambient,
    use_p_in=true)
    annotation (Placement(transformation(extent={{-40,-30},{-20,-10}})));
  Modelica.Blocks.Sources.Ramp ramp(
    duration=1,
    height=-6.5e5,
    offset=7e5) annotation (Placement(transformation(extent={{-90,-2},{-70,-22}})));
  Modelica.Fluid.Pipes.StaticPipe pipe(      redeclare package Medium =
        Modelica.Media.Air.DryAirNasa,
    length=1,
    diameter=0.1)                      annotation (Placement(transformation(
          extent={{-12,-30},{8,-10}})));
  Modelica.Fluid.Pipes.StaticPipe pipe1(      redeclare package Medium =
        Modelica.Media.Air.DryAirNasa,
    length=1,
    diameter=0.1)                      annotation (Placement(transformation(
          extent={{50,-30},{70,-10}})));
  Modelica.Fluid.Pipes.StaticPipe pipe2(      redeclare package Medium =
        Modelica.Media.Air.DryAirNasa,
    length=1,
    diameter=0.1)
    annotation (Placement(transformation(
        origin={30,24},
        extent={{-10,-10},{10,10}},
        rotation=90)));
equation
  connect(ramp.y, source1.p_in) annotation (Line(points={{-69,-12},{-55.5,-12},
          {-42,-12}}, color={0,0,127}));
  connect(source1.ports[1], pipe.port_a)
                                     annotation (Line(points={{-20,-20},{-12,
          -20}}, color={0,127,255}));
  connect(pipe.port_b, junction.port_1)
    annotation (Line(points={{8,-20},{20,-20}}, color={0,127,255}));
  connect(pipe1.port_b, source2.ports[1])
                                      annotation (Line(points={{70,-20},{80,-20}}, color={0,127,255}));
  connect(junction.port_2, pipe1.port_a) annotation (Line(points={{40,-20},{50,
          -20}}, color={0,127,255}));
  connect(pipe2.port_b, source3.ports[1])
                                      annotation (Line(points={{30,34},{30,47},
          {30,60}}, color={0,127,255}));
  connect(pipe2.port_a, junction.port_3)
    annotation (Line(points={{30,14},{30,-10}}, color={0,127,255}));
  annotation ( experiment(StopTime=1.01));
end TestJunctionVolume;
