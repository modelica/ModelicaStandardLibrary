within Modelica.Magnetic.FundamentalWave.Examples.BasicMachines.SynchronousMachines;
model SMEE_Generator
  "Electrical excited synchronous machine operating as generator"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  constant Integer m=3 "Number of stator phases";
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
  Modelica.Electrical.Polyphase.Basic.Star star(final m=m) annotation (
      Placement(transformation(extent={{-50,80},{-70,100}})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(
        origin={-90,90},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Polyphase.Sources.SineVoltage sineVoltage(
    final m=m,
    final V=fill(VsNominal*sqrt(2), m),
    final f=fill(fsNominal, m)) annotation (Placement(transformation(
          extent={{-20,80},{-40,100}})));
  Modelica.Electrical.Machines.Sensors.ElectricalPowerSensor electricalPowerSensorM
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,30})));
  Modelica.Electrical.Machines.Sensors.ElectricalPowerSensor electricalPowerSensorE
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-60,30})));
  Modelica.Electrical.Machines.Utilities.TerminalBox terminalBoxM(
      terminalConnection="Y") annotation (Placement(transformation(extent={{-10,-14},
            {10,6}})));
  Modelica.Electrical.Machines.Utilities.TerminalBox terminalBoxE(
      terminalConnection="Y") annotation (Placement(transformation(extent={{-10,-74},
            {10,-54}})));
  Magnetic.FundamentalWave.BasicMachines.SynchronousMachines.SM_ElectricalExcited
    smeeM(
    ratioCommonStatorLeakage=smeeData.ratioCommonStatorLeakage,
    phiMechanical(start=-(Modelica.Constants.pi + gamma0)/p, fixed=true),
    Jr=0.29,
    Js=0.29,
    p=2,
    fsNominal=smeeData.fsNominal,
    Rs=smeeData.Rs,
    TsRef=smeeData.TsRef,
    alpha20s(displayUnit="1/K") = smeeData.alpha20s,
    Lssigma=smeeData.Lssigma,
    Lmd=smeeData.Lmd,
    Lmq=smeeData.Lmq,
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
    sigmae=smeeData.sigmae,
    statorCoreParameters(VRef=100),
    strayLoadParameters(IRef=100),
    brushParameters(ILinear=0.01),
    ir(each fixed=true),
    TsOperational=293.15,
    effectiveStatorTurns=smeeData.effectiveStatorTurns,
    TrOperational=293.15,
    TeOperational=293.15)
    annotation (Placement(transformation(extent={{-10,-30},{10,-10}})));

  Modelica.Electrical.Machines.BasicMachines.SynchronousMachines.SM_ElectricalExcited
    smeeE(
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
    TsOperational=293.15,
    ir(each fixed=true),
    TrOperational=293.15,
    TeOperational=293.15) annotation (Placement(transformation(extent={{-10,
            -90},{10,-70}})));

  Modelica.Electrical.Analog.Basic.Ground groundM annotation (Placement(
        transformation(
        origin={-50,-30},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Ground groundE annotation (Placement(
        transformation(
        origin={-50,-90},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Sources.RampCurrent rampCurrentM(
    duration=0.1,
    I=Ie - Ie0,
    offset=Ie0) annotation (Placement(transformation(
        origin={-30,-20},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Electrical.Analog.Sources.RampCurrent rampCurrentE(
    duration=0.1,
    I=Ie - Ie0,
    offset=Ie0) annotation (Placement(transformation(
        origin={-30,-80},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Electrical.Machines.Sensors.RotorDisplacementAngle rotorAngleM(
      p=p) annotation (Placement(transformation(
        origin={30,-20},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  Modelica.Electrical.Machines.Sensors.RotorDisplacementAngle rotorAngleE(
      p=p) annotation (Placement(transformation(
        origin={30,-80},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  Modelica.Electrical.Machines.Sensors.MechanicalPowerSensor
    mechanicalPowerSensorM annotation (Placement(transformation(extent={{
            50,-30},{70,-10}})));
  Modelica.Electrical.Machines.Sensors.MechanicalPowerSensor
    mechanicalPowerSensorE annotation (Placement(transformation(extent={{
            50,-90},{70,-70}})));
  Modelica.Mechanics.Rotational.Sources.ConstantSpeed constantSpeedM(
      final w_fixed=w, useSupport=false) annotation (Placement(
        transformation(extent={{100,-30},{80,-10}})));
  Modelica.Mechanics.Rotational.Sources.ConstantSpeed constantSpeedE(
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
    annotation (Placement(transformation(extent={{-80,-80},{-60,-60}})));

  SI.Angle thetaM=rotorAngleM.rotorDisplacementAngle "Rotor displacement angle, FundamentalWave machine";
  SI.Angle thetaE=rotorAngleE.rotorDisplacementAngle "Rotor displacement angle, Electrical machine";

initial equation
  smeeE.is[1:2] = zeros(2);
  smeeM.is[1:2] = zeros(2);
  //conditional damper cage currents are defined as fixed start values
equation
  connect(rotorAngleE.plug_n, smeeE.plug_sn) annotation (Line(points={{36,
          -70},{36,-60},{-6,-60},{-6,-70}}, color={0,0,255}));
  connect(rotorAngleE.plug_p, smeeE.plug_sp)
    annotation (Line(points={{24,-70},{6,-70}}, color={0,0,255}));
  connect(rotorAngleE.flange, smeeE.flange)
    annotation (Line(points={{20,-80},{10,-80}}));
  connect(star.pin_n, ground.p)
    annotation (Line(points={{-70,90},{-80,90}}, color={0,0,255}));
  connect(star.plug_p, sineVoltage.plug_n)
    annotation (Line(points={{-50,90},{-40,90}}, color={0,0,255}));
  connect(smeeE.flange, mechanicalPowerSensorE.flange_a)
    annotation (Line(points={{10,-80},{50,-80}}));
  connect(mechanicalPowerSensorE.flange_b, constantSpeedE.flange)
    annotation (Line(points={{70,-80},{80,-80}}));
  connect(rampCurrentE.p, groundE.p)
    annotation (Line(points={{-30,-90},{-40,-90}}, color={0,0,255}));
  connect(rampCurrentE.p, smeeE.pin_en) annotation (Line(points={{-30,-90},
          {-20,-90},{-20,-86},{-10,-86}},color={0,0,255}));
  connect(rampCurrentE.n, smeeE.pin_ep) annotation (Line(points={{-30,-70},
          {-20,-70},{-20,-74},{-10,-74}},color={0,0,255}));
  connect(smeeE.plug_sn, terminalBoxE.plug_sn)
    annotation (Line(points={{-6,-70},{-6,-70}}, color={0,0,255}));
  connect(smeeE.plug_sp, terminalBoxE.plug_sp)
    annotation (Line(points={{6,-70},{6,-70}}, color={0,0,255}));
  connect(rotorAngleM.plug_n, smeeM.plug_sn) annotation (Line(points={{36,
          -10},{36,0},{-6,0},{-6,-10}}, color={0,0,255}));
  connect(rotorAngleM.plug_p, smeeM.plug_sp) annotation (Line(points={{24,
          -10},{24,-10},{6,-10}}, color={0,0,255}));
  connect(rotorAngleM.flange, smeeM.flange) annotation (Line(points={{20,
          -20},{15,-20},{10,-20}}));
  connect(smeeM.flange, mechanicalPowerSensorM.flange_a)
    annotation (Line(points={{10,-20},{50,-20}}));
  connect(mechanicalPowerSensorM.flange_b, constantSpeedM.flange)
    annotation (Line(points={{70,-20},{80,-20}}));
  connect(rampCurrentM.p, groundM.p) annotation (Line(points={{-30,-30},{
          -35,-30},{-35,-30},{-40,-30}}, color={0,0,255}));
  connect(rampCurrentM.p, smeeM.pin_en) annotation (Line(points={{-30,-30},
          {-20,-30},{-20,-26},{-10,-26}}, color={0,0,255}));
  connect(rampCurrentM.n, smeeM.pin_ep) annotation (Line(points={{-30,-10},
          {-20,-10},{-20,-14},{-10,-14}}, color={0,0,255}));
  connect(smeeM.plug_sn, terminalBoxM.plug_sn)
    annotation (Line(points={{-6,-10},{-6,-10}}, color={0,0,255}));
  connect(smeeM.plug_sp, terminalBoxM.plug_sp)
    annotation (Line(points={{6,-10},{6,-10}}, color={0,0,255}));
  connect(electricalPowerSensorM.plug_p, sineVoltage.plug_p) annotation (
      Line(
      points={{0,40},{0,90},{-20,90}},
      color={0,0,255}));
  connect(electricalPowerSensorE.plug_p, sineVoltage.plug_p) annotation (
      Line(
      points={{-60,40},{0,40},{0,90},{-20,90}},
      color={0,0,255}));
  connect(electricalPowerSensorM.plug_ni, terminalBoxM.plugSupply)
    annotation (Line(
      points={{0,20},{0,-8}},
      color={0,0,255}));
  connect(electricalPowerSensorE.plug_ni, terminalBoxE.plugSupply)
    annotation (Line(
      points={{-60,20},{-60,-50},{0,-50},{0,-68}},
      color={0,0,255}));
  connect(electricalPowerSensorE.plug_nv, star.plug_p) annotation (Line(
      points={{-50,30},{-50,90}},
      color={0,0,255}));
  connect(electricalPowerSensorM.plug_nv, star.plug_p) annotation (Line(
      points={{-10,30},{-50,30},{-50,90}},
      color={0,0,255}));
  annotation (experiment(
      StopTime=30,
      Interval=0.001,
      Tolerance=1e-06), Documentation(info="<html>
<h4>Electrical excited synchronous machine as generator</h4>
<p>
An
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.SynchronousMachines.SM_ElectricalExcited\">electrically excited synchronous generator</a> is connected to the grid and driven with constant speed.
Since speed is slightly smaller than synchronous speed corresponding to mains frequency,
rotor angle is very slowly increased. This allows to see several characteristics dependent on rotor angle.
</p>

<p>
Simulate for 30 seconds and plot (versus <code>rotorAngleM.rotorDisplacementAngle</code>):
</p>

<ul>
<li><code>speedM|E.tauElectrical</code>: machine torque</li>
<li><code>mechanicalPowerSensorM|E.P</code>: mechanical power</li>
</ul>
</html>"));
end SMEE_Generator;
