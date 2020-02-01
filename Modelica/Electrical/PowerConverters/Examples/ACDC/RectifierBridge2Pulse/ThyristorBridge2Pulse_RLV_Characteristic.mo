within Modelica.Electrical.PowerConverters.Examples.ACDC.RectifierBridge2Pulse;
model ThyristorBridge2Pulse_RLV_Characteristic
  "Characteristic of two pulse Graetz thyristor bridge rectifier with R-L load and voltage"
  extends ExampleTemplates.ThyristorBridge2Pulse(pulse2(
        useConstantFiringAngle=false));
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  parameter SI.Voltage Vdi0=2/pi*sin(pi/2)*sqrt(2)*Vrms
    "Ideal max. DC voltage";
  parameter SI.Resistance R=20 "Load resistance";
  parameter SI.Inductance L=1 "Load resistance"
    annotation (Evaluate=true);
  parameter SI.Voltage VDC=-120 "DC load offset voltage";
  Modelica.Electrical.Analog.Basic.Resistor resistor(R=R) annotation (
      Placement(transformation(
        origin={30,30},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  Modelica.Electrical.Analog.Basic.Inductor inductor(L=L, i(fixed=true,
        start=0)) annotation (Placement(transformation(
        origin={30,0},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(V=
        VDC) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={30,-30})));
  Modelica.Blocks.Sources.Ramp ramp(height=pi, duration=10) annotation (
     Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={-30,-50})));
equation
  connect(resistor.n, inductor.p) annotation (Line(
      points={{30,20},{30,10}}, color={0,0,255}));
  connect(inductor.n, constantVoltage.p) annotation (Line(
      points={{30,-10},{30,-20}}, color={0,0,255}));
  connect(constantVoltage.n, currentSensor.p) annotation (Line(
      points={{30,-40},{10,-40}}, color={0,0,255}));
  connect(ramp.y, pulse2.firingAngle) annotation (Line(
      points={{-30,-39},{-30,-39},{-30,-14}}, color={0,0,127}));
  connect(resistor.p, rectifier.dc_p) annotation (Line(
      points={{30,40},{-10,40},{-10,40},{-20,40}}, color={0,0,255}));
  annotation (
    experiment(
      StopTime=10,
      Tolerance=1e-06,
      Interval=0.0002),
    Documentation(info="<html>

<p>This examples shows a two pulse full controlled bridge example with R-L load including DC voltage source. The additional DC voltage source in this example enables negative average load voltages.</p>

<p>Plot average voltage <code>meanVoltage.v</code> versus firingAngle <code>pulse2.firingAngle</code> to see control characteristic of this type of rectifier with R-L load including active voltage.</p>
</html>"));
end ThyristorBridge2Pulse_RLV_Characteristic;
