within Modelica.Electrical.Polyphase.Examples;
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
  Modelica.Electrical.Polyphase.Sources.SineVoltage sineVoltage(
    final m=m,
    V=fill(sqrt(2)*VRMS, m),
    f=fill(f, m)) annotation (Placement(transformation(
        origin={-20,-30},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  Modelica.Electrical.Polyphase.Basic.Star star(final m=m) annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-20,-70})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(
        origin={-20,-100},
        extent={{-10,-10},{10,10}})));
  Modelica.Electrical.Polyphase.Basic.Resistor resistor(m=m, R=fill(R, m))
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={20,-20})));
  Modelica.Electrical.Polyphase.Basic.Inductor inductor(m=m, L=fill(L, m))
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={20,-50})));
  Modelica.Electrical.Polyphase.Basic.Star starLoad(m=m) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={20,-80})));
  Modelica.Electrical.Polyphase.Sensors.CurrentQuasiRMSSensor
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

  Sensors.VoltageQuasiRMSSensor voltageQuasiRMSSensor(m=m) annotation (
      Placement(transformation(
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
  Sensors.PowerSensor powerSensor(m=m) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={20,10})));
  Modelica.Blocks.Math.Feedback feedbackP
    annotation (Placement(transformation(extent={{40,10},{60,30}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=
        Modelica.Electrical.Polyphase.Functions.activePower(
        voltageQuasiRMSSensor.v, currentQuasiRMSSensor.i)) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={50,-20})));
  Modelica.Electrical.Machines.Sensors.ElectricalPowerSensor powerSensorSpacePhasor
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-20,70})));
  Modelica.Blocks.Math.Feedback feedbackSpacePhasor annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-60,60})));
  Sensors.AronSensor aronSensor annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={20,40})));
  Modelica.Blocks.Math.Feedback feedbackAron
    annotation (Placement(transformation(extent={{80,30},{100,50}})));
  Sensors.ReactivePowerSensor reactivePowerSensor annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={20,70})));
  Modelica.Blocks.Math.Feedback feedbackQ
    annotation (Placement(transformation(extent={{40,80},{60,60}})));
initial equation
  for k in 1:m - 1 loop
    inductor.i[k] = 0;
  end for;

equation
  connect(star.pin_n, ground.p)
    annotation (Line(points={{-20,-80},{-20,-90}}, color={0,0,255}));

  connect(resistor.plug_n, inductor.plug_p) annotation (Line(
      points={{20,-30},{20,-40}}, color={0,0,255}));
  connect(inductor.plug_n, starLoad.plug_p) annotation (Line(
      points={{20,-60},{20,-70}}, color={0,0,255}));
  connect(voltageQuasiRMSSensor.plug_n, sineVoltage.plug_n) annotation (
      Line(
      points={{-50,-40},{-20,-40}},
                                  color={0,0,255}));
  connect(voltageQuasiRMSSensor.plug_p, sineVoltage.plug_p) annotation (
      Line(
      points={{-50,-20},{-20,-20}},
                                  color={0,0,255}));
  connect(feedbackV.u1, voltageQuasiRMSSensor.V) annotation (Line(
      points={{-72,-30},{-61,-30}},
                                  color={0,0,127}));
  connect(constV.y, feedbackV.u2) annotation (Line(
      points={{-80,-49},{-80,-38}},
                                  color={0,0,127}));
  connect(powerSensor.nc, resistor.plug_p) annotation (Line(
      points={{20,0},{20,-10}},color={0,0,255}));
  connect(powerSensor.pc, powerSensor.pv) annotation (Line(
      points={{20,20},{10,20},{10,10}}, color={0,0,255}));
  connect(powerSensor.nv, starLoad.plug_p) annotation (Line(
      points={{30,10},{30,-70},{20,-70}}, color={0,0,255}));
  connect(powerSensor.power, feedbackP.u1) annotation (Line(
      points={{31,20},{42,20}},                 color={0,0,127}));
  connect(aronSensor.plug_n, powerSensor.pc)
    annotation (Line(points={{20,30},{20,20}}, color={0,0,255}));
  connect(sineVoltage.plug_n, star.plug_p)
    annotation (Line(points={{-20,-40},{-20,-60}}, color={0,0,255}));
  connect(feedbackI.u2, constI.y)
    annotation (Line(points={{-80,32},{-80,21}}, color={0,0,127}));
  connect(feedbackI.u1, currentQuasiRMSSensor.I)
    annotation (Line(points={{-72,40},{-31,40}}, color={0,0,127}));
  connect(currentQuasiRMSSensor.plug_p, sineVoltage.plug_p)
    annotation (Line(points={{-20,30},{-20,-20}}, color={0,0,255}));
  connect(feedbackP.u2, realExpression.y)
    annotation (Line(points={{50,12},{50,-9}},  color={0,0,127}));
  connect(powerSensorSpacePhasor.plug_p, currentQuasiRMSSensor.plug_n)
    annotation (Line(points={{-20,60},{-20,50}}, color={0,0,255}));
  connect(powerSensorSpacePhasor.plug_nv, starLoad.plug_p) annotation (Line(
        points={{-10,70},{-10,70},{0,70},{0,-70},{20,-70}}, color={0,0,255}));
  connect(powerSensorSpacePhasor.plug_ni, reactivePowerSensor.plug_p)
    annotation (Line(points={{-20,80},{20,80}}, color={0,0,255}));
  connect(reactivePowerSensor.plug_n, aronSensor.plug_p)
    annotation (Line(points={{20,60},{20,50}}, color={0,0,255}));
  connect(reactivePowerSensor.reactivePower, feedbackQ.u1)
    annotation (Line(points={{31,70},{42,70}}, color={0,0,127}));
  connect(powerSensorSpacePhasor.Q, feedbackQ.u2) annotation (Line(points={{-31,
          75},{-40,75},{-40,90},{50,90},{50,78}}, color={0,0,127}));
  connect(aronSensor.power, feedbackAron.u1)
    annotation (Line(points={{31,40},{82,40}}, color={0,0,127}));
  connect(feedbackSpacePhasor.u1, powerSensorSpacePhasor.P) annotation (Line(
        points={{-52,60},{-40,60},{-40,65},{-31,65}}, color={0,0,127}));
  connect(realExpression.y, feedbackAron.u2)
    annotation (Line(points={{50,-9},{50,0},{90,0},{90,32}}, color={0,0,127}));
  connect(realExpression.y, feedbackSpacePhasor.u2) annotation (Line(points={{50,
          -9},{50,0},{70,0},{70,98},{-60,98},{-60,68}}, color={0,0,127}));
  annotation (experiment(StopTime=0.1, Interval=0.0001), Documentation(info="<html>
<p>
Test polyphase quasiRMS and power sensors: A sinusoidal source feeds a load consisting of resistor and inductor.
</p>
</html>"));
end TestSensors;
