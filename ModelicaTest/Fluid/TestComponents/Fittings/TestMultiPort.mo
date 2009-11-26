within ModelicaTest.Fluid.TestComponents.Fittings;
model TestMultiPort
  import Modelica.Fluid;
  extends Modelica.Icons.Example;

  Modelica.Fluid.Fittings.MultiPort multiPort(
                                       nPorts_b=2, redeclare package Medium =
        Modelica.Media.Air.MoistAir)        annotation (Placement(
        transformation(extent={{-28,-30},{-20,-10}},
                                                   rotation=0)));
  Modelica.Fluid.Sources.Boundary_pT source2(nPorts=1,
    T=278.15,
    p=5e5,
    redeclare package Medium = Modelica.Media.Air.MoistAir)
    annotation (Placement(transformation(
        origin={80,-20},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  Modelica.Fluid.Sources.Boundary_pT source3(nPorts=1,
    T=283.15,
    p=2e5,
    redeclare package Medium = Modelica.Media.Air.MoistAir)
    annotation (Placement(transformation(
        origin={10,70},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{-100,80},{-80,100}}, rotation=
           0)));
  Modelica.Fluid.Sources.Boundary_pT source1(nPorts=1,
    T=system.T_ambient,
    use_p_in=true,
    redeclare package Medium = Modelica.Media.Air.MoistAir,
    p=500000)
    annotation (Placement(transformation(extent={{-60,-30},{-40,-10}}, rotation=
           0)));
  Modelica.Blocks.Sources.Ramp ramp(
    duration=1,
    height=-6.5e5,
    offset=7e5) annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=270,
        origin={-80,10})));
  Modelica.Fluid.Pipes.StaticPipe pipe1(
    length=1,
    diameter=0.1,
    redeclare package Medium = Modelica.Media.Air.MoistAir)
                                       annotation (Placement(transformation(
          extent={{40,-30},{60,-10}}, rotation=0)));
  Modelica.Fluid.Pipes.StaticPipe pipe2(
    length=1,
    diameter=0.1,
    redeclare package Medium = Modelica.Media.Air.MoistAir)
    annotation (Placement(transformation(
        origin={10,24},
        extent={{-10,-10},{10,10}},
        rotation=90)));
equation
  connect(ramp.y, source1.p_in) annotation (Line(points={{-80,-1},{-80,-1},{-80,
          -12},{-62,-12}},
        color={0,0,127}));
  connect(pipe1.port_b, source2.ports[1])
                                      annotation (Line(points={{60,-20},{70,-20}},
        color={0,127,255}));
  connect(pipe2.port_b, source3.ports[1])
                                      annotation (Line(points={{10,34},{10,47},
          {10,60}},         color={0,127,255}));
  connect(multiPort.ports_b[1], pipe2.port_a)
                                             annotation (Line(
      points={{-20,-18},{10,-18},{10,14}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(multiPort.ports_b[2], pipe1.port_a)
                                             annotation (Line(
      points={{-20,-22},{35,-22},{35,-20},{40,-20}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(source1.ports[1], multiPort.port_a) annotation (Line(
      points={{-40,-20},{-28,-20}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}),
                      graphics));
end TestMultiPort;
