within Modelica.Electrical.QuasiStatic.Polyphase.Examples;
model TestSensors
  extends Modelica.Icons.Example;
  constant Integer m=3 "Number of phases";
  import Modelica.Constants.pi;
  parameter SI.Voltage VRMS=100
    "Nominal RMS voltage per phase";
  parameter SI.Frequency f=50 "Frequency";
  parameter SI.Resistance R=1/sqrt(2) "Load resistance";
  parameter SI.Inductance L=1/sqrt(2)/(2*pi*f) "Load inductance";
  final parameter SI.Impedance Z=sqrt(R^2 + (2*pi*f*L)^2) "Load impedance";
  final parameter SI.Current IRMS=VRMS/Z "Steady state RMS current";
  final parameter SI.ActivePower P=3*R*IRMS^2 "Total active power";
  final parameter SI.ReactivePower Q=3*(2*pi*f*L)*IRMS^2 "Total reactive power";
  final parameter SI.ApparentPower S=3*Z*IRMS^2 "Total apparent power";
  Modelica.Electrical.QuasiStatic.Polyphase.Sources.VoltageSource sineVoltage(
    final m=m,
    f=f,
    V=fill(VRMS, m),
    gamma(fixed=true, start=0))
                       annotation (Placement(transformation(
        origin={-20,-30},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  Modelica.Electrical.QuasiStatic.Polyphase.Basic.Star star(final m=m) annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-20,-70})));
  Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Ground ground annotation (Placement(
        transformation(
        origin={-20,-100},
        extent={{-10,-10},{10,10}})));
  Modelica.Electrical.QuasiStatic.Polyphase.Basic.Resistor resistor(m=m, R_ref=fill(R, m))
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={20,-20})));
  Modelica.Electrical.QuasiStatic.Polyphase.Basic.Inductor inductor(m=m, L=fill(L, m))
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={20,-50})));
  Modelica.Electrical.QuasiStatic.Polyphase.Basic.Star starLoad(m=m) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={20,-80})));
  Modelica.Electrical.QuasiStatic.Polyphase.Sensors.CurrentQuasiRMSSensor
    currentQuasiRMSSensor(m=m) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-20,40})));
  Modelica.Blocks.Math.Feedback feedbackI
    annotation (Placement(transformation(extent={{-70,30},{-90,50}})));
  Modelica.Blocks.Sources.Constant constI(k=IRMS) annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={-80,10})));

  Modelica.Electrical.QuasiStatic.Polyphase.Sensors.VoltageQuasiRMSSensor voltageQuasiRMSSensor(m=m)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-50,-30})));
  Modelica.Blocks.Math.Feedback feedbackV
    annotation (Placement(transformation(extent={{-70,-40},{-90,-20}})));
  Modelica.Blocks.Sources.Constant constV(k=VRMS) annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={-80,-60})));
  Modelica.Electrical.QuasiStatic.Polyphase.Sensors.PowerSensor powerSensor(m=m)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={20,10})));
  Modelica.ComplexBlocks.ComplexMath.ComplexToReal complexToReal
    annotation (Placement(transformation(extent={{40,30},{60,10}})));
  Modelica.Blocks.Math.Feedback feedbackP
    annotation (Placement(transformation(extent={{80,-10},{100,10}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=
    Modelica.Electrical.QuasiStatic.Polyphase.Functions.activePower(
        voltageQuasiRMSSensor.v, currentQuasiRMSSensor.i)) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={90,-30})));
  Modelica.Electrical.QuasiStatic.Polyphase.Sensors.AronSensor aronSensor annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={20,40})));
  Modelica.Blocks.Math.Feedback feedbackPAron
    annotation (Placement(transformation(extent={{80,30},{100,50}})));
  Modelica.Electrical.QuasiStatic.Polyphase.Sensors.ReactivePowerSensor
    reactivePowerSensor annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={20,70})));
  Modelica.Blocks.Math.Feedback feedbackQ
    annotation (Placement(transformation(extent={{40,60},{60,80}})));
