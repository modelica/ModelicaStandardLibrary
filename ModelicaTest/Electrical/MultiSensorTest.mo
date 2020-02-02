within ModelicaTest.Electrical;
model MultiSensorTest
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  parameter Integer m = 3 "Number of phases" annotation(Evaluate=true);
  parameter SI.Voltage Vrms = 100 "RMS supply voltage";
  parameter SI.Frequency f = 50 "Frequency";
  parameter SI.Resistance R = 10 "Resistance";
  parameter SI.Reactance X = 10 "Reactance";
  final parameter SI.Inductance L = X/(2*pi*f) "Inducance";

  SI.Current IA=rmsiA.y   "RMS current (Analog)";
  SI.Current IM[m]=rmsiM.y   "RMS current (Polyphase)";
  SI.Current IQS = Modelica.ComplexMath.abs(multiSensorQS.i) "RMS current (QuasiStatic SinglePhase)";
  SI.Current IQM[m] = Modelica.ComplexMath.abs(multiSensorQM.i) "RMS current (QuasiStatic Polyphase)";

  SI.Voltage VA = rmsvA.y "RMS voltage (Analog)";
  SI.Voltage VM[m] = rmsvM.y "RMS voltage (Polyphase)";
  SI.Voltage VQS = Modelica.ComplexMath.abs(multiSensorQS.v) "RMS voltage (QuasiStatic SinglePhase)";
  SI.Voltage VQM[m] = Modelica.ComplexMath.abs(multiSensorQM.v) "RMS voltage (QuasiStatic Polyphase)";

  SI.Power powerA = meanpowerA.y "Avareage power (Analog)";
  SI.Power powerM[m] = meanpowerM.y "Avareage power (Polyphase)";
  SI.Power powerQS = multiSensorQS.apparentPower.re "Active power (QuasiStatic SinglePhase)";
  SI.Power powerQM[m] = multiSensorQM.apparentPower.re "Active power (QuasiStatic Polyphase)";

  Modelica.Electrical.Analog.Basic.Resistor resistorA(R=R) annotation (Placement(transformation(extent={{40,70},{60,90}})));
  Modelica.Electrical.Analog.Basic.Inductor inductorA(L=L, i(fixed=true,
        start=0))                                          annotation (Placement(transformation(extent={{70,70},{90,90}})));
  Modelica.Electrical.Analog.Basic.Ground groundA annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-30,60})));
  Modelica.Electrical.Analog.Sensors.MultiSensor multiSensorA
    annotation (Placement(transformation(extent={{10,70},{30,90}})));
  Modelica.Electrical.Analog.Sources.SineVoltage sineVoltageA(
    V=sqrt(2)*Vrms,
    phase=0,
    f=f) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-10,70})));
  Modelica.Electrical.Polyphase.Basic.Resistor resistorM(m=m, R=fill(R, m)) annotation (Placement(transformation(extent={{40,10},
            {60,30}})));
  Modelica.Electrical.Polyphase.Basic.Inductor inductorM(m=m, L=fill(L, m),
    i(start=zeros(m), each fixed=true))                                           annotation (Placement(transformation(extent={{70,10},
            {90,30}})));
  Modelica.Electrical.Polyphase.Sensors.MultiSensor multiSensorM(m=m)
    annotation (Placement(transformation(extent={{10,10},{30,30}})));
  Modelica.Electrical.Polyphase.Sources.SineVoltage sineVoltageM(
    m=m,
    V=fill(sqrt(2)*Vrms, m),
    phase=-Modelica.Electrical.Polyphase.Functions.symmetricOrientation(m),
    f=fill(f, m))
              annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-10,10})));
  Modelica.Electrical.Analog.Basic.Ground groundM annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=270,
        origin={-60,0})));
  Modelica.Electrical.Polyphase.Basic.Star starM(m=m) annotation (Placement(transformation(extent={{-18,-10},
            {-38,10}})));
  Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Resistor resistorQS(R_ref=R) annotation (Placement(transformation(extent={{40,-40},
            {60,-20}})));
  Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Inductor inductorQS(L=L) annotation (Placement(transformation(extent={{70,-40},
            {90,-20}})));
  Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Ground groundQS annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-30,-50})));
  Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.MultiSensor
    multiSensorQS
    annotation (Placement(transformation(extent={{10,-40},{30,-20}})));
  Modelica.Electrical.QuasiStatic.SinglePhase.Sources.VoltageSource sineVoltageQS(
    f=f,
    phi=0,
    V=Vrms,
    gamma(fixed=true, start=0))
           annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-10,-40})));
  Modelica.Electrical.QuasiStatic.Polyphase.Basic.Resistor resistorQM(m=m, R_ref=fill(R, m))                                                                         annotation (Placement(transformation(extent={{40,-80},{60,-60}})));
  Modelica.Electrical.QuasiStatic.Polyphase.Basic.Inductor inductorQM(m=m, L=fill(L, m)) annotation (Placement(transformation(extent={{70,-80},{90,-60}})));
  Modelica.Electrical.QuasiStatic.Polyphase.Sensors.MultiSensor
    multiSensorQM(m=m)
    annotation (Placement(transformation(extent={{10,-80},{30,-60}})));
  Modelica.Electrical.QuasiStatic.Polyphase.Sources.VoltageSource sineVoltageQM(
    m=m,
    f=f,
    phi=-Modelica.Electrical.Polyphase.Functions.symmetricOrientation(m),
    V=fill(Vrms, m),
    gamma(fixed=true, start=0))                                            annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-10,-80})));
  Modelica.Electrical.QuasiStatic.Polyphase.Basic.Star starQM(m=m) annotation (Placement(transformation(extent={{-18,-100},{-38,-80}})));
  Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Ground groundQM annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-60,-90})));
  Modelica.Blocks.Math.RootMeanSquare rmsvA(f=f) annotation (Placement(transformation(extent={{-80,60},
            {-100,80}})));
  Modelica.Blocks.Math.RootMeanSquare rmsiA(f=f) annotation (Placement(transformation(extent={{-80,30},
            {-100,50}})));
  Modelica.Blocks.Math.Mean meanpowerA(f=f) annotation (Placement(transformation(extent={{-40,70},{-60,90}})));
  Modelica.Blocks.Math.RootMeanSquare rmsvM[m](f=fill(f, m)) annotation (Placement(transformation(extent={{-80,0},
            {-100,20}})));
  Modelica.Blocks.Math.RootMeanSquare rmsiM[m](f=fill(f, m)) annotation (Placement(transformation(extent={{-80,-30},
            {-100,-10}})));
  Modelica.Blocks.Math.Mean meanpowerM[m](f=fill(f, m)) annotation (Placement(transformation(extent={{-40,10},
            {-60,30}})));

