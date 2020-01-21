within Modelica.Magnetic.QuasiStatic.FundamentalWave.Examples.BasicMachines.SynchronousMachines;
model SMEE_Generator
  "Electrical excited synchronous machine operating as generator"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  parameter Integer m=3 "Number of stator phases" annotation(Evaluate=true);
  parameter SI.Voltage VsNominal=100
    "Nominal RMS voltage per phase";
  parameter SI.Frequency fsNominal=smeeData.fsNominal "Nominal frequency";
  parameter SI.AngularVelocity w=
      Modelica.Units.Conversions.from_rpm(1499) "Nominal speed";
  parameter SI.Current Ie=19 "Excitation current";
  parameter SI.Current Ie0=10
    "Initial excitation current";
  parameter SI.Angle gamma0(displayUnit="deg") = 0
    "Initial rotor displacement angle";
  SI.Angle thetaQS=rotorAngleQS.rotorDisplacementAngle "Rotor displacement angle, quasi-static";
  SI.Angle theta=rotorAngle.rotorDisplacementAngle "Rotor displacement angle, transient";

  output SI.Power Ptr=powerSensor.power "Transient power";
  output SI.Power Pqs=powerSensorQS.apparentPower.re "QS power";
  Modelica.Electrical.Polyphase.Basic.Star star(final m=m) annotation (
     Placement(transformation(extent={{-50,-30},{-70,-10}})));
  Modelica.Electrical.Analog.Basic.Ground grounde annotation (Placement(
        transformation(
        origin={-90,-20},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Polyphase.Sources.SineVoltage sineVoltage(
    final m=m,
    final V=fill(VsNominal*sqrt(2), m),
    final f=fill(fsNominal, m)) annotation (Placement(
        transformation(extent={{-20,-30},{-40,-10}})));
  Modelica.Electrical.Polyphase.Sensors.PowerSensor powerSensor(m=m)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-34})));
  Modelica.Electrical.Machines.Utilities.MultiTerminalBox terminalBoxM(
      terminalConnection="Y", m=m)
    annotation (Placement(transformation(extent={{-10,-64},{10,-44}})));
  Magnetic.FundamentalWave.BasicMachines.SynchronousMachines.SM_ElectricalExcited
    smee(
    phiMechanical(start=-(Modelica.Constants.pi + gamma0)/smee.p, fixed=true),
    Jr=0.29,
    Js=0.29,
    p=2,
    fsNominal=smeeData.fsNominal,
    TsRef=smeeData.TsRef,
    alpha20s(displayUnit="1/K") = smeeData.alpha20s,
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
    statorCoreParameters(VRef=100),
    strayLoadParameters(IRef=100),
    brushParameters(ILinear=0.01),
    ir(each fixed=true),
    useDamperCage=false,
    m=m,
    frictionParameters(PRef=0),
    Rs=smeeData.Rs*m/3,
    Lssigma=smeeData.Lssigma*m/3,
    Lmd=smeeData.Lmd*m/3,
    Lmq=smeeData.Lmq*m/3,
    effectiveStatorTurns=smeeData.effectiveStatorTurns,
    TsOperational=293.15,
    TrOperational=293.15,
    TeOperational=293.15,
    sigmae=smeeData.sigmae*m/3)
    annotation (Placement(transformation(extent={{-10,-80},{10,-60}})));
  FundamentalWave.BasicMachines.SynchronousMachines.SM_ElectricalExcited
    smeeQS(
    p=2,
    fsNominal=smeeData.fsNominal,
    TsRef=smeeData.TsRef,
    alpha20s(displayUnit="1/K") = smeeData.alpha20s,
    Jr=0.29,
    Js=0.29,
    frictionParameters(PRef=0),
    statorCoreParameters(PRef=0, VRef=100),
    strayLoadParameters(PRef=0, IRef=100),
    Lrsigmad=smeeData.Lrsigmad,
    Rrd=smeeData.Rrd,
    Rrq=smeeData.Rrq,
    alpha20r(displayUnit="1/K") = smeeData.alpha20r,
    VsNominal=smeeData.VsNominal,
    IeOpenCircuit=smeeData.IeOpenCircuit,
    Re=smeeData.Re,
    TeRef=smeeData.TeRef,
    alpha20e(displayUnit="1/K") = smeeData.alpha20e,
    brushParameters(V=0, ILinear=0.01),
    Lrsigmaq=smeeData.Lrsigmaq,
    TrRef=smeeData.TrRef,
    useDamperCage=false,
    m=m,
    gammar(fixed=true, start=pi/2),
    gamma(fixed=true, start=-pi/2),
    Rs=smeeData.Rs*m/3,
    Lssigma=smeeData.Lssigma*m/3,
    Lmd=smeeData.Lmd*m/3,
    Lmq=smeeData.Lmq*m/3,
    TsOperational=293.15,
    effectiveStatorTurns=smeeData.effectiveStatorTurns,
    TrOperational=293.15,
    TeOperational=293.15) annotation (Placement(transformation(extent={
            {-10,20},{10,40}})));
  Modelica.Electrical.Analog.Basic.Ground groundr annotation (Placement(
        transformation(
        origin={-50,-88},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Ground groundrQS annotation (
      Placement(transformation(
        origin={-50,12},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Sources.RampCurrent rampCurrent(
    duration=0.1,
    I=Ie - Ie0,
    offset=Ie0) annotation (Placement(transformation(
        origin={-30,-70},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Electrical.Analog.Sources.RampCurrent rampCurrentQS(
    duration=0.1,
    I=Ie - Ie0,
    offset=Ie0) annotation (Placement(transformation(
        origin={-28,30},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Electrical.Machines.Sensors.MechanicalPowerSensor
    mechanicalPowerSensor annotation (Placement(transformation(extent={{50,-80},{70,-60}})));
  Modelica.Electrical.Machines.Sensors.MechanicalPowerSensor
    mechanicalPowerSensorQS annotation (Placement(transformation(extent={{50,20},{70,40}})));
  Modelica.Mechanics.Rotational.Sources.ConstantSpeed constantSpeed(
      final w_fixed=w, useSupport=false) annotation (Placement(
        transformation(extent={{100,-80},{80,-60}})));
  Modelica.Mechanics.Rotational.Sources.ConstantSpeed constantSpeedQS(
      final w_fixed=w, useSupport=false) annotation (Placement(
        transformation(extent={{100,20},{80,40}})));
  parameter
    Modelica.Electrical.Machines.Utilities.SynchronousMachineData
    smeeData(
    SNominal=30e3,
    VsNominal=100,
    fsNominal=50,
    IeOpenCircuit=10,
    x0=0.1,
    xd=1.6,
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
    xq=1.1,
    TsSpecification=293.15,
    TsRef=293.15,
    TrSpecification=293.15,
    TrRef=293.15,
    TeSpecification=293.15,
    TeRef=293.15) "Synchronous machine data"
    annotation (Placement(transformation(extent={{70,70},{90,90}})));

  Modelica.Electrical.QuasiStatic.Polyphase.Sources.VoltageSource
    voltageSourceQS(
    m=m,
    phi=-Modelica.Electrical.Polyphase.Functions.symmetricOrientation(
        m),
    V=fill(VsNominal, m),
    f=fsNominal) annotation (Placement(transformation(
        origin={-30,80},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  Modelica.Electrical.QuasiStatic.Polyphase.Basic.Star starQS(m=m)
    annotation (Placement(transformation(
        origin={-60,80},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Ground
    groundeQS annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-90,80})));
  Modelica.Electrical.QuasiStatic.Polyphase.Sensors.PowerSensor
    powerSensorQS(m=m) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,66})));
  Utilities.MultiTerminalBox terminalBoxQS(m=m, terminalConnection="Y")
    annotation (Placement(transformation(extent={{-10,36},{10,56}})));
  Modelica.Electrical.QuasiStatic.Polyphase.Basic.Star
    starMachineQS(m=
        Modelica.Electrical.Polyphase.Functions.numberOfSymmetricBaseSystems(
                                                                    m))
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-20,50})));
  Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Ground
    groundMachineQS annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-50,50})));
  Modelica.Electrical.Machines.Sensors.RotorDisplacementAngle rotorAngle(m=m, p=
        smee.p) annotation (Placement(transformation(
        origin={30,-70},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  Sensors.RotorDisplacementAngle rotorAngleQS(m=m, p=smeeQS.p) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={30,30})));
  Modelica.Electrical.Analog.Basic.Ground groundMachine annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        origin={-50,-50},
        rotation=270)));
  Modelica.Electrical.Polyphase.Basic.Star starMachine(final m=
        Modelica.Electrical.Polyphase.Functions.numberOfSymmetricBaseSystems(m))
    annotation (Placement(transformation(extent={{10,-10},{-10,10}}, origin={-20,
            -50})));
