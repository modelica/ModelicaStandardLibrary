within Modelica.Electrical.PowerConverters.Examples.DCAC.ExampleTemplates;
partial model SinglePhaseTwoLevel
  "Single-phase two level inverter including control"
  extends Icons.ExampleTemplate;
  parameter SI.Frequency f=1000 "Switching frequency";
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage_n(
      V=50) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-70,10})));
  PowerConverters.DCAC.SinglePhase2Level inverter(useHeatPort=false)
    annotation (Placement(transformation(extent={{-50,20},{-30,40}})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor
    annotation (Placement(transformation(extent={{10,-80},{-10,-60}})));
  Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={70,-10})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-90,40})));
  PowerConverters.DCDC.Control.SignalPWM signalPWM(useConstantDutyCycle=false,
      f=f) annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          origin={-40,-20})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage_p(
      V=50) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-70,50})));
  Modelica.Blocks.Sources.Sine sine(f=50) annotation (Placement(
        transformation(extent={{-30,-64},{-50,-44}})));
  Modelica.Blocks.Math.Harmonic fundamentalWaveVoltage(f=f, k=1)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={90,50})));
  Modelica.Blocks.Math.Harmonic fundamentalWaveCurrent(f=f, k=1)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={30,-90})));
equation
  connect(voltageSensor.n, currentSensor.p) annotation (Line(
      points={{70,-20},{70,-70},{10,-70}}, color={0,0,255}));
  connect(signalPWM.fire, inverter.fire_p) annotation (Line(
      points={{-46,-9},{-46,18}}, color={255,0,255}));
  connect(constantVoltage_p.n, constantVoltage_n.p) annotation (Line(
      points={{-70,40},{-70,20}}, color={0,0,255}));
  connect(constantVoltage_p.p, inverter.dc_p) annotation (Line(
      points={{-70,60},{-60,60},{-60,36},{-50,36},{-50,36}}, color={0,0,255}));
  connect(constantVoltage_n.n, inverter.dc_n) annotation (Line(
      points={{-70,0},{-60,0},{-60,24},{-52,24},{-52,24},{-50,24},{-50,24}}, color={0,0,255}));
  connect(ground.p, constantVoltage_p.n) annotation (Line(
      points={{-90,30},{-70,30},{-70,40}}, color={0,0,255}));
  connect(currentSensor.n, ground.p) annotation (Line(
      points={{-10,-70},{-90,-70},{-90,30}}, color={0,0,255}));
  connect(voltageSensor.p, inverter.ac) annotation (Line(
      points={{70,0},{70,30},{-30,30}}, color={0,0,255}));
  connect(sine.y, signalPWM.dutyCycle) annotation (Line(
      points={{-51,-54},{-60,-54},{-60,-20},{-52,-20}}, color={0,0,127}));
  connect(inverter.fire_n, signalPWM.notFire) annotation (Line(
      points={{-34,18},{-34,-9}}, color={255,0,255}));
  connect(currentSensor.i, fundamentalWaveCurrent.u) annotation (Line(
      points={{0,-81},{0,-90},{18,-90}}, color={0,0,127}));
  connect(voltageSensor.v, fundamentalWaveVoltage.u) annotation (Line(
      points={{81,-10},{90,-10},{90,38}}, color={0,0,127}));
  annotation (Documentation(
        info="<html>
<p>Single-phase two level example template including supply and sensors; load is not yet included.</p>
</html>"));
end SinglePhaseTwoLevel;
