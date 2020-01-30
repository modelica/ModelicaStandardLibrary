within Modelica.Electrical.PowerConverters.Examples.ACDC.Rectifier1Pulse;
model Thyristor1Pulse_R_Characteristic
  "Control characteristic of one pulse rectifier with resistive load"
  extends ExampleTemplates.Thyristor1Pulse(pulse2(
        useConstantFiringAngle=false, f=f));
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  parameter SI.Resistance R=20 "Load resistance";
  Modelica.Electrical.Analog.Basic.Resistor resistor(R=R) annotation (
      Placement(transformation(
        origin={30,30},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  Modelica.Blocks.Sources.Ramp ramp(height=pi, duration=10) annotation (
     Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={-40,-70})));
equation
  connect(resistor.n, currentSensor.p) annotation (Line(
      points={{30,20},{30,-40},{10,-40}}, color={0,0,255}));
  connect(resistor.p, idealthyristor.n) annotation (Line(
      points={{30,40},{0,40}}, color={0,0,255}));
  connect(ramp.y, pulse2.firingAngle) annotation (Line(
      points={{-40,-59},{-40,-12}}, color={0,0,127}));
  annotation (
    experiment(
      StopTime=10,
      Tolerance=1e-06,
      Interval=0.0002),
    Documentation(info="<html>
<p>This example demonstrates the operational behavior of a single-phase controlled rectifier with variable firing angle and resistive load. The average load voltage can be controlled by means of the firing angle.</p>
<p><br>Plot average voltage <code>meanVoltage.v</code> versus firingAngle <code>pulse2.firingAngle</code> to see control characteristic of this type of rectifier with resistive load.</p>
</html>"));
end Thyristor1Pulse_R_Characteristic;
