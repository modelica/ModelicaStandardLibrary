within Modelica.Electrical.Machines.Examples.SynchronousMachines;
model SMR_Inverter
  "Test example: SynchronousMachineReluctanceRotor with inverter"
  extends Modelica.Icons.Example;
  constant Integer m=3 "Number of phases";
  parameter SI.Voltage VNominal=100
    "Nominal RMS voltage per phase";
  parameter SI.Frequency fNominal=50 "Nominal frequency";
  parameter SI.Frequency f=50 "Actual frequency";
  parameter SI.Time tRamp=1 "Frequency ramp";
  parameter SI.Torque TLoad=46 "Nominal load torque";
  parameter SI.Time tStep=1.2 "Time of load torque step";
  parameter SI.Inertia JLoad=0.29
    "Load's moment of inertia";
  Machines.BasicMachines.SynchronousMachines.SM_ReluctanceRotor smr(
    p=smrData.p,
    fsNominal=smrData.fsNominal,
    Rs=smrData.Rs,
    TsRef=smrData.TsRef,
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
    TsOperational=293.15,
    alpha20s=smrData.alpha20s,
    ir(each fixed=true),
    TrOperational=293.15,
    alpha20r=smrData.alpha20r)
    annotation (Placement(transformation(extent={{-20,-50},{0,-30}})));
  Machines.Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensor annotation (
      Placement(transformation(
        origin={0,30},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  Machines.Sensors.RotorDisplacementAngle rotorDisplacementAngle(p=smr.p)
    annotation (Placement(transformation(
        origin={20,-40},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  Modelica.Blocks.Sources.Ramp ramp(height=f, duration=tRamp) annotation (
     Placement(transformation(extent={{-80,50},{-60,70}})));
  Machines.Utilities.VfController vfController(
    final m=m,
    VNominal=VNominal,
    fNominal=fNominal)
    annotation (Placement(transformation(extent={{-40,50},{-20,70}})));
  Modelica.Electrical.Polyphase.Sources.SignalVoltage signalVoltage(
      final m=m) annotation (Placement(transformation(
        origin={0,60},
        extent={{10,10},{-10,-10}},
        rotation=270)));
  Modelica.Electrical.Polyphase.Basic.Star star(final m=m) annotation (
      Placement(transformation(extent={{-50,80},{-70,100}})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(
        origin={-90,90},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Mechanics.Rotational.Components.Inertia loadInertia(J=JLoad)
    annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
  Modelica.Mechanics.Rotational.Sources.TorqueStep loadTorqueStep(
    startTime=tStep,
    stepTorque=-TLoad,
    useSupport=false,
    offsetTorque=0) annotation (Placement(transformation(extent={{90,-50},
            {70,-30}})));
  Machines.Utilities.TerminalBox terminalBox(terminalConnection="Y")
    annotation (Placement(transformation(extent={{-20,-34},{0,-14}})));
  parameter Utilities.ParameterRecords.SM_ReluctanceRotorData smrData "Synchronous machine data"
    annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
initial equation
  smr.is[1:2] = zeros(2);
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
  connect(loadInertia.flange_b, loadTorqueStep.flange)
    annotation (Line(points={{60,-40},{70,-40}}));
  connect(currentQuasiRMSSensor.plug_p, signalVoltage.plug_p)
    annotation (Line(points={{0,40},{0,42.5},{0,50}}, color={0,0,255}));
  connect(smr.plug_sn, rotorDisplacementAngle.plug_n) annotation (Line(
        points={{-16,-30},{-16,-20},{26,-20},{26,-30}}, color={0,0,255}));
  connect(smr.plug_sp, rotorDisplacementAngle.plug_p)
    annotation (Line(points={{-4,-30},{14,-30}}, color={0,0,255}));
  connect(terminalBox.plugSupply, currentQuasiRMSSensor.plug_n)
    annotation (Line(
      points={{-10,-28},{-10,0},{0,0},{0,20}},
      color={0,0,255}));
  connect(terminalBox.plug_sp, smr.plug_sp) annotation (Line(
      points={{-4,-30},{-4,-30}},
      color={0,0,255}));
  connect(terminalBox.plug_sn, smr.plug_sn) annotation (Line(
      points={{-16,-30},{-16,-30}},
      color={0,0,255}));
  connect(smr.flange, rotorDisplacementAngle.flange) annotation (Line(
      points={{0,-40},{10,-40}}));
  connect(smr.flange, loadInertia.flange_a) annotation (Line(
      points={{0,-40},{40,-40}}));
  annotation (experiment(StopTime=1.5, Interval=1E-4, Tolerance=1e-06), Documentation(
        info="<html>
<p>An ideal frequency inverter is modeled by using a VfController and a three-phase SignalVoltage.
Frequency is raised by a ramp, causing the reluctance machine to start,
and accelerating inertias. At time tStep a load step is applied.</p>

<p>Simulate for 1.5 seconds and plot (versus time):</p>

<ul>
<li>currentQuasiRMSSensor.I: stator current RMS</li>
<li>smr.wMechanical: motor's speed</li>
<li>smr.tauElectrical: motor's torque</li>
<li>rotorDisplacementAngle.rotorDisplacementAngle: rotor displacement angle</li>
</ul>

<p>Default machine parameters are used.</p>
</html>"));
end SMR_Inverter;
