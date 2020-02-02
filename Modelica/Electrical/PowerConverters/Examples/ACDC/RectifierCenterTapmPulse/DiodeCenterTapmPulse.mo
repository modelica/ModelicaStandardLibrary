within Modelica.Electrical.PowerConverters.Examples.ACDC.RectifierCenterTapmPulse;
model DiodeCenterTapmPulse
  "2*m pulse diode rectifier with center tap with resistive load"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  parameter Integer m(final min=3) = 3 "Number of phases" annotation(Evaluate=true);
  parameter SI.Voltage Vrms=110 "RMS supply voltage";
  parameter SI.Frequency f=50 "Frequency";
  parameter SI.Resistance R=20 "Load resistance";

  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(extent={{-80,-100},{-60,-80}})));
  Modelica.Electrical.Polyphase.Basic.Star star(final m=m) annotation (
     Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-70,-30})));
  Modelica.Electrical.Polyphase.Sources.SineVoltage sineVoltage_p(
    final m=m,
    V=fill(sqrt(2)*Vrms, m),
    phase=-
        Modelica.Electrical.Polyphase.Functions.symmetricOrientation(m),
    f=fill(f, m)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-70,10})));
  PowerConverters.ACDC.DiodeCenterTapmPulse rectifier(final m=m)
    annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
  Modelica.Electrical.Analog.Sensors.VoltageSensor voltagesensor
    annotation (Placement(transformation(
        origin={50,10},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  Modelica.Blocks.Math.Mean meanVoltage(f=m*f) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        origin={80,40})));
  Modelica.Blocks.Math.RootMeanSquare rootMeanSquareVoltage(f=m*f)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={80,10})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={0,-50})));
  Modelica.Blocks.Math.Mean meanCurrent(f=m*f) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        origin={80,-70})));
  Modelica.Electrical.Analog.Basic.Resistor resistor(R=R) annotation (
      Placement(transformation(
        origin={30,30},
        extent={{10,-10},{-10,10}},
        rotation=90)));
equation
  connect(star.pin_n, ground.p) annotation (Line(
      points={{-70,-40},{-70,-80}}, color={0,0,255}));
  connect(meanCurrent.u, currentSensor.i) annotation (Line(
      points={{68,-70},{0,-70},{0,-60}}, color={0,0,127}));
  connect(voltagesensor.v, meanVoltage.u) annotation (Line(
      points={{60,10},{64,10},{64,40},{68,40}}, color={0,0,127}));
  connect(voltagesensor.v, rootMeanSquareVoltage.u) annotation (Line(
      points={{60,10},{68,10}}, color={0,0,127}));
  connect(rectifier.dc_p, voltagesensor.p) annotation (Line(
      points={{-20,40},{50,40},{50,20}}, color={0,0,255}));
  connect(currentSensor.p, voltagesensor.n) annotation (Line(
      points={{10,-50},{50,-50},{50,0}}, color={0,0,255}));
  connect(star.plug_p, sineVoltage_p.plug_n) annotation (Line(
      points={{-70,-20},{-70,0}}, color={0,0,255}));
  connect(star.pin_n, currentSensor.n) annotation (Line(
      points={{-70,-40},{-70,-50},{-10,-50}}, color={0,0,255}));
  connect(rectifier.ac, sineVoltage_p.plug_p) annotation (Line(
      points={{-40,40},{-70,40},{-70,20}}, color={0,0,255}));
  connect(resistor.n, currentSensor.p) annotation (Line(
      points={{30,20},{30,-50},{10,-50}}, color={0,0,255}));
  connect(rectifier.dc_p, resistor.p) annotation (Line(
      points={{-20,40},{30,40}}, color={0,0,255}));
  annotation (
    experiment(
      StopTime=0.1,
      Tolerance=1e-06,
      Interval=0.0002),
    Documentation(info="<html>
<p>This example shows an uncontrolled <code>m</code> pulse center tap diode rectifier with resistive load, where <code>m</code> is the number of phases.</p>

<p>Plot current <code>currentSensor.i</code>, average current <code>meanCurrent.y</code>, voltage <code>voltageSensor.v</code> and average voltage <code>meanVoltage.v</code>.</p>
</html>"));
end DiodeCenterTapmPulse;
