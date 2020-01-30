within Modelica.Electrical.PowerConverters.Examples.ACDC.Rectifier1Pulse;
model Thyristor1Pulse_R
  "One pulse rectifier with resistive load and constant firing angle"
  extends ExampleTemplates.Thyristor1Pulse(pulse2(
      useConstantFiringAngle=true,
      f=f,
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
  connect(idealthyristor.n, resistor.p) annotation (Line(
      points={{0,40},{30,40}}, color={0,0,255}));
  connect(resistor.n, currentSensor.p) annotation (Line(
      points={{30,20},{30,-40},{10,-40}}, color={0,0,255}));
  annotation (
    experiment(
      StopTime=0.1,
      Tolerance=1e-06,
      Interval=0.0002),
    Documentation(info="<html>
<p>This example demonstrates the operational behavior of a single-phase controlled rectifier with constant firing angle and resistive load.</p>
<p>Plot current <code>currentSensor.i</code>, average current <code>meanCurrent.y</code>, voltage <code>voltageSensor.v</code> and average voltage <code>meanVoltage.v</code>.</p>
</html>"));
end Thyristor1Pulse_R;
