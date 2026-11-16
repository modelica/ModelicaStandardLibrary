within ModelicaTest.Magnetic.FluxTubes.Shapes;
model Force
  extends Modelica.Icons.Example;
  Modelica.Magnetic.FluxTubes.Shapes.Force.HollowCylinderAxialFlux
    hollowCylinderAxialFlux(
    dlBydx=1,
    r_i=0,
    r_o=0.01,
    useSupport=false,
    mu_r=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-60,50})));
  Modelica.Magnetic.FluxTubes.Shapes.Force.CuboidParallelFlux
    cuboidParallelFlux(mu_r=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-20,10})));
  Modelica.Magnetic.FluxTubes.Shapes.Force.CuboidOrthogonalFlux
    cuboidOrthogonalFlux(mu_r=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-10})));
  Modelica.Magnetic.FluxTubes.Sources.ConstantMagneticPotentialDifference
    constantSource(V_m=10) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-80,10})));
  Modelica.Magnetic.FluxTubes.Basic.Ground ground
    annotation (Placement(transformation(extent={{-90,-80},{-70,-60}})));
  Modelica.Mechanics.Translational.Sources.Position position(v(fixed=true,
        start=0))
    annotation (Placement(transformation(extent={{70,-20},{50,0}})));
  Modelica.Blocks.Sources.Ramp ramp(
    duration=1,
    offset=0.1e-3,
    startTime=0,
    height=5e-3)
    annotation (Placement(transformation(extent={{100,-20},{80,0}})));
  Modelica.Magnetic.FluxTubes.Shapes.Force.HollowCylinderRadialFlux
    hollowCylinderRadialFlux(
    mu_r=1,
    dlBydx=1,
    r_i=0.01,
    r_o=0.015) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-40,30})));
  Modelica.Magnetic.FluxTubes.Shapes.Force.LeakageAroundPoles
    leakageAroundPoles(
    mu_r=1,
    dlBydx=1,
    w=0.1,
    r=0.01) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={20,-30})));
equation

  connect(constantSource.port_p, hollowCylinderAxialFlux.port_p)
    annotation (Line(points={{-80,20},{-80,20},{-80,80},{-60,80},{-60,60}}, color={255,127,0}));
  connect(cuboidOrthogonalFlux.port_p, hollowCylinderAxialFlux.port_p)
    annotation (Line(points={{1.77636e-015,0},{1.77636e-015,80},{-60,80},{
          -60,60}}, color={255,127,0}));
  connect(cuboidParallelFlux.port_p, hollowCylinderAxialFlux.port_p)
    annotation (Line(points={{-20,20},{-20,80},{-60,80},{-60,60}}, color={
          255,127,0}));
  connect(constantSource.port_n, ground.port)
    annotation (Line(points={{-80,0},{-80,-60}}, color={255,127,0}));
  connect(cuboidOrthogonalFlux.port_n, ground.port) annotation (Line(points=
         {{-1.77636e-015,-20},{-1.77636e-015,-60},{-80,-60}}, color={255,
          127,0}));
  connect(cuboidParallelFlux.port_n, ground.port) annotation (Line(points={
          {-20,0},{-20,-60},{-80,-60}}, color={255,127,0}));
  connect(hollowCylinderAxialFlux.port_n, ground.port) annotation (Line(
        points={{-60,40},{-60,-60},{-80,-60}}, color={255,127,0}));
  connect(position.flange, cuboidOrthogonalFlux.flange) annotation (Line(
        points={{50,-10},{50,-10},{10,-10}}, color={0,127,0}));
  connect(cuboidParallelFlux.flange, cuboidOrthogonalFlux.flange)
    annotation (Line(points={{-10,10},{-10,10},{40,10},{40,-10},{10,-10}}, color={0,127,0}));
  connect(hollowCylinderAxialFlux.flange, cuboidOrthogonalFlux.flange)
    annotation (Line(points={{-50,50},{40,50},{40,-10},{10,-10}}, color={0,
          127,0}));
  connect(ramp.y, position.s_ref)
    annotation (Line(points={{79,-10},{72,-10}}, color={0,0,127}));
  connect(hollowCylinderRadialFlux.port_p, hollowCylinderAxialFlux.port_p)
    annotation (Line(points={{-40,40},{-40,80},{-60,80},{-60,60}}, color={
          255,127,0}));
  connect(hollowCylinderRadialFlux.port_n, ground.port) annotation (Line(
        points={{-40,20},{-40,-60},{-80,-60}}, color={255,127,0}));
  connect(hollowCylinderRadialFlux.flange, cuboidOrthogonalFlux.flange)
    annotation (Line(points={{-30,30},{40,30},{40,-10},{10,-10}}, color={0,
          127,0}));
  connect(leakageAroundPoles.port_p, hollowCylinderAxialFlux.port_p)
    annotation (Line(points={{20,-20},{20,80},{-60,80},{-60,60}}, color={
          255,127,0}));
  connect(leakageAroundPoles.port_n, ground.port) annotation (Line(points={
          {20,-40},{20,-40},{20,-60},{-80,-60}}, color={255,127,0}));
  connect(leakageAroundPoles.flange, cuboidOrthogonalFlux.flange)
    annotation (Line(points={{30,-30},{40,-30},{40,-10},{10,-10}}, color={0,
          127,0}));
  annotation (experiment(StartTime=0, StopTime=1, Interval=1e-3, Tolerance=1e-005));
end Force;
