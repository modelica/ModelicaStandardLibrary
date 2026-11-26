within ModelicaTest.Magnetic.FluxTubes.Shapes;
model HysteresisAndMagnets
  extends Modelica.Icons.Example;
  Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets.GenericHystTellinenSoft
    Core(
    MagRel(fixed=true),
    Js=1.8,
    Br=0.9,
    Hc=120,
    K=1,
    derHstat(fixed=false)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,50})));
  Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets.GenericHystTellinenEverett
    Core2(
    MagRel(fixed=true),
    mat=Modelica.Magnetic.FluxTubes.Material.HysteresisEverettParameter.M330_50A(),
    derHstat(fixed=false)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={20,50})));

  Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets.GenericHystTellinenTable
    Core3(
    MagRel(fixed=true),
    mat=Modelica.Magnetic.FluxTubes.Material.HysteresisTableData.M330_50A(),
    derHstat(fixed=false)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={40,50})));

  Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets.GenericHystPreisachEverett
    Core4(
    MagRel(fixed=true),
    mat=Modelica.Magnetic.FluxTubes.Material.HysteresisEverettParameter.M330_50A(),
    derHstat(fixed=false)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={60,50})));

  Modelica.Magnetic.FluxTubes.Sources.SignalMagneticPotentialDifference
    signalSource annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-40,50})));
  Modelica.Blocks.Sources.Sine sine(amplitude=100, f=2)
    annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
  Modelica.Magnetic.FluxTubes.Basic.Ground ground
    annotation (Placement(transformation(extent={{-50,0},{-30,20}})));
  Modelica.Blocks.Sources.Sine sine1(f=2, amplitude=100000)
    annotation (Placement(transformation(extent={{-80,-60},{-60,-40}})));
  Modelica.Magnetic.FluxTubes.Sources.SignalMagneticPotentialDifference
    signalSource1 annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-40,-50})));
  Modelica.Magnetic.FluxTubes.Basic.Ground ground1
    annotation (Placement(transformation(extent={{-50,-100},{-30,-80}})));
  Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets.GenericHystTellinenHard
    Core1(derHstat(fixed=false), MagRel(fixed=true)) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-50})));
  Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets.GenericHystTellinenPermanentMagnet
    PM(MagRel(start=-1), derHstat(fixed=false)) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={20,-50})));
  Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets.GenericLinearPermanentMagnet
    PM1(mat=Modelica.Magnetic.FluxTubes.Material.HardMagnetic.NdFeB())
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={40,-50})));
equation

  connect(sine.y, signalSource.V_m)
    annotation (Line(points={{-59,50},{-49,50}}, color={0,0,127}));
  connect(ground.port, signalSource.port_n) annotation (Line(points={{-40,
          20},{-40,30},{-40,40}}, color={255,127,0}));
  connect(signalSource.port_p, Core.port_p) annotation (Line(points={{-40,
          60},{-40,80},{0,80},{0,60}}, color={255,127,0}));
  connect(Core2.port_p, Core.port_p) annotation (Line(points={{20,60},{20,
          80},{0,80},{0,60}}, color={255,127,0}));
  connect(Core3.port_p, Core.port_p) annotation (Line(points={{40,60},{40,
          80},{0,80},{0,60}}, color={255,127,0}));
  connect(Core4.port_p, Core.port_p) annotation (Line(points={{60,60},{60,
          80},{0,80},{0,60}}, color={255,127,0}));
  connect(Core.port_n, ground.port) annotation (Line(points={{0,40},{0,40},
          {0,20},{-40,20}}, color={255,127,0}));
  connect(Core2.port_n, ground.port) annotation (Line(points={{20,40},{20,
          20},{-40,20}}, color={255,127,0}));
  connect(Core3.port_n, ground.port) annotation (Line(points={{40,40},{40,
          20},{-40,20}}, color={255,127,0}));
  connect(Core4.port_n, ground.port) annotation (Line(points={{60,40},{60,
          20},{-40,20}}, color={255,127,0}));
  connect(sine1.y, signalSource1.V_m)
    annotation (Line(points={{-59,-50},{-49,-50}}, color={0,0,127}));
  connect(ground1.port, signalSource1.port_n) annotation (Line(points={{-40,
          -80},{-40,-70},{-40,-60}}, color={255,127,0}));
  connect(signalSource1.port_p, Core1.port_p) annotation (Line(points={{-40,
          -40},{-40,-20},{1.77636e-015,-20},{1.77636e-015,-40}}, color={255,
          127,0}));
  connect(Core1.port_n, ground1.port) annotation (Line(points={{
          -1.77636e-015,-60},{0,-60},{0,-80},{-40,-80}}, color={255,127,0}));
  connect(PM.port_p, Core1.port_p) annotation (Line(points={{20,-40},{20,
          -20},{1.77636e-015,-20},{1.77636e-015,-40}}, color={255,127,0}));
  connect(PM1.port_p, Core1.port_p) annotation (Line(points={{40,-40},{40,
          -20},{1.77636e-015,-20},{1.77636e-015,-40}}, color={255,127,0}));
  connect(PM.port_n, ground1.port) annotation (Line(points={{20,-60},{20,
          -80},{-40,-80}}, color={255,127,0}));
  connect(PM1.port_n, ground1.port) annotation (Line(points={{40,-60},{40,
          -80},{-40,-80}}, color={255,127,0}));
  annotation (experiment(StartTime=0, StopTime=1, Interval=1e-3, Tolerance=1e-005));
end HysteresisAndMagnets;
