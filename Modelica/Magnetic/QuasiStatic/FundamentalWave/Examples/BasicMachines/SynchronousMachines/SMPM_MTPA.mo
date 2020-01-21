within Modelica.Magnetic.QuasiStatic.FundamentalWave.Examples.BasicMachines.SynchronousMachines;
model SMPM_MTPA "Test example: PermanentMagnetSynchronousMachine, investigating maximum torque per Amps"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  parameter Integer m=3 "Number of phases" annotation(Evaluate=true);
  parameter SI.Voltage VNominal=100 "Nominal RMS voltage per phase";
  parameter SI.Frequency fNominal=50 "Nominal frequency";
  parameter SI.Frequency f=50 "Actual frequency";
  parameter SI.Time tRamp=1 "Frequency ramp";
  parameter SI.Torque TLoad=181.4 "Nominal load torque";
  parameter SI.Time tStep=1.2 "Time of load torque step";
  parameter SI.Inertia JLoad=0.29 "Load's moment of inertia";
  parameter SI.AngularVelocity wNominal = 2*pi*fNominal/smpmData.p "Nominal angular velocity";
  parameter Boolean positiveRange = false "Use positive range of angles, if true";
  output SI.Angle theta=rotorAngleQS.rotorDisplacementAngle "Rotor displacement angle, quasi-static";
  output SI.Angle phi_i = Modelica.Math.wrapAngle(smpmQS.arg_is[1],positiveRange) "Angle of current";
  output SI.Angle phi_v = Modelica.Math.wrapAngle(smpmQS.arg_vs[1],positiveRange) "Angle of voltage";
  output SI.Angle phi = Modelica.Math.wrapAngle(phi_v-phi_i,positiveRange) "Angle between voltage and current";
  output SI.Angle epsilon = Modelica.Math.wrapAngle(phi-theta,positiveRange) "Current angle";

  parameter
    Modelica.Electrical.Machines.Utilities.ParameterRecords.SM_PermanentMagnetData
    smpmData(useDamperCage=false, effectiveStatorTurns=64,
    fsNominal=fNominal,
    Lmd=0.1/(2*pi*fNominal),
    Lmq=0.3/(2*pi*fNominal),
    TsRef=373.15) "Synchronous machine data"
    annotation (Placement(transformation(extent={{60,40},{80,60}})));
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
    effectiveStatorTurns=smpmData.effectiveStatorTurns,
    TsOperational=373.15,
    alpha20s=smpmData.alpha20s,
    alpha20r=smpmData.alpha20r,
    TrOperational=373.15)
    annotation (Placement(transformation(extent={{0,10},{20,30}})));

  Modelica.Mechanics.Rotational.Sources.ConstantSpeed
    quadraticSpeedDependentTorqueQS(w_fixed=wNominal)
    annotation (Placement(transformation(extent={{80,10},{60,30}})));
  Modelica.Electrical.QuasiStatic.Polyphase.Basic.Star
    starMachineQS(m=
        Modelica.Electrical.Polyphase.Functions.numberOfSymmetricBaseSystems(
                                                                     m))
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-20,20})));
  Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Ground
    groundMQS annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={-50,10})));
  Magnetic.QuasiStatic.FundamentalWave.Utilities.MultiTerminalBox terminalBoxQS(
      terminalConnection="Y", m=m)
    annotation (Placement(transformation(extent={{0,26},{20,46}})));
  Magnetic.QuasiStatic.FundamentalWave.Utilities.CurrentController currentControllerQS(m=m, p=
        smpmQS.p)
    annotation (Placement(transformation(extent={{-40,80},{-20,100}})));
  Modelica.Mechanics.Rotational.Sensors.AngleSensor angleSensorQS
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={40,60})));
  Modelica.Electrical.QuasiStatic.Polyphase.Sources.ReferenceCurrentSource referenceCurrentSourceQS(m=m) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={10,90})));
  Modelica.Electrical.QuasiStatic.Polyphase.Basic.Star starQS(m=m)
    annotation (Placement(transformation(
        origin={60,90},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Ground
    groundeQS annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={60,70})));
  Modelica.Electrical.QuasiStatic.Polyphase.Basic.Resistor resistorQS(m=m, R_ref=fill(1e5, m)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={30,90})));
  Magnetic.QuasiStatic.FundamentalWave.Sensors.RotorDisplacementAngle rotorAngleQS(
    m=m,
    p=smpmData.p,
    positiveRange=positiveRange) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={40,20})));
  Modelica.Electrical.QuasiStatic.Polyphase.Sensors.CurrentQuasiRMSSensor currentRMSSensorQS(m=m) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={10,60})));
  Modelica.Electrical.QuasiStatic.Polyphase.Sensors.VoltageQuasiRMSSensor voltageQuasiRMSSensorQS(m=m) annotation (Placement(transformation(extent={{-30,60},{-10,40}})));
  Modelica.Electrical.QuasiStatic.Polyphase.Basic.Star starMQS(m=m) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-40,40})));
  Modelica.ComplexBlocks.Sources.ComplexRotatingPhasor rotSource(magnitude=100, w=2*pi) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-70,30})));
  Modelica.ComplexBlocks.ComplexMath.ComplexToReal toReal annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-70,60})));
