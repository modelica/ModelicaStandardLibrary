within Modelica.Electrical.PowerConverters.Examples.ACDC.RectifierBridge2Pulse;
model ThyristorBridge2Pulse_R
  "Two pulse Graetz thyristor bridge rectifier with resistive load"
  extends ExampleTemplates.ThyristorBridge2Pulse(pulse2(
        constantFiringAngle=constantFiringAngle));
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  parameter SI.Angle constantFiringAngle=30*pi/180
    "Firing angle";
  parameter SI.Resistance R=20 "Load resistance";
  Modelica.Electrical.Analog.Basic.Resistor resistor(R=R) annotation (
      Placement(transformation(
        origin={30,30},
        extent={{10,-10},{-10,10}},
        rotation=90)));
equation
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
<p>This examples shows a two pulse full controlled bridge example with resistive load. In case of resistive load the full controlled bridge shows the same output voltage as the
<a href=\"modelica://Modelica.Electrical.PowerConverters.Examples.ACDC.RectifierBridge2Pulse.HalfControlledBridge2Pulse\">half controlled bridge</a>.</p>

<p>Plot current <code>currentSensor.i</code>, average current <code>meanCurrent.y</code>, voltage <code>voltageSensor.v</code> and average voltage <code>meanVoltage.v</code>.</p>
</html>"));
end ThyristorBridge2Pulse_R;
