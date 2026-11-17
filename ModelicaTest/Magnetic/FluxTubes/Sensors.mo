within ModelicaTest.Magnetic.FluxTubes;
model Sensors
  extends Modelica.Icons.Example;
  Modelica.Magnetic.FluxTubes.Sources.SignalMagneticPotentialDifference
    signalSource annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-30,20})));
  Modelica.Magnetic.FluxTubes.Shapes.FixedShape.GenericFluxTube
    genericFluxTube(
    nonLinearPermeability=false,
    mu_rConst=1000,
    l=0.01,
    area=1e-4) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={30,20})));
  Modelica.Blocks.Sources.Ramp ramp(
    duration=1,
    offset=0,
    startTime=0,
    height=15.9)
    annotation (Placement(transformation(extent={{-56,14},{-44,26}})));
  Modelica.Magnetic.FluxTubes.Basic.Ground ground1
    annotation (Placement(transformation(extent={{-40,-20},{-20,0}})));
  Modelica.Magnetic.FluxTubes.Sensors.MagneticPotentialDifferenceSensor
    magneticPotentialDifferenceSensor annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={54,20})));
  Modelica.Magnetic.FluxTubes.Sensors.MagneticFluxSensor magneticFluxSensor
    annotation (Placement(transformation(extent={{-10,30},{10,50}})));
equation

  connect(signalSource.V_m, ramp.y)
    annotation (Line(points={{-39,20},{-43.4,20}}, color={0,0,127}));
  connect(signalSource.port_n, ground1.port)
    annotation (Line(points={{-30,10},{-30,5},{-30,0}}, color={255,127,0}));
  connect(genericFluxTube.port_n, ground1.port)
    annotation (Line(points={{30,10},{30,0},{-30,0}}, color={255,127,0}));
  connect(magneticPotentialDifferenceSensor.port_n, ground1.port)
    annotation (Line(points={{54,10},{54,0},{-30,0}}, color={255,127,0}));
  connect(magneticFluxSensor.port_p, signalSource.port_p) annotation (Line(
        points={{-10,40},{-30,40},{-30,30}}, color={255,127,0}));
  connect(magneticFluxSensor.port_n, genericFluxTube.port_p)
    annotation (Line(points={{10,40},{30,40},{30,30}}, color={255,127,0}));
  connect(magneticPotentialDifferenceSensor.port_p, genericFluxTube.port_p)
    annotation (Line(points={{54,30},{54,40},{30,40},{30,30}}, color={255,127,
          0}));
  annotation (experiment(StartTime=0, StopTime=1, Interval=1e-3, Tolerance=1e-005));
end Sensors;