equation
  connect(groundA.p, sineVoltageA.n) annotation (Line(points={{-20,60},{-20,60},
          {-10,60}}, color={0,0,255}));
  connect(sineVoltageA.p, multiSensorA.pc) annotation (Line(points={{-10,80},{0,80},{10,80}}, color={0,0,255}));
  connect(multiSensorA.nc, resistorA.p) annotation (Line(points={{30,80},{35,80},{40,80}}, color={0,0,255}));
  connect(resistorA.n, inductorA.p) annotation (Line(points={{60,80},{60,80},{70,80}}, color={0,0,255}));
  connect(sineVoltageA.n, inductorA.n) annotation (Line(points={{-10,60},{100,60},{100,80},{90,80}}, color={0,0,255}));
  connect(multiSensorA.pv, multiSensorA.pc) annotation (Line(points={{20,90},{10,90},{10,80}}, color={0,0,255}));
  connect(multiSensorA.nv, sineVoltageA.n) annotation (Line(points={{20,70},{20,60},{-10,60}}, color={0,0,255}));
  connect(starM.pin_n, groundM.p) annotation (Line(points={{-38,0},{-38,0},{-50,
          0}}, color={0,0,255}));
  connect(starM.plug_p, sineVoltageM.plug_n) annotation (Line(points={{-18,0},{-20,
          0},{-10,0}}, color={0,0,255}));
  connect(multiSensorM.pc,sineVoltageM. plug_p) annotation (Line(points={{10,20},
          {-10,20}}, color={0,0,255}));
  connect(starM.plug_p, multiSensorM.nv) annotation (Line(points={{-18,0},{0,0},
          {20,0},{20,10}}, color={0,0,255}));
  connect(multiSensorM.nv,inductorM. plug_n) annotation (Line(points={{20,10},{20,
          10},{20,0},{100,0},{100,20},{90,20}}, color={0,0,255}));
  connect(multiSensorM.pc,multiSensorM. pv) annotation (Line(points={{10,20},{10,
          30},{20,30}}, color={0,0,255}));
  connect(multiSensorM.nc,resistorM. plug_p) annotation (Line(points={{30,20},{35,
          20},{40,20}}, color={0,0,255}));
  connect(resistorM.plug_n,inductorM. plug_p) annotation (Line(points={{60,20},{
          65,20},{70,20}}, color={0,0,255}));
  connect(multiSensorQS.pv, multiSensorQS.pc) annotation (Line(points={{20,-20},
          {10,-20},{10,-30}}, color={0,0,255}));
  connect(sineVoltageQS.pin_p, multiSensorQS.pc) annotation (Line(points={{-10,-30},
          {10,-30}}, color={85,170,255}));
  connect(multiSensorQS.nv, sineVoltageQS.pin_n) annotation (Line(points={{20,-40},
          {20,-50},{-10,-50}}, color={85,170,255}));
  connect(sineVoltageQS.pin_n, groundQS.pin) annotation (Line(points={{-10,-50},
          {-20,-50}}, color={85,170,255}));
  connect(resistorQS.pin_n, inductorQS.pin_p) annotation (Line(points={{60,-30},
          {66,-30},{70,-30}}, color={85,170,255}));
  connect(inductorQS.pin_n, sineVoltageQS.pin_n) annotation (Line(points={{90,-30},
          {100,-30},{100,-50},{-10,-50}}, color={85,170,255}));
  connect(multiSensorQS.nc, resistorQS.pin_p) annotation (Line(points={{30,-30},
          {36,-30},{40,-30}}, color={85,170,255}));
  connect(multiSensorQM.pc, sineVoltageQM.plug_p) annotation (Line(points={{10,-70},{10,-70},{2,-70},{-10,-70}}, color={0,0,255}));
  connect(multiSensorQM.pc, multiSensorQM.pv) annotation (Line(points={{10,-70},{10,-60},{20,-60}}, color={0,0,255}));
  connect(multiSensorQM.nc, resistorQM.plug_p) annotation (Line(points={{30,-70},{30,-70},{40,-70}}, color={0,0,255}));
  connect(resistorQM.plug_n, inductorQM.plug_p) annotation (Line(points={{60,-70},{60,-70},{70,-70}}, color={0,0,255}));
  connect(inductorQM.plug_n, sineVoltageQM.plug_n) annotation (Line(points={{90,-70},{100,-70},{100,-90},{-10,-90}}, color={85,170,255}));
  connect(multiSensorQM.nv, sineVoltageQM.plug_n) annotation (Line(points={{20,-80},{20,-80},{20,-88},{20,-90},{-10,-90}}, color={85,170,255}));
  connect(starQM.plug_p, sineVoltageQM.plug_n) annotation (Line(points={{-18,-90},{-14,-90},{-10,-90}}, color={85,170,255}));
  connect(starQM.pin_n, groundQM.pin) annotation (Line(points={{-38,-90},{-44,-90},{-50,-90}}, color={85,170,255}));
  connect(rmsvA.u, multiSensorA.v) annotation (Line(points={{-78,70},{-70,70},{-70,
          40},{26,40},{26,69}}, color={0,0,127}));
  connect(rmsiA.u, multiSensorA.i) annotation (Line(points={{-78,40},{-68,40},{14,
          40},{14,69}}, color={0,0,127}));
  connect(rmsvM.u, multiSensorM.v) annotation (Line(points={{-78,10},{-70,10},{-70,
          -10},{26,-10},{26,9}}, color={0,0,127}));
  connect(rmsiM.u, multiSensorM.i) annotation (Line(points={{-78,-20},{-78,-20},
          {-70,-20},{-70,-20},{-70,-10},{14,-10},{14,9}}, color={0,0,127}));
  connect(multiSensorM.power, meanpowerM.u) annotation (Line(points={{9,14},{0,14},
          {0,30},{-28,30},{-28,20},{-38,20}}, color={0,0,127}));
  connect(multiSensorA.power, meanpowerA.u) annotation (Line(points={{9,74},{0,74},
          {0,88},{-30,88},{-30,80},{-38,80}}, color={0,0,127}));
  annotation (experiment(StopTime=0.1));
end MultiSensorTest;
