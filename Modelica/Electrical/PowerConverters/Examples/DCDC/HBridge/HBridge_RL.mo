within Modelica.Electrical.PowerConverters.Examples.DCDC.HBridge;
model HBridge_RL "H bridge DC/DC converter with R-L load"
  extends ExampleTemplates.HBridge;
  extends Modelica.Icons.Example;
  parameter SI.Resistance R=100 "Resistance";
  parameter SI.Inductance L=1 "Inductance";
  Modelica.Electrical.Analog.Basic.Resistor resistor(R=R) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={20,50})));
  Modelica.Electrical.Analog.Basic.Inductor inductor(i(fixed=true,
        start=0), L=L) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={20,10})));
equation
  connect(resistor.n, inductor.p) annotation (Line(
      points={{20,40},{20,20}}, color={0,0,255}));
  connect(inductor.n, currentSensor.p) annotation (Line(
      points={{20,0},{20,-6},{0,-6}}, color={0,0,255}));
  connect(resistor.p, hbridge.dc_p2) annotation (Line(
      points={{20,60},{20,70},{-30,70},{-30,6},{-40,6}}, color={0,0,255}));
  annotation (
    Documentation(info="<html>
<p>This example demonstrates the switching on of an R-L load operated by an H bridge.
DC output voltage is equal to <code>2 * (dutyCycle - 0.5)</code> times the input voltage.
Plot current <code>currentSensor.i</code>, averaged current <code>meanCurrent.y</code>, total voltage <code>voltageSensor.v</code> and voltage <code>meanVoltage.v</code>. The waveform the average current is determined by the time constant <code>L/R</code> of the load.</p>
</html>"),
    experiment(
      StopTime=0.1,
      Interval=0.0002,
      Tolerance=1e-06));
end HBridge_RL;
