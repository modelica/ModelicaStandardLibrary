within Modelica.Electrical.PowerConverters.Examples.ACDC.RectifierCenterTap2Pulse;
model DiodeCenterTap2Pulse
  "Two pulse diode rectifier with center tap with resistive load"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  parameter SI.Voltage Vrms=110 "RMS supply voltage";
  parameter SI.Frequency f=50 "Frequency";
  parameter SI.Resistance R=20 "Load resistance";

  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(
        origin={-90,-50},
        extent={{-10,-10},{10,10}})));
  Modelica.Electrical.Analog.Sources.SineVoltage sinevoltage_n(V=sqrt(2)
        *Vrms,f=f) annotation (Placement(transformation(
        origin={-80,-13.9999},
        extent={{-9.999890000000001,-10},{10,10}},
        rotation=-90)));
  Modelica.Electrical.Analog.Sources.SineVoltage sinevoltage_p(V=sqrt(2)
        *Vrms,f=f) annotation (Placement(transformation(
        origin={-80,14},
        extent={{-10,-10},{10,10}},
        rotation=-90)));
  PowerConverters.ACDC.DiodeCenterTap2Pulse rectifier
    annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
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
  Modelica.Electrical.Analog.Basic.Resistor resistor(R=R) annotation (
      Placement(transformation(
        origin={30,30},
        extent={{10,-10},{-10,10}},
        rotation=90)));
equation
  connect(meanCurrent.u, currentSensor.i) annotation (Line(
      points={{68,-60},{0,-60},{0,-51}}, color={0,0,127}));
  connect(voltagesensor.v, meanVoltage.u) annotation (Line(
      points={{61,10},{64,10},{64,40},{68,40}}, color={0,0,127}));
  connect(voltagesensor.v, rootMeanSquareVoltage.u) annotation (Line(
      points={{61,10},{68,10}}, color={0,0,127}));
  connect(sinevoltage_p.n, sinevoltage_n.p) annotation (Line(
      points={{-80,4},{-80,-4.00001}}, color={0,0,255}));
  connect(ground.p, sinevoltage_p.n) annotation (Line(
      points={{-90,-40},{-90,0},{-80,0},{-80,4}}, color={0,0,255}));
  connect(sinevoltage_p.p, rectifier.ac_p) annotation (Line(
      points={{-80,24},{-80,46},{-40,46}}, color={0,0,255}));
  connect(sinevoltage_n.n, rectifier.ac_n) annotation (Line(
      points={{-80,-23.9999},{-80,-32},{-50,-32},{-50,34},{-40,34}}, color={0,0,255}));
  connect(ground.p, currentSensor.n) annotation (Line(
      points={{-90,-40},{-10,-40}}, color={0,0,255}));
  connect(currentSensor.p, voltagesensor.n) annotation (Line(
      points={{10,-40},{50,-40},{50,0}}, color={0,0,255}));
  connect(voltagesensor.p, rectifier.dc_p) annotation (Line(
      points={{50,20},{50,40},{-20,40}}, color={0,0,255}));
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
<p>This example shows an uncontrolled two pulse center tap diode rectifier with resistive load.</p>

<p>Plot current <code>currentSensor.i</code>, average current <code>meanCurrent.y</code>, voltage <code>voltageSensor.v</code> and average voltage <code>meanVoltage.v</code>.</p>
</html>"));
end DiodeCenterTap2Pulse;
