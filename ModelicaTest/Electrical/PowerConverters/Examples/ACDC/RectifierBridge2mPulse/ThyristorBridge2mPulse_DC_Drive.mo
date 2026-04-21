within ModelicaTest.Electrical.PowerConverters.Examples.ACDC.RectifierBridge2mPulse;
model ThyristorBridge2mPulse_DC_Drive
  "2*m pulse thyristor bridge feeding a DC drive"
  extends Modelica.Electrical.PowerConverters.Examples.ACDC.RectifierBridge2mPulse.ThyristorBridge2mPulse_DC_Drive;
  annotation (
    experiment(
      StopTime=15,
      Interval=0.0002,
      Tolerance=1e-006,
      __MAPLib_ComparisonWindow={2.45, 2.55}),
    Documentation(info="<html>
<p>
In this example a PM excited DC machine is started with nominal torque at nominal speed. After 5 seconds, load torque is reduced to zero over a period of additional 10 seconds. At 15 seconds, the machine is operating at no load.
</p>

<p>Plot current <code>currentSensor.i</code>, average current <code>meanCurrent.y</code>, voltage <code>voltageSensor.v</code> and average voltage <code>meanVoltage.v</code>.</p>
</html>"));
end ThyristorBridge2mPulse_DC_Drive;
