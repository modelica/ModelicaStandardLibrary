within Modelica.Electrical.PowerConverters.Examples.ACDC.RectifierBridge2Pulse;
model HalfControlledBridge2Pulse
  "Two pulse Graetz half controlled bridge with resistive load"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  parameter SI.Voltage Vrms=110 "RMS supply voltage";
  parameter SI.Frequency f=50 "Frequency";
  parameter SI.Angle constantFiringAngle=30*pi/180
    "Firing angle";
  parameter SI.Resistance R=20 "Load resistance";

  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(
        origin={-80,-50},
        extent={{-10,-10},{10,10}})));
  Modelica.Electrical.Analog.Sources.SineVoltage sinevoltage(V=sqrt(2)*
        Vrms, f=f) annotation (Placement(transformation(
        origin={-80,20},
        extent={{-10,-10},{10,10}},
        rotation=-90)));
  PowerConverters.ACDC.HalfControlledBridge2Pulse rectifier(useHeatPort=false,
      offStart_p1=true)
    annotation (Placement(transformation(extent={{-40,24},{-20,44}})));
  Modelica.Electrical.Analog.Sensors.VoltageSensor voltagesensor
    annotation (Placement(transformation(
        origin={50,10},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  Modelica.Blocks.Math.Mean meanVoltage(f=2*f) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        origin={80,40})));
  Modelica.Blocks.Math.RootMeanSquare rootMeanSquareVoltage(f=2*f)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={80,10})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={0,-40})));
  Modelica.Blocks.Math.Mean meanCurrent(f=2*f) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        origin={80,-60})));
  PowerConverters.ACDC.Control.VoltageBridge2Pulse pulse2(
    f=f,
    useFilter=false,
    constantFiringAngle=constantFiringAngle) annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-30,-2})));
  Modelica.Electrical.Analog.Basic.Resistor resistor(R=R) annotation (
      Placement(transformation(
        origin={30,30},
        extent={{10,-10},{-10,10}},
        rotation=90)));
equation
  connect(meanCurrent.u, currentSensor.i) annotation (Line(
      points={{68,-60},{0,-60},{0,-51}}, color={0,0,127}));
  connect(ground.p, sinevoltage.n) annotation (Line(
      points={{-80,-40},{-80,10}}, color={0,0,255}));
  connect(voltagesensor.v, meanVoltage.u) annotation (Line(
      points={{61,10},{64,10},{64,40},{68,40}}, color={0,0,127}));
  connect(voltagesensor.v, rootMeanSquareVoltage.u) annotation (Line(
      points={{61,10},{68,10}}, color={0,0,127}));
  connect(sinevoltage.p, rectifier.ac_p) annotation (Line(
      points={{-80,30},{-80,40},{-40,40}}, color={0,0,255}));
  connect(sinevoltage.n, rectifier.ac_n) annotation (Line(
      points={{-80,10},{-80,10},{-80,-8},{-50,-8},{-50,28},{-40,28}}, color={0,0,255}));
  connect(rectifier.dc_n, currentSensor.n) annotation (Line(
      points={{-20,28},{-10,28},{-10,-40}},   color={0,0,255}));
  connect(rectifier.dc_p, voltagesensor.p) annotation (Line(
      points={{-20,40},{50,40},{50,20}}, color={0,0,255}));
  connect(voltagesensor.n, currentSensor.p) annotation (Line(
      points={{50,0},{50,-40},{10,-40}}, color={0,0,255}));
  connect(pulse2.fire_p, rectifier.fire_p) annotation (Line(
      points={{-36,9},{-36,22}}, color={255,0,255}));
  connect(pulse2.fire_n, rectifier.fire_n) annotation (Line(
      points={{-24,9},{-24,22}}, color={255,0,255}));
  connect(pulse2.ac_p, rectifier.ac_p) annotation (Line(
      points={{-40,4},{-60,4},{-60,40},{-40,40}}, color={0,0,255}));
  connect(rectifier.ac_n, pulse2.ac_n) annotation (Line(
      points={{-40,28},{-50,28},{-50,-8},{-40,-8}}, color={0,0,255}));
  connect(resistor.n, currentSensor.p) annotation (Line(
      points={{30,20},{30,-40},{10,-40}}, color={0,0,255}));
  connect(resistor.p, rectifier.dc_p) annotation (Line(
      points={{30,40},{-20,40}}, color={0,0,255}));
  annotation (
    experiment(
      StopTime=0.1,
      Tolerance=1e-06,
      Interval=0.0002),
    Documentation(info="<html>
<p>This examples shows a two pulse half controlled bridge example with resistive load. In case of resistive load the half controlled bridge shows the same output voltage as the
<a href=\"modelica:/Modelica.Electrical.PowerConverters.Examples.ACDC.RectifierBridge2Pulse.ThyristorBridge2Pulse_R\">full controlled bridge</a>.</p>

<p>Plot current <code>currentSensor.i</code>, average current <code>meanCurrent.y</code>, voltage <code>voltageSensor.v</code> and average voltage <code>meanVoltage.v</code>.</p>
</html>"));
end HalfControlledBridge2Pulse;
