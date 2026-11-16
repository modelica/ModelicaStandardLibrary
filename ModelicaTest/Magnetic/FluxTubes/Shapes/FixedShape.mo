within ModelicaTest.Magnetic.FluxTubes.Shapes;
model FixedShape
  extends Modelica.Icons.Example;
  Modelica.Magnetic.FluxTubes.Shapes.FixedShape.GenericFluxTube genericFluxTube(
    l=0.01,
    area=1e-4,
    nonLinearPermeability=true,
    material=
        Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.ElectricSheet.M330_50A())
            annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={20,10})));

  Modelica.Magnetic.FluxTubes.Shapes.FixedShape.Cuboid cuboid(
    l=0.01,
    a=0.01,
    b=0.01,
    nonLinearPermeability=true,
    material=
        Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.ElectricSheet.M330_50A())
            annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={40,10})));

  Modelica.Magnetic.FluxTubes.Shapes.FixedShape.HollowCylinderAxialFlux
    hollowCylinderAxialFlux(
    nonLinearPermeability=true,
    material=
        Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.ElectricSheet.M330_50A(),
    l=0.01,
    r_i=0,
    r_o=0.01) annotation (Placement(transformation(extent={{-10,-10},{10,
            10}},
        rotation=270,
        origin={60,10})));
  Modelica.Magnetic.FluxTubes.Shapes.FixedShape.HollowCylinderRadialFlux
    hollowCylinderRadialFlux(
    nonLinearPermeability=true,
    material=
        Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.ElectricSheet.M330_50A(),
    l=0.01,
    r_i=0.01,
    r_o=0.02) annotation (Placement(transformation(extent={{-10,-10},{10,
            10}},
        rotation=270,
        origin={80,10})));
  Modelica.Magnetic.FluxTubes.Basic.Ground ground
    annotation (Placement(transformation(extent={{-30,-40},{-10,-20}})));
  Modelica.Magnetic.FluxTubes.Sources.SignalMagneticPotentialDifference
    signalSource annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-20,10})));
  Modelica.Blocks.Sources.Ramp ramp(height=5, duration=1)
    annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
equation

  connect(signalSource.port_n, ground.port)
    annotation (Line(points={{-20,0},{-20,-20}}, color={255,127,0}));
  connect(genericFluxTube.port_n, ground.port) annotation (Line(points={{
          20,0},{20,-20},{-20,-20}}, color={255,127,0}));
  connect(hollowCylinderRadialFlux.port_n, ground.port) annotation (Line(
        points={{80,0},{80,-20},{-20,-20}}, color={255,127,0}));
  connect(hollowCylinderAxialFlux.port_n, ground.port) annotation (Line(
        points={{60,0},{60,-20},{-20,-20}}, color={255,127,0}));
  connect(cuboid.port_n, ground.port) annotation (Line(points={{40,0},{40,
          -20},{-20,-20}}, color={255,127,0}));
  connect(genericFluxTube.port_p, signalSource.port_p) annotation (Line(
        points={{20,20},{20,40},{-20,40},{-20,20}}, color={255,127,0}));
  connect(hollowCylinderRadialFlux.port_p, signalSource.port_p)
    annotation (Line(points={{80,20},{80,40},{-20,40},{-20,20}}, color={
          255,127,0}));
  connect(hollowCylinderAxialFlux.port_p, signalSource.port_p)
    annotation (Line(points={{60,20},{60,40},{-20,40},{-20,20}}, color={
          255,127,0}));
  connect(cuboid.port_p, signalSource.port_p) annotation (Line(points={{
          40,20},{40,40},{-20,40},{-20,20}}, color={255,127,0}));
  connect(ramp.y, signalSource.V_m)
    annotation (Line(points={{-39,10},{-29,10}}, color={0,0,127}));
  annotation (experiment(StartTime=0, StopTime=1, Interval=1e-3, Tolerance=1e-005));
end FixedShape;
