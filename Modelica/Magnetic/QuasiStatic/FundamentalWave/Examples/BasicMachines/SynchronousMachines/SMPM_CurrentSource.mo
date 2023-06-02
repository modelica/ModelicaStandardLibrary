within Modelica.Magnetic.QuasiStatic.FundamentalWave.Examples.BasicMachines.SynchronousMachines;
model SMPM_CurrentSource
  "Test example: PermanentMagnetSynchronousMachine fed by current source"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  parameter Integer m=3 "Number of phases" annotation(Evaluate=true);
  parameter SI.Voltage VNominal=100
    "Nominal RMS voltage per phase";
  parameter SI.Frequency fNominal=smpmData.fsNominal "Nominal frequency";
  parameter SI.Frequency f=50 "Actual frequency";
  parameter SI.Time tRamp=1 "Frequency ramp";
  parameter SI.Torque TLoad=181.4 "Nominal load torque";
  parameter SI.Time tStep=1.2 "Time of load torque step";
  parameter SI.Inertia JLoad=0.29
    "Load's moment of inertia";
  SI.Angle thetaQS=rotorAngleQS.rotorDisplacementAngle "Rotor displacement angle, quasi-static";
  SI.Angle theta=rotorAngle.rotorDisplacementAngle "Rotor displacement angle, transient";

  Magnetic.FundamentalWave.BasicMachines.SynchronousMachines.SM_PermanentMagnet
    smpm(
    p=smpmData.p,
    fsNominal=smpmData.fsNominal,
    Rs=smpmData.Rs,
    TsRef=smpmData.TsRef,
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
    permanentMagnetLossParameters=smpmData.permanentMagnetLossParameters,
    m=m,
    TsOperational=293.15,
    alpha20s=smpmData.alpha20s,
    effectiveStatorTurns=smpmData.effectiveStatorTurns,
    alpha20r=smpmData.alpha20r,
    TrOperational=293.15)
    annotation (Placement(transformation(extent={{-10,-90},{10,-70}})));
  Modelica.Electrical.Polyphase.Sources.SignalCurrent signalCurrent(
      final m=m) annotation (Placement(transformation(
        origin={0,-10},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  Modelica.Electrical.Polyphase.Basic.Star star(final m=m) annotation (
     Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={50,-10})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(
        origin={50,-30},
        extent={{-10,-10},{10,10}})));
  Modelica.Electrical.Machines.Utilities.DQToThreePhase dqToThreePhase(
      p=smpm.p, m=m)
    annotation (Placement(transformation(extent={{-50,-20},{-30,0}})));
  Modelica.Blocks.Sources.Constant iq(k=84.6*3/m)
                                              annotation (Placement(
        transformation(extent={{-100,-20},{-80,0}})));
  Modelica.Blocks.Sources.Constant id(k=-53.5*3/m)
    annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
  Modelica.Electrical.Polyphase.Sensors.VoltageQuasiRMSSensor
    voltageQuasiRMSSensor(m=m)
                          annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-30,-50})));
  Modelica.Electrical.Polyphase.Basic.Star starM(final m=m)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-60,-60})));
  Modelica.Electrical.Analog.Basic.Ground groundM annotation (Placement(
        transformation(
        origin={-60,-90},
        extent={{-10,-10},{10,10}})));
  Modelica.Electrical.Machines.Utilities.MultiTerminalBox terminalBox(
      terminalConnection="Y", m=m)
    annotation (Placement(transformation(extent={{-10,-74},{10,-54}})));
  Modelica.Electrical.Machines.Sensors.RotorDisplacementAngle rotorAngle(m=m, p=smpmData.p) annotation (Placement(transformation(
        origin={30,-80},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  Modelica.Mechanics.Rotational.Sensors.AngleSensor angleSensor
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={30,-40})));
  Modelica.Mechanics.Rotational.Components.Inertia inertiaLoad(J=0.29)
    annotation (Placement(transformation(extent={{50,-90},{70,-70}})));
  Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
    quadraticSpeedDependentTorque(tau_nominal=-181.4, w_nominal(
        displayUnit="rpm") = 157.07963267949)
    annotation (Placement(transformation(extent={{100,-90},{80,-70}})));
  parameter
    Modelica.Electrical.Machines.Utilities.ParameterRecords.SM_PermanentMagnetData
    smpmData(useDamperCage=false) "Synchronous machine data"
    annotation (Placement(transformation(extent={{70,72},{90,92}})));
  Modelica.Electrical.Polyphase.Sensors.CurrentQuasiRMSSensor currentRMSsensor(m=m)
    annotation (Placement(transformation(
        origin={0,-40},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Magnetic.QuasiStatic.FundamentalWave.BasicMachines.SynchronousMachines.SM_PermanentMagnet
    smpmQS(
    p=smpmData.p,
    fsNominal=smpmData.fsNominal,
    Rs=smpmData.Rs,
    TsRef=smpmData.TsRef,
    Lssigma=smpmData.Lssigma,
    Jr=smpmData.Jr,
    Js=smpmData.Js,
    frictionParameters=smpmData.frictionParameters,
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
    permanentMagnetLossParameters=smpmData.permanentMagnetLossParameters,
    phiMechanical(fixed=true, start=0),
    m=m,
    TsOperational=293.15,
    alpha20s=smpmData.alpha20s,
    effectiveStatorTurns=smpmData.effectiveStatorTurns,
    alpha20r=smpmData.alpha20r,
    TrOperational=293.15)
    annotation (Placement(transformation(extent={{-10,10},{10,30}})));

  Modelica.Mechanics.Rotational.Components.Inertia inertiaLoadQS(J=0.29)
    annotation (Placement(transformation(extent={{50,10},{70,30}})));
  Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
    quadraticSpeedDependentTorqueQS(tau_nominal=-181.4, w_nominal(
        displayUnit="rpm") = 157.07963267949)
    annotation (Placement(transformation(extent={{100,10},{80,30}})));
  Modelica.Electrical.QuasiStatic.Polyphase.Basic.Star
    starMachineQS(m=
        Modelica.Electrical.Polyphase.Functions.numberOfSymmetricBaseSystems(
                                                                    m))
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-30,20})));
  Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Ground
    groundMQS annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={-60,10})));
  Magnetic.QuasiStatic.FundamentalWave.Utilities.MultiTerminalBox terminalBoxQS(
      terminalConnection="Y", m=m)
    annotation (Placement(transformation(extent={{-10,26},{10,46}})));
  Magnetic.QuasiStatic.FundamentalWave.Utilities.CurrentController dqToThreePhaseQS(m=m, p=
        smpmQS.p)
    annotation (Placement(transformation(extent={{-50,80},{-30,100}})));
  Modelica.Mechanics.Rotational.Sensors.AngleSensor angleSensorQS
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={30,60})));
  Modelica.Electrical.QuasiStatic.Polyphase.Sources.ReferenceCurrentSource referenceCurrentSourceQS(m=m)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={0,90})));
  Modelica.Electrical.QuasiStatic.Polyphase.Basic.Star starQS(m=m)
    annotation (Placement(transformation(
        origin={50,90},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Ground
    groundeQS annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={50,70})));
  Modelica.Electrical.QuasiStatic.Polyphase.Basic.Resistor resistorQS(m=m, R_ref=fill(1e5, m)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={20,90})));
  Sensors.RotorDisplacementAngle rotorAngleQS(m=m, p=smpmData.p) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={30,20})));
  Modelica.Electrical.QuasiStatic.Polyphase.Sensors.CurrentQuasiRMSSensor currentRMSSensorQS(m=m)
    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={0,60})));
  Modelica.Electrical.QuasiStatic.Polyphase.Sensors.VoltageQuasiRMSSensor voltageQuasiRMSSensorQS(m=m)
    annotation (Placement(transformation(extent={{-40,60},{-20,40}})));
  Modelica.Electrical.QuasiStatic.Polyphase.Basic.Star starMQS(m=m) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-50,40})));
  Modelica.Electrical.Polyphase.Basic.Star starMachine(final m=
        Modelica.Electrical.Polyphase.Functions.numberOfSymmetricBaseSystems(m))
    annotation (Placement(transformation(extent={{10,-10},{-10,10}}, origin={-30,
            -80})));
