within Modelica.Magnetic.FundamentalWave.Examples.BasicMachines.SynchronousMachines.ComparisonPolyphase;
model SMR_Inverter_Polyphase
  "Starting of polyphase synchronous reluctance machine with inverter"

  extends Modelica.Icons.Example;
  constant Integer m3=3 "Number of stator phases of three-phase system";
  parameter Integer m=5 "Number of stator phases" annotation(Evaluate=true);
  parameter SI.Voltage VsNominal=100
    "Nominal RMS voltage per phase";
  parameter SI.Frequency fsNominal=smrData.fsNominal "Nominal frequency";
  parameter SI.Frequency fKnee=50
    "Knee frequency of V/f curve";
  parameter SI.Time tRamp=1 "Frequency ramp";
  parameter SI.Torque T_Load=46 "Nominal load torque";
  parameter SI.Time tStep=1.2 "Time of load torque step";
  parameter SI.Inertia J_Load=0.29 "Load inertia";
  Modelica.Electrical.Machines.Utilities.TerminalBox terminalBoxM(
      terminalConnection="Y", m=m) annotation (Placement(transformation(
          extent={{-10,-14},{10,6}})));
  Modelica.Electrical.Machines.Utilities.TerminalBox terminalBox3(
      terminalConnection="Y", m=m3) annotation (Placement(transformation(
          extent={{-10,-74},{10,-54}})));
  Magnetic.FundamentalWave.BasicMachines.SynchronousMachines.SM_ReluctanceRotor
    smrM(
    Jr=smrData.Jr,
    Js=smrData.Js,
    p=smrData.p,
    fsNominal=smrData.fsNominal,
    TsRef=smrData.TsRef,
    alpha20s(displayUnit="1/K") = smrData.alpha20s,
    ratioCommonStatorLeakage=smrData.ratioCommonStatorLeakage,
    frictionParameters=smrData.frictionParameters,
    statorCoreParameters=smrData.statorCoreParameters,
    strayLoadParameters=smrData.strayLoadParameters,
    phiMechanical(fixed=true),
    wMechanical(fixed=true),
    useDamperCage=smrData.useDamperCage,
    Lrsigmad=smrData.Lrsigmad,
    Lrsigmaq=smrData.Lrsigmaq,
    Rrd=smrData.Rrd,
    Rrq=smrData.Rrq,
    TrRef=smrData.TrRef,
    alpha20r(displayUnit="1/K") = smrData.alpha20r,
    Rs=smrData.Rs*m/3,
    Lssigma=smrData.Lssigma*m/3,
    Lszero=smrData.Lszero*m/3,
    Lmd=smrData.Lmd*m/3,
    Lmq=smrData.Lmq*m/3,
    m=m,
    ir(each fixed=true),
    TsOperational=293.15,
    effectiveStatorTurns=smrData.effectiveStatorTurns,
    TrOperational=293.15)
    annotation (Placement(transformation(extent={{-10,-30},{10,-10}})));
  Magnetic.FundamentalWave.BasicMachines.SynchronousMachines.SM_ReluctanceRotor
    smr3(
    p=smrData.p,
    fsNominal=smrData.fsNominal,
    Rs=smrData.Rs,
    TsRef=smrData.TsRef,
    alpha20s(displayUnit="1/K") = smrData.alpha20s,
    ratioCommonStatorLeakage=smrData.ratioCommonStatorLeakage,
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
    alpha20r(displayUnit="1/K") = smrData.alpha20r,
    m=m3,
    ir(each fixed=true),
    TsOperational=293.15,
    effectiveStatorTurns=smrData.effectiveStatorTurns,
    TrOperational=293.15)
    annotation (Placement(transformation(extent={{-10,-90},{10,-70}})));
  Modelica.Electrical.Machines.Sensors.RotorDisplacementAngle rotorAngle3(
     p=smr3.p) annotation (Placement(transformation(
        origin={30,-80},
        extent={{10,-10},{-10,10}},
        rotation=90)));
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
    Modelica.Electrical.Machines.Utilities.ParameterRecords.SM_ReluctanceRotorData
    smrData "Synchronous machine data"
    annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));
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
  Modelica.Electrical.Machines.Utilities.VfController vfControllerM(
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
  smr3.is[1:2] = zeros(2);
  smrM.is[1:2] = zeros(2);
  //conditional damper cage currents are defined as fixed start values
equation
  connect(smr3.flange, loadInertia3.flange_a)
    annotation (Line(points={{10,-80},{50,-80}}));
  connect(loadInertia3.flange_b, torqueStep3.flange)
    annotation (Line(points={{70,-80},{80,-80}}));
  connect(smr3.plug_sn, rotorAngle3.plug_n) annotation (Line(points={{-6,
          -70},{-6,-60},{36,-60},{36,-70}}, color={0,0,255}));
  connect(smr3.plug_sp, rotorAngle3.plug_p)
    annotation (Line(points={{6,-70},{24,-70}}, color={0,0,255}));
  connect(smr3.flange, rotorAngle3.flange)
    annotation (Line(points={{10,-80},{20,-80}}));
  connect(terminalBox3.plug_sp, smr3.plug_sp)
    annotation (Line(points={{6,-70},{6,-70}}, color={0,0,255}));
  connect(terminalBox3.plug_sn, smr3.plug_sn)
    annotation (Line(points={{-6,-70},{-6,-70}}, color={0,0,255}));
  connect(smrM.flange, loadInertiaM.flange_a) annotation (Line(points={{
          10,-20},{10,-20},{50,-20}}));
  connect(loadInertiaM.flange_b, torqueStepM.flange)
    annotation (Line(points={{70,-20},{80,-20}}));
  connect(terminalBoxM.plug_sp, smrM.plug_sp)
    annotation (Line(points={{6,-10},{6,-10}}, color={0,0,255}));
  connect(terminalBoxM.plug_sn, smrM.plug_sn)
    annotation (Line(points={{-6,-10},{-6,-10}}, color={0,0,255}));
  connect(signalVoltage3.plug_n, star3.plug_p)
    annotation (Line(points={{0,80},{0,90},{-50,90}}, color={0,0,255}));
  connect(star3.pin_n, ground3.p)
    annotation (Line(points={{-70,90},{-80,90}}, color={0,0,255}));
  connect(ramp.y, vfController3.u)
    annotation (Line(points={{-59,70},{-42,70}}, color={0,0,255}));
  connect(vfController3.y, signalVoltage3.v)
    annotation (Line(points={{-19,70},{-12,70}},color={0,0,255}));
  connect(terminalBoxM.plugSupply, currentRMSsensorM.plug_n) annotation (
      Line(points={{0,-8},{0,-8},{0,10},{30,10}},        color={0,0,255}));
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
  connect(vfControllerM.y, signalVoltageM.v) annotation (Line(
      points={{-19,50},{18,50}},
      color={0,0,127}));
  connect(vfControllerM.u, ramp.y) annotation (Line(
      points={{-42,50},{-50,50},{-50,70},{-59,70}},
      color={0,0,127}));
  connect(signalVoltageM.plug_p, currentRMSsensorM.plug_p) annotation (
      Line(
      points={{30,40},{30,30}},
      color={0,0,255}));
  connect(gain.y, feedback.u2) annotation (Line(
      points={{-41,20},{-50,20},{-50,8}},
      color={0,0,127}));
  connect(gain.u, currentRMSsensorM.I) annotation (Line(
      points={{-18,20},{19,20}},
      color={0,0,127}));
  connect(currentRMSsensor3.plug_n, terminalBox3.plugSupply) annotation (
      Line(points={{-80,-10},{-80,-60},{0,-60},{0,-68}}, color={0,0,255}));
  connect(currentRMSsensor3.I, feedback.u1) annotation (Line(
      points={{-69,0},{-58,0}},
      color={0,0,127}));
  annotation (
    experiment(
      StopTime=1.5,
      Interval=1E-4,
      Tolerance=1e-06),
    Documentation(info="<html>
<h4>Synchronous machine with reluctance rotor fed by an ideal inverter</h4>
<p>
Ideal frequency inverters are modeled by using a
<a href=\"modelica://Modelica.Electrical.Machines.Utilities.VfController\">VfController</a>
and phase <a href=\"modelica://Modelica.Electrical.Polyphase.Sources.SignalVoltage\">SignalVoltage</a>s.
Frequency is raised by a ramp, causing the
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.SynchronousMachines.SM_ReluctanceRotor\">reluctance machine</a> to start,
and accelerating inertias. At time <code>tStep</code> a load step is applied. Two equivalent machines with different numbers of phases are compared and their equal behavior is demonstrated.
</p>

<p>
Simulate for 1.5 seconds and plot (versus time):
</p>

<ul>
<li><code>aimcM|M3.tauElectrical</code>: machine torque</li>
<li><code>aimsM|M3.wMechanical</code>: machine speed</li>
<li><code>feedback.y</code>: zero since difference of three-phase current phasor and scaled polyphase current phasor are equal</li>
</ul>

</html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={Rectangle(
                extent={{-20,0},{100,-40}},
                fillColor={255,255,170},
                fillPattern=FillPattern.Solid,
                pattern=LinePattern.Dash),Text(
                extent={{40,-44},{100,-52}},
                fillColor={255,255,170},
                fillPattern=FillPattern.Solid,
                textStyle={TextStyle.Bold},
                textString="%m-phase machine
"),     Text(
          extent={{40,-54},{100,-62}},
                fillColor={255,255,170},
                fillPattern=FillPattern.Solid,
                textStyle={TextStyle.Bold},
                textString="Three-phase machine
"),     Rectangle(
          extent={{-20,-60},{100,-100}},
                fillColor={255,255,170},
                fillPattern=FillPattern.Solid,
                pattern=LinePattern.Dash)}));
end SMR_Inverter_Polyphase;
