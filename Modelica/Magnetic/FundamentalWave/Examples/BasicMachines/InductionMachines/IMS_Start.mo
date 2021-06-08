within Modelica.Magnetic.FundamentalWave.Examples.BasicMachines.InductionMachines;
model IMS_Start
  "Starting of induction machine with slip rings"
  extends Modelica.Icons.Example;
  constant Integer m=3 "Number of phases";
  parameter SI.Voltage VsNominal=100
    "Nominal RMS voltage per phase";
  parameter SI.Frequency fNominal=aimsData.fsNominal "Nominal frequency";
  parameter SI.Time tOn=0.1 "Start time of machine";
  parameter SI.Resistance RStart=0.16/aimsData.turnsRatio^2
    "Starting resistance";
  parameter SI.Time tRheostat=1.0
    "Time of shortening the rheostat";
  parameter SI.Torque T_Load=161.4 "Nominal load torque";
  parameter SI.AngularVelocity w_Load(displayUnit="rev/min")=
       Modelica.Units.Conversions.from_rpm(1440.45)
    "Nominal load speed";
  parameter SI.Inertia J_Load=0.29 "Load inertia";
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(
        origin={-90,90},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Polyphase.Basic.Star star(final m=m) annotation (
      Placement(transformation(extent={{-50,80},{-70,100}})));
  Modelica.Electrical.Polyphase.Sources.SineVoltage sineVoltage(
    final m=m,
    V=fill(sqrt(2.0/3.0)*VsNominal, m),
    f=fill(fNominal, m)) annotation (Placement(transformation(
        origin={-30,90},
        extent={{10,-10},{-10,10}})));
  Modelica.Electrical.Polyphase.Ideal.IdealClosingSwitch idealCloser(
    final m=m,
    Ron=fill(1e-5, m),
    Goff=fill(1e-5, m)) annotation (Placement(transformation(
        origin={0,60},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  Modelica.Blocks.Sources.BooleanStep booleanStep[m](each startTime=tOn)
    annotation (Placement(transformation(extent={{-60,50},{-40,70}})));
  Modelica.Electrical.Polyphase.Sensors.CurrentQuasiRMSSensor currentRMSsensorM
    annotation (Placement(transformation(
        origin={0,20},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  Modelica.Electrical.Machines.Sensors.CurrentQuasiRMSSensor
    currentRMSsensorE annotation (Placement(transformation(
        origin={-60,20},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Machines.Utilities.TerminalBox terminalBoxM(
      terminalConnection="D") annotation (Placement(transformation(extent={{-10,-14},
            {10,6}})));
  Modelica.Electrical.Machines.Utilities.TerminalBox terminalBoxE(
      terminalConnection="D") annotation (Placement(transformation(extent={{-10,-74},
            {10,-54}})));
  Magnetic.FundamentalWave.BasicMachines.InductionMachines.IM_SlipRing aimsM(
    Jr=aimsData.Jr,
    Js=aimsData.Js,
    p=aimsData.p,
    fsNominal=aimsData.fsNominal,
    Rs=aimsData.Rs,
    TsRef=aimsData.TsRef,
    alpha20s(displayUnit="1/K") = aimsData.alpha20s,
    Lssigma=aimsData.Lssigma,
    ratioCommonStatorLeakage=aimsData.ratioCommonStatorLeakage,
    Lszero=aimsData.Lszero,
    frictionParameters=aimsData.frictionParameters,
    statorCoreParameters=aimsData.statorCoreParameters,
    strayLoadParameters=aimsData.strayLoadParameters,
    phiMechanical(fixed=true),
    wMechanical(fixed=true),
    Lm=aimsData.Lm,
    Lrsigma=aimsData.Lrsigma,
    ratioCommonRotorLeakage=aimsData.ratioCommonRotorLeakage,
    Lrzero=aimsData.Lrzero,
    Rr=aimsData.Rr,
    TrRef=aimsData.TrRef,
    alpha20r(displayUnit="1/K") = aimsData.alpha20r,
    useTurnsRatio=aimsData.useTurnsRatio,
    VsNominal=aimsData.VsNominal,
    VrLockedRotor=aimsData.VrLockedRotor,
    rotorCoreParameters=aimsData.rotorCoreParameters,
    TurnsRatio=aimsData.turnsRatio,
    TsOperational=293.15,
    effectiveStatorTurns=aimsData.effectiveStatorTurns,
    TrOperational=293.15)
    annotation (Placement(transformation(extent={{-10,-30},{10,-10}})));
  Modelica.Electrical.Machines.BasicMachines.InductionMachines.IM_SlipRing
    aimsE(
    p=aimsData.p,
    fsNominal=aimsData.fsNominal,
    Rs=aimsData.Rs,
    TsRef=aimsData.TsRef,
    alpha20s(displayUnit="1/K") = aimsData.alpha20s,
    Lszero=aimsData.Lszero,
    Lssigma=aimsData.Lssigma,
    Jr=aimsData.Jr,
    Js=aimsData.Js,
    frictionParameters=aimsData.frictionParameters,
    phiMechanical(fixed=true),
    wMechanical(fixed=true),
    statorCoreParameters=aimsData.statorCoreParameters,
    strayLoadParameters=aimsData.strayLoadParameters,
    Lm=aimsData.Lm,
    Lrsigma=aimsData.Lrsigma,
    Lrzero=aimsData.Lrzero,
    Rr=aimsData.Rr,
    TrRef=aimsData.TrRef,
    alpha20r(displayUnit="1/K") = aimsData.alpha20r,
    useTurnsRatio=aimsData.useTurnsRatio,
    VsNominal=aimsData.VsNominal,
    VrLockedRotor=aimsData.VrLockedRotor,
    rotorCoreParameters=aimsData.rotorCoreParameters,
    TsOperational=566.3,
    turnsRatio=aimsData.turnsRatio,
    TrOperational=566.3) annotation (Placement(transformation(extent={{-10,
            -90},{10,-70}})));
  Modelica.Electrical.Machines.Utilities.SwitchedRheostat rheostatM(
    RStart=RStart,
    tStart=tRheostat,
    m=m) annotation (Placement(transformation(extent={{-40,-30},{-20,-10}})));
  Modelica.Electrical.Machines.Utilities.SwitchedRheostat rheostatE(
    RStart=RStart,
    tStart=tRheostat,
    m=m) annotation (Placement(transformation(extent={{-40,-90},{-20,-70}})));
  Modelica.Mechanics.Rotational.Components.Inertia loadInertiaM(J=J_Load)
    annotation (Placement(transformation(extent={{50,-30},{70,-10}})));
  Modelica.Mechanics.Rotational.Components.Inertia loadInertiaE(J=J_Load)
    annotation (Placement(transformation(extent={{50,-90},{70,-70}})));
  Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
    quadraticLoadTorqueM(
    tau_nominal=-T_Load,
    TorqueDirection=false,
    useSupport=false,
    w_nominal=w_Load) annotation (Placement(transformation(extent={{100,-30},
            {80,-10}})));
  Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
    quadraticLoadTorqueE(
    tau_nominal=-T_Load,
    TorqueDirection=false,
    useSupport=false,
    w_nominal=w_Load) annotation (Placement(transformation(extent={{100,-90},
            {80,-70}})));
  parameter
    Modelica.Electrical.Machines.Utilities.ParameterRecords.IM_SlipRingData aimsData
    "Induction machine data"
    annotation (Placement(transformation(extent={{70,72},{90,92}})));
initial equation
  aimsE.is = zeros(3);
  aimsE.ir = zeros(3);
  aimsM.is = zeros(3);
  aimsM.ir = zeros(3);
equation
  connect(star.pin_n, ground.p)
    annotation (Line(points={{-70,90},{-80,90}}, color={0,0,255}));
  connect(sineVoltage.plug_n, star.plug_p) annotation (Line(points={{-40,
          90},{-40,90},{-50,90}}, color={0,0,255}));
  connect(loadInertiaE.flange_b, quadraticLoadTorqueE.flange)
    annotation (Line(points={{70,-80},{80,-80}}));
  connect(aimsE.flange, loadInertiaE.flange_a)
    annotation (Line(points={{10,-80},{50,-80}}));
  connect(booleanStep.y, idealCloser.control)
    annotation (Line(points={{-39,60},{-12,60}},color={255,0,255}));
  connect(terminalBoxE.plug_sn, aimsE.plug_sn)
    annotation (Line(points={{-6,-70},{-6,-70}}, color={0,0,255}));
  connect(terminalBoxE.plug_sp, aimsE.plug_sp)
    annotation (Line(points={{6,-70},{6,-70}}, color={0,0,255}));
  connect(rheostatE.plug_p, aimsE.plug_rp) annotation (Line(points={{-20,
          -74},{-18,-74},{-10,-74}}, color={0,0,255}));
  connect(rheostatE.plug_n, aimsE.plug_rn) annotation (Line(points={{-20,
          -86},{-18,-86},{-10,-86}}, color={0,0,255}));
  connect(loadInertiaM.flange_b, quadraticLoadTorqueM.flange) annotation (
     Line(points={{70,-20},{70,-20},{80,-20}}));
  connect(aimsM.flange, loadInertiaM.flange_a) annotation (Line(points={{
          10,-20},{10,-20},{50,-20}}));
  connect(terminalBoxM.plug_sp, aimsM.plug_sp)
    annotation (Line(points={{6,-10},{6,-10}}, color={0,0,255}));
  connect(terminalBoxM.plug_sn, aimsM.plug_sn)
    annotation (Line(points={{-6,-10},{-6,-10}}, color={0,0,255}));
  connect(currentRMSsensorM.plug_n, terminalBoxM.plugSupply) annotation (
      Line(
      points={{0,10},{0,-8}},
      color={0,0,255}));
  connect(rheostatM.plug_p, aimsM.plug_rp) annotation (Line(
      points={{-20,-14},{-10,-14}},
      color={0,0,255}));
  connect(rheostatM.plug_n, aimsM.plug_rn) annotation (Line(
      points={{-20,-26},{-10,-26}},
      color={0,0,255}));
  connect(currentRMSsensorE.plug_n, terminalBoxE.plugSupply) annotation (
      Line(
      points={{-60,10},{-60,-60},{0,-60},{0,-68}},
      color={0,0,255}));
  connect(idealCloser.plug_n, currentRMSsensorM.plug_p) annotation (Line(
      points={{0,50},{0,45},{0,40},{0,30}},
      color={0,0,255}));

  connect(currentRMSsensorE.plug_p, idealCloser.plug_n) annotation (Line(
      points={{-60,30},{0,30},{0,50}},
      color={0,0,255}));
  connect(idealCloser.plug_p, sineVoltage.plug_p) annotation (Line(
      points={{0,70},{0,90},{-20,90}},
      color={0,0,255}));
  annotation (experiment(
      StopTime=1.5,
      Interval=1E-4,
      Tolerance=1e-06), Documentation(info="<html>
<p>
At start time <code>tOn</code> three-phase voltage is supplied to the
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.InductionMachines.IM_SlipRing\">induction machine with sliprings</a>.
The machine starts from standstill, accelerating inertias against load torque quadratic dependent on speed,
using a starting resistance. At time tRheostat external rotor resistance is shortened, finally reaching nominal speed.</p>

<p>
Simulate for 1.5 seconds and plot (versus time):
</p>

<ul>
<li><code>currentRMSsensorM|E.I</code>: equivalent RMS stator current</li>
<li><code>aimsM/E.wMechanical</code>: machine speed</li>
<li><code>aimsM|E.tauElectrical</code>: machine torque</li>
</ul>
</html>"));
end IMS_Start;
