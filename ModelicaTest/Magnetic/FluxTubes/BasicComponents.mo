within ModelicaTest.Magnetic.FluxTubes;
model BasicComponents
  "Test model with all components from Modelica.Magnetic.FluxTubes.Basic"
  extends Modelica.Icons.Example;
  Modelica.Magnetic.FluxTubes.Basic.Ground ground
    annotation (Placement(transformation(extent={{-30,-30},{-10,-10}})));
  Modelica.Magnetic.FluxTubes.Basic.ElectroMagneticConverter converter(N=1, i(
        start=0, fixed=true))
    annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
  Modelica.Magnetic.FluxTubes.Basic.ElectroMagneticConverterWithLeakageInductance
    converter1(N=1, i(fixed=true, start=0))
               annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
  Modelica.Magnetic.FluxTubes.Basic.ConstantReluctance constantReluctance
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={20,70})));
  Modelica.Magnetic.FluxTubes.Basic.LeakageWithCoefficient
    leakageWithCoefficient(c_usefulFlux=0.7, R_mUsefulTot=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,70})));
  Modelica.Magnetic.FluxTubes.Basic.EddyCurrent eddyCurrent(Phi(start=0,
        fixed=true))
    annotation (Placement(transformation(extent={{-10,10},{10,30}})));
  Modelica.Magnetic.FluxTubes.Basic.Idle idle annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={90,10})));
  Modelica.Magnetic.FluxTubes.Basic.Short short
    annotation (Placement(transformation(extent={{50,10},{70,30}})));
  Modelica.Magnetic.FluxTubes.Basic.Crossing crossing annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={30,10})));
  Modelica.Electrical.Analog.Basic.Ground ground1
    annotation (Placement(transformation(extent={{-90,30},{-70,50}})));
  Modelica.Electrical.Analog.Basic.Conductor conductor(G=1)
    annotation (Placement(transformation(extent={{-70,70},{-50,90}})));
  Modelica.Electrical.Analog.Sources.StepVoltage stepVoltage(V=1) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-80,70})));
  Modelica.Magnetic.FluxTubes.Basic.Ground ground2
    annotation (Placement(transformation(extent={{10,30},{30,50}})));
  Modelica.Electrical.Analog.Basic.Ground ground3
    annotation (Placement(transformation(extent={{-90,-30},{-70,-10}})));
  Modelica.Electrical.Analog.Basic.Conductor conductor1(G=1)
    annotation (Placement(transformation(extent={{-70,10},{-50,30}})));
  Modelica.Electrical.Analog.Sources.StepVoltage stepVoltage1(V=1) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-80,10})));
  Modelica.Magnetic.FluxTubes.Basic.ConstantPermeance constantPermeance
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={80,10})));
equation
  connect(ground1.p, stepVoltage.n) annotation (Line(
      points={{-80,50},{-80,60}}, color={0,0,255}));
  connect(stepVoltage.p, conductor.p) annotation (Line(
      points={{-80,80},{-70,80}}, color={0,0,255}));
  connect(conductor.n, converter.p) annotation (Line(
      points={{-50,80},{-40,80},{-40,80}}, color={0,0,255}));
  connect(converter.n, stepVoltage.n) annotation (Line(
      points={{-40,60},{-40,60},{-80,60}}, color={0,0,255}));
  connect(converter.port_p, leakageWithCoefficient.port_p) annotation (Line(
      points={{-20,80},{-20,80},{0,80}}, color={255,127,0}));
  connect(leakageWithCoefficient.port_p, constantReluctance.port_p) annotation (
     Line(
      points={{0,80},{20,80}}, color={255,127,0}));
  connect(constantReluctance.port_n, leakageWithCoefficient.port_n) annotation (
     Line(
      points={{20,60},{0,60}}, color={255,127,0}));
  connect(leakageWithCoefficient.port_n, converter.port_n) annotation (Line(
      points={{0,60},{-20,60},{-20,60}}, color={255,127,0}));
  connect(ground3.p, stepVoltage1.n) annotation (Line(
      points={{-80,-10},{-80,0}}, color={0,0,255}));
  connect(stepVoltage1.p, conductor1.p) annotation (Line(
      points={{-80,20},{-70,20}}, color={0,0,255}));
  connect(ground2.port, constantReluctance.port_n) annotation (Line(
      points={{20,50},{20,60}}, color={255,127,0}));
  connect(converter1.port_p, eddyCurrent.port_p) annotation (Line(
      points={{-20,20},{-20,20},{-10,20}}, color={255,127,0}));
  connect(conductor1.n, converter1.p) annotation (Line(
      points={{-50,20},{-40,20},{-40,20}}, color={0,0,255}));
  connect(converter1.n, stepVoltage1.n) annotation (Line(
      points={{-40,0.2},{-40,0},{-80,0}},
                                        color={0,0,255}));
  connect(ground.port, converter1.port_n) annotation (Line(
      points={{-20,-10},{-20,0}}, color={255,127,0}));
  connect(eddyCurrent.port_n, crossing.port_n2) annotation (Line(
      points={{10,20},{20,20}}, color={255,127,0}));
  connect(crossing.port_p2, short.port_p) annotation (Line(
      points={{40,20},{50,20}}, color={255,127,0}));
  connect(crossing.port_p1, converter1.port_n) annotation (Line(
      points={{20,0},{-20,0},{-20,0}}, color={255,127,0}));
  connect(constantPermeance.port_p, short.port_n) annotation (Line(
      points={{80,20},{70,20}}, color={255,127,0}));
  connect(constantPermeance.port_n, crossing.port_n1) annotation (Line(
      points={{80,0},{40,0}}, color={255,127,0}));
  connect(idle.port_p, short.port_n) annotation (Line(
      points={{90,20},{70,20}}, color={255,127,0}));
  connect(idle.port_n, constantPermeance.port_n) annotation (Line(
      points={{90,0},{80,0}}, color={255,127,0}));
  annotation (experiment(StartTime=0, StopTime=14, Interval=3e-3, Tolerance=1e-005));
end BasicComponents;
