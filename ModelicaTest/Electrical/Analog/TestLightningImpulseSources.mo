within ModelicaTest.Electrical.Analog;
model TestLightningImpulseSources "Test the lightning impulse sources"
  extends Modelica.Icons.Example;
  parameter Real eps = 1e-9;
  parameter Real amplitude=100;
  parameter Modelica.Units.SI.Time T1=10e-3;
  parameter Modelica.Units.SI.Time T2=350e-3;
  parameter Modelica.Units.SI.Time startTime=0.15;
  Modelica.Electrical.Analog.Sources.LightningImpulseVoltage impulseSource1(
    approximation=Modelica.Blocks.Types.ImpulseApproximation.DoubleExp,
    V=amplitude,
    T1=T1,
    T2=T2,
    startTime=startTime) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-20,70})));
  Modelica.Electrical.Analog.Sources.LightningImpulseVoltage impulseSource2(
    approximation=Modelica.Blocks.Types.ImpulseApproximation.Heidler,
    V=amplitude,
    T1=T1,
    T2=T2,
    startTime=startTime) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-20,30})));
  Modelica.Electrical.Analog.Sources.LightningImpulseCurrent impulseSource3(
    approximation=Modelica.Blocks.Types.ImpulseApproximation.DoubleExp,
    I=amplitude,
    T1=T1,
    T2=T2,
    startTime=startTime) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-20,-30})));
  Modelica.Electrical.Analog.Sources.LightningImpulseCurrent impulseSource4(
    approximation=Modelica.Blocks.Types.ImpulseApproximation.Heidler,
    I=amplitude,
    T1=T1,
    T2=T2,
    startTime=startTime) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-20,-70})));
  Modelica.Electrical.Analog.Basic.Ground ground1
    annotation (Placement(transformation(extent={{-10,40},{10,60}})));
  Modelica.Electrical.Analog.Basic.Ground ground2
    annotation (Placement(transformation(extent={{-10,0},{10,20}})));
  Modelica.Electrical.Analog.Basic.Ground ground3
    annotation (Placement(transformation(extent={{-10,-60},{10,-40}})));
  Modelica.Electrical.Analog.Basic.Ground ground4
    annotation (Placement(transformation(extent={{-10,-100},{10,-80}})));
  Modelica.Electrical.Analog.Basic.Resistor resistor1(R=1) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={20,70})));
  Modelica.Electrical.Analog.Basic.Resistor resistor2(R=1) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={20,30})));
  Modelica.Electrical.Analog.Basic.Resistor resistor3(R=1) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={20,-30})));
  Modelica.Electrical.Analog.Basic.Resistor resistor4(R=1) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={20,-70})));
equation
  when time>=startTime + T1 then
    assert(abs(resistor1.i - 0.9*amplitude)<eps, "Error impulseVoltageDoubleExp");
    assert(abs(resistor2.i - 0.9*amplitude)<eps, "Error impulseVoltageHeidler");
    assert(abs(resistor3.v - 0.9*amplitude)<eps, "Error impulseCurrentDoubleExp");
    assert(abs(resistor4.v - 0.9*amplitude)<eps, "Error impulseCurrentHeidler");
  end when;
  when time>=startTime + T2 then
    assert(abs(resistor1.i - 0.5*amplitude)<eps, "Error impulseVoltageDoubleExp");
    assert(abs(resistor2.i - 0.5*amplitude)<eps, "Error impulseVoltageHeidler");
    assert(abs(resistor3.v - 0.5*amplitude)<eps, "Error impulseCurrentDoubleExp");
    assert(abs(resistor4.v - 0.5*amplitude)<eps, "Error impulseCurrentHeidler");
  end when;
  connect(impulseSource4.p, ground4.p)
    annotation (Line(points={{-20,-80},{0,-80}}, color={0,0,255}));
  connect(ground4.p, resistor4.n)
    annotation (Line(points={{0,-80},{20,-80}}, color={0,0,255}));
  connect(impulseSource4.n, resistor4.p)
    annotation (Line(points={{-20,-60},{20,-60}}, color={0,0,255}));
  connect(impulseSource3.p, ground3.p)
    annotation (Line(points={{-20,-40},{0,-40}}, color={0,0,255}));
  connect(ground3.p, resistor3.n)
    annotation (Line(points={{0,-40},{20,-40}}, color={0,0,255}));
  connect(impulseSource3.n, resistor3.p)
    annotation (Line(points={{-20,-20},{20,-20}}, color={0,0,255}));
  connect(impulseSource2.n, ground2.p)
    annotation (Line(points={{-20,20},{0,20}}, color={0,0,255}));
  connect(ground2.p, resistor2.n)
    annotation (Line(points={{0,20},{20,20}}, color={0,0,255}));
  connect(impulseSource2.p, resistor2.p)
    annotation (Line(points={{-20,40},{20,40}}, color={0,0,255}));
  connect(impulseSource1.n, ground1.p)
    annotation (Line(points={{-20,60},{0,60}}, color={0,0,255}));
  connect(ground1.p, resistor1.n)
    annotation (Line(points={{0,60},{20,60}}, color={0,0,255}));
  connect(impulseSource1.p, resistor1.p)
    annotation (Line(points={{-20,80},{20,80}}, color={0,0,255}));
  annotation (experiment(
      StopTime=1,
      Interval=0.0001,
      Tolerance=1e-06), Documentation(info="<html>
<p>
This test compares lightning impulse voltage and current sources, both using a double-exponential and a Heidler function.
</p>
</html>"));
end TestLightningImpulseSources;
