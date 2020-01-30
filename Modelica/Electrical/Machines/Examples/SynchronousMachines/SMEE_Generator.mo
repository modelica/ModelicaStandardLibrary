within Modelica.Electrical.Machines.Examples.SynchronousMachines;
model SMEE_Generator
  "Test example: ElectricalExcitedSynchronousMachine as Generator"
  extends Modelica.Icons.Example;
  constant Integer m=3 "Number of phases";
  parameter SI.Voltage VNominal=100
    "Nominal RMS voltage per phase";
  parameter SI.Frequency fNominal=50 "Nominal frequency";
  parameter SI.AngularVelocity wActual(displayUnit="rev/min")=
       1499*2*Modelica.Constants.pi/60 "Actual speed";
  parameter SI.Current Ie=19 "Excitation current";
  parameter SI.Current Ie0=10 "Initial excitation current";
  parameter SI.Angle gamma0(displayUnit="deg") = 0
    "Initial rotor displacement angle";
  Machines.BasicMachines.SynchronousMachines.SM_ElectricalExcited smee(
    phiMechanical(start=-(Modelica.Constants.pi + gamma0)/smee.p, fixed=true),
    fsNominal=smeeData.fsNominal,
    Rs=smeeData.Rs,
    TsRef=smeeData.TsRef,
    Lssigma=smeeData.Lssigma,
    Lmd=smeeData.Lmd,
    Lmq=smeeData.Lmq,
    Lrsigmad=smeeData.Lrsigmad,
    Lrsigmaq=smeeData.Lrsigmaq,
    Rrd=smeeData.Rrd,
    Rrq=smeeData.Rrq,
    TrRef=smeeData.TrRef,
    VsNominal=smeeData.VsNominal,
    IeOpenCircuit=smeeData.IeOpenCircuit,
    Re=smeeData.Re,
    TeRef=smeeData.TeRef,
    sigmae=smeeData.sigmae,
    p=2,
    Jr=0.29,
    Js=0.29,
    useDamperCage=true,
    statorCoreParameters(VRef=100),
    strayLoadParameters(IRef=100),
    brushParameters(ILinear=0.01),
    TsOperational=293.15,
    alpha20s=smeeData.alpha20s,
    ir(each fixed=true),
    TrOperational=293.15,
    alpha20r=smeeData.alpha20r,
    alpha20e=smeeData.alpha20e,
    TeOperational=293.15)
    annotation (Placement(transformation(extent={{-20,-50},{0,-30}})));
  Machines.Sensors.RotorDisplacementAngle rotorDisplacementAngle(p=smee.p)
    annotation (Placement(transformation(
        origin={20,-40},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Ground groundExcitation annotation (
      Placement(transformation(
        origin={-90,-50},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Mechanics.Rotational.Sources.ConstantSpeed constantSpeed(
      final w_fixed=wActual) annotation (Placement(transformation(extent=
            {{90,-50},{70,-30}})));
  Machines.Sensors.MechanicalPowerSensor mechanicalPowerSensor
    annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
  Machines.Sensors.ElectricalPowerSensor electricalPowerSensor annotation (
      Placement(transformation(
        origin={0,60},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Machines.Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensor annotation (
      Placement(transformation(
        origin={0,30},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  Modelica.Electrical.Polyphase.Sources.SineVoltage sineVoltage(
    final m=m,
    final V=fill(VNominal*sqrt(2), m),
    final f=fill(fNominal, m)) annotation (Placement(transformation(
          extent={{-20,80},{-40,100}})));
  Modelica.Electrical.Polyphase.Basic.Star star(final m=m) annotation (
      Placement(transformation(extent={{-50,80},{-70,100}})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(
        origin={-90,90},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Sources.RampCurrent rampCurrent(
    duration=0.1,
    I=Ie - Ie0,
    offset=Ie0) annotation (Placement(transformation(
        origin={-50,-40},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Machines.Utilities.TerminalBox terminalBox(terminalConnection="Y")
    annotation (Placement(transformation(extent={{-20,-34},{0,-14}})));
  parameter Machines.Utilities.SynchronousMachineData smeeData(
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
    annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));

initial equation
  smee.is[1:2] = zeros(2);
  //conditional damper cage currents are defined as fixed start values
equation
  connect(rotorDisplacementAngle.plug_n, smee.plug_sn) annotation (Line(
        points={{26,-30},{26,-20},{-16,-20},{-16,-30}}, color={0,0,255}));
  connect(rotorDisplacementAngle.plug_p, smee.plug_sp)
    annotation (Line(points={{14,-30},{-4,-30}}, color={0,0,255}));
  connect(star.pin_n, ground.p)
    annotation (Line(points={{-70,90},{-80,90}}, color={0,0,255}));
  connect(star.plug_p, sineVoltage.plug_n)
    annotation (Line(points={{-50,90},{-40,90}}, color={0,0,255}));
  connect(electricalPowerSensor.plug_ni, currentQuasiRMSSensor.plug_p)
    annotation (Line(points={{0,50},{0,46},{0,40}}, color={0,0,255}));
  connect(mechanicalPowerSensor.flange_b, constantSpeed.flange)
    annotation (Line(points={{60,-40},{70,-40}}));
  connect(sineVoltage.plug_p, electricalPowerSensor.plug_p)
    annotation (Line(points={{-20,90},{0,90},{0,70}}, color={0,0,255}));
  connect(rampCurrent.p, groundExcitation.p)
    annotation (Line(points={{-50,-50},{-80,-50}}, color={0,0,255}));
  connect(rampCurrent.p, smee.pin_en) annotation (Line(points={{-50,-50},
          {-40,-50},{-40,-46},{-20,-46}}, color={0,0,255}));
  connect(rampCurrent.n, smee.pin_ep) annotation (Line(points={{-50,-30},
          {-40,-30},{-40,-34},{-20,-34}}, color={0,0,255}));
  connect(electricalPowerSensor.plug_nv, smee.plug_sn) annotation (Line(
        points={{-10,60},{-16,60},{-16,-30}}, color={0,0,255}));
  connect(terminalBox.plugSupply, currentQuasiRMSSensor.plug_n)
    annotation (Line(
      points={{-10,-28},{-10,0},{0,0},{0,20}},
      color={0,0,255}));
  connect(terminalBox.plug_sn, smee.plug_sn) annotation (Line(
      points={{-16,-30},{-16,-30}},
      color={0,0,255}));
  connect(terminalBox.plug_sp, smee.plug_sp) annotation (Line(
      points={{-4,-30},{-4,-30}},
      color={0,0,255}));
  connect(smee.flange, rotorDisplacementAngle.flange) annotation (Line(
      points={{0,-40},{10,-40}}));
  connect(smee.flange, mechanicalPowerSensor.flange_a) annotation (Line(
      points={{0,-40},{40,-40}}));
  annotation (experiment(StopTime=30, Interval=0.001, Tolerance=1e-06), Documentation(info="<html>
<p>An electrically excited synchronous generator is connected to the grid and driven with constant speed.
Since speed is slightly smaller than synchronous speed corresponding to mains frequency,
rotor angle is very slowly increased. This allows to see several characteristics dependent on rotor angle.</p>

<p>Simulate for 30 seconds and plot (versus rotorDisplacementAngle.rotorDisplacementAngle):</p>

<ul>
<li>smee.tauElectrical</li>
<li>currentQuasiRMSSensor.I</li>
<li>electricalPowerSensor.P</li>
<li>electricalPowerSensor.Q</li>
<li>mechanicalPowerSensor.P</li>
</ul>

<p>Default machine parameters are used.</p>
</html>"));
end SMEE_Generator;