equation
  connect(starMachineQS.plug_p, terminalBoxQS.starpoint) annotation (
      Line(
      points={{-10,20},{-10,32},{0,32}},
      color={85,170,255}));
  connect(groundMQS.pin, starMachineQS.pin_n) annotation (Line(
      points={{-50,20},{-30,20}},
      color={85,170,255}));
  connect(terminalBoxQS.plug_sn, smpmQS.plug_sn) annotation (Line(
      points={{4,30},{4,30}},
      color={85,170,255}));
  connect(terminalBoxQS.plug_sp, smpmQS.plug_sp) annotation (Line(
      points={{16,30},{16,30}},
      color={85,170,255}));
  connect(currentControllerQS.I, referenceCurrentSourceQS.I) annotation (Line(points={{-19,94},{-10,94},{-10,96},{-2,96}},
                                                                                                          color={85,170,255}));
  connect(referenceCurrentSourceQS.plug_p, starQS.plug_p) annotation (Line(points={{10,100},{60,100}},          color={85,170,255}));
  connect(starQS.pin_n, groundeQS.pin) annotation (Line(
      points={{60,80},{60,80}},
      color={85,170,255}));
  connect(angleSensorQS.flange, smpmQS.flange) annotation (Line(
      points={{40,50},{40,40},{30,40},{30,20},{20,20}}));
  connect(referenceCurrentSourceQS.plug_p, resistorQS.plug_p) annotation (Line(points={{10,100},{30,100}},          color={85,170,255}));
  connect(resistorQS.plug_n, referenceCurrentSourceQS.plug_n) annotation (Line(points={{30,80},{10,80}},           color={85,170,255}));
  connect(currentControllerQS.gamma, referenceCurrentSourceQS.gamma) annotation (Line(points={{-19,86},{-10,86},{-10,84},{-2,84}},
                                                                                                                  color={0,0,127}));
  connect(angleSensorQS.phi, currentControllerQS.phi) annotation (Line(points={{40,71},{40,74},{-30,74},{-30,78}}, color={0,0,127}));
  connect(smpmQS.flange, rotorAngleQS.flange) annotation (Line(points={{20,20},{30,20}}));
  connect(terminalBoxQS.plug_sp, rotorAngleQS.plug_p) annotation (Line(points={{16,30},{34,30}},color={85,170,255}));
  connect(terminalBoxQS.plugSupply, currentRMSSensorQS.plug_n) annotation (Line(points={{10,32},{10,50}},   color={85,170,255}));
  connect(currentRMSSensorQS.plug_p, referenceCurrentSourceQS.plug_n) annotation (Line(points={{10,70},{10,80}},
                                                                                                               color={85,170,255}));
  connect(rotorAngleQS.plug_n, terminalBoxQS.plug_sn) annotation (Line(points={{46,30},{46,36},{4,36},{4,30}},   color={85,170,255}));
  connect(voltageQuasiRMSSensorQS.plug_n, currentRMSSensorQS.plug_n) annotation (Line(points={{-10,50},{10,50}},color={85,170,255}));
  connect(starMQS.pin_n, starMachineQS.pin_n) annotation (Line(points={{-40,30},{-40,20},{-30,20}}, color={85,170,255}));
  connect(starMQS.plug_p, voltageQuasiRMSSensorQS.plug_p) annotation (Line(points={{-40,50},{-30,50}}, color={85,170,255}));
  connect(quadraticSpeedDependentTorqueQS.flange, rotorAngleQS.flange) annotation (Line(points={{60,20},{30,20}}));
  connect(toReal.u, rotSource.y) annotation (Line(points={{-70,48},{-70,41}}, color={85,170,255}));
  connect(toReal.re, currentControllerQS.id_rms) annotation (Line(points={{-76,72},{-76,96},{-42,96}}, color={0,0,127}));
  connect(currentControllerQS.iq_rms, toReal.im) annotation (Line(points={{-42,84},{-64,84},{-64,72}}, color={0,0,127}));
  annotation (
    experiment(StopTime=1, Interval=1E-3, Tolerance=1E-6),
    Documentation(info="<html>
<p>
This example investigates the maximum torque per amps (MTPA) of a quasi-static permanent magnet synchronous machine.
The machines is operated at constant speed. The current magnitude is kept constant and the current angle is
rotated from 0 to 360 degrees with the simulation period of one second.</p>

<p>
In this simulation the angle is the following angles are calculated:</p>

<ul>
<li><code>phi_v</code> = angle of voltage phasor</li>
<li><code>phi_i</code> = angle of current phasor</li>
<li><code>phiphi_v - phi_i</code> = angle between voltage and current phasor</li>
<li><code>theta</code> = rotor displacement angle</li>
<li><code>epsilon = phi - theta</code> = current angle</li>
</ul>

<p>
Simulate for 1 second and plot (versus angle epsilon):
</p>

<ul>
<li><code>smpmQS.tauElectrical</code>: machine torque</li>
<li><code>smpmQS.abs_vs[1]</code>: machine phase voltage magnitude</li>
<li><code>phi</code>: phase angle between voltage and current phasor</li>
</ul>

<h5>Note</h5>
<p>The resistors connected to the terminals of the windings of the quasi-static machine model are necessary
to numerically stabilize the simulation.</p>
</html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={
        Text(
          extent={{20,0},{100,-8}},
                  textStyle={TextStyle.Bold},
          textString="%m phase quasi-static")}));
end SMPM_MTPA;
