within Modelica.Magnetic.FundamentalWave.Examples.BasicMachines.SynchronousMachines.ComparisonPolyphase;
model SMPM_Inverter_Polyphase
  "Starting of polyphase permanent magnet synchronous machine with inverter"

  extends Modelica.Icons.Example;
  constant Integer m3=3 "Number of stator phases of three-phase system";
  parameter Integer m=5 "Number of stator phases" annotation(Evaluate=true);
  parameter SI.Voltage VsNominal=100
    "Nominal RMS voltage per phase";
  parameter SI.Frequency fsNominal=smpmData.fsNominal "Nominal frequency";
  parameter SI.Frequency fKnee=50
    "Knee frequency of V/f curve";
  parameter SI.Time tRamp=1 "Frequency ramp";
  parameter SI.Torque T_Load=181.4 "Nominal load torque";
  parameter SI.Time tStep=1.2 "Time of load torque step";
  parameter SI.Inertia J_Load=0.29 "Load inertia";
  Modelica.Electrical.Analog.Basic.Ground ground3 annotation (Placement(
        transformation(
        origin={-90,90},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Polyphase.Basic.Star star3(final m=m3) annotation (
     Placement(transformation(extent={{-50,80},{-70,100}})));
  Modelica.Electrical.Polyphase.Sources.SignalVoltage signalVoltage3(
      final m=m3) annotation (Placement(transformation(
        origin={0,70},
        extent={{10,10},{-10,-10}},
        rotation=270)));
  Modelica.Blocks.Sources.Ramp ramp(height=fKnee, duration=tRamp)
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  Modelica.Electrical.Machines.Utilities.VfController vfController3(
    VNominal=VsNominal,
    fNominal=fsNominal,
    BasePhase=+Modelica.Constants.pi/2,
    final m=m3,
    orientation=-
        Modelica.Electrical.Polyphase.Functions.symmetricOrientation(m3))
    annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
  Modelica.Electrical.Polyphase.Sensors.CurrentQuasiRMSSensor
    currentRMSsensorM(m=m) annotation (Placement(transformation(
        origin={30,20},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Machines.Sensors.CurrentQuasiRMSSensor
    currentRMSsensor3 annotation (Placement(transformation(
        origin={-80,0},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  Modelica.Electrical.Machines.Utilities.TerminalBox terminalBoxM(
      terminalConnection="Y", m=m) annotation (Placement(transformation(
          extent={{-10,-14},{10,6}})));
  Modelica.Electrical.Machines.Utilities.TerminalBox terminalBox3(
      terminalConnection="Y", m=m3) annotation (Placement(transformation(
          extent={{-10,-74},{10,-54}})));
  Magnetic.FundamentalWave.BasicMachines.SynchronousMachines.SM_PermanentMagnet
    smpmM(
    Jr=smpmData.Jr,
    Js=smpmData.Js,
    p=smpmData.p,
    fsNominal=smpmData.fsNominal,
    TsRef=smpmData.TsRef,
    alpha20s(displayUnit="1/K") = smpmData.alpha20s,
    ratioCommonStatorLeakage=smpmData.ratioCommonStatorLeakage,
    phiMechanical(fixed=true),
    wMechanical(fixed=true),
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
    m=m,
    Rs=smpmData.Rs*m/3,
    Lssigma=smpmData.Lssigma*m/3,
    Lszero=smpmData.Lszero*m/3,
    Lmd=smpmData.Lmd*m/3,
    Lmq=smpmData.Lmq*m/3,
    ir(each fixed=true),
    TsOperational=293.15,
    effectiveStatorTurns=smpmData.effectiveStatorTurns,
    TrOperational=293.15)
    annotation (Placement(transformation(extent={{-10,-30},{10,-10}})));

  Magnetic.FundamentalWave.BasicMachines.SynchronousMachines.SM_PermanentMagnet
    smpm3(
    p=smpmData.p,
    fsNominal=smpmData.fsNominal,
    Rs=smpmData.Rs,
    TsRef=smpmData.TsRef,
    alpha20s(displayUnit="1/K") = smpmData.alpha20s,
    ratioCommonStatorLeakage=smpmData.ratioCommonStatorLeakage,
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
    m=m3,
    ir(each fixed=true),
    TsOperational=293.15,
    effectiveStatorTurns=smpmData.effectiveStatorTurns,
    TrOperational=293.15)
    annotation (Placement(transformation(extent={{-10,-90},{10,-70}})));

  Modelica.Electrical.Machines.Sensors.RotorDisplacementAngle rotorAngle3(
     p=smpm3.p) annotation (Placement(transformation(
        origin={30,-80},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  Modelica.Mechanics.Rotational.Components.Inertia loadInertiaM(J=J_Load)
    annotation (Placement(transformation(extent={{50,-30},{70,-10}})));
  Modelica.Mechanics.Rotational.Components.Inertia loadInertia3(J=J_Load)
    annotation (Placement(transformation(extent={{50,-90},{70,-70}})));
  Modelica.Mechanics.Rotational.Sources.TorqueStep torqueStepM(
    startTime=tStep,
    stepTorque=-T_Load,
    useSupport=false,
    offsetTorque=0) annotation (Placement(transformation(extent={{100,-30},
            {80,-10}})));
  Modelica.Mechanics.Rotational.Sources.TorqueStep torqueStep3(
    startTime=tStep,
    stepTorque=-T_Load,
    useSupport=false,
    offsetTorque=0) annotation (Placement(transformation(extent={{100,-90},
            {80,-70}})));
  parameter
    Modelica.Electrical.Machines.Utilities.ParameterRecords.SM_PermanentMagnetData
    smpmData "Synchronous machine data"
    annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));
  Modelica.Electrical.Polyphase.Sources.SignalVoltage signalVoltageM(
      final m=m) annotation (Placement(transformation(
        origin={30,50},
        extent={{10,10},{-10,-10}},
        rotation=270)));
  Modelica.Electrical.Polyphase.Basic.Star starM(final m=m) annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={60,90})));
  Modelica.Electrical.Analog.Basic.Ground groundM annotation (Placement(
        transformation(
        origin={90,90},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Electrical.Machines.Utilities.VfController vfController(
    VNominal=VsNominal,
    fNominal=fsNominal,
    BasePhase=+Modelica.Constants.pi/2,
    final m=m,
    orientation=-
        Modelica.Electrical.Polyphase.Functions.symmetricOrientation(m))
    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-30,50})));
  Modelica.Blocks.Math.Feedback feedback annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        origin={-50,0})));
  Modelica.Blocks.Math.Gain gain(k=(m/m3))
    annotation (Placement(transformation(extent={{-20,10},{-40,30}})));
initial equation
  smpm3.is[1:2] = zeros(2);
  smpmM.is[1:2] = zeros(2);
  //conditional damper cage currents are defined as fixed start values
equation
  connect(signalVoltage3.plug_n, star3.plug_p)
    annotation (Line(points={{0,80},{0,90},{-50,90}}, color={0,0,255}));
  connect(star3.pin_n, ground3.p)
    annotation (Line(points={{-70,90},{-80,90}}, color={0,0,255}));
  connect(ramp.y, vfController3.u)
    annotation (Line(points={{-59,70},{-42,70}}, color={0,0,255}));
  connect(vfController3.y, signalVoltage3.v)
    annotation (Line(points={{-19,70},{-12,70}},color={0,0,255}));
  connect(loadInertiaM.flange_b, torqueStepM.flange)
    annotation (Line(points={{70,-20},{80,-20}}));
  connect(smpmM.flange, loadInertiaM.flange_a)
    annotation (Line(points={{10,-20},{50,-20}}));
  connect(terminalBoxM.plug_sn, smpmM.plug_sn)
    annotation (Line(points={{-6,-10},{-6,-10}}, color={0,0,255}));
  connect(terminalBoxM.plug_sp, smpmM.plug_sp)
    annotation (Line(points={{6,-10},{6,-10}}, color={0,0,255}));
  connect(terminalBoxM.plugSupply, currentRMSsensorM.plug_n) annotation (
      Line(points={{0,-8},{0,-8},{0,10},{30,10}},        color={0,0,255}));
  connect(loadInertia3.flange_b, torqueStep3.flange)
    annotation (Line(points={{70,-80},{80,-80}}));
  connect(rotorAngle3.plug_n, smpm3.plug_sn) annotation (Line(points={{36,
          -70},{36,-64},{-6,-64},{-6,-70}}, color={0,0,255}));
  connect(rotorAngle3.plug_p, smpm3.plug_sp)
    annotation (Line(points={{24,-70},{6,-70}}, color={0,0,255}));
  connect(rotorAngle3.flange, smpm3.flange)
    annotation (Line(points={{20,-80},{10,-80}}));
  connect(smpm3.flange, loadInertia3.flange_a)
    annotation (Line(points={{10,-80},{50,-80}}));
  connect(terminalBox3.plug_sn, smpm3.plug_sn)
    annotation (Line(points={{-6,-70},{-6,-70}}, color={0,0,255}));
  connect(terminalBox3.plug_sp, smpm3.plug_sp)
    annotation (Line(points={{6,-70},{6,-70}}, color={0,0,255}));
  connect(currentRMSsensor3.plug_n, terminalBox3.plugSupply) annotation (
      Line(points={{-80,-10},{-80,-60},{0,-60},{0,-68}}, color={0,0,255}));
  connect(signalVoltage3.plug_p, currentRMSsensor3.plug_p) annotation (
      Line(
      points={{0,60},{0,34},{-80,34},{-80,10}},
      color={0,0,255}));
  connect(signalVoltageM.plug_n, starM.plug_p) annotation (Line(
      points={{30,60},{30,90},{50,90}},
      color={0,0,255}));
  connect(starM.pin_n, groundM.p) annotation (Line(
      points={{70,90},{80,90}},
      color={0,0,255}));
  connect(vfController.y, signalVoltageM.v) annotation (Line(
      points={{-19,50},{18,50}},
      color={0,0,127}));
  connect(vfController.u, ramp.y) annotation (Line(
      points={{-42,50},{-50,50},{-50,70},{-59,70}},
      color={0,0,127}));
  connect(signalVoltageM.plug_p, currentRMSsensorM.plug_p) annotation (
      Line(
      points={{30,40},{30,30}},
      color={0,0,255}));
  connect(currentRMSsensor3.I, feedback.u1) annotation (Line(
      points={{-69,0},{-64.5,0},{-64.5,0},{-58,0}},
      color={0,0,255}));
  connect(gain.y, feedback.u2) annotation (Line(
      points={{-41,20},{-50,20},{-50,8}},
      color={0,0,127}));
  connect(gain.u, currentRMSsensorM.I) annotation (Line(
      points={{-18,20},{19,20}},
      color={0,0,127}));
  annotation (
    experiment(
      StopTime=1.5,
      Interval=1E-4,
      Tolerance=1e-006),
    Documentation(info="<html>
<h4>Permanent magnet synchronous machine fed by an ideal inverter</h4>
<p>

An ideal frequency inverter is modeled by using
<a href=\"modelica://Modelica.Electrical.Machines.Utilities.VfController\">VfController</a>s
and <a href=\"modelica://Modelica.Electrical.Polyphase.Sources.SignalVoltage\">SignalVoltages</a>s.
Frequency is raised by a ramp, causing the
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.SynchronousMachines.SM_PermanentMagnet\">permanent magnet synchronous machines</a> to start,
and accelerate the inertias. Two equivalent machines with different numbers of phases are compared and their equal behavior is demonstrated.</p>

<p>At time tStep a load step is applied. Simulate for 1.5 seconds and plot (versus time):</p>

<ul>
<li><code>aimcM|M3.tauElectrical</code>: machine torque</li>
<li><code>aimsM|M3.wMechanical</code>: machine speed</li>
<li><code>feedback.y</code>: zero since difference of three-phase current phasor and scaled polyphase current phasor are equal</li>
</ul>

</html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                         graphics={Rectangle(
                extent={{-20,0},{100,-40}},
                fillColor={255,255,170},
                fillPattern=FillPattern.Solid,
                pattern=LinePattern.Dash),Rectangle(
                extent={{-20,-60},{100,-100}},
                fillColor={255,255,170},
                fillPattern=FillPattern.Solid,
                pattern=LinePattern.Dash),Text(
                extent={{40,-54},{100,-62}},
                fillColor={255,255,170},
                fillPattern=FillPattern.Solid,
                textStyle={TextStyle.Bold},
                textString="Three-phase machine
"),     Text(
          extent={{40,-44},{100,-52}},
                fillColor={255,255,170},
                fillPattern=FillPattern.Solid,
                textStyle={TextStyle.Bold},
                textString="%m-phase machine
")}));
end SMPM_Inverter_Polyphase;
