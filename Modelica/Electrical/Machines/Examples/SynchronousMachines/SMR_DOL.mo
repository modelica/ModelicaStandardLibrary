within Modelica.Electrical.Machines.Examples.SynchronousMachines;
model SMR_DOL
  "Test example: SynchronousMachineReluctanceRotor direct-on-line"
  extends Modelica.Icons.Example;
  constant Integer m=3 "Number of phases";
  parameter SI.Voltage VNominal=100
    "Nominal RMS voltage per phase";
  parameter SI.Frequency fNominal=50 "Nominal frequency";
  parameter SI.Frequency f=50 "Actual frequency";
  parameter SI.Time tStart1=0.1 "Switch-on time";
  parameter SI.Torque TLoad=20 "Nominal load torque";
  parameter SI.Time tStep=1.5 "Time of load torque step";
  parameter SI.Inertia JLoad=0.29
    "Load's moment of inertia";
  Modelica.Electrical.Machines.BasicMachines.SynchronousMachines.SM_ReluctanceRotor
    smr(
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
  Modelica.Electrical.Machines.Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensor
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270)));
  Modelica.Electrical.Machines.Sensors.RotorDisplacementAngle rotorDisplacementAngle(p=smr.p)
    annotation (Placement(transformation(
        origin={20,-40},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  Modelica.Mechanics.Rotational.Components.Inertia loadInertia(J=JLoad)
    annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
  Modelica.Mechanics.Rotational.Sources.TorqueStep loadTorqueStep(
    startTime=tStep,
    stepTorque=-TLoad,
    useSupport=false,
    offsetTorque=0) annotation (Placement(transformation(extent={{90,-50},
            {70,-30}})));
  Modelica.Electrical.Machines.Utilities.TerminalBox terminalBox(
      terminalConnection="Y")
    annotation (Placement(transformation(extent={{-20,-34},{0,-14}})));
  parameter
    Modelica.Electrical.Machines.Utilities.ParameterRecords.SM_ReluctanceRotorData
    smrData "Synchronous machine data"
    annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
  Modelica.Electrical.Polyphase.Sources.SineVoltage sineVoltage(
    final m=m,
    f=fill(fNominal, m),
    V=fill(sqrt(2/3)*VNominal, m)) annotation (Placement(transformation(
        origin={0,60},
        extent={{10,-10},{-10,10}},
        rotation=270)));
  Modelica.Electrical.Polyphase.Basic.Star star(final m=m) annotation (
      Placement(transformation(extent={{-50,80},{-70,100}})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(
        origin={-90,90},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Blocks.Sources.BooleanStep booleanStep[m](each startTime=
        tStart1) annotation (Placement(transformation(extent={{-80,30},{-60,
            50}})));
  Modelica.Electrical.Polyphase.Ideal.IdealClosingSwitch idealCloser(
    final m=m,
    Ron=fill(1e-5, m),
    Goff=fill(1e-5, m)) annotation (Placement(transformation(
        origin={0,30},
        extent={{-10,10},{10,-10}},
        rotation=270)));
initial equation
  smr.is[1:2] = zeros(2);
equation
  connect(loadInertia.flange_b, loadTorqueStep.flange)
    annotation (Line(points={{60,-40},{70,-40}}));
  connect(smr.plug_sn, rotorDisplacementAngle.plug_n) annotation (Line(
        points={{-16,-30},{-16,-20},{26,-20},{26,-30}}, color={0,0,255}));
  connect(smr.plug_sp, rotorDisplacementAngle.plug_p)
    annotation (Line(points={{-4,-30},{14,-30}}, color={0,0,255}));
  connect(terminalBox.plugSupply, currentQuasiRMSSensor.plug_n)
    annotation (Line(
      points={{-10,-28},{-10,-10},{0,-10}},
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
  connect(star.pin_n,ground. p)
    annotation (Line(points={{-70,90},{-80,90}}, color={0,0,255}));
  connect(sineVoltage.plug_n,star. plug_p)
    annotation (Line(points={{0,70},{0,90},{-50,90}}, color={0,0,255}));
  connect(sineVoltage.plug_p,idealCloser. plug_p) annotation (Line(points=
         {{0,50},{0,48},{0,46},{0,40}}, color={0,0,255}));
  connect(booleanStep.y,idealCloser. control) annotation (Line(points={{-59,40},
          {-20,40},{-20,30},{-12,30}},    color={255,0,255}));
  connect(idealCloser.plug_n, currentQuasiRMSSensor.plug_p)
    annotation (Line(points={{0,20},{0,10}}, color={0,0,255}));
  annotation (experiment(StopTime=2.5, Interval=0.001), Documentation(
        info="<html>
<strong>Test example: Synchronous machine with reluctance rotor direct on line</strong><br>
A synchronous machine with reluctance rotor starts direct on line, utilizing the damper cage.<br>
After reaching synchronous speed, at time tStep a load step is applied.<br>
Simulate for 2.5 seconds and plot (versus time):
<ul>
<li>currentQuasiRMSSensor.I: stator current RMS</li>
<li>smr.wMechanical: motor's speed</li>
<li>smr.tauElectrical: motor's torque</li>
<li>rotorDisplacementAngle.rotorDisplacementAngle: rotor displacement angle</li>
</ul>
Default machine parameters of model <em>SM_ReluctanceRotor</em> are used.
</html>"));
end SMR_DOL;
