within Modelica.Electrical.PowerConverters.Examples.ACDC.RectifierBridge2mPulse;
model ThyristorBridge2mPulse_RLV
  "2*m pulse thyristor rectifier bridge with R-L load and voltage"
  extends ExampleTemplates.ThyristorBridge2mPulse(pulse2m(
        constantFiringAngle=constantFiringAngle));
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  parameter SI.Angle constantFiringAngle=30*pi/180
    "Firing angle";
  parameter SI.Resistance R=20 "Load resistance";
  parameter SI.Inductance L=1 "Load resistance"
    annotation (Evaluate=true);
  parameter SI.Voltage VDC=-260 "DC load offset voltage";
  Modelica.Electrical.Analog.Basic.Resistor resistor(R=R) annotation (
      Placement(transformation(
        origin={30,30},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  Modelica.Electrical.Analog.Basic.Inductor inductor(L=L, i(start=0,
        fixed=true)) annotation (Placement(transformation(
        origin={30,0},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(V=
        VDC) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={30,-30})));
equation
  connect(resistor.n, inductor.p) annotation (Line(
      points={{30,20},{30,10}}, color={0,0,255}));
  connect(inductor.n, constantVoltage.p) annotation (Line(
      points={{30,-10},{30,-20}}, color={0,0,255}));
  connect(constantVoltage.n, currentSensor.p) annotation (Line(
      points={{30,-40},{10,-40}}, color={0,0,255}));
  connect(resistor.p, rectifier.dc_p) annotation (Line(
      points={{30,40},{-10,40},{-10,40},{-20,40}}, color={0,0,255}));
  annotation (
    experiment(
      StopTime=0.1,
      Tolerance=1e-06,
      Interval=0.0002),
    Documentation(info="<html>
<p>This example shows a full controlled <code>2*m</code> pulse bridge rectifier with R-L load including DC voltage source, where <code>m</code> is the number of phases. The additional DC voltage source in this example enables negative average load voltages.</p>

<p>Plot current <code>currentSensor.i</code>, average current <code>meanCurrent.y</code>, voltage <code>voltageSensor.v</code> and average voltage <code>meanVoltage.v</code>.</p>
</html>"));
end ThyristorBridge2mPulse_RLV;
