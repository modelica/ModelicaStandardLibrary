within Modelica.Magnetic.QuasiStatic.FundamentalWave.Examples.BasicMachines.SynchronousMachines;
model SMPM_Mains
  "Permanent magnet synchronous machine operated at mains with step torque load"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  parameter Integer m=3 "Number of phases" annotation(Evaluate=true);
  parameter SI.Frequency f=50 "Supply frequency";
  parameter SI.Voltage V=112.3 "Supply voltage";
  parameter SI.Torque T_Load=181.4 "Nominal load torque";
  parameter SI.Time tStep=0.5 "Time of load torque step";
  parameter SI.Inertia J_Load=0.29 "Load inertia";
  output SI.Current Itr=currentQuasiRMSSensor.I
    "Transient RMS current";
  output SI.Current Iqs=currentQuasiRMSSensorQS.I
    "QS RMS current";
  Modelica.Electrical.QuasiStatic.Polyphase.Sources.VoltageSource
    voltageSourceQS(
    m=m,
    f=f,
    V=fill(V, m),
    phi=-Modelica.Electrical.Polyphase.Functions.symmetricOrientation(
        m)) annotation (Placement(transformation(
        origin={-60,60},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.QuasiStatic.Polyphase.Basic.Star starQS(m=m)
    annotation (Placement(transformation(
        origin={-60,30},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Ground groundQS
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={-60,10})));
  Modelica.Electrical.QuasiStatic.Polyphase.Sensors.PowerSensor
    powerSensorQS(m=m) annotation (Placement(transformation(extent={{-40,70},{-20,90}})));
  Modelica.Electrical.QuasiStatic.Polyphase.Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensorQS(m=m)
    annotation (Placement(transformation(extent={{-10,70},{10,90}})));
  FundamentalWave.BasicMachines.SynchronousMachines.SM_PermanentMagnet
    smpmQS(
    m=m,
    Jr=smpmData.Jr,
    p=smpmData.p,
    fsNominal=smpmData.fsNominal,
    TsRef=smpmData.TsRef,
    frictionParameters=smpmData.frictionParameters,
    statorCoreParameters=smpmData.statorCoreParameters,
    strayLoadParameters=smpmData.strayLoadParameters,
    useDamperCage=smpmData.useDamperCage,
    Lrsigmad=smpmData.Lrsigmad,
    Lrsigmaq=smpmData.Lrsigmaq,
    Rrd=smpmData.Rrd,
    Rrq=smpmData.Rrq,
    TrRef=smpmData.TrRef,
    VsOpenCircuit=smpmData.VsOpenCircuit,
    permanentMagnetLossParameters=smpmData.permanentMagnetLossParameters,
    wMechanical(fixed=true, start=2*pi*smpmData.fsNominal/smpmData.p),
    Rs=smpmData.Rs*m/3,
    Lssigma=smpmData.Lssigma*m/3,
    Lmd=smpmData.Lmd*m/3,
    Lmq=smpmData.Lmq*m/3,
    useSupport=false,
    Js=smpmData.Js,
    gammar(start=pi/2, fixed=true),
    gamma(start=-pi/2, fixed=true),
    TsOperational=293.15,
    alpha20s=smpmData.alpha20s,
    effectiveStatorTurns=smpmData.effectiveStatorTurns,
    alpha20r=smpmData.alpha20r,
    TrOperational=293.15)
    annotation (Placement(transformation(extent={{20,30},{40,50}})));

  Modelica.Mechanics.Rotational.Components.Inertia loadInertiaMQS(J=
        J_Load) annotation (Placement(transformation(extent={{50,30},{70,50}})));
  Modelica.Mechanics.Rotational.Sources.TorqueStep torqueStepMQS(
    startTime=tStep,
    stepTorque=-T_Load,
    useSupport=false,
    offsetTorque=0) annotation (Placement(transformation(extent={{100,30},{80,50}})));
  parameter
    Modelica.Electrical.Machines.Utilities.ParameterRecords.SM_PermanentMagnetData
    smpmData(useDamperCage=true) "Synchronous machine data"
    annotation (Placement(transformation(extent={{70,72},{90,92}})));
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
        origin={-10,40})));
  Utilities.MultiTerminalBox terminalBoxQS(m=m, terminalConnection="Y")
    annotation (Placement(transformation(extent={{20,46},{40,66}})));
  Modelica.Electrical.Polyphase.Sources.CosineVoltage voltageSource(
    m=m,
    f=fill(f, m),
    V=fill(sqrt(2)*V, m))
                       annotation (Placement(transformation(
        origin={-60,-40},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Polyphase.Basic.Star star(m=m) annotation (
      Placement(transformation(
        origin={-60,-70},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        origin={-60,-90})));
  Modelica.Electrical.Polyphase.Sensors.PowerSensor powerSensor(m=m)
    annotation (Placement(transformation(extent={{-40,-30},{-20,-10}})));
  Modelica.Electrical.Polyphase.Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensor(m=m)
    annotation (Placement(transformation(extent={{-10,-30},{10,-10}})));
  Magnetic.FundamentalWave.BasicMachines.SynchronousMachines.SM_PermanentMagnet
    smpm(
    m=m,
    Jr=smpmData.Jr,
    p=smpmData.p,
    fsNominal=smpmData.fsNominal,
    TsRef=smpmData.TsRef,
    frictionParameters=smpmData.frictionParameters,
    statorCoreParameters=smpmData.statorCoreParameters,
    strayLoadParameters=smpmData.strayLoadParameters,
    useDamperCage=smpmData.useDamperCage,
    Lrsigmad=smpmData.Lrsigmad,
    Lrsigmaq=smpmData.Lrsigmaq,
    Rrd=smpmData.Rrd,
    Rrq=smpmData.Rrq,
    TrRef=smpmData.TrRef,
    VsOpenCircuit=smpmData.VsOpenCircuit,
    permanentMagnetLossParameters=smpmData.permanentMagnetLossParameters,
    wMechanical(fixed=true, start=2*pi*smpmData.fsNominal/smpmData.p),
    Rs=smpmData.Rs*m/3,
    Lssigma=smpmData.Lssigma*m/3,
    Lmd=smpmData.Lmd*m/3,
    Lmq=smpmData.Lmq*m/3,
    useSupport=false,
    Js=smpmData.Jr,
    phiMechanical(start=0, fixed=true),
    ir(each fixed=true, start=zeros(2)),
    TsOperational=293.15,
    alpha20s=smpmData.alpha20s,
    effectiveStatorTurns=smpmData.effectiveStatorTurns,
    alpha20r=smpmData.alpha20r,
    TrOperational=293.15)
    annotation (Placement(transformation(extent={{20,-70},{40,-50}})));

  Modelica.Mechanics.Rotational.Components.Inertia loadInertiaM(J=
        J_Load) annotation (Placement(transformation(extent={{50,-70},{70,-50}})));
  Modelica.Mechanics.Rotational.Sources.TorqueStep torqueStepM(
    startTime=tStep,
    stepTorque=-T_Load,
    useSupport=false,
    offsetTorque=0) annotation (Placement(transformation(extent={{100,-70},{80,-50}})));
  Modelica.Electrical.Analog.Basic.Ground groundMachine annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={-10,-90})));
  Modelica.Electrical.Machines.Utilities.MultiTerminalBox terminalBox(m=m,
      terminalConnection="Y")
    annotation (Placement(transformation(extent={{20,-54},{40,-34}})));
  Modelica.Electrical.Polyphase.Basic.Star starMachine(final m=
        Modelica.Electrical.Polyphase.Functions.numberOfSymmetricBaseSystems(m))
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-10,-60})));
initial equation
  sum(smpm.is)=0;
  smpm.is[1:2]=zeros(2);

