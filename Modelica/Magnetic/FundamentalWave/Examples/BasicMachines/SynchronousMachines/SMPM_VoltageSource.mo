within Modelica.Magnetic.FundamentalWave.Examples.BasicMachines.SynchronousMachines;
model SMPM_VoltageSource
  "Test example: PermanentMagnetSynchronousMachine fed by FOC"
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
  Magnetic.FundamentalWave.BasicMachines.SynchronousMachines.SM_PermanentMagnet
    smpm(
    ratioCommonStatorLeakage=smpmData.ratioCommonStatorLeakage,
    phiMechanical(start=0, fixed=true),
    wMechanical(start=0, fixed=true),
    useSupport=false,
    useThermalPort=false,
    p=smpmData.p,
    fsNominal=smpmData.fsNominal,
    TsRef=smpmData.TsRef,
    Jr=smpmData.Jr,
    Js=smpmData.Js,
    frictionParameters=smpmData.frictionParameters,
    statorCoreParameters=smpmData.statorCoreParameters,
    strayLoadParameters=smpmData.strayLoadParameters,
    VsOpenCircuit=smpmData.VsOpenCircuit,
    useDamperCage=smpmData.useDamperCage,
    Lrsigmad=smpmData.Lrsigmad,
    Lrsigmaq=smpmData.Lrsigmaq,
    Rrd=smpmData.Rrd,
    Rrq=smpmData.Rrq,
    TrRef=smpmData.TrRef,
    permanentMagnetLossParameters=smpmData.permanentMagnetLossParameters,
    Rs=smpmData.Rs*m/3,
    Lssigma=smpmData.Lssigma*m/3,
    Lszero=smpmData.Lszero*m/3,
    Lmd=smpmData.Lmd*m/3,
    Lmq=smpmData.Lmq*m/3,
    TsOperational=293.15,
    alpha20s=smpmData.alpha20s,
    effectiveStatorTurns=smpmData.effectiveStatorTurns,
    alpha20r=smpmData.alpha20r,
    TrOperational=293.15)
    annotation (Placement(transformation(extent={{-20,-50},{0,-30}})));

  Modelica.Electrical.Polyphase.Sources.SignalVoltage signalVoltage(
      final m=m) annotation (Placement(transformation(
        origin={-10,50},
        extent={{10,10},{-10,-10}},
        rotation=270)));
  Modelica.Electrical.Polyphase.Basic.Star star(final m=m) annotation (
      Placement(transformation(extent={{-50,80},{-70,100}})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(
        origin={-90,90},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Blocks.Sources.Constant iq(k=Idq[2])
    annotation (Placement(transformation(extent={{-90,20},{-70,40}})));
  Modelica.Blocks.Sources.Constant id(k=Idq[1])
    annotation (Placement(transformation(extent={{-90,60},{-70,80}})));
  Modelica.Electrical.Machines.Utilities.TerminalBox terminalBox(
      terminalConnection="Y")
    annotation (Placement(transformation(extent={{-20,-34},{0,-14}})));
  Modelica.Mechanics.Rotational.Sensors.AngleSensor angleSensor
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={10,0})));
  Modelica.Mechanics.Rotational.Components.Inertia inertiaLoad(J=JLoad)
    annotation (Placement(transformation(extent={{50,-50},{70,-30}})));
  Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
    quadraticSpeedDependentTorque(            tau_nominal=-TLoad,
      w_nominal(displayUnit="rad/s") = wNominal)
    annotation (Placement(transformation(extent={{100,-50},{80,-30}})));
  Modelica.Electrical.Polyphase.Sensors.CurrentSensor currentSensor(m=m)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-10,0})));
  Modelica.Electrical.Machines.Utilities.DQCurrentController currentController(
    p=smpm.p,
    Ld=smpm.Lssigma + smpm.Lmd,
    Lq=smpm.Lssigma + smpm.Lmq,
    Rs=Modelica.Electrical.Machines.Thermal.convertResistance(
        smpm.Rs,
        smpm.TsRef,
        smpm.alpha20s,
        smpm.TsOperational),
    fsNominal=smpm.fsNominal,
    VsOpenCircuit=smpm.VsOpenCircuit)
    annotation (Placement(transformation(extent={{-50,40},{-30,60}})));
  Modelica.Mechanics.Rotational.Sensors.TorqueSensor torqueSensor
    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={40,-60})));
  Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={30,0})));
  Modelica.Electrical.Machines.Sensors.RotorDisplacementAngle rotorDisplacementAngle(p=smpm.p)
    annotation (Placement(transformation(
        origin={20,-40},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Ground groundM annotation (Placement(
        transformation(
        origin={-80,-28},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Polyphase.Basic.Star starM(final m=m) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-60,-10})));
  Modelica.Electrical.Machines.Sensors.VoltageQuasiRMSSensor voltageQuasiRMSSensor
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-30,-10})));
  parameter
    Modelica.Electrical.Machines.Utilities.ParameterRecords.SM_PermanentMagnetData
    smpmData(useDamperCage=false) "Synchronous machine data"
    annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
  Modelica.Electrical.Machines.Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensor
    annotation (Placement(transformation(
        origin={-10,20},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  SI.Angle theta=rotorDisplacementAngle.rotorDisplacementAngle "Rotor displacement angle, FundamentalWave machine";

initial equation
  smpm.is[1:2] = zeros(2);

equation
  connect(star.pin_n, ground.p)
    annotation (Line(points={{-70,90},{-80,90}}, color={0,0,255}));
  connect(terminalBox.plug_sn, smpm.plug_sn) annotation (Line(
      points={{-16,-30},{-16,-30}}, color={0,0,255}));
  connect(terminalBox.plug_sp, smpm.plug_sp) annotation (Line(
      points={{-4,-30},{-4,-30}}, color={0,0,255}));
  connect(quadraticSpeedDependentTorque.flange, inertiaLoad.flange_b)
    annotation (Line(
      points={{80,-40},{70,-40}}));
  connect(smpm.flange, angleSensor.flange) annotation (Line(
      points={{0,-40},{10,-40},{10,-10}}));
  connect(star.plug_p, signalVoltage.plug_n) annotation (Line(
      points={{-50,90},{-10,90},{-10,60}}, color={0,0,255}));
  connect(currentSensor.plug_n, terminalBox.plugSupply) annotation (Line(
      points={{-10,-10},{-10,-28}}, color={0,0,255}));
  connect(id.y, currentController.id) annotation (Line(points={{-69,70},
          {-60,70},{-60,56},{-52,56}}, color={0,0,127}));
  connect(iq.y, currentController.iq) annotation (Line(points={{-69,30},
          {-60,30},{-60,44},{-52,44}}, color={0,0,127}));
  connect(angleSensor.phi,currentController. phi) annotation (Line(
      points={{10,11},{10,34},{-34,34},{-34,38}}, color={0,0,127}));
  connect(currentController.y, signalVoltage.v) annotation (Line(
      points={{-29,50},{-22,50}}, color={0,0,127}));
  connect(currentSensor.i,currentController. iActual) annotation (Line(
      points={{-21,1.9984e-015},{-46,1.9984e-015},{-46,38}}, color={0,0,127}));
  connect(inertiaLoad.flange_a, torqueSensor.flange_b) annotation (Line(
      points={{50,-40},{50,-60}}));
  connect(torqueSensor.flange_a, smpm.flange) annotation (Line(
      points={{30,-60},{30,-40},{0,-40}}));
  connect(speedSensor.flange, smpm.flange) annotation (Line(
      points={{30,-10},{30,-40},{0,-40}}));
  connect(rotorDisplacementAngle.flange, smpm.flange) annotation (Line(
      points={{10,-40},{0,-40}}));
  connect(rotorDisplacementAngle.plug_p, smpm.plug_sp) annotation (Line(
      points={{14,-30},{-4,-30}}, color={0,0,255}));
  connect(rotorDisplacementAngle.plug_n, smpm.plug_sn) annotation (Line(
      points={{26,-30},{26,-20},{-16,-20},{-16,-30}}, color={0,0,255}));
  connect(voltageQuasiRMSSensor.plug_p, currentSensor.plug_n) annotation (
     Line(
      points={{-20,-10},{-10,-10}}, color={0,0,255}));
  connect(starM.plug_p, voltageQuasiRMSSensor.plug_n) annotation (Line(
      points={{-50,-10},{-40,-10}}, color={0,0,255}));
  connect(groundM.p, starM.pin_n) annotation (Line(
      points={{-70,-28},{-70,-10}}, color={0,0,255}));
  connect(currentQuasiRMSSensor.plug_n, currentSensor.plug_p) annotation (
     Line(
      points={{-10,10},{-10,10}}, color={0,0,255}));
  connect(signalVoltage.plug_p, currentQuasiRMSSensor.plug_p) annotation (
     Line(
      points={{-10,40},{-10,30}}, color={0,0,255}));
  annotation (experiment(StopTime=2.0, Interval=1E-4, Tolerance=1e-06), Documentation(
        info="<html>
<p>
A synchronous machine with permanent magnets accelerates a quadratic speed dependent load from standstill.
The rms values of d- and q-current in rotor fixed coordinate system are controlled by the voltageController,
and the output voltages fed to the machine. The result shows that the torque is influenced by the q-current,
whereas the stator voltage is influenced by the d-current.</p>

<p>Default machine parameters are used</p>
</html>"));
end SMPM_VoltageSource;