equation

  connect(feedbackV.u1, voltageQuasiRMSSensor.V) annotation (Line(
      points={{-72,-30},{-61,-30}},
                                  color={0,0,127}));
  connect(constV.y, feedbackV.u2) annotation (Line(
      points={{-80,-49},{-80,-38}},
                                  color={0,0,127}));
  connect(realExpression.y, feedbackP.u2)
    annotation (Line(points={{90,-19},{90,-8}},
                                              color={0,0,127}));
  connect(voltageQuasiRMSSensor.plug_p, sineVoltage.plug_p)
    annotation (Line(points={{-50,-20},{-20,-20}},
                                                 color={85,170,255}));
  connect(voltageQuasiRMSSensor.plug_n, sineVoltage.plug_n)
    annotation (Line(points={{-50,-40},{-20,-40}},
                                                 color={85,170,255}));
  connect(powerSensor.currentP, aronSensor.plug_n)
    annotation (Line(points={{20,20},{20,30}}, color={85,170,255}));
  connect(powerSensor.currentP, powerSensor.voltageP)
    annotation (Line(points={{20,20},{10,20},{10,10}},
                                                     color={85,170,255}));
  connect(powerSensor.currentN, resistor.plug_p)
    annotation (Line(points={{20,0},{20,-10}}, color={85,170,255}));
  connect(resistor.plug_n, inductor.plug_p)
    annotation (Line(points={{20,-30},{20,-40}}, color={85,170,255}));
  connect(inductor.plug_n, starLoad.plug_p)
    annotation (Line(points={{20,-60},{20,-70}}, color={85,170,255}));
  connect(starLoad.plug_p, powerSensor.voltageN)
    annotation (Line(points={{20,-70},{30,-70},{30,10}}, color={85,170,255}));
  connect(star.pin_n, ground.pin)
    annotation (Line(points={{-20,-80},{-20,-90}}, color={85,170,255}));
  connect(sineVoltage.plug_n, star.plug_p)
    annotation (Line(points={{-20,-40},{-20,-60}},color={85,170,255}));
  connect(powerSensor.apparentPower, complexToReal.u) annotation (Line(points={{31,20},{38,20}}, color={85,170,255}));
  connect(complexToReal.re, feedbackP.u1) annotation (Line(points={{62,14},{70,14},
          {70,0},{82,0}},   color={0,0,127}));
  connect(feedbackI.u2, constI.y)
    annotation (Line(points={{-80,32},{-80,21}}, color={0,0,127}));
  connect(feedbackI.u1, currentQuasiRMSSensor.I)
    annotation (Line(points={{-72,40},{-31,40}}, color={0,0,127}));
  connect(currentQuasiRMSSensor.plug_p, sineVoltage.plug_p)
    annotation (Line(points={{-20,30},{-20,-20}}, color={85,170,255}));
  connect(reactivePowerSensor.plug_n, aronSensor.plug_p)
    annotation (Line(points={{20,60},{20,50}}, color={85,170,255}));
  connect(currentQuasiRMSSensor.plug_n, reactivePowerSensor.plug_p)
    annotation (Line(points={{-20,50},{-20,80},{20,80}}, color={85,170,255}));
  connect(reactivePowerSensor.reactivePower, feedbackQ.u1)
    annotation (Line(points={{31,70},{42,70}}, color={0,0,127}));
  connect(aronSensor.activePower, feedbackPAron.u1) annotation (Line(points={{31,40},{82,40}}, color={0,0,127}));
  connect(complexToReal.re, feedbackPAron.u2)
    annotation (Line(points={{62,14},{90,14},{90,32}}, color={0,0,127}));
  connect(complexToReal.im, feedbackQ.u2) annotation (Line(points={{62,26},{70,26},
          {70,50},{50,50},{50,62}}, color={0,0,127}));
  annotation (experiment(StopTime=0.1, Interval=0.0001), Documentation(info="<html>
<p>
Test quasi-static polyphase sensors: A sinusoidal source feeds a load consisting of resistor and inductor.
</p>
</html>"));
end TestSensors;