equation
  connect(groundQS.pin, starQS.pin_n) annotation (Line(points={{-60,20},{-60,20}},
                              color={85,170,255}));
  connect(starQS.plug_p, voltageSourceQS.plug_n)
    annotation (Line(points={{-60,40},{-60,50}}, color={85,170,255}));
  connect(voltageSourceQS.plug_p, powerSensorQS.currentP) annotation (
      Line(points={{-60,70},{-60,80},{-40,80}}, color={85,170,255}));
  connect(powerSensorQS.currentN, currentQuasiRMSSensorQS.plug_p)
    annotation (Line(points={{-20,80},{-10,80}}, color={85,170,255}));
  connect(powerSensorQS.voltageP, powerSensorQS.currentP) annotation (
      Line(points={{-30,90},{-40,90},{-40,80}}, color={85,170,255}));
  connect(powerSensorQS.voltageN, starQS.plug_p) annotation (Line(
        points={{-30,70},{-30,40},{-60,40}}, color={85,170,255}));
  connect(loadInertiaMQS.flange_b, torqueStepMQS.flange)
    annotation (Line(points={{70,40},{80,40}}));
  connect(smpmQS.flange, loadInertiaMQS.flange_a) annotation (Line(
      points={{40,40},{50,40}}));
  connect(terminalBoxQS.plug_sn, smpmQS.plug_sn) annotation (Line(
      points={{24,50},{24,50}},
      color={85,170,255}));
  connect(terminalBoxQS.plug_sp, smpmQS.plug_sp) annotation (Line(
      points={{36,50},{36,50}},
      color={85,170,255}));
  connect(starMachineQS.plug_p, terminalBoxQS.starpoint) annotation (
      Line(
      points={{-10,50},{-10,52},{20,52}},
      color={85,170,255}));
  connect(currentQuasiRMSSensorQS.plug_n, terminalBoxQS.plugSupply)
    annotation (Line(points={{10,80},{10,80},{30,80},{30,78},{30,78},{30,52},{30,52}},
                                             color={85,170,255}));
  connect(starMachineQS.pin_n, groundMachineQS.pin) annotation (Line(
      points={{-10,30},{-10,20}},
      color={85,170,255}));
  connect(loadInertiaM.flange_b, torqueStepM.flange)
    annotation (Line(points={{70,-60},{80,-60}}));
  connect(smpm.flange, loadInertiaM.flange_a) annotation (Line(
      points={{40,-60},{50,-60}}));
  connect(terminalBox.plug_sn, smpm.plug_sn) annotation (Line(
      points={{24,-50},{24,-50}},
      color={0,0,255}));
  connect(terminalBox.plug_sp, smpm.plug_sp) annotation (Line(
      points={{36,-50},{36,-50}},
      color={0,0,255}));
  connect(terminalBox.plugSupply, currentQuasiRMSSensor.plug_n)
    annotation (Line(points={{30,-48},{30,-20},{10,-20}},
                                               color={0,0,255}));
  connect(currentQuasiRMSSensor.plug_p, powerSensor.nc)
    annotation (Line(points={{-10,-20},{-20,-20}}, color={0,0,255}));
  connect(powerSensor.pc, voltageSource.plug_p) annotation (Line(
      points={{-40,-20},{-60,-20},{-60,-30}},
      color={0,0,255}));
  connect(powerSensor.pv, powerSensor.pc) annotation (Line(
      points={{-30,-10},{-40,-10},{-40,-20}},
      color={0,0,255}));
  connect(voltageSource.plug_n, star.plug_p) annotation (Line(
      points={{-60,-50},{-60,-60}},
      color={0,0,255}));
  connect(star.pin_n, ground.p) annotation (Line(
      points={{-60,-80},{-60,-80}},
      color={0,0,255}));
  connect(powerSensor.nv, star.plug_p) annotation (Line(
      points={{-30,-30},{-30,-60},{-60,-60}}, color={0,0,255}));
  connect(terminalBox.starpoint, starMachine.plug_p) annotation (Line(points={{20,-48},{-10,-48},{-10,-50},{-10,-50}}, color={0,0,255}));
  connect(starMachine.pin_n, groundMachine.p) annotation (Line(points={{-10,-70},{-10,-80}}, color={0,0,255}));
  annotation (experiment(StopTime=1, Interval=1E-4, Tolerance=1E-6),Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{20,8},{100,0}},
                  textStyle={TextStyle.Bold},
          textString="%m phase quasi-static"),               Text(
                  extent={{20,-92},{100,-100}},
                  fillColor={255,255,170},
                  fillPattern=FillPattern.Solid,
                  textStyle={TextStyle.Bold},
                  textString="%m phase transient")}),
    Documentation(info="<html>

<p>
This example compares a time transient and a quasi-static model of a permanent magnet synchronous machine. The machines start with zero load and synchronous speed. At time <code>tStep</code> the machines are loaded with nominal torque.</p>

<p>
Simulate for 1 second and plot (versus time):
</p>

<ul>
<li><code>currentQuasiRMSSensor|currentQuasiRMSSensorQS.I</code>: (equivalent) RMS stator current</li>
<li><code>smpm|smpmQS.wMechanical</code>: machine speed</li>
<li><code>smpm|smpmQS.tauElectrical</code>: machine torque</li>
</ul>
</html>"));
end SMPM_Mains;
