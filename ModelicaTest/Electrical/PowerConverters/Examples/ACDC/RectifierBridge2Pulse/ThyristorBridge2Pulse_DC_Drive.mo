within ModelicaTest.Electrical.PowerConverters.Examples.ACDC.RectifierBridge2Pulse;
model ThyristorBridge2Pulse_DC_Drive
  "Two pulse Graetz thyristor bridge feeding a DC drive"
  extends Modelica.Electrical.PowerConverters.Examples.ACDC.RectifierBridge2Pulse.ThyristorBridge2Pulse_DC_Drive;
  annotation (
    experiment(
      StopTime=15,
      Interval=0.0002,
      Tolerance=1e-006),
    TestCase(
      shouldPass = true,
      __MAPLib_ComparisonWindow={2.45, 2.55}),
    Documentation(info="<html>
<p>
In this example a PM excited DC machine is started with nominal torque at nominal speed. After 5 seconds, load torque is reduced to zero over a period of additional 10 seconds. At 15 seconds, the machine is operating at no load.
</p>

<p>
Plot torque <code>tau</code>, current <code>currentSensor.i</code> and average current <code>meanCurrent.y</code>. Also plot speed <code>w</code>, voltage <code>voltageSensor.v</code> and the average voltage <code>meanVoltage.y</code>.</p>
</html>"));
end ThyristorBridge2Pulse_DC_Drive;
