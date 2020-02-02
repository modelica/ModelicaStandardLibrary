within Modelica.Electrical.PowerConverters.Examples.ACDC.RectifierCenterTap2mPulse;
model DiodeCenterTap2mPulse
  "2*m pulse diode center tap rectifier with resistive load"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  parameter Integer m(final min=3) = 3 "Number of phases" annotation(Evaluate=true);
  parameter SI.Voltage Vrms=110 "RMS supply voltage";
  parameter SI.Frequency f=50 "Frequency";
  parameter SI.Resistance R=20 "Load resistance";

  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(extent={{-90,-100},{-70,-80}})));
  Modelica.Electrical.Polyphase.Basic.Star star(final m=m) annotation (
     Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-100,-10})));
  Modelica.Electrical.Polyphase.Sources.SineVoltage sineVoltage_p(
    final m=m,
    V=fill(sqrt(2)*Vrms, m),
    phase=-
        Modelica.Electrical.Polyphase.Functions.symmetricOrientation(m),
    f=fill(f, m)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-70,10})));
  PowerConverters.ACDC.DiodeCenterTap2mPulse rectifier(final m=m)
    annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
  Modelica.Electrical.Analog.Sensors.VoltageSensor voltagesensor
    annotation (Placement(transformation(
        origin={50,10},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  Modelica.Blocks.Math.Mean meanVoltage(f=2*m*f) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        origin={80,40})));
  Modelica.Blocks.Math.RootMeanSquare rootMeanSquareVoltage(f=2*m*f)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={80,10})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={0,-50})));
  Modelica.Blocks.Math.Mean meanCurrent(f=2*m*f) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        origin={80,-70})));
  Modelica.Electrical.Polyphase.Sources.SineVoltage sineVoltage_n(
    final m=m,
    V=fill(sqrt(2)*Vrms, m),
    phase=-
        Modelica.Electrical.Polyphase.Functions.symmetricOrientation(m),
    f=fill(f, m)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-70,-20})));
  Modelica.Electrical.Analog.Basic.Resistor resistor(R=R) annotation (
      Placement(transformation(
        origin={30,30},
        extent={{10,-10},{-10,10}},
        rotation=90)));
equation
  connect(star.pin_n, ground.p) annotation (Line(
      points={{-100,-20},{-100,-50},{-80,-50},{-80,-80}}, color={0,0,255}));
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
  connect(sineVoltage_p.plug_n, sineVoltage_n.plug_p) annotation (Line(
      points={{-70,0},{-70,
          -10}}, color={0,0,255}));
  connect(sineVoltage_n.plug_n, rectifier.ac_n) annotation (Line(
      points={{-70,-30},{-70,-40},{-50,-40},{-50,34},{-40,34}}, color={0,0,255}));
  connect(sineVoltage_p.plug_p, rectifier.ac_p) annotation (Line(
      points={{-70,20},{-70,46},{-40,46}}, color={0,0,255}));
  connect(star.plug_p, sineVoltage_p.plug_n) annotation (Line(
      points={{-100,0},{-70,0}}, color={0,0,255}));
  connect(star.pin_n, currentSensor.n) annotation (Line(
      points={{-100,-20},{-100,-50},{-10,-50}}, color={0,0,255}));
  connect(resistor.n, currentSensor.p) annotation (Line(
      points={{30,20},{30,-50},{10,-50}}, color={0,0,255}));
  connect(resistor.p, rectifier.dc_p) annotation (Line(
      points={{30,40},{-20,40}}, color={0,0,255}));
  annotation (
    experiment(
      StopTime=0.1,
      Tolerance=1e-06,
      Interval=0.0002),
    Documentation(info="<html>
<p>This example shows an uncontrolled <code>2*m</code> pulse center tap diode rectifier with resistive load, where <code>m</code> is the number of phases.</p>

<p>Plot current <code>currentSensor.i</code>, average current <code>meanCurrent.y</code>, voltage <code>voltageSensor.v</code> and average voltage <code>meanVoltage.v</code>.</p>
</html>"));
end DiodeCenterTap2mPulse;
