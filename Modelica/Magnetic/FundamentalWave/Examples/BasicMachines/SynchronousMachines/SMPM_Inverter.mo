within Modelica.Magnetic.FundamentalWave.Examples.BasicMachines.SynchronousMachines;
model SMPM_Inverter
  "Starting of permanent magnet synchronous machine with inverter"
  extends Modelica.Icons.Example;
  constant Integer m=3 "Number of phases";
  parameter SI.Voltage VsNominal=100
    "Nominal RMS voltage per phase";
  parameter SI.Frequency fsNominal=smpmData.fsNominal "Nominal frequency";
  parameter SI.Frequency fKnee=50
    "Knee frequency of V/f curve";
  parameter SI.Time tRamp=1 "Frequency ramp";
  parameter SI.Torque T_Load=181.4 "Nominal load torque";
  parameter SI.Time tStep=1.2 "Time of load torque step";
  parameter SI.Inertia J_Load=0.29 "Load inertia";
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
    fNominal=fsNominal,
    BasePhase=+Modelica.Constants.pi/2) annotation (Placement(
        transformation(extent={{-40,50},{-20,70}})));
  Modelica.Electrical.Polyphase.Sensors.CurrentQuasiRMSSensor currentRMSsensorM
    annotation (Placement(transformation(
        origin={0,30},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  Modelica.Electrical.Machines.Sensors.CurrentQuasiRMSSensor
    currentRMSsensorE annotation (Placement(transformation(
        origin={-60,30},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Machines.Utilities.TerminalBox terminalBoxM(
      terminalConnection="Y") annotation (Placement(transformation(extent={{-10,-14},
            {10,6}})));
  Modelica.Electrical.Machines.Utilities.TerminalBox terminalBoxE(
      terminalConnection="Y") annotation (Placement(transformation(extent={{-10,-74},
            {10,-54}})));
  Magnetic.FundamentalWave.BasicMachines.SynchronousMachines.SM_PermanentMagnet
    smpmM(
    Jr=smpmData.Jr,
    Js=smpmData.Js,
    p=smpmData.p,
    fsNominal=smpmData.fsNominal,
    Rs=smpmData.Rs,
    TsRef=smpmData.TsRef,
    alpha20s(displayUnit="1/K") = smpmData.alpha20s,
    Lssigma=smpmData.Lssigma,
    ratioCommonStatorLeakage=smpmData.ratioCommonStatorLeakage,
    Lszero=smpmData.Lszero,
    phiMechanical(fixed=true),
    wMechanical(fixed=true),
    Lmd=smpmData.Lmd,
    Lmq=smpmData.Lmq,
    useDamperCage=smpmData.useDamperCage,
    Lrsigmad=smpmData.Lrsigmad,
    Lrsigmaq=smpmData.Lrsigmaq,
    Rrd=smpmData.Rrd,
    Rrq=smpmData.Rrq,
    TrRef=smpmData.TrRef,
    alpha20r(displayUnit="1/K") = smpmData.alpha20r,
    VsOpenCircuit=smpmData.VsOpenCircuit,
    frictionParameters=smpmData.frictionParameters,
    statorCoreParameters=smpmData.statorCoreParameters,
    strayLoadParameters=smpmData.strayLoadParameters,
    permanentMagnetLossParameters=smpmData.permanentMagnetLossParameters,
    ir(each fixed=true),
    TsOperational=293.15,
    effectiveStatorTurns=smpmData.effectiveStatorTurns,
    TrOperational=293.15)
    annotation (Placement(transformation(extent={{-10,-30},{10,-10}})));

  Modelica.Electrical.Machines.BasicMachines.SynchronousMachines.SM_PermanentMagnet
    smpmE(
    p=smpmData.p,
    fsNominal=smpmData.fsNominal,
    Rs=smpmData.Rs,
    TsRef=smpmData.TsRef,
    alpha20s(displayUnit="1/K") = smpmData.alpha20s,
    Lszero=smpmData.Lszero,
    Lssigma=smpmData.Lssigma,
    Jr=smpmData.Jr,
    Js=smpmData.Js,
    frictionParameters=smpmData.frictionParameters,
    phiMechanical(fixed=true),
    wMechanical(fixed=true),
    statorCoreParameters=smpmData.statorCoreParameters,
    strayLoadParameters=smpmData.strayLoadParameters,
    VsOpenCircuit=smpmData.VsOpenCircuit,
    Lmd=smpmData.Lmd,
    Lmq=smpmData.Lmq,
    useDamperCage=smpmData.useDamperCage,
    Lrsigmad=smpmData.Lrsigmad,
    Lrsigmaq=smpmData.Lrsigmaq,
    Rrd=smpmData.Rrd,
    Rrq=smpmData.Rrq,
    TrRef=smpmData.TrRef,
    alpha20r(displayUnit="1/K") = smpmData.alpha20r,
    permanentMagnetLossParameters=smpmData.permanentMagnetLossParameters,
    TsOperational=293.15,
    ir(each fixed=true),
    TrOperational=293.15) annotation (Placement(transformation(extent={{-10,
            -90},{10,-70}})));

  Modelica.Electrical.Machines.Sensors.RotorDisplacementAngle rotorAngleM(
      p=smpmM.p) annotation (Placement(transformation(
        origin={30,-20},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  Modelica.Electrical.Machines.Sensors.RotorDisplacementAngle rotorAngleE(
      p=smpmE.p) annotation (Placement(transformation(
        origin={30,-80},
        extent={{-10,10},{10,-10}},
        rotation=270)));
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
    Modelica.Electrical.Machines.Utilities.ParameterRecords.SM_PermanentMagnetData
    smpmData "Synchronous machine data"
    annotation (Placement(transformation(extent={{-40,-100},{-20,-80}})));
  SI.Angle thetaM=rotorAngleM.rotorDisplacementAngle "Rotor displacement angle, FundamentalWave machine";
  SI.Angle thetaE=rotorAngleE.rotorDisplacementAngle "Rotor displacement angle, Electrical machine";
initial equation
  smpmE.is[1:2] = zeros(2);
  smpmM.is[1:2] = zeros(2);
  //conditional damper cage currents are defined as fixed start values
equation
  connect(signalVoltage.plug_n, star.plug_p)
    annotation (Line(points={{0,70},{0,90},{-50,90}}, color={0,0,255}));
  connect(star.pin_n, ground.p)
    annotation (Line(points={{-70,90},{-80,90}}, color={0,0,255}));
  connect(ramp.y, vfController.u)
    annotation (Line(points={{-59,60},{-42,60}}, color={0,0,255}));
  connect(vfController.y, signalVoltage.v)
    annotation (Line(points={{-19,60},{-12,60}},color={0,0,255}));
  connect(loadInertiaM.flange_b, torqueStepM.flange)
    annotation (Line(points={{70,-20},{80,-20}}));
  connect(signalVoltage.plug_p, currentRMSsensorM.plug_p)
    annotation (Line(points={{0,50},{0,50},{0,40}}, color={0,0,255}));
  connect(rotorAngleM.plug_n, smpmM.plug_sn) annotation (Line(points={{36,
          -10},{36,0},{-6,0},{-6,-10}}, color={0,0,255}));
  connect(rotorAngleM.plug_p, smpmM.plug_sp) annotation (Line(points={{24,
          -10},{15,-10},{6,-10}}, color={0,0,255}));
  connect(rotorAngleM.flange, smpmM.flange)
    annotation (Line(points={{20,-20},{10,-20}}));
  connect(smpmM.flange, loadInertiaM.flange_a)
    annotation (Line(points={{10,-20},{50,-20}}));
  connect(terminalBoxM.plug_sn, smpmM.plug_sn)
    annotation (Line(points={{-6,-10},{-6,-10}}, color={0,0,255}));
  connect(terminalBoxM.plug_sp, smpmM.plug_sp)
    annotation (Line(points={{6,-10},{6,-10}}, color={0,0,255}));
  connect(terminalBoxM.plugSupply, currentRMSsensorM.plug_n) annotation (
      Line(points={{0,-8},{0,-8},{0,6},{0,20}},              color={0,0,
          255}));
  connect(loadInertiaE.flange_b, torqueStepE.flange)
    annotation (Line(points={{70,-80},{80,-80}}));
  connect(rotorAngleE.plug_n, smpmE.plug_sn) annotation (Line(points={{36,
          -70},{36,-60},{-6,-60},{-6,-70}}, color={0,0,255}));
  connect(rotorAngleE.plug_p, smpmE.plug_sp)
    annotation (Line(points={{24,-70},{6,-70}}, color={0,0,255}));
  connect(rotorAngleE.flange, smpmE.flange)
    annotation (Line(points={{20,-80},{10,-80}}));
  connect(smpmE.flange, loadInertiaE.flange_a)
    annotation (Line(points={{10,-80},{50,-80}}));
  connect(terminalBoxE.plug_sn, smpmE.plug_sn)
    annotation (Line(points={{-6,-70},{-6,-70}}, color={0,0,255}));
  connect(terminalBoxE.plug_sp, smpmE.plug_sp)
    annotation (Line(points={{6,-70},{6,-70}}, color={0,0,255}));
  connect(currentRMSsensorE.plug_n, terminalBoxE.plugSupply) annotation (
      Line(points={{-60,20},{-60,-50},{0,-50},{0,-68}}, color={0,0,255}));
  connect(currentRMSsensorE.plug_p, signalVoltage.plug_p) annotation (
      Line(
      points={{-60,40},{0,40},{0,50}},
      color={0,0,255}));
  annotation (experiment(
      StopTime=1.5,
      Interval=1E-4,
      Tolerance=1e-006), Documentation(info="<html>
<h4>Permanent magnet synchronous machine fed by an ideal inverter</h4>
<p>

An ideal frequency inverter is modeled by using a
<a href=\"modelica://Modelica.Electrical.Machines.Utilities.VfController\">VfController</a>
and a three-phase <a href=\"modelica://Modelica.Electrical.Polyphase.Sources.SignalVoltage\">SignalVoltage</a>.
Frequency is raised by a ramp, causing the
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.SynchronousMachines.SM_PermanentMagnet\">permanent magnet synchronous machine</a> to start,
and accelerate the inertias.</p>

<p>At time tStep a load step is applied. Simulate for 1.5 seconds and plot (versus time):</p>

<ul>
<li><code>currentRMSsensorM|E.I</code>: equivalent RMS stator current</li>
<li><code>smpmM|E.wMechanical</code>: machine speed</li>
<li><code>smpmM|E.tauElectrical</code>: machine torque</li>
<li><code>rotorAnglepmsmM|E.rotorDisplacementAngle</code>: rotor displacement angle</li>
</ul>
</html>"));
end SMPM_Inverter;
