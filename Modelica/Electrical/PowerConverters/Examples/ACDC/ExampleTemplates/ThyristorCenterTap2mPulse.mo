within Modelica.Electrical.PowerConverters.Examples.ACDC.ExampleTemplates;
partial model ThyristorCenterTap2mPulse
  "Template of 2*m pulse thyristor rectifier with center tap"
  extends Icons.ExampleTemplate;
  import Modelica.Constants.pi;
  parameter Integer m(final min=3) = 3 "Number of phases" annotation(Evaluate=true);
  parameter SI.Voltage Vrms=110 "RMS supply voltage";
  parameter SI.Frequency f=50 "Frequency";

  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(extent={{-90,-100},{-70,-80}})));
  Modelica.Electrical.Polyphase.Basic.Star star(final m=m) annotation (
     Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-100,-10})));
  Modelica.Electrical.Polyphase.Sources.SineVoltage sineVoltage_p(
    final m=m,
    V=fill(sqrt(2)*Vrms, m),
    phase=-
        Modelica.Electrical.Polyphase.Functions.symmetricOrientation(m),
    f=fill(f, m)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-70,10})));
  PowerConverters.ACDC.ThyristorCenterTap2mPulse rectifier(final m=m)
    annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
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
        origin={0,-50})));
  Modelica.Blocks.Math.Mean meanCurrent(f=2*m*f) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        origin={80,-70})));
  PowerConverters.ACDC.Control.VoltageCenterTap2mPulse pulse2m(
    m=m,
    f=f,
    useFilter=false) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-30,0})));
  Modelica.Electrical.Polyphase.Sources.SineVoltage sineVoltage_n(
    final m=m,
    V=fill(sqrt(2)*Vrms, m),
    phase=-
        Modelica.Electrical.Polyphase.Functions.symmetricOrientation(m),
    f=fill(f, m)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-70,-20})));
equation
  connect(star.pin_n, ground.p) annotation (Line(
      points={{-100,-20},{-100,-50},{-80,-50},{-80,-80}}, color={0,0,255}));
  connect(meanCurrent.u, currentSensor.i) annotation (Line(
      points={{68,-70},{0,-70},{0,-61}}, color={0,0,127}));
  connect(voltagesensor.v, meanVoltage.u) annotation (Line(
      points={{61,10},{64,10},{64,40},{68,40}}, color={0,0,127}));
  connect(voltagesensor.v, rootMeanSquareVoltage.u) annotation (Line(
      points={{61,10},{68,10}}, color={0,0,127}));
  connect(rectifier.dc_p, voltagesensor.p) annotation (Line(
      points={{-20,40},{50,40},{50,20}}, color={0,0,255}));
  connect(currentSensor.p, voltagesensor.n) annotation (Line(
      points={{10,-50},{50,-50},{50,0}}, color={0,0,255}));
  connect(pulse2m.fire_p, rectifier.fire_p) annotation (Line(
      points={{-36,11},{-36,28}}, color={255,0,255}));
  connect(pulse2m.ac, sineVoltage_p.plug_p) annotation (Line(
      points={{-40,0},{-46,0},{-46,46},{-70,46},{-70,
          20}}, color={0,0,255}));
  connect(sineVoltage_p.plug_n, sineVoltage_n.plug_p) annotation (Line(
      points={{-70,0},{-70,
          -10}}, color={0,0,255}));
  connect(sineVoltage_n.plug_n, rectifier.ac_n) annotation (Line(
      points={{-70,-30},{-70,-40},{-50,-40},{-50,34},{-40,34}}, color={0,0,255}));
  connect(sineVoltage_p.plug_p, rectifier.ac_p) annotation (Line(
      points={{-70,20},{-70,46},{-40,46}}, color={0,0,255}));
  connect(star.plug_p, sineVoltage_p.plug_n) annotation (Line(
      points={{-100,0},{-70,0}}, color={0,0,255}));
  connect(star.pin_n, currentSensor.n) annotation (Line(
      points={{-100,-20},{-100,-50},{-10,-50}}, color={0,0,255}));
  connect(pulse2m.fire_n, rectifier.fire_n) annotation (Line(
      points={{-24,11},{-24,28}}, color={255,0,255}));
  annotation (
    Documentation(info="<html>
<p>Template of
<a href=\"modelica://Modelica.Electrical.PowerConverters.Examples.ACDC.RectifierCenterTap2mPulse\">
center tap <code>2*m</code> pulse rectifiers</a>, where <code>m</code> is the number of phases; load is not yet included.</p>
</html>"));
end ThyristorCenterTap2mPulse;
