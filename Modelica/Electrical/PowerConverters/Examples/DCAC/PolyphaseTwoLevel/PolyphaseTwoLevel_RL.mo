within Modelica.Electrical.PowerConverters.Examples.DCAC.PolyphaseTwoLevel;
model PolyphaseTwoLevel_RL
  "Polyphase DC to AC converter with R-L load"
  extends Modelica.Icons.Example;
  parameter Integer m=6 "Number of phases" annotation(Evaluate=true);
  parameter SI.Frequency f=1000 "Switching frequency";
  parameter SI.Frequency f1=50
    "Fundamental wave AC frequency";
  parameter SI.Resistance R=100 "Resistance";
  parameter SI.Inductance L=1 "Inductance";
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage_n(
      V=50) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-70,10})));
  PowerConverters.DCAC.Polyphase2Level inverter(useHeatPort=false, m=m)
    annotation (Placement(transformation(extent={{-50,20},{-30,40}})));
  Modelica.Electrical.Polyphase.Sensors.CurrentSensor currentSensor(m=
        m) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={40,-50})));
  Modelica.Electrical.Polyphase.Sensors.VoltageSensor voltageSensor(m=
        m) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={70,-10})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-90,40})));
  PowerConverters.DCDC.Control.SignalPWM signalPWM[m](each useConstantDutyCycle
      =false, each f=f) annotation (Placement(transformation(extent={{-10,-10},
            {10,10}}, origin={-40,-20})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage_p(
      V=50) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-70,50})));
  Modelica.Blocks.Sources.Sine sine[m](
    phase=-
        Modelica.Electrical.Polyphase.Functions.symmetricOrientation(m),
    startTime=zeros(m),
    amplitude=fill(0.5, m),
    offset=fill(0.5, m),
    f=fill(f1, m)) annotation (Placement(transformation(extent={{-30,
            -64},{-50,-44}})));
  Modelica.Blocks.Math.Harmonic fundamentalWaveCurrent[m](
    each k=1,
    each x0Cos=0,
    each x0Sin=0,
    each f=f1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={90,-50})));
  Modelica.Blocks.Math.Harmonic fundamentalWaveVoltage[m](
    each k=1,
    each x0Cos=0,
    each x0Sin=0,
    each f=f1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={90,50})));
  Modelica.Electrical.Polyphase.Basic.Resistor resistor(m=m, R=fill(R,
        m)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={40,10})));
  Modelica.Electrical.Polyphase.Basic.Inductor inductor(m=m, L=fill(L,
        m)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={40,-20})));
  Modelica.Electrical.Polyphase.Basic.Star star(m=m) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={40,-90})));
initial equation
  inductor.i[1:m - 1] = zeros(m - 1);

equation
  connect(constantVoltage_p.n, constantVoltage_n.p) annotation (Line(
      points={{-70,40},{-70,20}}, color={0,0,255}));
  connect(constantVoltage_p.p, inverter.dc_p) annotation (Line(
      points={{-70,60},{-60,60},{-60,36},{-50,36},{-50,36}}, color={0,0,255}));
  connect(constantVoltage_n.n, inverter.dc_n) annotation (Line(
      points={{-70,0},{-60,0},{-60,24},{-50,24},{-50,24}}, color={0,0,255}));
  connect(ground.p, constantVoltage_p.n) annotation (Line(
      points={{-90,30},{-70,30},{-70,40}}, color={0,0,255}));
  connect(sine.y, signalPWM.dutyCycle) annotation (Line(
      points={{-51,-54},{-60,-54},{-60,-20},{-52,-20}}, color={0,0,127}));
  connect(voltageSensor.v, fundamentalWaveVoltage.u) annotation (Line(
      points={{81,-10},{90,-10},{90,38}}, color={0,0,127}));
  connect(fundamentalWaveCurrent.u, currentSensor.i) annotation (Line(
      points={{78,-50},{51,-50}}, color={0,0,127}));
  connect(signalPWM.fire, inverter.fire_p) annotation (Line(
      points={{-46,-9},{-46,18}}, color={255,0,255}));
  connect(signalPWM.notFire, inverter.fire_n) annotation (Line(
      points={{-34,-9},{-34,18}}, color={255,0,255}));
  connect(inverter.ac, resistor.plug_p) annotation (Line(
      points={{-30,30},{40,30},{40,20}}, color={0,0,255}));
  connect(resistor.plug_n, inductor.plug_p) annotation (Line(
      points={{40,0},{40,-10}}, color={0,0,255}));
  connect(voltageSensor.plug_p, inverter.ac) annotation (Line(
      points={{70,0},{70,30},{-30,30}}, color={0,0,255}));
  connect(voltageSensor.plug_n, currentSensor.plug_n) annotation (Line(
      points={{70,-20},{70,-70},{40,-70},{40,-60}}, color={0,0,255}));
  connect(currentSensor.plug_p, inductor.plug_n) annotation (Line(
      points={{40,-40},{40,-30}}, color={0,0,255}));
  connect(currentSensor.plug_n, star.plug_p) annotation (Line(
      points={{40,-60},{40,-80}}, color={0,0,255}));
  annotation (
    experiment(
      StartTime=0,
      StopTime=0.1,
      Tolerance=1e-06,
      Interval=0.00002),
    Documentation(info="<html>
<p>Plot current <code>currentSensor.i[:]</code>, harmonic current magnitude <code>fundamentalWaveCurrent[:].y_RMS</code>, harmonic voltage magnitude <code>fundamentalWaveVoltage[:].y_RMS</code>. The instantaneous voltages <code>voltageSensor.i[:]</code> directly show the switching pattern of the inverter.</p>
</html>"));
end PolyphaseTwoLevel_RL;
