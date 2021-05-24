within Modelica.Magnetic.FundamentalWave.Examples.BasicMachines.InductionMachines;
model IMC_DOL
  "Direct on line (DOL) start of induction machine with squirrel cage"
  extends Modelica.Icons.Example;
  constant Integer m=3 "Number of stator phases";
  parameter SI.Voltage VsNominal=100
    "Nominal RMS voltage per phase";
  parameter SI.Frequency fNominal=aimcData.fsNominal "Nominal frequency";
  parameter SI.Time tOn=0.1 "Start time of machine";
  parameter SI.Torque T_Load=161.4 "Nominal load torque";
  parameter SI.AngularVelocity w_Load(displayUnit="rev/min")=
       1440.45*2*Modelica.Constants.pi/60 "Nominal load speed";
  parameter SI.Inertia J_Load=0.29 "Load inertia";
  parameter Integer p=2 "Number of pole pairs";
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(
        origin={-90,90},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Polyphase.Basic.Star star(final m=m) annotation (
      Placement(transformation(extent={{-50,80},{-70,100}})));
  Modelica.Electrical.Polyphase.Sources.SineVoltage sineVoltage(
    final m=m,
    f=fill(fNominal, m),
    V=fill(sqrt(2.0/3.0)*VsNominal, m)) annotation (Placement(
        transformation(
        origin={-30,90},
        extent={{10,-10},{-10,10}})));
  Modelica.Electrical.Polyphase.Ideal.IdealClosingSwitch idealCloser(
    final m=m,
    Ron=fill(1e-5, m),
    Goff=fill(1e-5, m)) annotation (Placement(transformation(
        origin={0,60},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  Modelica.Blocks.Sources.BooleanStep booleanStep[m](each startTime=tOn, each
      startValue=false)
    annotation (Placement(transformation(extent={{-60,50},{-40,70}})));
  Modelica.Electrical.Machines.Sensors.CurrentQuasiRMSSensor
    currentRMSsensorM annotation (Placement(transformation(
        origin={0,30},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  Modelica.Electrical.Machines.Sensors.CurrentQuasiRMSSensor
    currentRMSsensorE annotation (Placement(transformation(
        origin={-60,30},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Machines.Utilities.TerminalBox terminalBoxM(
      terminalConnection="D") annotation (Placement(transformation(extent={{-10,-14},
            {10,6}})));
  Modelica.Electrical.Machines.Utilities.TerminalBox terminalBoxE(
      terminalConnection="D") annotation (Placement(transformation(extent={{-10,-74},
            {10,-54}})));
  Magnetic.FundamentalWave.BasicMachines.InductionMachines.IM_SquirrelCage aimcM(
    Jr=aimcData.Jr,
    Js=aimcData.Js,
    p=aimcData.p,
    fsNominal=aimcData.fsNominal,
    Rs=aimcData.Rs,
    TsRef=aimcData.TsRef,
    alpha20s(displayUnit="1/K") = aimcData.alpha20s,
    Lssigma=aimcData.Lssigma,
    ratioCommonStatorLeakage=aimcData.ratioCommonStatorLeakage,
    Lszero=aimcData.Lszero,
    frictionParameters=aimcData.frictionParameters,
    statorCoreParameters=aimcData.statorCoreParameters,
    strayLoadParameters=aimcData.strayLoadParameters,
    Lm=aimcData.Lm,
    Lrsigma=aimcData.Lrsigma,
    Rr=aimcData.Rr,
    TrRef=aimcData.TrRef,
    alpha20r(displayUnit="1/K") = aimcData.alpha20r,
    phiMechanical(fixed=true),
    wMechanical(fixed=true),
    TsOperational=293.15,
    effectiveStatorTurns=aimcData.effectiveStatorTurns,
    TrOperational=293.15)
    annotation (Placement(transformation(extent={{-10,-30},{10,-10}})));
  Modelica.Electrical.Machines.BasicMachines.InductionMachines.IM_SquirrelCage
    aimcE(
    p=aimcData.p,
    fsNominal=aimcData.fsNominal,
    Rs=aimcData.Rs,
    TsRef=aimcData.TsRef,
    alpha20s(displayUnit="1/K") = aimcData.alpha20s,
    Lszero=aimcData.Lszero,
    Lssigma=aimcData.Lssigma,
    Jr=aimcData.Jr,
    Js=aimcData.Js,
    frictionParameters=aimcData.frictionParameters,
    phiMechanical(fixed=true),
    wMechanical(fixed=true),
    statorCoreParameters=aimcData.statorCoreParameters,
    strayLoadParameters=aimcData.strayLoadParameters,
    Lm=aimcData.Lm,
    Lrsigma=aimcData.Lrsigma,
    Rr=aimcData.Rr,
    alpha20r(displayUnit="1/K") = aimcData.alpha20r,
    TsOperational=293.15,
    TrRef=aimcData.TrRef,
    TrOperational=293.15) annotation (Placement(transformation(extent={{-10,
            -90},{10,-70}})));
  Modelica.Mechanics.Rotational.Components.Inertia loadInertiaM(J=J_Load)
    annotation (Placement(transformation(extent={{50,-30},{70,-10}})));
  Modelica.Mechanics.Rotational.Components.Inertia loadInertiaE(J=J_Load)
    annotation (Placement(transformation(extent={{50,-90},{70,-70}})));
  Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
    quadraticLoadTorqueM(
    w_nominal=w_Load,
    tau_nominal=-T_Load,
    TorqueDirection=false,
    useSupport=false) annotation (Placement(transformation(extent={{100,-30},
            {80,-10}})));
  Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
    quadraticLoadTorqueE(
    w_nominal=w_Load,
    tau_nominal=-T_Load,
    TorqueDirection=false,
    useSupport=false) annotation (Placement(transformation(extent={{100,-90},
            {80,-70}})));
  parameter
    Modelica.Electrical.Machines.Utilities.ParameterRecords.IM_SquirrelCageData
    aimcData "Induction machine data"
    annotation (Placement(transformation(extent={{-40,-100},{-20,-80}})));
  Modelica.Electrical.Polyphase.Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensor
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={0,10})));
initial equation
  aimcE.is = zeros(m);
  aimcE.ir = zeros(2);
  aimcM.is = zeros(m);
  aimcM.rotorCage.electroMagneticConverter.Phi = Complex(0, 0);

equation
  connect(star.pin_n, ground.p)
    annotation (Line(points={{-70,90},{-80,90}}, color={0,0,255}));
  connect(sineVoltage.plug_n, star.plug_p) annotation (Line(points={{-40,
          90},{-40,90},{-50,90}}, color={0,0,255}));
  connect(aimcM.flange, loadInertiaM.flange_a) annotation (Line(points={{
          10,-20},{10,-20},{50,-20}}));
  connect(loadInertiaM.flange_b, quadraticLoadTorqueM.flange)
    annotation (Line(points={{70,-20},{80,-20}}));
  connect(terminalBoxM.plug_sn, aimcM.plug_sn)
    annotation (Line(points={{-6,-10},{-6,-10}}, color={0,0,255}));
  connect(terminalBoxM.plug_sp, aimcM.plug_sp)
    annotation (Line(points={{6,-10},{6,-10}}, color={0,0,255}));
  connect(aimcE.flange, loadInertiaE.flange_a) annotation (Line(points={{
          10,-80},{10,-80},{50,-80}}));
  connect(loadInertiaE.flange_b, quadraticLoadTorqueE.flange)
    annotation (Line(points={{70,-80},{80,-80}}));
  connect(terminalBoxE.plug_sn, aimcE.plug_sn)
    annotation (Line(points={{-6,-70},{-6,-70}}, color={0,0,255}));
  connect(terminalBoxE.plug_sp, aimcE.plug_sp)
    annotation (Line(points={{6,-70},{6,-70}}, color={0,0,255}));
  connect(currentRMSsensorE.plug_n, terminalBoxE.plugSupply) annotation (
      Line(points={{-60,20},{-60,-60},{0,-60},{0,-68}}, color={0,0,255}));
  connect(sineVoltage.plug_p, idealCloser.plug_p) annotation (Line(
      points={{-20,90},{0,90},{0,70}},
      color={0,0,255}));
  connect(idealCloser.plug_n, currentRMSsensorM.plug_p) annotation (Line(
      points={{0,50},{0,47.5},{0,45},{0,
          40}},
      color={0,0,255}));
  connect(booleanStep.y, idealCloser.control) annotation (Line(
      points={{-39,60},{-12,60}},color={255,0,255}));
  connect(currentRMSsensorE.plug_p, idealCloser.plug_n) annotation (Line(
      points={{-60,40},{0,40},{0,50}},
      color={0,0,255}));
  connect(currentRMSsensorM.plug_n, currentQuasiRMSSensor.plug_p)
    annotation (Line(
      points={{0,20},{0,20}},
      color={0,0,255}));
  connect(terminalBoxM.plugSupply, currentQuasiRMSSensor.plug_n)
    annotation (Line(
      points={{0,-8},{0,0}},
      color={0,0,255}));
  annotation (experiment(
      StopTime=1.5,
      Interval=1E-4,
      Tolerance=1e-06), Documentation(info="<html>
<p>
At start time tStart three-phase voltage is supplied to the
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.InductionMachines.IM_SquirrelCage\">induction machine with squirrel cage</a>.
The machine starts from standstill, accelerating
inertias against load torque quadratic dependent on speed, finally reaching nominal speed.</p>

<p>
Simulate for 1.5 seconds and plot (versus time):
</p>

<ul>
<li><code>currentRMSsensorM|E.I</code>: equivalent RMS stator current</li>
<li><code>aimcM|E.wMechanical</code>: machine speed</li>
<li><code>aimcM|E.tauElectrical</code>: machine torque</li>
</ul>
</html>"));
end IMC_DOL;
