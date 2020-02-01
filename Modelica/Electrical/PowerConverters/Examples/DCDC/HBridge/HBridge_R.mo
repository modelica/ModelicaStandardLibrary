within Modelica.Electrical.PowerConverters.Examples.DCDC.HBridge;
model HBridge_R "H bridge DC/DC converter with resistive load"
  extends ExampleTemplates.HBridge;
  extends Modelica.Icons.Example;
  parameter SI.Resistance R=100 "Resistance";
  Modelica.Electrical.Analog.Basic.Resistor resistor(R=R) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={20,50})));
equation
  connect(resistor.p, hbridge.dc_p2) annotation (Line(
      points={{20,60},{20,70},{-30,70},{-30,6},{-40,6}}, color={0,0,255}));
  connect(resistor.n, currentSensor.p) annotation (Line(
      points={{20,40},{20,-6},{0,-6}}, color={0,0,255}));
  annotation (
    experiment(
      StopTime=0.1,
      Interval=0.0002,
      Tolerance=1e-06),
    Documentation(info="<html>
<p>This example demonstrates the switching on of a resistive load operated by an H bridge.
DC output voltage is equal to <code>2 * (dutyCycle - 0.5)</code> times the input voltage.
Plot current <code>currentSensor.i</code>, averaged current <code>meanCurrent.y</code>, total voltage <code>voltageSensor.v</code> and voltage <code>meanVoltage.v</code>.</p>
</html>"));
end HBridge_R;
