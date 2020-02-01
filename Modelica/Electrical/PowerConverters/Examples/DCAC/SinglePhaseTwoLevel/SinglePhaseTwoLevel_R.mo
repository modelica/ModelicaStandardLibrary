within Modelica.Electrical.PowerConverters.Examples.DCAC.SinglePhaseTwoLevel;
model SinglePhaseTwoLevel_R
  "Single-phase DC to AC converter with resistive load"
  extends ExampleTemplates.SinglePhaseTwoLevel(sine(
      amplitude=0.5,
      offset=0.5,
      f=f1));
  extends Modelica.Icons.Example;
  parameter SI.Resistance R=100 "Resistance";
  parameter SI.Frequency f1=50 "AC frequency";
  Modelica.Electrical.Analog.Basic.Resistor resistor(R=R) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={40,10})));
equation
  connect(resistor.p, inverter.ac) annotation (Line(
      points={{40,20},{40,30},{-30,30}}, color={0,0,255}));
  connect(resistor.n, currentSensor.p) annotation (Line(
      points={{40,0},{40,-70},{10,-70}}, color={0,0,255}));
  annotation (
    experiment(
      StartTime=0,
      StopTime=0.1,
      Tolerance=1e-06,
      Interval=0.0002),
    Documentation(info="<html>
<p>Plot current <code>currentSensor.i</code>, average current <code>meanCurrent.y</code>, voltage <code>voltageSensor.v</code> and average voltage <code>meanVoltage.v</code>. The instantaneous voltage and current directly show the switch pattern of the inverter. The average voltage and average current reveal the fundamental wave of the voltage and current, each of them being basically in phase with the command <code>sine.y</code>.</p>
</html>"));
end SinglePhaseTwoLevel_R;
