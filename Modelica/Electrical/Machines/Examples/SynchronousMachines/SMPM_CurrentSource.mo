within Modelica.Electrical.Machines.Examples.SynchronousMachines;
model SMPM_CurrentSource
  "Test example: PermanentMagnetSynchronousMachine fed by current source"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  constant Integer m=3 "Number of phases";
  parameter SI.Current Idq[2]={-53.5, 84.6}
    "Desired d- and q-current";
  parameter SI.AngularVelocity wNominal=2*pi*smpmData.fsNominal/smpmData.p
    "Nominal speed";
  parameter SI.Torque TLoad=181.4 "Nominal load torque";
  parameter SI.Inertia JLoad=0.29
    "Load's moment of inertia";
  Machines.BasicMachines.SynchronousMachines.SM_PermanentMagnet smpm(
    p=smpmData.p,
    fsNominal=smpmData.fsNominal,
    TsOperational=293.15,
    Rs=smpmData.Rs,
    TsRef=smpmData.TsRef,
    alpha20s=smpmData.alpha20s,
    Lszero=smpmData.Lszero,
    Lssigma=smpmData.Lssigma,
    Jr=smpmData.Jr,
    Js=smpmData.Js,
    frictionParameters=smpmData.frictionParameters,
    phiMechanical(fixed=true),
    wMechanical(fixed=true),
    statorCoreParameters=smpmData.statorCoreParameters,
    strayLoadParameters=smpmData.strayLoadParameters,
    TrOperational=293.15,
    VsOpenCircuit=smpmData.VsOpenCircuit,
    Lmd=smpmData.Lmd,
    Lmq=smpmData.Lmq,
    useDamperCage=smpmData.useDamperCage,
    Lrsigmad=smpmData.Lrsigmad,
    Lrsigmaq=smpmData.Lrsigmaq,
    Rrd=smpmData.Rrd,
    Rrq=smpmData.Rrq,
    TrRef=smpmData.TrRef,
    alpha20r=smpmData.alpha20r,
    permanentMagnetLossParameters=smpmData.permanentMagnetLossParameters)
    annotation (Placement(transformation(extent={{-20,-50},{0,-30}})));
  Modelica.Electrical.Polyphase.Sources.SignalCurrent signalCurrent(
      final m=m) annotation (Placement(transformation(
        origin={-10,50},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  Modelica.Electrical.Polyphase.Basic.Star star(final m=m) annotation (
      Placement(transformation(extent={{-50,80},{-70,100}})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(
        origin={-90,90},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Utilities.DQToThreePhase dqToThreePhase(p=smpm.p)
    annotation (Placement(transformation(extent={{-50,40},{-30,60}})));
  Modelica.Blocks.Sources.Constant iq(k=Idq[2])
    annotation (Placement(transformation(extent={{-90,20},{-70,40}})));
  Modelica.Blocks.Sources.Constant id(k=Idq[1])
    annotation (Placement(transformation(extent={{-90,60},{-70,80}})));
  Sensors.VoltageQuasiRMSSensor voltageQuasiRMSSensor annotation (
      Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-30,-10})));
  Modelica.Electrical.Polyphase.Basic.Star starM(final m=m) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-60,-10})));
  Modelica.Electrical.Analog.Basic.Ground groundM annotation (Placement(
        transformation(
        origin={-80,-28},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Machines.Utilities.TerminalBox terminalBox(terminalConnection="Y")
    annotation (Placement(transformation(extent={{-20,-34},{0,-14}})));
  Machines.Sensors.RotorDisplacementAngle rotorDisplacementAngle(p=smpm.p)
    annotation (Placement(transformation(
        origin={10,-20},
        extent={{-10,10},{10,-10}})));
  Mechanics.Rotational.Sensors.AngleSensor angleSensor annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={30,-20})));
  Mechanics.Rotational.Sensors.MultiSensor  multiSensor  annotation (
      Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={40,-40})));
  Mechanics.Rotational.Components.Inertia inertiaLoad(J=JLoad)
    annotation (Placement(transformation(extent={{60,-50},{80,-30}})));
  Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
    quadraticSpeedDependentTorque(            tau_nominal=-TLoad,
      w_nominal(displayUnit="rad/s") = wNominal)
    annotation (Placement(transformation(extent={{100,-50},{80,-30}})));
  parameter Utilities.ParameterRecords.SM_PermanentMagnetData smpmData(
      useDamperCage=false) "Synchronous machine data"
    annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
  Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensor annotation (
      Placement(transformation(
        origin={-10,20},
        extent={{-10,-10},{10,10}},
        rotation=270)));
