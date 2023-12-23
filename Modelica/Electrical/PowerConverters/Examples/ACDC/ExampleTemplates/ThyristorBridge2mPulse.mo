within Modelica.Electrical.PowerConverters.Examples.ACDC.ExampleTemplates;
partial model ThyristorBridge2mPulse
  "Template of 2*m pulse bridge thyristor rectifier"
  extends Icons.ExampleTemplate;
  import Modelica.Constants.pi;
  parameter Integer m(final min=3) = 3 "Number of phases" annotation(Evaluate=true);
  parameter SI.Voltage Vrms=110 "RMS supply voltage";
  parameter SI.Frequency f=50 "Frequency";

  Modelica.Electrical.Polyphase.Sources.SineVoltage sineVoltage(
    final m=m,
    V=fill(sqrt(2)*Vrms, m),
    phase=-
        Modelica.Electrical.Polyphase.Functions.symmetricOrientation(m),
    f=fill(f, m)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-80,-30})));
  PowerConverters.ACDC.ThyristorBridge2mPulse rectifier(final m=m)
    annotation (Placement(transformation(extent={{-40,24},{-20,44}})));
  Modelica.Electrical.Analog.Sensors.VoltageSensor voltagesensor
    annotation (Placement(transformation(
        origin={50,10},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  Modelica.Blocks.Math.Mean meanVoltage(f=2*m*f) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        origin={80,40})));
  Modelica.Blocks.Math.RootMeanSquare rootMeanSquareVoltage(f=2*m*f)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={80,10})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={0,-40})));
  Modelica.Blocks.Math.Mean meanCurrent(f=2*m*f) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        origin={80,-60})));
  PowerConverters.ACDC.Control.VoltageBridge2mPulse pulse2m(
    m=m,
    f=f,
    useFilter=false) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-30,0})));
  Modelica.Electrical.Polyphase.Basic.MultiStarResistance
    multiStarResistance(final m=m) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-80,-60})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(extent={{-90,-100},{-70,-80}})));
equation
  connect(meanCurrent.u, currentSensor.i) annotation (Line(
      points={{68,-60},{0,-60},{0,-51}}, color={0,0,127}));
  connect(voltagesensor.v, meanVoltage.u) annotation (Line(
      points={{61,10},{64,10},{64,40},{68,40}}, color={0,0,127}));
  connect(voltagesensor.v, rootMeanSquareVoltage.u) annotation (Line(
      points={{61,10},{68,10}}, color={0,0,127}));
  connect(sineVoltage.plug_p, rectifier.ac) annotation (Line(
      points={{-80,-20},{-80,34},{-40,34}}, color={0,0,255}));
  connect(rectifier.dc_n, currentSensor.n) annotation (Line(
      points={{-20,28},{-10,28},{-10,-40}}, color={0,0,255}));
  connect(rectifier.dc_p, voltagesensor.p) annotation (Line(
      points={{-20,40},{50,40},{50,20}}, color={0,0,255}));
  connect(currentSensor.p, voltagesensor.n) annotation (Line(
      points={{10,-40},{50,-40},{50,0}}, color={0,0,255}));
  connect(pulse2m.fire_p, rectifier.fire_p) annotation (Line(
      points={{-36,11},{-36,22}}, color={255,0,255}));
  connect(pulse2m.fire_n, rectifier.fire_n) annotation (Line(
      points={{-24,11},{-24,22}}, color={255,0,255}));
  connect(pulse2m.ac, sineVoltage.plug_p) annotation (Line(
      points={{-40,0},{-80,0},{-80,-20}}, color={0,0,255}));
  connect(sineVoltage.plug_n, multiStarResistance.plug) annotation (
      Line(
      points={{-80,-40},{-80,-50}}, color={0,0,255}));
  connect(multiStarResistance.pin, ground.p) annotation (Line(
      points={{-80,-70},{-80,-80}}, color={0,0,255}));
  annotation (
    Documentation(info="<html>
<p>Template of
<a href=\"modelica:/Modelica.Electrical.PowerConverters.Examples.ACDC.RectifierBridge2mPulse\">
<code>2*m</code> pulse bridge rectifiers</a>, where <code>m</code> is the number of phases; load is not yet included.</p>
</html>"));
end ThyristorBridge2mPulse;
