within Modelica.Magnetic.QuasiStatic.FundamentalWave.Examples.BasicMachines.SynchronousMachines;
model SMPM_FieldWeakening
  "Test example: Investigate field weakening of a PermanentMagnetSynchronousMachine"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  constant Integer m=3 "Number of phases";
  parameter SI.Voltage VNominal=100 "Nominal RMS voltage per phase";
  parameter SI.Current INominal=150 "Nominal RMS current per phase";
  parameter SI.AngularVelocity wNominal=2*pi*smpmData.fsNominal/smpmData.p "Nominal speed";
  parameter
    Modelica.Electrical.Machines.Utilities.ParameterRecords.SM_PermanentMagnetData
    smpmData(useDamperCage=false, VsOpenCircuit=80)
                                  "Synchronous machine data"
    annotation (Placement(transformation(extent={{30,-70},{50,-50}})));
  Magnetic.QuasiStatic.FundamentalWave.BasicMachines.SynchronousMachines.SM_PermanentMagnet
    smpm(
    p=smpmData.p,
    fsNominal=smpmData.fsNominal,
    Rs=smpmData.Rs,
    TsRef=smpmData.TsRef,
    Lssigma=smpmData.Lssigma,
    Jr=0,
    Js=smpmData.Js,
    frictionParameters=smpmData.frictionParameters,
    wMechanical(fixed=false),
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
    TrOperational=293.15,
    stator(electroMagneticConverter(port_p(Phi(re(start=0), im(start=0))))))
    annotation (Placement(transformation(extent={{30,-40},{50,-20}})));
  Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Ground groundM annotation (
      Placement(transformation(extent={{-10,-10},{10,10}}, origin={20,-30})));
  Modelica.Magnetic.QuasiStatic.FundamentalWave.Utilities.TerminalBox terminalBox(
      terminalConnection="Y", m=m)
    annotation (Placement(transformation(extent={{30,-24},{50,-4}})));
  Magnetic.QuasiStatic.FundamentalWave.Utilities.CurrentController dqToThreePhase(m=m, p=
        smpm.p)
    annotation (Placement(transformation(extent={{-10,30},{10,50}})));
  Modelica.Mechanics.Rotational.Sensors.AngleSensor angleSensorQS
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={60,-20})));
  Modelica.Electrical.QuasiStatic.Polyphase.Sources.ReferenceCurrentSource referenceCurrentSource(m=m)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={40,40})));
  Modelica.Electrical.QuasiStatic.Polyphase.Basic.Star starS(m=m) annotation (
      Placement(transformation(
        origin={80,40},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Ground
    groundeQS annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={80,10})));
  Modelica.Electrical.QuasiStatic.Polyphase.Basic.Resistor resistorS(m=m, R_ref=fill(1e5, m),
    i(re(each start=0), im(each start=0))) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={60,40})));
  Modelica.Electrical.QuasiStatic.Polyphase.Sensors.VoltageQuasiRMSSensor voltageQuasiRMSSensorQS(m=m)
    annotation (Placement(transformation(extent={{10,10},{-10,-10}},
        rotation=90,
        origin={30,0})));
  Mechanics.Rotational.Sources.Speed speedSource(exact=true, phi(fixed=false))
    annotation (Placement(transformation(extent={{90,-40},{70,-20}})));
  ExampleUtilities.FieldWeakeningController fieldWeakeningController(VNominal=
        VNominal, IMax=INominal)
    annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
  Blocks.Math.Gain gainCurrent(k=INominal)
    annotation (Placement(transformation(extent={{-70,30},{-50,50}})));
  Blocks.Math.Gain gainSpeed(k=wNominal)
    annotation (Placement(transformation(extent={{-70,-90},{-50,-70}})));
  Blocks.Sources.Ramp     iqRef(
    height=1,
    duration=0.5,
    offset=0,
    startTime=0)
    annotation (Placement(transformation(extent={{-100,30},{-80,50}})));
  Blocks.Sources.Ramp speed(
    height=4,
    duration=2,
    offset=0,
    startTime=0.5)
    annotation (Placement(transformation(extent={{-100,-90},{-80,-70}})));