equation
  connect(star.pin_n, ground.p)
    annotation (Line(points={{-70,90},{-80,90}}, color={0,0,255}));
  connect(rotorDisplacementAngle.plug_n, smpm.plug_sn) annotation (Line(
        points={{0,-14},{0,-20},{-16,-20},{-16,-30}},   color={0,0,255}));
  connect(rotorDisplacementAngle.plug_p, smpm.plug_sp)
    annotation (Line(points={{0,-26},{0,-30},{-4,-30}},
                                                 color={0,0,255}));
  connect(terminalBox.plug_sn, smpm.plug_sn) annotation (Line(
      points={{-16,-30},{-16,-30}},
      color={0,0,255}));
  connect(terminalBox.plug_sp, smpm.plug_sp) annotation (Line(
      points={{-4,-30},{-4,-30}},
      color={0,0,255}));
  connect(smpm.flange, rotorDisplacementAngle.flange) annotation (Line(
      points={{0,-40},{10,-40},{10,-30}}));
  connect(signalCurrent.plug_p, star.plug_p) annotation (Line(
      points={{-10,60},{-10,90},{-50,90}},
      color={0,0,255}));
  connect(id.y, dqToThreePhase.d) annotation (Line(points={{-69,70},{-60,
          70},{-60,56},{-52,56}}, color={0,0,127}));
  connect(iq.y, dqToThreePhase.q) annotation (Line(points={{-69,30},{-60,
          30},{-60,44},{-52,44}}, color={0,0,127}));
  connect(groundM.p, terminalBox.starpoint) annotation (Line(
      points={{-70,-28},{-20,-28}},
      color={0,0,255}));
  connect(smpm.flange, multiSensor.flange_a)
    annotation (Line(points={{0,-40},{30,-40}}));
  connect(voltageQuasiRMSSensor.plug_p, terminalBox.plugSupply)
    annotation (Line(
      points={{-20,-10},{-10,-10},{-10,-28}},
      color={0,0,255}));
  connect(starM.plug_p, voltageQuasiRMSSensor.plug_n) annotation (Line(
      points={{-50,-10},{-40,-10}},
      color={0,0,255}));
  connect(starM.pin_n, groundM.p) annotation (Line(
      points={{-70,-10},{-70,-28}},
      color={0,0,255}));
  connect(dqToThreePhase.y, signalCurrent.i)
    annotation (Line(points={{-29,50},{-22,50}}, color={0,0,127}));
  connect(quadraticSpeedDependentTorque.flange, inertiaLoad.flange_b)
    annotation (Line(
      points={{80,-40},{80,-40}}));
  connect(multiSensor.flange_b, inertiaLoad.flange_a)
    annotation (Line(points={{50,-40},{60,-40}}));
  connect(signalCurrent.plug_n, currentQuasiRMSSensor.plug_p) annotation (
     Line(
      points={{-10,40},{-10,30}},
      color={0,0,255}));
  connect(currentQuasiRMSSensor.plug_n, voltageQuasiRMSSensor.plug_p)
    annotation (Line(
      points={{-10,10},{-10,-10},{-20,-10}},
                                    color={0,0,255}));
  connect(smpm.flange, angleSensor.flange)
    annotation (Line(points={{0,-40},{30,-40},{30,-30}}, color={0,0,0}));
  connect(angleSensor.phi, dqToThreePhase.phi) annotation (Line(points={{
          30,-9},{30,34},{-40,34},{-40,38}}, color={0,0,127}));
  annotation (experiment(StopTime=2.0, Interval=1E-4, Tolerance=1e-06), Documentation(
        info="<html>
<p>A synchronous machine with permanent magnets accelerates a quadratic speed dependent load from standstill.
The rms values of d- and q-current in rotor fixed coordinate system are converted to three-phase currents,
and fed to the machine. The result shows that the torque is influenced by the q-current,
whereas the stator voltage is influenced by the d-current.</p>

<p>Default machine parameters are used.</p>
</html>"));
end SMPM_CurrentSource;
