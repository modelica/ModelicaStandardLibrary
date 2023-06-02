within Modelica.Electrical.Machines.Examples.InductionMachines;
model IMC_Inverter
  "Test example: InductionMachineSquirrelCage with inverter"
  extends Modelica.Icons.Example;
  constant Integer m=3 "Number of phases";
  parameter SI.Voltage VNominal=100
    "Nominal RMS voltage per phase";
  parameter SI.Frequency fNominal=50 "Nominal frequency";
  parameter SI.Frequency f=50 "Actual frequency";
  parameter SI.Time tRamp=1 "Frequency ramp";
  parameter SI.Torque TLoad=161.4 "Nominal load torque";
  parameter SI.Time tStep=1.2 "Time of load torque step";
  parameter SI.Inertia JLoad=0.29
    "Load's moment of inertia";
  Machines.BasicMachines.InductionMachines.IM_SquirrelCage aimc(
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
    TrRef=aimcData.TrRef,
    TsOperational=293.15,
    alpha20r=aimcData.alpha20r,
    TrOperational=293.15)
    annotation (Placement(transformation(extent={{-20,-50},{0,-30}})));
  Machines.Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensor annotation (
      Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-10,-10})));
  Modelica.Blocks.Sources.Ramp ramp(height=f, duration=tRamp) annotation (
     Placement(transformation(extent={{-100,20},{-80,40}})));
  Machines.Utilities.VfController vfController(
    final m=m,
    VNominal=VNominal,
    fNominal=fNominal)
    annotation (Placement(transformation(extent={{-70,20},{-50,40}})));
  Modelica.Electrical.Polyphase.Sources.SignalVoltage signalVoltage(
      final m=m) annotation (Placement(transformation(
        origin={30,30},
        extent={{10,10},{-10,-10}},
        rotation=270)));
  Modelica.Electrical.Polyphase.Basic.Star star(final m=m) annotation (
      Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=270,
        origin={30,60})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(
        origin={30,90},
        extent={{-10,-10},{10,10}},
        rotation=180)));
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
  parameter Utilities.ParameterRecords.IM_SquirrelCageData aimcData "Induction machine data"
    annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
initial equation
  aimc.is[1:2] = zeros(2);
  aimc.ir = zeros(2);
equation
  connect(signalVoltage.plug_n, star.plug_p)
    annotation (Line(points={{30,40},{30,50}},        color={0,0,255}));
  connect(star.pin_n, ground.p)
    annotation (Line(points={{30,70},{30,80}},   color={0,0,255}));
  connect(ramp.y, vfController.u)
    annotation (Line(points={{-79,30},{-72,30}}, color={0,0,255}));
  connect(vfController.y, signalVoltage.v)
    annotation (Line(points={{-49,30},{18,30}}, color={0,0,255}));
  connect(loadTorqueStep.flange, loadInertia.flange_b)
    annotation (Line(points={{70,-40},{60,-40}}));
  connect(signalVoltage.plug_p, currentQuasiRMSSensor.plug_p)
    annotation (Line(points={{30,20},{30,10},{-10,10},{-10,-1.77636e-15}},
                                                    color={0,0,255}));
  connect(terminalBox.plugSupply, currentQuasiRMSSensor.plug_n)
    annotation (Line(
      points={{-10,-28},{-10,-20}},
      color={0,0,255}));
  connect(terminalBox.plug_sn, aimc.plug_sn) annotation (Line(
      points={{-16,-30},{-16,-30}},
      color={0,0,255}));
  connect(terminalBox.plug_sp, aimc.plug_sp) annotation (Line(
      points={{-4,-30},{-4,-30}},
      color={0,0,255}));
  connect(aimc.flange, loadInertia.flange_a) annotation (Line(
      points={{0,-40},{40,-40}}));
  annotation (experiment(StopTime=1.5, Interval=1E-4, Tolerance=1e-06), Documentation(
        info="<html>
<p>
An ideal frequency inverter is modeled by using a VfController and a three-phase SignalVoltage.
Frequency is raised by a ramp, causing the induction machine with squirrel cage to start,
and accelerating inertias.<br>At time tStep a load step is applied.</p>

<p>Simulate for 1.5 seconds and plot (versus time):</p>

<ul>
<li>currentQuasiRMSSensor.I: stator current RMS</li>
<li>aimc.wMechanical: motor's speed</li>
<li>aimc.tauElectrical: motor's torque</li>
</ul>

<p>Default machine parameters are used.</p>
</html>"));
end IMC_Inverter;