equation
  connect(starS.pin_n, groundeQS.pin)
    annotation (Line(points={{80,30},{80,20}}, color={85,170,255}));
  connect(terminalBox.plug_sn, smpm.plug_sn)
    annotation (Line(points={{34,-20},{34,-20}}, color={85,170,255}));
  connect(terminalBox.plug_sp, smpm.plug_sp)
    annotation (Line(points={{46,-20},{46,-20}},
                                               color={85,170,255}));
  connect(terminalBox.plug_sn, voltageQuasiRMSSensorQS.plug_n) annotation (Line(
        points={{34,-20},{34,-10},{30,-10}},  color={85,170,255}));
  connect(voltageQuasiRMSSensorQS.plug_p, terminalBox.plug_sp)
    annotation (Line(points={{30,10},{46,10},{46,-20}},color={85,170,255}));
  connect(dqToThreePhase.I, referenceCurrentSource.I) annotation (Line(points={{11,44},
          {20,44},{20,46},{28,46}},            color={85,170,255}));
  connect(dqToThreePhase.gamma, referenceCurrentSource.gamma) annotation (Line(
        points={{11,36},{20,36},{20,34},{28,34}},     color={0,0,127}));
  connect(referenceCurrentSource.plug_p, resistorS.plug_p)
    annotation (Line(points={{40,50},{60,50}},          color={85,170,255}));
  connect(resistorS.plug_p, starS.plug_p)
    annotation (Line(points={{60,50},{80,50}}, color={85,170,255}));
  connect(smpm.flange, angleSensorQS.flange)
    annotation (Line(points={{50,-30},{60,-30}}, color={0,0,0}));
  connect(angleSensorQS.phi, dqToThreePhase.phi) annotation (Line(points={{60,-9},
          {60,20},{0,20},{0,28}},     color={0,0,127}));
  connect(angleSensorQS.flange, speedSource.flange)
    annotation (Line(points={{60,-30},{70,-30}}, color={0,0,0}));
  connect(fieldWeakeningController.id, dqToThreePhase.id_rms)
    annotation (Line(points={{-19,46},{-12,46}}, color={0,0,127}));
  connect(fieldWeakeningController.iq, dqToThreePhase.iq_rms)
    annotation (Line(points={{-19,34},{-12,34}}, color={0,0,127}));
  connect(gainCurrent.y, fieldWeakeningController.iqRef)
    annotation (Line(points={{-49,40},{-42,40}}, color={0,0,127}));
  connect(terminalBox.plugSupply, referenceCurrentSource.plug_n)
    annotation (Line(points={{40,-18},{40,30}}, color={85,170,255}));
  connect(voltageQuasiRMSSensorQS.V, fieldWeakeningController.vs) annotation (
      Line(points={{19,8.88178e-16},{-30,8.88178e-16},{-30,28}}, color={0,0,127}));
  connect(gainSpeed.y, speedSource.w_ref) annotation (Line(points={{-49,-80},{100,
          -80},{100,-30},{92,-30}}, color={0,0,127}));
  connect(iqRef.y, gainCurrent.u)
    annotation (Line(points={{-79,40},{-72,40}}, color={0,0,127}));
  connect(speed.y, gainSpeed.u)
    annotation (Line(points={{-79,-80},{-72,-80}}, color={0,0,127}));
  connect(terminalBox.starpoint, groundM.pin)
    annotation (Line(points={{30,-18},{20,-18},{20,-20}}, color={85,170,255}));
  connect(referenceCurrentSource.plug_n, resistorS.plug_n)
    annotation (Line(points={{40,30},{60,30}}, color={85,170,255}));
  annotation (experiment(
      StopTime=2.5,
      Interval=0.0001,
      Tolerance=1e-06), Documentation(info="<html>
<p>
This example demonstrates idealized field weakening of a quasistatic permanent magnet synchronous machine.
</p>

<p>
At standstill, the q-axis current is prescribed by a short ramp up to the nominal current.
The d-axis current is controlled to keep voltage &le; nominal voltage, while speed is varied up to four times nominal speed like in an automotive application. 
Total stator current is kept &le; nominal total current. Simulate and plot versus <code>smpm.wMechanical</code>:
</p>

<ul>
<li><code>fieldWeakeningController.vs</code>: stator voltage</li>
<li><code>fieldWeakeningController.is</code>: stator current</li>
<li><code>fieldWeakeningController.id</code>: d-axis current</li>
<li><code>fieldWeakeningController.iq</code>: q-axis current</li>
</ul>

<p>
It can be seen that when field weakening begins negative d-axis current is increased from zero while the q-axis current current has to be reduced (current limit) 
to enable increase of the d-axis current (voltage limit).
</p>

<h5>Note</h5>
<ul>
<li>The resistors connected to the quasi-static source model are necessary to numerically stabilize the simulation.</li>
<li>Inertia of the machine is set to zero to enable a proper comparison of electrical and mechanical power.</li>
<li><code>INominal</code> denotes total nominal current, which can be applied without exceeding maximum temperature.</li>
</ul>
</html>"));
end SMPM_FieldWeakening;
