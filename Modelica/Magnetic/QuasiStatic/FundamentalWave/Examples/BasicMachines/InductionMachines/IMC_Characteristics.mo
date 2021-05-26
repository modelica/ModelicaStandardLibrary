within Modelica.Magnetic.QuasiStatic.FundamentalWave.Examples.BasicMachines.InductionMachines;
model IMC_Characteristics "Characteristic curves of Induction machine with squirrel cage"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  parameter Integer m=3 "Number of phases" annotation(Evaluate=true);
  parameter SI.Voltage VsNominal=100
    "Nominal RMS voltage per phase";
  parameter SI.Frequency fNominal=imcData.fsNominal "Nominal frequency";
  parameter SI.AngularVelocity w_Load(displayUnit="rev/min")=
       1440.45*2*Modelica.Constants.pi/60 "Nominal load speed";
  parameter Integer p=imcData.p "Number of pole pairs";
  Real speedPerUnit = p*imcQS.wMechanical/(2*pi*fNominal) "Per unit speed";
  Real slip = 1-speedPerUnit "Slip";
  output SI.Current Iqs=iSensorQS.I "QS RMS current";
  Modelica.Electrical.QuasiStatic.Polyphase.Sources.VoltageSource vSourceQS(
    m=m,
    f=fNominal,
    V=fill(VsNominal, m),
    phi=-Modelica.Electrical.Polyphase.Functions.symmetricOrientation(m)) annotation (Placement(transformation(
        origin={-60,40},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.QuasiStatic.Polyphase.Basic.Star starQS(m=m)
    annotation (Placement(transformation(
        origin={-70,20},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Ground groundQS
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-90,20})));
  Modelica.Electrical.QuasiStatic.Polyphase.Sensors.PowerSensor pSensorQS(m=m) annotation (Placement(transformation(extent={{-40,70},{-20,90}})));
  Modelica.Electrical.QuasiStatic.Polyphase.Sensors.CurrentQuasiRMSSensor iSensorQS(m=m)
    annotation (Placement(transformation(extent={{-10,70},{10,90}})));
  parameter
    Modelica.Electrical.Machines.Utilities.ParameterRecords.IM_SquirrelCageData
    imcData "Induction machine data"
    annotation (Placement(transformation(extent={{70,72},{90,92}})));
  FundamentalWave.BasicMachines.InductionMachines.IM_SquirrelCage imcQS(
    Js=imcData.Js,
    p=imcData.p,
    fsNominal=imcData.fsNominal,
    TsRef=imcData.TsRef,
    alpha20s(displayUnit="1/K") = imcData.alpha20s,
    frictionParameters=imcData.frictionParameters,
    gammar(fixed=true, start=-pi/2),
    statorCoreParameters=imcData.statorCoreParameters,
    strayLoadParameters=imcData.strayLoadParameters,
    alpha20r(displayUnit="1/K") = imcData.alpha20r,
    Rs=imcData.Rs*m/3,
    Lssigma=imcData.Lssigma*m/3,
    Lm=imcData.Lm*m/3,
    Lrsigma=imcData.Lrsigma*m/3,
    Rr=imcData.Rr*m/3,
    TrRef=imcData.TrRef,
    m=m,
    Jr=0*imcData.Jr,
    TsOperational=293.15,
    effectiveStatorTurns=imcData.effectiveStatorTurns,
    TrOperational=293.15) annotation (Placement(transformation(extent={{20,30},{40,50}})));
  Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Ground
    groundMachineQS annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={-10,10})));
  Modelica.Electrical.QuasiStatic.Polyphase.Basic.Star
    starMachineQS(m=
        Modelica.Electrical.Polyphase.Functions.numberOfSymmetricBaseSystems(
                                                                    m))
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-10,30})));
  Utilities.MultiTerminalBox terminalBoxQS(m=m, terminalConnection="Y")
    annotation (Placement(transformation(extent={{20,46},{40,66}})));
  Modelica.Mechanics.Rotational.Sources.Speed speed(exact=true)
    annotation (Placement(transformation(extent={{70,30},{50,50}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=3*2*pi*fNominal/p,
    duration=1,
    offset=-2*pi*fNominal/p)
    annotation (Placement(transformation(extent={{100,30},{80,50}})));
equation
  connect(groundQS.pin, starQS.pin_n)
    annotation (Line(points={{-80,20},{-80,20}}, color={85,170,255}));
  connect(starQS.plug_p, vSourceQS.plug_n) annotation (Line(points={{-60,20},{-60,30}}, color={85,170,255}));
  connect(pSensorQS.currentN, iSensorQS.plug_p) annotation (Line(points={{-20,80},{-10,80}}, color={85,170,255}));
  connect(pSensorQS.voltageP, pSensorQS.currentP) annotation (Line(points={{-30,90},{-40,90},{-40,80}}, color={85,170,255}));
  connect(pSensorQS.voltageN, starQS.plug_p) annotation (Line(points={{-30,70},{-30,20},{-60,20}}, color={85,170,255}));
  connect(terminalBoxQS.plug_sn, imcQS.plug_sn) annotation (Line(
      points={{24,50},{24,50}},
      color={85,170,255}));
  connect(terminalBoxQS.plug_sp, imcQS.plug_sp) annotation (Line(
      points={{36,50},{36,50}},
      color={85,170,255}));
  connect(starMachineQS.plug_p, terminalBoxQS.starpoint) annotation (
      Line(
      points={{-10,40},{-10,52},{20,52}},
      color={85,170,255}));
  connect(iSensorQS.plug_n, terminalBoxQS.plugSupply) annotation (Line(points={{10,80},{30,80},{30,52}}, color={85,170,255}));
  connect(starMachineQS.pin_n, groundMachineQS.pin) annotation (Line(
      points={{-10,20},{-10,20}},
      color={85,170,255}));
  connect(imcQS.flange, speed.flange) annotation (Line(points={{40,40},{50,40}}));
  connect(ramp.y, speed.w_ref) annotation (Line(points={{79,40},{72,40}}, color={0,0,127}));
  connect(vSourceQS.plug_p, pSensorQS.currentP) annotation (Line(points={{-60,50},{-60,80},{-40,80}}, color={85,170,255}));
  annotation (experiment(StopTime=1, Interval=0.001, Tolerance=1E-6),
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{20,8},{100,0}},
                  textStyle={TextStyle.Bold},
          textString="%m phase quasi-static")}),
    Documentation(info="<html>
<p>
This examples allows the investigation of characteristic curves of quasi-static polyphase induction machines with squirrel cage rotor
as a function of rotor speed.
</p>

<p>
Simulate for 1 second and plot (versus <code>imcQS.wMechanical</code> or <code>speedPerUnit</code>):
</p>

<ul>
<li><code>iSensorQS.I</code>: (equivalent) RMS stator current</li>
<li><code>imcQS.tauElectrical</code>: machine torque</li>
<li><code>imcQS.powerBalance.powerStator</code>: stator power</li>
<li><code>imcQS.powerBalance.powerMechanical</code>: mechanical power</li>
</ul>
</html>"));
end IMC_Characteristics;
