within Modelica.Electrical.PowerConverters.Examples.DCDC.ExampleTemplates;
partial model HBridge "H bridge DC/DC converter"
  extends Icons.ExampleTemplate;
  parameter SI.Frequency f=1000 "Switching frequency";
  PowerConverters.DCDC.HBridge hbridge(useHeatPort=false)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(V=
        100) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-80,0})));
  PowerConverters.DCDC.Control.SignalPWM signalPWM(constantDutyCycle=0.6, f=f)
    annotation (Placement(transformation(extent={{-60,-70},{-40,-50}})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(extent={{-90,-40},{-70,-20}})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor
    annotation (Placement(transformation(extent={{0,-16},{-20,4}})));
  Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={60,10})));
  Modelica.Blocks.Math.Mean meanCurrent(f=f, x0=0) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-10,-40})));
  Modelica.Blocks.Math.Mean meanVoltage(f=f, x0=0) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={90,10})));
equation
  connect(hbridge.fire_p, signalPWM.fire) annotation (Line(
      points={{-56,-12},{-56,-49}}, color={255,0,255}));
  connect(ground.p, constantVoltage.n) annotation (Line(
      points={{-80,-20},{-80,-10}}, color={0,0,255}));
  connect(constantVoltage.p, hbridge.dc_p1) annotation (Line(
      points={{-80,10},{-68,10},{-68,6},{-60,6}}, color={0,0,255}));
  connect(constantVoltage.n, hbridge.dc_n1) annotation (Line(
      points={{-80,-10},{-68,-10},{-68,-6},{-60,-6}}, color={0,0,255}));
  connect(voltageSensor.n, currentSensor.p) annotation (Line(
      points={{60,0},{60,-6},{0,-6}}, color={0,0,255}));
  connect(voltageSensor.v, meanVoltage.u) annotation (Line(
      points={{71,10},{78,10}}, color={0,0,127}));
  connect(currentSensor.i, meanCurrent.u) annotation (Line(
      points={{-10,-17},{-10,-28}}, color={0,0,127}));
  connect(hbridge.dc_p2, voltageSensor.p) annotation (Line(
      points={{-40,6},{-30,6},{-30,70},{60,70},{60,20}}, color={0,0,255}));
  connect(currentSensor.n, hbridge.dc_n2) annotation (Line(
      points={{-20,-6},{-40,-6}}, color={0,0,255}));
  connect(signalPWM.notFire, hbridge.fire_n) annotation (Line(
      points={{-44,-49},{-44,-12}}, color={255,0,255}));
  annotation (Documentation(
        info="<html>
<p>H bridge example template including supply and sensors; load is not yet included</p>
</html>"));
end HBridge;
