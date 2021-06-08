within Modelica.Magnetic.FundamentalWave.Examples.BasicMachines.SynchronousMachines;
model SMR_Inverter
  "Starting of synchronous reluctance machine with inverter"
  extends Modelica.Icons.Example;
  constant Integer m=3 "Number of stator phases";
  parameter SI.Voltage VsNominal=100
    "Nominal RMS voltage per phase";
  parameter SI.Frequency fsNominal=smrData.fsNominal "Nominal frequency";
  parameter SI.Frequency fKnee=50
    "Knee frequency of V/f curve";
  parameter SI.Time tRamp=1 "Frequency ramp";
  parameter SI.Torque T_Load=46 "Nominal load torque";
  parameter SI.Time tStep=1.2 "Time of load torque step";
  parameter SI.Inertia J_Load=0.29 "Load inertia";
  SI.Angle thetaM=rotorAngleM.rotorDisplacementAngle "Rotor displacement angle, FundamentalWave machine";
  SI.Angle thetaE=rotorAngleE.rotorDisplacementAngle "Rotor displacement angle, Electrical machine";

  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(
        origin={-90,90},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Polyphase.Basic.Star star(final m=m) annotation (
      Placement(transformation(extent={{-50,80},{-70,100}})));
  Modelica.Electrical.Polyphase.Sources.SignalVoltage signalVoltage(
      final m=m) annotation (Placement(transformation(
        origin={0,60},
        extent={{10,10},{-10,-10}},
        rotation=270)));
  Modelica.Blocks.Sources.Ramp ramp(height=fKnee, duration=tRamp)
    annotation (Placement(transformation(extent={{-80,50},{-60,70}})));
  Modelica.Electrical.Machines.Utilities.VfController vfController(
    final m=m,
    VNominal=VsNominal,
    fNominal=fsNominal) annotation (Placement(transformation(extent={{-40,
            50},{-20,70}})));
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
      terminalConnection="Y") annotation (Placement(transformation(extent={{-10,-14},
            {10,6}})));
  Modelica.Electrical.Machines.Utilities.TerminalBox terminalBoxE(
      terminalConnection="Y") annotation (Placement(transformation(extent={{-10,-74},
            {10,-54}})));
  Magnetic.FundamentalWave.BasicMachines.SynchronousMachines.SM_ReluctanceRotor
    smrM(
    Jr=smrData.Jr,
    Js=smrData.Js,
    p=smrData.p,
    fsNominal=smrData.fsNominal,
    Rs=smrData.Rs,
    TsRef=smrData.TsRef,
    alpha20s(displayUnit="1/K") = smrData.alpha20s,
    Lssigma=smrData.Lssigma,
    ratioCommonStatorLeakage=smrData.ratioCommonStatorLeakage,
    Lszero=smrData.Lszero,
    frictionParameters=smrData.frictionParameters,
    statorCoreParameters=smrData.statorCoreParameters,
    strayLoadParameters=smrData.strayLoadParameters,
    phiMechanical(fixed=true),
    wMechanical(fixed=true),
    Lmd=smrData.Lmd,
    Lmq=smrData.Lmq,
    useDamperCage=smrData.useDamperCage,
    Lrsigmad=smrData.Lrsigmad,
    Lrsigmaq=smrData.Lrsigmaq,
    Rrd=smrData.Rrd,
    Rrq=smrData.Rrq,
    TrRef=smrData.TrRef,
    alpha20r(displayUnit="1/K") = smrData.alpha20r,
    ir(each fixed=true),
    TsOperational=293.15,
    effectiveStatorTurns=smrData.effectiveStatorTurns,
    TrOperational=293.15)
    annotation (Placement(transformation(extent={{-10,-30},{10,-10}})));
  Modelica.Electrical.Machines.BasicMachines.SynchronousMachines.SM_ReluctanceRotor
    smrE(
    p=smrData.p,
    fsNominal=smrData.fsNominal,
    Rs=smrData.Rs,
    TsRef=smrData.TsRef,
    alpha20s(displayUnit="1/K") = smrData.alpha20s,
    Lszero=smrData.Lszero,
    Lssigma=smrData.Lssigma,
    Jr=smrData.Jr,
    Js=smrData.Js,
    frictionParameters=smrData.frictionParameters,
    phiMechanical(fixed=true),
    wMechanical(fixed=true),
    statorCoreParameters=smrData.statorCoreParameters,
    strayLoadParameters=smrData.strayLoadParameters,
    Lmd=smrData.Lmd,
    Lmq=smrData.Lmq,
    useDamperCage=smrData.useDamperCage,
    Lrsigmad=smrData.Lrsigmad,
    Lrsigmaq=smrData.Lrsigmaq,
    Rrd=smrData.Rrd,
    Rrq=smrData.Rrq,
    TrRef=smrData.TrRef,
    alpha20r(displayUnit="1/K") = smrData.alpha20r,
    TsOperational=293.15,
    ir(each fixed=true),
    TrOperational=293.15) annotation (Placement(transformation(extent={{-10,
            -90},{10,-70}})));
  Modelica.Electrical.Machines.Sensors.RotorDisplacementAngle rotorAngleM(
      p=smrM.p) annotation (Placement(transformation(
        origin={30,-20},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  Modelica.Electrical.Machines.Sensors.RotorDisplacementAngle rotorAngleE(
      p=smrE.p) annotation (Placement(transformation(
        origin={30,-80},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  Modelica.Mechanics.Rotational.Components.Inertia loadInertiaM(J=J_Load)
    annotation (Placement(transformation(extent={{50,-30},{70,-10}})));
  Modelica.Mechanics.Rotational.Components.Inertia loadInertiaE(J=J_Load)
    annotation (Placement(transformation(extent={{50,-90},{70,-70}})));
  Modelica.Mechanics.Rotational.Sources.TorqueStep torqueStepM(
    startTime=tStep,
    stepTorque=-T_Load,
    useSupport=false,
    offsetTorque=0) annotation (Placement(transformation(extent={{100,-30},
            {80,-10}})));
  Modelica.Mechanics.Rotational.Sources.TorqueStep torqueStepE(
    startTime=tStep,
    stepTorque=-T_Load,
    useSupport=false,
    offsetTorque=0) annotation (Placement(transformation(extent={{100,-90},
            {80,-70}})));
  parameter
    Modelica.Electrical.Machines.Utilities.ParameterRecords.SM_ReluctanceRotorData
    smrData "Synchronous machine data"
    annotation (Placement(transformation(extent={{-40,-100},{-20,-80}})));
initial equation
  smrE.is[1:2] = zeros(2);
  smrM.is[1:2] = zeros(2);
  //conditional damper cage currents are defined as fixed start values
equation
  connect(signalVoltage.plug_n, star.plug_p)
    annotation (Line(points={{0,70},{0,90},{-50,90}}, color={0,0,255}));
  connect(star.pin_n, ground.p)
    annotation (Line(points={{-70,90},{-80,90}}, color={0,0,255}));
  connect(smrE.flange, loadInertiaE.flange_a)
    annotation (Line(points={{10,-80},{50,-80}}));
  connect(ramp.y, vfController.u)
    annotation (Line(points={{-59,60},{-42,60}}, color={0,0,255}));
  connect(vfController.y, signalVoltage.v)
    annotation (Line(points={{-19,60},{-12,60}},color={0,0,255}));
  connect(loadInertiaE.flange_b, torqueStepE.flange)
    annotation (Line(points={{70,-80},{80,-80}}));
  connect(smrE.plug_sn, rotorAngleE.plug_n) annotation (Line(points={{-6,
          -70},{-6,-60},{36,-60},{36,-70}}, color={0,0,255}));
  connect(smrE.plug_sp, rotorAngleE.plug_p)
    annotation (Line(points={{6,-70},{24,-70}}, color={0,0,255}));
  connect(smrE.flange, rotorAngleE.flange)
    annotation (Line(points={{10,-80},{20,-80}}));
  connect(terminalBoxE.plug_sp, smrE.plug_sp)
    annotation (Line(points={{6,-70},{6,-70}}, color={0,0,255}));
  connect(terminalBoxE.plug_sn, smrE.plug_sn)
    annotation (Line(points={{-6,-70},{-6,-70}}, color={0,0,255}));
  connect(terminalBoxE.plugSupply, currentRMSsensorE.plug_n) annotation (
      Line(points={{0,-68},{0,-50},{-60,-50},{-60,10}}, color={0,0,255}));
  connect(smrM.flange, loadInertiaM.flange_a) annotation (Line(points={{
          10,-20},{10,-20},{50,-20}}));
  connect(loadInertiaM.flange_b, torqueStepM.flange)
    annotation (Line(points={{70,-20},{80,-20}}));
  connect(smrM.plug_sn, rotorAngleM.plug_n) annotation (Line(points={{-6,
          -10},{-6,0},{36,0},{36,-10}}, color={0,0,255}));
  connect(smrM.plug_sp, rotorAngleM.plug_p) annotation (Line(points={{6,-10},
          {6,-10},{24,-10}}, color={0,0,255}));
  connect(smrM.flange, rotorAngleM.flange) annotation (Line(points={{10,-20},
          {10,-20},{20,-20}}));
  connect(terminalBoxM.plug_sp, smrM.plug_sp)
    annotation (Line(points={{6,-10},{6,-10}}, color={0,0,255}));
  connect(terminalBoxM.plug_sn, smrM.plug_sn)
    annotation (Line(points={{-6,-10},{-6,-10}}, color={0,0,255}));
  connect(currentRMSsensorM.plug_n, terminalBoxM.plugSupply) annotation (
      Line(points={{0,10},{0,-8}},                             color={0,0,
          255}));
  connect(signalVoltage.plug_p, currentRMSsensorM.plug_p) annotation (
      Line(points={{0,50},{0,45},{0,40},
          {0,30}}, color={0,0,255}));
  connect(signalVoltage.plug_p, currentRMSsensorE.plug_p) annotation (
      Line(points={{0,50},{0,50},{0,30},{-60,30}}, color={0,0,255}));
  annotation (experiment(
      StopTime=1.5,
      Interval=1E-4,
      Tolerance=1e-06), Documentation(info="<html>
<h4>Synchronous machine with reluctance rotor fed by an ideal inverter</h4>
<p>
An ideal frequency inverter is modeled by using a
<a href=\"modelica://Modelica.Electrical.Machines.Utilities.VfController\">VfController</a>
and a three-phase <a href=\"modelica://Modelica.Electrical.Polyphase.Sources.SignalVoltage\">SignalVoltage</a>.
Frequency is raised by a ramp, causing the
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.SynchronousMachines.SM_ReluctanceRotor\">reluctance machine</a> to start,
and accelerating inertias. At time <code>tStep</code> a load step is applied.
</p>

<p>
Simulate for 1.5 seconds and plot (versus time):
</p>

<ul>
<li><code>currentRMSsensorM|E.I</code>: equivalent RMS stator current</li>
<li><code>smrM|E.wMechanical</code>: machine speed</li>
<li><code>smrM|E.tauElectrical</code>: machine torque</li>
<li><code>rotorAngleM|R.rotorDisplacementAngle</code>: rotor displacement angle</li>
</ul>
</html>"));
end SMR_Inverter;
