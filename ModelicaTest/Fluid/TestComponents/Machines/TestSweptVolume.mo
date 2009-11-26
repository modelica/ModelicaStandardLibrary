within ModelicaTest.Fluid.TestComponents.Machines;
model TestSweptVolume
  "Enclosed medium with fixed quantity in an adiabatic volume with varying size"
  extends Modelica.Icons.Example;
  Modelica.Fluid.Machines.SweptVolume sweptVolume(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Air.DryAirNasa,
    clearance(displayUnit="l") = 1e-005,
    use_portsData=false,
    pistonCrossArea(displayUnit="cm2") = 0.001) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={10,10})));
  Modelica.Mechanics.Translational.Components.Mass mass(m=1, s(start=0.5, fixed=
         true))
    annotation (Placement(transformation(extent={{-10,0},{-30,20}})));
  Modelica.Fluid.Sources.Boundary_pT boundary(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Air.DryAirNasa,
    use_p_in=true,
    p=200000)
    annotation (Placement(transformation(extent={{60,0},{40,20}})));
  Modelica.Blocks.Sources.Trapezoid trapezoid(
    offset=1e5,
    amplitude=1e5,
    rising=0.5,
    falling=0.5,
    period=2,
    startTime=1)
    annotation (Placement(transformation(extent={{40,40},{60,60}})));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  Modelica.Mechanics.Translational.Components.Fixed fixed(s0=2)
                                                          annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-70,10})));
  Modelica.Mechanics.Translational.Components.SpringDamper springDamper(
    c=100,
    d=1,
    s_rel0=1.5)
    annotation (Placement(transformation(extent={{-40,0},{-60,20}})));
equation
  connect(sweptVolume.ports[1], boundary.ports[1]) annotation (Line(
      points={{20,10},{40,10}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(boundary.p_in, trapezoid.y) annotation (Line(
      points={{62,18},{80,18},{80,50},{61,50}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(mass.flange_a, sweptVolume.flange) annotation (Line(
      points={{-10,10},{0,10}},
      color={0,127,0},
      smooth=Smooth.None));
  connect(mass.flange_b, springDamper.flange_a) annotation (Line(
      points={{-30,10},{-40,10}},
      color={0,127,0},
      smooth=Smooth.None));
  connect(springDamper.flange_b, fixed.flange) annotation (Line(
      points={{-60,10},{-70,10}},
      color={0,127,0},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}),
                        graphics), experiment(StopTime=5));
end TestSweptVolume;
