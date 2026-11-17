within ModelicaTest.Magnetic.FluxTubes;
model Sources
  extends Modelica.Icons.Example;
  Modelica.Magnetic.FluxTubes.Sources.ConstantMagneticPotentialDifference
    constantSource(V_m=15.9) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-80,40})));
  Modelica.Magnetic.FluxTubes.Sources.SignalMagneticPotentialDifference
    signalSource annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={20,40})));
  Modelica.Magnetic.FluxTubes.Sources.ConstantMagneticFlux constantSource1(
      Phi=2e-4) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-80,-40})));
  Modelica.Magnetic.FluxTubes.Sources.SignalMagneticFlux signalSource1
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={20,-40})));
  Modelica.Magnetic.FluxTubes.Shapes.FixedShape.GenericFluxTube
    genericFluxTube(
    nonLinearPermeability=false,
    mu_rConst=1000,
    l=0.01,
    area=1e-4) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-40,40})));
  Modelica.Magnetic.FluxTubes.Basic.Ground ground
    annotation (Placement(transformation(extent={{-90,0},{-70,20}})));
  Modelica.Magnetic.FluxTubes.Shapes.FixedShape.GenericFluxTube
    genericFluxTube1(
    nonLinearPermeability=false,
    mu_rConst=1000,
    l=0.01,
    area=1e-4) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={60,40})));
  Modelica.Blocks.Sources.Ramp ramp(
    duration=1,
    offset=0,
    startTime=0,
    height=15.9)
    annotation (Placement(transformation(extent={{-6,34},{6,46}})));
  Modelica.Blocks.Sources.Ramp ramp1(
    duration=1,
    offset=0,
    startTime=0,
    height=2e-4)
    annotation (Placement(transformation(extent={{-6,-46},{6,-34}})));
  Modelica.Magnetic.FluxTubes.Basic.Ground ground1
    annotation (Placement(transformation(extent={{10,0},{30,20}})));
  Modelica.Magnetic.FluxTubes.Shapes.FixedShape.GenericFluxTube
    genericFluxTube2(
    nonLinearPermeability=false,
    mu_rConst=1000,
    l=0.01,
    area=1e-4) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-40,-40})));
  Modelica.Magnetic.FluxTubes.Shapes.FixedShape.GenericFluxTube
    genericFluxTube3(
    nonLinearPermeability=false,
    mu_rConst=1000,
    l=0.01,
    area=1e-4) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={60,-40})));
  Modelica.Magnetic.FluxTubes.Basic.Ground ground2
    annotation (Placement(transformation(extent={{-90,-80},{-70,-60}})));
  Modelica.Magnetic.FluxTubes.Basic.Ground ground3
    annotation (Placement(transformation(extent={{10,-80},{30,-60}})));
equation

  connect(constantSource.port_n, ground.port) annotation (Line(points={{-80,
          30},{-80,30},{-80,20}}, color={255,127,0}));
  connect(constantSource.port_p, genericFluxTube.port_p) annotation (Line(
        points={{-80,50},{-80,60},{-40,60},{-40,50}}, color={255,127,0}));
  connect(genericFluxTube.port_n, ground.port) annotation (Line(points={{-40,
          30},{-40,20},{-80,20}}, color={255,127,0}));
  connect(signalSource.port_p, genericFluxTube1.port_p) annotation (Line(
        points={{20,50},{20,60},{60,60},{60,50}}, color={255,127,0}));
  connect(signalSource.V_m, ramp.y)
    annotation (Line(points={{11,40},{6.6,40}}, color={0,0,127}));
  connect(constantSource1.port_p, genericFluxTube2.port_p) annotation (Line(
        points={{-80,-30},{-80,-30},{-80,-20},{-40,-20},{-40,-30}}, color={
          255,127,0}));
  connect(signalSource.port_n, ground1.port)
    annotation (Line(points={{20,30},{20,25},{20,20}}, color={255,127,0}));
  connect(genericFluxTube1.port_n, ground1.port)
    annotation (Line(points={{60,30},{60,20},{20,20}}, color={255,127,0}));
  connect(ramp1.y, signalSource1.Phi)
    annotation (Line(points={{6.6,-40},{11,-40}}, color={0,0,127}));
  connect(signalSource1.port_p, genericFluxTube3.port_p) annotation (Line(
        points={{20,-30},{20,-20},{60,-20},{60,-30}}, color={255,127,0}));
  connect(genericFluxTube3.port_n, ground3.port) annotation (Line(points={{60,
          -50},{60,-60},{20,-60}}, color={255,127,0}));
  connect(signalSource1.port_n, ground3.port) annotation (Line(points={{20,
          -50},{20,-50},{20,-60}}, color={255,127,0}));
  connect(constantSource1.port_n, ground2.port) annotation (Line(points={{-80,
          -50},{-80,-55},{-80,-60}}, color={255,127,0}));
  connect(genericFluxTube2.port_n, ground2.port) annotation (Line(points={{
          -40,-50},{-40,-60},{-80,-60}}, color={255,127,0}));
  annotation (experiment(StartTime=0, StopTime=1, Interval=1e-3, Tolerance=1e-005));
end Sources;