equation
  connect(star.pin_n, ground.p)
    annotation (Line(points={{50,-20},{50,-20}}, color={0,0,255}));
  connect(rotorAngle.plug_n, smpm.plug_sn) annotation (Line(points={{36,-70},{36,-64},{-6,-64},{-6,-70}}, color={0,0,255}));
  connect(rotorAngle.plug_p, smpm.plug_sp) annotation (Line(points={{24,-70},{6,-70}}, color={0,0,255}));
  connect(terminalBox.plug_sn, smpm.plug_sn) annotation (Line(
      points={{-6,-70},{-6,-70}},
      color={0,0,255}));
  connect(terminalBox.plug_sp, smpm.plug_sp) annotation (Line(
      points={{6,-70},{6,-70}},
      color={0,0,255}));
  connect(smpm.flange, rotorAngle.flange) annotation (Line(points={{10,-80},{20,-80}}));
  connect(signalCurrent.plug_p, star.plug_p) annotation (Line(
      points={{1.77636e-15,0},{50,0}},
      color={0,0,255}));
  connect(angleSensor.flange, rotorAngle.flange) annotation (Line(points={{30,-50},{30,-60},{20,-60},{20,-80}}));
  connect(voltageQuasiRMSSensor.plug_p, terminalBox.plugSupply)
    annotation (Line(
      points={{-20,-50},{0,-50},{0,-68}},
      color={0,0,255}));
  connect(starM.plug_p, voltageQuasiRMSSensor.plug_n) annotation (Line(
      points={{-60,-50},{-40,-50}},
      color={0,0,255}));
  connect(starM.pin_n, groundM.p) annotation (Line(
      points={{-60,-70},{-60,-80}},
      color={0,0,255}));
  connect(quadraticSpeedDependentTorque.flange, inertiaLoad.flange_b)
    annotation (Line(
      points={{80,-80},{70,-80}}));
  connect(signalCurrent.plug_n, currentRMSsensor.plug_p) annotation (
      Line(
      points={{0,-20},{0,-30}},
      color={0,0,255}));
  connect(currentRMSsensor.plug_n, voltageQuasiRMSSensor.plug_p)
    annotation (Line(
      points={{0,-50},{-20,-50}},
      color={0,0,255}));
  connect(smpm.flange, inertiaLoad.flange_a) annotation (Line(
      points={{10,-80},{50,-80}}));
  connect(quadraticSpeedDependentTorqueQS.flange, inertiaLoadQS.flange_b)
    annotation (Line(
      points={{80,20},{70,20}}));
  connect(starMachineQS.plug_p, terminalBoxQS.starpoint) annotation (
      Line(
      points={{-20,20},{-20,32},{-10,32}},
      color={85,170,255}));
  connect(groundMQS.pin, starMachineQS.pin_n) annotation (Line(
      points={{-60,20},{-40,20}},
      color={85,170,255}));
  connect(terminalBoxQS.plug_sn, smpmQS.plug_sn) annotation (Line(
      points={{-6,30},{-6,30}},
      color={85,170,255}));
  connect(terminalBoxQS.plug_sp, smpmQS.plug_sp) annotation (Line(
      points={{6,30},{6,30}},
      color={85,170,255}));
  connect(dqToThreePhaseQS.I, referenceCurrentSourceQS.I) annotation (
      Line(points={{-29,94},{-20,94},{-20,96},{-12,96}}, color={85,170,
          255}));
  connect(referenceCurrentSourceQS.plug_p, starQS.plug_p) annotation (Line(points={{4.44089e-16,100},{50,100}}, color={85,170,255}));
  connect(starQS.pin_n, groundeQS.pin) annotation (Line(
      points={{50,80},{50,80}},
      color={85,170,255}));
  connect(angleSensorQS.flange, smpmQS.flange) annotation (Line(
      points={{30,50},{30,40},{20,40},{20,20},{10,20}}));
  connect(referenceCurrentSourceQS.plug_p, resistorQS.plug_p) annotation (Line(points={{4.44089e-16,100},{20,100}}, color={85,170,255}));
  connect(resistorQS.plug_n, referenceCurrentSourceQS.plug_n) annotation (Line(points={{20,80},{-6.66134e-16,80}}, color={85,170,255}));
  connect(dqToThreePhase.y, signalCurrent.i)
    annotation (Line(points={{-29,-10},{-12,-10}}, color={0,0,127}));
  connect(dqToThreePhaseQS.gamma, referenceCurrentSourceQS.gamma)
    annotation (Line(points={{-29,86},{-20,86},{-20,84},{-12,84}},
        color={0,0,127}));
  connect(angleSensorQS.phi, dqToThreePhaseQS.phi) annotation (Line(
        points={{30,71},{30,74},{-40,74},{-40,78}}, color={0,0,127}));
  connect(angleSensor.phi, dqToThreePhase.phi) annotation (Line(points={{30,-29},
          {30,-26},{-40,-26},{-40,-22}},           color={0,0,127}));
  connect(smpmQS.flange, rotorAngleQS.flange) annotation (Line(points={{10,20},{20,20}}));
  connect(terminalBoxQS.plug_sp, rotorAngleQS.plug_p) annotation (Line(points={{6,30},{24,30}}, color={85,170,255}));
  connect(terminalBoxQS.plugSupply, currentRMSSensorQS.plug_n) annotation (Line(points={{0,32},{0,50}},     color={85,170,255}));
  connect(currentRMSSensorQS.plug_p, referenceCurrentSourceQS.plug_n) annotation (Line(points={{0,70},{0,80}}, color={85,170,255}));
  connect(inertiaLoadQS.flange_a, smpmQS.flange) annotation (Line(points={{50,20},{10,20}}));
  connect(rotorAngleQS.plug_n, terminalBoxQS.plug_sn) annotation (Line(points={{36,30},{36,36},{-6,36},{-6,30}}, color={85,170,255}));
  connect(voltageQuasiRMSSensorQS.plug_n, currentRMSSensorQS.plug_n) annotation (Line(points={{-20,50},{0,50}}, color={85,170,255}));
  connect(starMQS.pin_n, starMachineQS.pin_n) annotation (Line(points={{-50,30},{-50,20},{-40,20}}, color={85,170,255}));
  connect(starMQS.plug_p, voltageQuasiRMSSensorQS.plug_p) annotation (Line(points={{-50,50},{-40,50}}, color={85,170,255}));
  connect(starMachine.plug_p, terminalBox.starpoint) annotation (Line(points={{-20,-80},{-20,-68},{-10,-68}},color={0,0,255}));
  connect(starMachine.pin_n, groundM.p) annotation (Line(points={{-40,-80},{-60,-80}}, color={0,0,255}));
  connect(id.y, dqToThreePhaseQS.id_rms) annotation (Line(points={{-79,
          30},{-74,30},{-74,96},{-52,96}}, color={0,0,127}));
  connect(id.y, dqToThreePhase.d) annotation (Line(points={{-79,30},{-74,
          30},{-74,-4},{-52,-4}}, color={0,0,127}));
  connect(iq.y, dqToThreePhaseQS.iq_rms) annotation (Line(points={{-79,
          -10},{-68,-10},{-68,84},{-52,84}}, color={0,0,127}));
  connect(iq.y, dqToThreePhase.q) annotation (Line(points={{-79,-10},{-68,
          -10},{-68,-16},{-52,-16}}, color={0,0,127}));
  annotation (
    experiment(StopTime=2.0, Interval=1E-4, Tolerance=1E-6),
    Documentation(info="<html>
<p>
This example compares a time transient and a quasi-static model of a permanent magnet synchronous machine. The machines are fed by a current source. The current components are oriented at the magnetic field orientation and transformed to the stator fixed reference frame. This way the machines are operated at constant torque. The machines start to accelerate from standstill.</p>

<p>
Simulate for 2 seconds and plot (versus time):
</p>

<ul>
<li><code>smpm|smpmQS.wMechanical</code>: machine speed</li>
<li><code>smpm|smpmQS.tauElectrical</code>: machine torque</li>
</ul>

<h5>Note</h5>
<p>The resistors connected to the terminals of the windings of the quasi-static machine model are necessary
to numerically stabilize the simulation.</p>
</html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={
        Text(
          extent={{30,48},{110,40}},
                  textStyle={TextStyle.Bold},
          textString="%m phase quasi-static"),               Text(
                  extent={{30,-52},{110,-60}},
                  fillColor={255,255,170},
                  fillPattern=FillPattern.Solid,
                  textStyle={TextStyle.Bold},
                  textString="%m phase transient")}));
end SMPM_CurrentSource;
