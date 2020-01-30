within Modelica.Electrical.PowerConverters.Examples.DCAC.SinglePhaseTwoLevel;
model SinglePhaseTwoLevel_RL
  "Single-phase DC to AC converter with R-L load"
  extends ExampleTemplates.SinglePhaseTwoLevel(sine(
      amplitude=0.5,
      offset=0.5,
      f=f1));
  extends Modelica.Icons.Example;
  parameter SI.Resistance R=100 "Resistance";
  parameter SI.Inductance L=1 "Inductance";
  parameter SI.Frequency f1=50 "AC frequency";
  Modelica.Electrical.Analog.Basic.Resistor resistor(R=R) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={40,10})));
  Modelica.Electrical.Analog.Basic.Inductor inductor(L=L, i(fixed=true))
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={40,-22})));
equation
  connect(resistor.p, inverter.ac) annotation (Line(
      points={{40,20},{40,30},{-30,30}}, color={0,0,255}));
  connect(resistor.n, inductor.p) annotation (Line(
      points={{40,0},{40,-12}}, color={0,0,255}));
  connect(inductor.n, currentSensor.p) annotation (Line(
      points={{40,-32},{40,-70},{10,-70}}, color={0,0,255}));
  annotation (
    experiment(
      StartTime=0,
      StopTime=0.1,
      Tolerance=1e-06,
      Interval=0.0002),
    Documentation(info="<html>
<p>Plot current <code>currentSensor.i</code>, average current <code>meanCurrent.y</code>, voltage <code>voltageSensor.v</code> and average voltage <code>meanVoltage.v</code>. The instantaneous voltage directly show the switch pattern of the inverter. The current shows a particular ripple determined by the input voltage and the switching frequency. The average voltage is basically in phase with the command <code>sine.y</code>. The average current has a phase shift due to the R-L load.</p>
</html>"));
end SinglePhaseTwoLevel_RL;