initial equation
  sum(smee.is) = 0;
  smee.is[1:2] = zeros(2);

equation
  connect(star.pin_n, grounde.p)
    annotation (Line(points={{-70,-20},{-80,-20}}, color={0,0,255}));
  connect(star.plug_p, sineVoltage.plug_n)
    annotation (Line(points={{-50,-20},{-40,-20}}, color={0,0,255}));
  connect(mechanicalPowerSensorQS.flange_b, constantSpeedQS.flange)
    annotation (Line(points={{70,30},{80,30}}));
  connect(rampCurrentQS.p, groundrQS.p) annotation (Line(points={{-28,
          20},{-34,20},{-34,12},{-40,12}}, color={0,0,255}));
  connect(rampCurrentQS.p, smeeQS.pin_en) annotation (Line(points={{-28,
          20},{-20,20},{-20,24},{-10,24}}, color={0,0,255}));
  connect(rampCurrentQS.n, smeeQS.pin_ep) annotation (Line(points={{-28,
          40},{-20,40},{-20,36},{-10,36}}, color={0,0,255}));
  connect(smee.flange, mechanicalPowerSensor.flange_a)
    annotation (Line(points={{10,-70},{50,-70}}));
  connect(mechanicalPowerSensor.flange_b, constantSpeed.flange)
    annotation (Line(points={{70,-70},{80,-70}}));
  connect(rampCurrent.p, groundr.p) annotation (Line(points={{-30,-80},
          {-36,-80},{-36,-88},{-38,-88},{-38,-88},{-40,-88},{-40,-88}},
        color={0,0,255}));
  connect(rampCurrent.p, smee.pin_en) annotation (Line(points={{-30,-80},
          {-20,-80},{-20,-76},{-10,-76}}, color={0,0,255}));
  connect(rampCurrent.n, smee.pin_ep) annotation (Line(points={{-30,-60},
          {-20,-60},{-20,-64},{-10,-64}}, color={0,0,255}));
  connect(smee.plug_sn, terminalBoxM.plug_sn)
    annotation (Line(points={{-6,-60},{-6,-60}}, color={0,0,255}));
  connect(smee.plug_sp, terminalBoxM.plug_sp)
    annotation (Line(points={{6,-60},{6,-60}}, color={0,0,255}));
  connect(groundeQS.pin, starQS.pin_n) annotation (Line(points={{-80,80},
          {-80,80},{-70,80}}, color={85,170,255}));
  connect(starQS.plug_p, voltageSourceQS.plug_n) annotation (Line(
        points={{-50,80},{-50,80},{-40,80}}, color={85,170,255}));
  connect(voltageSourceQS.plug_p, powerSensorQS.currentP) annotation (
      Line(points={{-20,80},{-20,80},{0,80},{0,76}},
        color={85,170,255}));
  connect(powerSensorQS.voltageP, powerSensorQS.currentP) annotation (
      Line(points={{10,66},{10,76},{0,76}}, color={85,170,255}));
  connect(powerSensorQS.voltageN, starQS.plug_p) annotation (Line(
        points={{-10,66},{-10,66},{-42,66},{-50,66},{-50,80}}, color={
          85,170,255}));
  connect(sineVoltage.plug_p, powerSensor.pc)
    annotation (Line(points={{-20,-20},{0,-20},{0,-24}}, color={0,0,255}));
  connect(powerSensor.pc, powerSensor.pv)
    annotation (Line(points={{0,-24},{10,-24},{10,-34}}, color={0,0,255}));
  connect(powerSensor.nv, star.plug_p)
    annotation (Line(points={{-10,-34},{-50,-34},{-50,-20}}, color={0,0,255}));
  connect(powerSensor.nc, terminalBoxM.plugSupply)
    annotation (Line(points={{0,-44},{0,-58}}, color={0,0,255}));
  connect(terminalBoxQS.plug_sn, smeeQS.plug_sn) annotation (Line(
      points={{-6,40},{-6,40}},
      color={85,170,255}));
  connect(terminalBoxQS.plug_sp, smeeQS.plug_sp) annotation (Line(
      points={{6,40},{6,40}},
      color={85,170,255}));
  connect(powerSensorQS.currentN, terminalBoxQS.plugSupply) annotation (
     Line(
      points={{0,56},{0,42}},
      color={85,170,255}));
  connect(starMachineQS.pin_n, groundMachineQS.pin) annotation (Line(
      points={{-30,50},{-40,50}},
      color={85,170,255}));
  connect(starMachineQS.plug_p, terminalBoxQS.starpoint) annotation (
      Line(
      points={{-10,50},{-10,42},{-10,42}},
      color={85,170,255}));
  connect(smee.flange, rotorAngle.flange) annotation (Line(points={{10,-70},{20,-70}}));
  connect(rotorAngle.plug_p, smee.plug_sp) annotation (Line(points={{24,-60},{6,-60}}, color={0,0,255}));
  connect(smee.plug_sn, rotorAngle.plug_n) annotation (Line(points={{-6,-60},{-6,-54},{36,-54},{36,-60}}, color={0,0,255}));
  connect(terminalBoxQS.plug_sp, rotorAngleQS.plug_p) annotation (Line(points={{6,40},{24,40}}, color={85,170,255}));
  connect(rotorAngleQS.plug_n, terminalBoxQS.plug_sn) annotation (Line(points={{36,40},{36,46},{-6,46},{-6,40}}, color={85,170,255}));
  connect(smeeQS.flange, rotorAngleQS.flange) annotation (Line(points={{10,30},{20,30}}));
  connect(smeeQS.flange, mechanicalPowerSensorQS.flange_a) annotation (Line(points={{10,30},{50,30}}));
  connect(starMachine.pin_n,groundMachine. p) annotation (Line(points={{-30,-50},{-40,-50}}, color={0,0,255}));
  connect(starMachine.plug_p, terminalBoxM.starpoint) annotation (Line(points={{-10,-50},{-10,-54},{-10,-58},{-10,-58}},color={0,0,255}));
  annotation (
    experiment(
      StopTime=30,
      Interval=1E-3,
      Tolerance=1e-06),
    Documentation(info="<html>
<p>
This example compares a time transient and a quasi-static model of a electrically excited synchronous machine.
The electrically excited synchronous generators are connected to the grid and driven with constant speed.
Since speed is slightly smaller than synchronous speed corresponding to mains frequency,
rotor angle is very slowly increased. This allows to see several characteristics dependent on rotor angle.
</p>

<p>
Simulate for 30 seconds and plot versus <code>rotorAngle|rotorAngleQS.rotorDisplacementAngle</code>:
</p>

<ul>
<li><code>smpm|smpmQS.tauElectrical</code>: machine torque</li>
</ul>

<p>Since the rotor slip is very low the transient and quasi-static electromagnetic torque are practically equal.</p>
</html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                         graphics={         Text(
                  extent={{20,8},{100,0}},
                  fillColor={255,255,170},
                  fillPattern=FillPattern.Solid,
                  textStyle={TextStyle.Bold},
          textString="%m phase quasi-static"),     Text(
          extent={{20,-92},{100,-100}},
                  textStyle={TextStyle.Bold},
                  textString="%m phase transient")}));
end SMEE_Generator;
