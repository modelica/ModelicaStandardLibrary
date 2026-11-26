within ModelicaTest.Magnetic.FluxTubes.Shapes;
model Leakage
  extends Modelica.Icons.Example;
  Modelica.Magnetic.FluxTubes.Shapes.Leakage.QuarterCylinder
    quarterCylinder(l=0.1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-60,-10})));
  Modelica.Magnetic.FluxTubes.Shapes.Leakage.QuarterHollowCylinder
    quarterHollowCylinder(l=0.1, ratio=1) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-40,-10})));
  Modelica.Magnetic.FluxTubes.Shapes.Leakage.HalfCylinder halfCylinder(l=
        0.1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-20,-10})));
  Modelica.Magnetic.FluxTubes.Shapes.Leakage.HalfHollowCylinder
    halfHollowCylinder(l=0.1, ratio=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-10})));
  Modelica.Magnetic.FluxTubes.Shapes.Leakage.QuarterSphere quarterSphere(r=
        0.005) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={20,-10})));
  Modelica.Magnetic.FluxTubes.Shapes.Leakage.QuarterHollowSphere
    quarterHollowSphere(t=0.01) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={40,-10})));
  Modelica.Magnetic.FluxTubes.Shapes.Leakage.EighthOfSphere eighthOfSphere(
      r=0.01) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={60,-10})));
  Modelica.Magnetic.FluxTubes.Shapes.Leakage.EighthOfHollowSphere
    eighthOfHollowSphere(t=0.01) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={80,-10})));
  Modelica.Magnetic.FluxTubes.Shapes.Leakage.CoaxCylindersEndFaces
    coaxCylindersEndFaces(
    r_0=10e-3,
    r_1=17e-3,
    r_2=20e-3) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={100,-10})));
  Modelica.Magnetic.FluxTubes.Sources.ConstantMagneticPotentialDifference
    constantSource(V_m=10) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-100,-10})));
  Modelica.Magnetic.FluxTubes.Basic.Ground ground
    annotation (Placement(transformation(extent={{-110,-60},{-90,-40}})));
equation

  connect(ground.port, constantSource.port_n) annotation (Line(points={{
          -100,-40},{-100,-30},{-100,-20}}, color={255,127,0}));
  connect(constantSource.port_p, coaxCylindersEndFaces.port_p) annotation (
      Line(points={{-100,0},{-100,20},{100,20},{100,0}}, color={255,127,0}));
  connect(eighthOfHollowSphere.port_p, coaxCylindersEndFaces.port_p)
    annotation (Line(points={{80,0},{80,20},{100,20},{100,0}}, color={255,
          127,0}));
  connect(eighthOfSphere.port_p, coaxCylindersEndFaces.port_p) annotation (
      Line(points={{60,0},{60,20},{100,20},{100,0}}, color={255,127,0}));
  connect(quarterHollowSphere.port_p, coaxCylindersEndFaces.port_p)
    annotation (Line(points={{40,0},{40,20},{100,20},{100,0}}, color={255,
          127,0}));
  connect(quarterSphere.port_p, coaxCylindersEndFaces.port_p) annotation (
      Line(points={{20,0},{20,20},{100,20},{100,0}}, color={255,127,0}));
  connect(halfHollowCylinder.port_p, coaxCylindersEndFaces.port_p)
    annotation (Line(points={{1.77636e-015,0},{0,20},{100,20},{100,0}}, color={255,127,0}));
  connect(halfCylinder.port_p, coaxCylindersEndFaces.port_p) annotation (
      Line(points={{-20,0},{-20,20},{100,20},{100,0}}, color={255,127,0}));
  connect(quarterHollowCylinder.port_p, coaxCylindersEndFaces.port_p)
    annotation (Line(points={{-40,0},{-40,20},{100,20},{100,0}}, color={255,
          127,0}));
  connect(quarterCylinder.port_p, coaxCylindersEndFaces.port_p) annotation (
     Line(points={{-60,0},{-60,20},{100,20},{100,0}}, color={255,127,0}));
  connect(coaxCylindersEndFaces.port_n, ground.port) annotation (Line(
        points={{100,-20},{100,-40},{-100,-40}}, color={255,127,0}));
  connect(quarterCylinder.port_n, ground.port) annotation (Line(points={{
          -60,-20},{-60,-40},{-100,-40}}, color={255,127,0}));
  connect(quarterHollowCylinder.port_n, ground.port) annotation (Line(
        points={{-40,-20},{-40,-40},{-100,-40}}, color={255,127,0}));
  connect(halfCylinder.port_n, ground.port) annotation (Line(points={{-20,
          -20},{-20,-40},{-100,-40}}, color={255,127,0}));
  connect(halfHollowCylinder.port_n, ground.port) annotation (Line(points={
          {-1.77636e-015,-20},{0,-40},{-100,-40}}, color={255,127,0}));
  connect(quarterSphere.port_n, ground.port) annotation (Line(points={{20,
          -20},{20,-40},{-100,-40}}, color={255,127,0}));
  connect(quarterHollowSphere.port_n, ground.port) annotation (Line(points=
          {{40,-20},{40,-40},{-100,-40}}, color={255,127,0}));
  connect(eighthOfSphere.port_n, ground.port) annotation (Line(points={{60,
          -20},{60,-40},{-100,-40}}, color={255,127,0}));
  connect(eighthOfHollowSphere.port_n, ground.port) annotation (Line(points=
         {{80,-20},{80,-40},{-100,-40}}, color={255,127,0}));
  annotation (experiment(StartTime=0, StopTime=1, Interval=1e-3, Tolerance=1e-005));
end Leakage;
