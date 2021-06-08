within Modelica.Magnetic.FundamentalWave.Examples.BasicMachines.SynchronousMachines.ComparisonPolyphase;
model SMEE_Generator_Polyphase
  "Electrical excited polyphase synchronous machine operating as generator"

  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  constant Integer m3=3 "Number of stator phases of three-phase system";
  parameter Integer m=5 "Number of stator phases" annotation(Evaluate=true);
  parameter SI.Voltage VsNominal=100
    "Nominal RMS voltage per phase";
  parameter SI.Frequency fsNominal=smeeData.fsNominal "Nominal frequency";
  parameter SI.AngularVelocity w=
      Modelica.Units.Conversions.from_rpm(1499) "Nominal speed";
  parameter SI.Current Ie=19 "Excitation current";
  parameter SI.Current Ie0=10 "Initial excitation current";
  parameter SI.Angle gamma0(displayUnit="deg") = 0
    "Initial rotor displacement angle";
  parameter Integer p=2 "Number of pole pairs";
  parameter SI.Resistance Rs=0.03
    "Warm stator resistance per phase";
  parameter SI.Inductance Lssigma=0.1/(2*Modelica.Constants.pi
      *fsNominal) "Stator stray inductance per phase";
  parameter SI.Inductance Lmd=1.5/(2*Modelica.Constants.pi*
      fsNominal) "Main field inductance in d-axis";
  parameter SI.Inductance Lmq=1.5/(2*Modelica.Constants.pi*
      fsNominal) "Main field inductance in q-axis";
  parameter SI.Inductance Lrsigmad=0.05/(2*Modelica.Constants.pi
      *fsNominal)
    "Damper stray inductance (equivalent three-phase winding) d-axis";
  parameter SI.Inductance Lrsigmaq=Lrsigmad
    "Damper stray inductance (equivalent three-phase winding) q-axis";
  parameter SI.Resistance Rrd=0.04
    "Warm damper resistance (equivalent three-phase winding) d-axis";
  parameter SI.Resistance Rrq=Rrd
    "Warm damper resistance (equivalent three-phase winding) q-axis";
  Modelica.Electrical.Polyphase.Basic.Star star3(final m=m3) annotation (
     Placement(transformation(extent={{-50,-30},{-70,-10}})));
  Modelica.Electrical.Analog.Basic.Ground ground3 annotation (Placement(
        transformation(
        origin={-90,-20},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Polyphase.Sources.SineVoltage sineVoltage3(
    final m=m3,
    final V=fill(VsNominal*sqrt(2), m3),
    phase=-Modelica.Electrical.Polyphase.Functions.symmetricOrientation(
        m3),
    final f=fill(fsNominal, m3)) annotation (Placement(
        transformation(extent={{-20,-30},{-40,-10}})));
  Modelica.Electrical.Polyphase.Sensors.PowerSensor
    electricalPowerSensorM(m=m) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-2,80})));
  Modelica.Electrical.Machines.Sensors.ElectricalPowerSensor electricalPowerSensor3
    annotation (Placement(transformation(extent={{-10,10},{10,-10}}, origin={0,
            -20})));
  Modelica.Electrical.Machines.Utilities.TerminalBox terminalBoxM(
      terminalConnection="Y", m=m) annotation (Placement(transformation(
          extent={{-10,46},{10,66}})));
  Modelica.Electrical.Machines.Utilities.TerminalBox terminalBox3(
      terminalConnection="Y", m=m3) annotation (Placement(transformation(
          extent={{-10,-74},{10,-54}})));
  Magnetic.FundamentalWave.BasicMachines.SynchronousMachines.SM_ElectricalExcited
    smeeM(
    ratioCommonStatorLeakage=smeeData.ratioCommonStatorLeakage,
    phiMechanical(start=-(Modelica.Constants.pi + gamma0)/p, fixed=true),
    Jr=0.29,
    Js=0.29,
    p=2,
    fsNominal=smeeData.fsNominal,
    TsRef=smeeData.TsRef,
    alpha20s(displayUnit="1/K") = smeeData.alpha20s,
    useDamperCage=true,
    Lrsigmad=smeeData.Lrsigmad,
    Lrsigmaq=smeeData.Lrsigmaq,
    Rrd=smeeData.Rrd,
    Rrq=smeeData.Rrq,
    TrRef=smeeData.TrRef,
    alpha20r(displayUnit="1/K") = smeeData.alpha20r,
    VsNominal=smeeData.VsNominal,
    IeOpenCircuit=smeeData.IeOpenCircuit,
    Re=smeeData.Re,
    TeRef=smeeData.TeRef,
    alpha20e(displayUnit="1/K") = smeeData.alpha20e,
    m=m,
    Rs=smeeData.Rs*m/3,
    Lssigma=smeeData.Lssigma*m/3,
    Lmd=smeeData.Lmd*m/3,
    Lmq=smeeData.Lmq*m/3,
    statorCoreParameters(VRef=100),
    strayLoadParameters(IRef=100),
    brushParameters(ILinear=0.01),
    ir(each fixed=true),
    effectiveStatorTurns=smeeData.effectiveStatorTurns,
    TsOperational=293.15,
    TrOperational=293.15,
    TeOperational=293.15,
    sigmae=smeeData.sigmae*m/3)
    annotation (Placement(transformation(extent={{-10,30},{10,50}})));

  Magnetic.FundamentalWave.BasicMachines.SynchronousMachines.SM_ElectricalExcited
    smee3(
    ratioCommonStatorLeakage=smeeData.ratioCommonStatorLeakage,
    phiMechanical(start=-(Modelica.Constants.pi + gamma0)/p, fixed=true),
    p=2,
    fsNominal=smeeData.fsNominal,
    Rs=smeeData.Rs,
    TsRef=smeeData.TsRef,
    alpha20s(displayUnit="1/K") = smeeData.alpha20s,
    Lssigma=smeeData.Lssigma,
    Jr=0.29,
    Js=0.29,
    frictionParameters(PRef=0),
    statorCoreParameters(PRef=0, VRef=100),
    strayLoadParameters(PRef=0, IRef=100),
    Lmd=smeeData.Lmd,
    Lmq=smeeData.Lmq,
    useDamperCage=true,
    Lrsigmad=smeeData.Lrsigmad,
    Rrd=smeeData.Rrd,
    Rrq=smeeData.Rrq,
    alpha20r(displayUnit="1/K") = smeeData.alpha20r,
    VsNominal=smeeData.VsNominal,
    IeOpenCircuit=smeeData.IeOpenCircuit,
    Re=smeeData.Re,
    TeRef=smeeData.TeRef,
    alpha20e(displayUnit="1/K") = smeeData.alpha20e,
    sigmae=smeeData.sigmae,
    brushParameters(V=0, ILinear=0.01),
    Lrsigmaq=smeeData.Lrsigmaq,
    TrRef=smeeData.TrRef,
    m=m3,
    ir(each fixed=true),
    TsOperational=293.15,
    effectiveStatorTurns=smeeData.effectiveStatorTurns,
    TrOperational=293.15,
    TeOperational=293.15)
    annotation (Placement(transformation(extent={{-10,-90},{10,-70}})));

  Modelica.Electrical.Analog.Basic.Ground groundRM annotation (Placement(
        transformation(
        origin={-20,20},
        extent={{-10,-10},{10,10}})));
  Modelica.Electrical.Analog.Basic.Ground groundR3 annotation (Placement(
        transformation(
        origin={-20,-100},
        extent={{-10,-10},{10,10}})));
  Modelica.Electrical.Analog.Sources.RampCurrent rampCurrentM(
    duration=0.1,
    I=Ie - Ie0,
    offset=Ie0) annotation (Placement(transformation(
        origin={-30,40},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Electrical.Analog.Sources.RampCurrent rampCurrent3(
    duration=0.1,
    I=Ie - Ie0,
    offset=Ie0) annotation (Placement(transformation(
        origin={-30,-80},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Electrical.Machines.Sensors.RotorDisplacementAngle rotorAngle3(
     p=p) annotation (Placement(transformation(
        origin={30,-80},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  Modelica.Electrical.Machines.Sensors.MechanicalPowerSensor
    mechanicalPowerSensorM annotation (Placement(transformation(extent={{
            20,30},{40,50}})));
  Modelica.Electrical.Machines.Sensors.MechanicalPowerSensor
    mechanicalPowerSensor3 annotation (Placement(transformation(extent={{
            50,-90},{70,-70}})));
  Modelica.Mechanics.Rotational.Sources.ConstantSpeed constantSpeedM(
      final w_fixed=w, useSupport=false) annotation (Placement(
        transformation(extent={{70,30},{50,50}})));
  Modelica.Mechanics.Rotational.Sources.ConstantSpeed constantSpeed3(
      final w_fixed=w, useSupport=false) annotation (Placement(
        transformation(extent={{100,-90},{80,-70}})));
  parameter Modelica.Electrical.Machines.Utilities.SynchronousMachineData smeeData(
    SNominal=30e3,
    VsNominal=100,
    fsNominal=50,
    IeOpenCircuit=10,
    x0=0.1,
    xd=1.6,
    xq=1.6,
    xdTransient=0.1375,
    xdSubtransient=0.121428571,
    xqSubtransient=0.148387097,
    Ta=0.014171268,
    Td0Transient=0.261177343,
    Td0Subtransient=0.006963029,
    Tq0Subtransient=0.123345081,
    alpha20s(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero,
    alpha20r(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero,
    alpha20e(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero,
    TsSpecification=293.15,
    TsRef=293.15,
    TrSpecification=293.15,
    TrRef=293.15,
    TeSpecification=293.15,
    TeRef=293.15) "Synchronous machine data"
    annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));

  Modelica.Electrical.Polyphase.Sensors.CurrentQuasiRMSSensor
    currentRMSsensorM(m=m) annotation (Placement(transformation(
        origin={30,80},
        extent={{-10,10},{10,-10}})));
  Modelica.Electrical.Machines.Sensors.CurrentQuasiRMSSensor
    currentRMSsensor3 annotation (Placement(transformation(
        origin={30,-20},
        extent={{-10,10},{10,-10}})));
  Modelica.Blocks.Math.Gain gain(k=(m/m3)) annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={90,30})));
  Modelica.Blocks.Math.Feedback feedback annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        origin={90,0})));
  Modelica.Electrical.Polyphase.Basic.Star starM(final m=m) annotation (
      Placement(transformation(extent={{-50,70},{-70,90}})));
  Modelica.Electrical.Analog.Basic.Ground groundM annotation (Placement(
        transformation(
        origin={-90,80},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Polyphase.Sources.SineVoltage sineVoltageM(
    final V=fill(VsNominal*sqrt(2), m),
    final f=fill(fsNominal, m),
    final m=m,
    phase=-Modelica.Electrical.Polyphase.Functions.symmetricOrientation(
        m)) annotation (Placement(transformation(extent={{-20,70},{-40,90}})));
initial equation
  smee3.is[1:2] = zeros(2);
  smeeM.is[1:2] = zeros(2);
  //conditional damper cage currents are defined as fixed start values
equation
  connect(rotorAngle3.plug_n, smee3.plug_sn) annotation (Line(points={{36,
          -70},{36,-60},{-6,-60},{-6,-70}}, color={0,0,255}));
  connect(rotorAngle3.plug_p, smee3.plug_sp)
    annotation (Line(points={{24,-70},{6,-70}}, color={0,0,255}));
  connect(rotorAngle3.flange, smee3.flange)
    annotation (Line(points={{20,-80},{10,-80}}));
  connect(star3.pin_n, ground3.p) annotation (Line(points={{-70,-20},{-75,
          -20},{-80,-20}}, color={0,0,255}));
  connect(star3.plug_p, sineVoltage3.plug_n) annotation (Line(points={{-50,
          -20},{-48,-20},{-46,-20},{-40,-20}}, color={0,0,255}));
  connect(smee3.flange, mechanicalPowerSensor3.flange_a)
    annotation (Line(points={{10,-80},{50,-80}}));
  connect(mechanicalPowerSensor3.flange_b, constantSpeed3.flange)
    annotation (Line(points={{70,-80},{80,-80}}));
  connect(rampCurrent3.p, groundR3.p) annotation (Line(points={{-30,-90},
          {-26,-90},{-20,-90}}, color={0,0,255}));
  connect(rampCurrent3.p, smee3.pin_en) annotation (Line(points={{-30,-90},
          {-20,-90},{-20,-86},{-10,-86}},color={0,0,255}));
  connect(rampCurrent3.n, smee3.pin_ep) annotation (Line(points={{-30,-70},
          {-20,-70},{-20,-74},{-10,-74}},color={0,0,255}));
  connect(smee3.plug_sn, terminalBox3.plug_sn)
    annotation (Line(points={{-6,-70},{-6,-70}}, color={0,0,255}));
  connect(smee3.plug_sp, terminalBox3.plug_sp)
    annotation (Line(points={{6,-70},{6,-70}}, color={0,0,255}));
  connect(smeeM.flange, mechanicalPowerSensorM.flange_a)
    annotation (Line(points={{10,40},{10,40},{20,40}}));
  connect(mechanicalPowerSensorM.flange_b, constantSpeedM.flange)
    annotation (Line(points={{40,40},{44,40},{46,40},{50,40}}, color={0,0,
          0}));
  connect(rampCurrentM.p, groundRM.p) annotation (Line(points={{-30,30},{
          -30,30},{-20,30}}, color={0,0,255}));
  connect(rampCurrentM.p, smeeM.pin_en) annotation (Line(points={{-30,30},
          {-20,30},{-20,34},{-10,34}}, color={0,0,255}));
  connect(rampCurrentM.n, smeeM.pin_ep) annotation (Line(points={{-30,50},
          {-20,50},{-20,46},{-10,46}}, color={0,0,255}));
  connect(smeeM.plug_sn, terminalBoxM.plug_sn)
    annotation (Line(points={{-6,50},{-6,50}}, color={0,0,255}));
  connect(smeeM.plug_sp, terminalBoxM.plug_sp)
    annotation (Line(points={{6,50},{6,50}}, color={0,0,255}));
  connect(electricalPowerSensor3.plug_p, sineVoltage3.plug_p) annotation (
     Line(
      points={{-10,-20},{-20,-20}},
      color={0,0,255}));
  connect(electricalPowerSensor3.plug_nv, star3.plug_p) annotation (Line(
      points={{0,-10},{0,-8},{-50,-8},{-50,-20}},
      color={0,0,255}));
  connect(gain.y, feedback.u2) annotation (Line(
      points={{90,19},{90,8}},
      color={0,0,127}));
  connect(electricalPowerSensor3.plug_ni, currentRMSsensor3.plug_p)
    annotation (Line(
      points={{10,-20},{20,-20}},
      color={0,0,255}));
  connect(currentRMSsensor3.plug_n, terminalBox3.plugSupply) annotation (
      Line(
      points={{40,-20},{40,-40},{0,-40},{0,-68}},
      color={0,0,255}));
  connect(currentRMSsensor3.I, feedback.u1) annotation (Line(
      points={{30,-9},{30,0},{82,0}},
      color={0,0,127}));
  connect(terminalBoxM.plugSupply, currentRMSsensorM.plug_n) annotation (
      Line(
      points={{0,52},{0,60},{40,60},{40,80}},
      color={0,0,255}));
  connect(currentRMSsensorM.I, gain.u) annotation (Line(
      points={{30,91},{30,100},{90,100},{90,42}},
      color={0,0,127}));
  connect(starM.pin_n, groundM.p) annotation (Line(points={{-70,80},{-75,
          80},{-80,80}}, color={0,0,255}));
  connect(starM.plug_p, sineVoltageM.plug_n) annotation (Line(points={{-50,
          80},{-48,80},{-40,80}}, color={0,0,255}));
  connect(sineVoltageM.plug_p, electricalPowerSensorM.pc) annotation (
      Line(
      points={{-20,80},{-12,80}},
      color={0,0,255}));
  connect(electricalPowerSensorM.pc, electricalPowerSensorM.pv)
    annotation (Line(
      points={{-12,80},{-12,70},{-2,70}},
      color={0,0,255}));
  connect(electricalPowerSensorM.nc, currentRMSsensorM.plug_p)
    annotation (Line(
      points={{8,80},{20,80}},
      color={0,0,255}));
  connect(electricalPowerSensorM.nv, starM.plug_p) annotation (Line(
      points={{-2,90},{-2,94},{-50,94},{-50,80}},
      color={0,0,255}));
  annotation (
    experiment(
      StopTime=30,
      Interval=0.001,
      Tolerance=1e-07),
    Documentation(info="<html>
<h4>Electrical excited synchronous machine as generator</h4>
<p>
Two
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.SynchronousMachines.SM_ElectricalExcited\">electrically excited synchronous generators</a> are connected to grids and driven with constant speed.
Since speed is slightly smaller than synchronous speed corresponding to mains frequency,
rotor angle is very slowly increased. Two equivalent machines with different numbers of phases are compared and their equal behavior is demonstrated.
</p>

<p>
Simulate for 30 seconds and plot (versus <code>rotorAngleM3.rotorDisplacementAngle</code>):
</p>

<ul>
<li><code>aimcM|M3.tauElectrical</code>: machine torque</li>
<li><code>aimsM|M3.wMechanical</code>: machine speed</li>
<li><code>feedback.y</code>: zero since difference of three-phase current phasor and scaled polyphase current phasor are equal</li>
</ul>

</html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={Rectangle(
                extent={{-50,60},{70,20}},
                fillColor={255,255,170},
                fillPattern=FillPattern.Solid,
                pattern=LinePattern.Dash),Text(
                extent={{10,16},{70,8}},
                fillColor={255,255,170},
                fillPattern=FillPattern.Solid,
                textStyle={TextStyle.Bold},
                textString="%m-phase machine
"),     Text(
          extent={{10,-52},{70,-60}},
                fillColor={255,255,170},
                fillPattern=FillPattern.Solid,
                textStyle={TextStyle.Bold},
                textString="Three-phase machine
"),     Rectangle(
          extent={{-50,-60},{100,-100}},
                fillColor={255,255,170},
                fillPattern=FillPattern.Solid,
                pattern=LinePattern.Dash)}));
end SMEE_Generator_Polyphase;
