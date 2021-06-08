within Modelica.Magnetic.FundamentalWave.Examples.BasicMachines.SynchronousMachines;
model SMEE_DOL
  "ElectricalExcitedSynchronousMachine starting direct on line"
  extends Modelica.Icons.Example;
  parameter Integer m=3 "Number of phases" annotation(Evaluate=true);
  parameter SI.Voltage VNominal=100 "Nominal RMS voltage per phase";
  parameter SI.Frequency fNominal=50 "Nominal frequency";
  parameter SI.Voltage Ve=smeeData.Re*smeeData.IeOpenCircuit "Excitation current";
  parameter SI.Angle gamma0(displayUnit="deg") = 0 "Initial rotor displacement angle";
  Modelica.Blocks.Interfaces.RealOutput irRMS(
    final quantity="ElectricCurrent",
    final unit="A") if smee.useDamperCage "Damper cage RMS current"
    annotation (Placement(visible=false));
  Magnetic.FundamentalWave.BasicMachines.SynchronousMachines.SM_ElectricalExcited
    smee(
    ratioCommonStatorLeakage=smeeData.ratioCommonStatorLeakage,
    phiMechanical(start=-(Modelica.Constants.pi + gamma0)/smee.p, fixed=true),
    fsNominal=smeeData.fsNominal,
    TsRef=smeeData.TsRef,
    Lrsigmad=smeeData.Lrsigmad,
    Lrsigmaq=smeeData.Lrsigmaq,
    Rrd=smeeData.Rrd,
    Rrq=smeeData.Rrq,
    TrRef=smeeData.TrRef,
    VsNominal=smeeData.VsNominal,
    IeOpenCircuit=smeeData.IeOpenCircuit,
    Re=smeeData.Re,
    TeRef=smeeData.TeRef,
    p=2,
    Jr=0.29,
    Js=0.29,
    useDamperCage=true,
    statorCoreParameters(VRef=100),
    strayLoadParameters(IRef=100),
    brushParameters(ILinear=0.01),
    ir(each fixed=true),
    wMechanical(fixed=true),
    m=m,
    Rs=smeeData.Rs*m/3,
    Lssigma=smeeData.Lssigma*m/3,
    Lmd=smeeData.Lmd*m/3,
    Lmq=smeeData.Lmq*m/3,
    TsOperational=293.15,
    alpha20s=smeeData.alpha20s,
    alpha20r=smeeData.alpha20r,
    TrOperational=293.15,
    TeOperational=293.15,
    alpha20e=smeeData.alpha20e,
    sigmae=smeeData.sigmae*m/3)
    annotation (Placement(transformation(extent={{-20,-50},{0,-30}})));
  Modelica.Electrical.Machines.Sensors.RotorDisplacementAngle rotorDisplacementAngle(p=smee.p, m=m) annotation (Placement(transformation(
        origin={20,-40},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Ground groundExcitation annotation (
      Placement(transformation(
        origin={-40,-70},
        extent={{-10,-10},{10,10}})));
  Modelica.Mechanics.Rotational.Sensors.MultiSensor mechanicalSensor annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
  Modelica.Electrical.Polyphase.Sensors.MultiSensor electricalSensor(m=m) annotation (Placement(transformation(
        origin={40,30},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Polyphase.Sensors.CurrentQuasiRMSSensor currentRMSSensor(m=m) annotation (Placement(transformation(
        origin={40,0},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Polyphase.Sources.SineVoltage sineVoltage(
    final m=m,
    final V=fill(VNominal*sqrt(2), m),
    final f=fill(fNominal, m)) annotation (Placement(transformation(
          extent={{-10,40},{-30,60}})));
  Modelica.Electrical.Polyphase.Basic.Star star(final m=m) annotation (
      Placement(transformation(extent={{-40,40},{-60,60}})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(
        origin={-60,30},
        extent={{-10,-10},{10,10}})));
  Modelica.Electrical.Analog.Sources.RampVoltage rampVoltage(
    duration=0.1,
    V=Ve,
    offset=0,
    startTime=0.5) annotation (Placement(transformation(
        origin={-40,-40},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  Modelica.Electrical.Machines.Utilities.TerminalBox terminalBox(terminalConnection="Y", m=m) annotation (Placement(transformation(extent={{-20,-34},{0,-14}})));
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
    TeRef=293.15) "Synchronous machine data" annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));

  Modelica.Electrical.Polyphase.Ideal.IdealClosingSwitch switch(
    final m=m,
    Ron=fill(1e-5*m/3, m),
    Goff=fill(1e-5*m/3, m)) annotation (Placement(transformation(
        origin={10,50},
        extent={{-10,10},{10,-10}})));
  Modelica.Blocks.Sources.BooleanStep booleanStep(startTime=0) annotation (Placement(transformation(extent={{-50,0},{-30,20}})));
  Modelica.Blocks.Routing.BooleanReplicator booleanReplicator(nout=m) annotation (Placement(transformation(extent={{-20,20},{0,0}})));
  Modelica.Mechanics.Rotational.Sources.TorqueStep torqueStep(
    offsetTorque=0,
    stepTorque=50,
    startTime=2) annotation (Placement(transformation(extent={{90,-50},{70,-30}})));
initial equation
  // sum(smee.is) = 0;
  smee.is[1:2] = zeros(2);
  smee.ie = 0;
  //conditional damper cage currents are defined as fixed start values
equation
  connect(irRMS, smee.irRMS);
  connect(rotorDisplacementAngle.plug_n, smee.plug_sn) annotation (Line(
        points={{26,-30},{26,-20},{-16,-20},{-16,-30}}, color={0,0,255}));
  connect(rotorDisplacementAngle.plug_p, smee.plug_sp)
    annotation (Line(points={{14,-30},{-4,-30}}, color={0,0,255}));
  connect(star.pin_n, ground.p)
    annotation (Line(points={{-60,50},{-60,40}}, color={0,0,255}));
  connect(star.plug_p, sineVoltage.plug_n)
    annotation (Line(points={{-40,50},{-30,50}}, color={0,0,255}));
  connect(terminalBox.plugSupply, currentRMSSensor.plug_n) annotation (Line(points={{-10,-28},{-10,-10},{40,-10}}, color={0,0,255}));
  connect(terminalBox.plug_sn, smee.plug_sn) annotation (Line(
      points={{-16,-30},{-16,-30}},
      color={0,0,255}));
  connect(terminalBox.plug_sp, smee.plug_sp) annotation (Line(
      points={{-4,-30},{-4,-30}},
      color={0,0,255}));
  connect(smee.flange, rotorDisplacementAngle.flange) annotation (Line(
      points={{0,-40},{10,-40}}));
  connect(smee.flange, mechanicalSensor.flange_a) annotation (Line(points={{0,-40},{40,-40}}));
  connect(sineVoltage.plug_p, switch.plug_p) annotation (Line(points={{-10,50},{0,50}}, color={0,0,255}));
  connect(booleanReplicator.y, switch.control) annotation (Line(points={{1,10},{10,10},{10,38}}, color={255,0,255}));
  connect(booleanStep.y, booleanReplicator.u)
    annotation (Line(points={{-29,10},{-22,10}}, color={255,0,255}));
  connect(groundExcitation.p, rampVoltage.n)
    annotation (Line(points={{-40,-60},{-40,-60},{-40,-56},{-40,-56},{-40,-50},{-40,-50}},
                                                   color={0,0,255}));
  connect(rampVoltage.n, smee.pin_en) annotation (Line(points={{-40,-50},{-30,-50},{-30,-46},{-20,-46}},
                                          color={0,0,255}));
  connect(rampVoltage.p, smee.pin_ep) annotation (Line(points={{-40,-30},{-30,-30},{-30,-34},{-20,-34}},
                                          color={0,0,255}));
  connect(mechanicalSensor.flange_b, torqueStep.flange) annotation (Line(points={{60,-40},{70,-40}}));
  connect(switch.plug_n, electricalSensor.pc) annotation (Line(points={{20,50},{40,50},{40,40}}, color={0,0,255}));
  connect(electricalSensor.nv, terminalBox.plug_sn) annotation (Line(points={{30,30},{20,30},{20,-20},{-16,-20},{-16,-30}}, color={0,0,255}));
  connect(electricalSensor.nc, currentRMSSensor.plug_p) annotation (Line(points={{40,20},{40,10}}, color={0,0,255}));
  connect(electricalSensor.pv, electricalSensor.pc) annotation (Line(points={{50,30},{50,40},{40,40}}, color={0,0,255}));
  annotation (experiment(StopTime=3,Interval=0.0001,Tolerance=1e-006),
    Documentation(info="<html>
<p>An electrically excited synchronous generator is started direct on line utilizing the damper cage
(and the shorted excitation winding) at 0 seconds.</p>
<p>At t = 0.5 seconds, the excitation voltage is raised to achieve the no-load excitation current.
Note, that reactive power of the stator goes to zero.</p>
<p>At t = 2 second, a driving torque step is applied to the shaft (i.e. the turbine is activated).
Note, that the active (and the reactive) power of the stator change.
To drive at higher torque, i.e., produce more electric power, excitation has to be adapted.
</p>

<p>Simulate for 3 seconds and plot:</p>

<ul>
<li><code>smee.tauElectrical</code>: electric torque</li>
<li><code>smee.wMechanical</code>: mechanical speed</li>
<li><code>currentRMSSensor.I</code>: quasi RMS stator current</li>
<li><code>irRMS</code>: quasi RMS rotor current</li>
<li><code>smee.ie</code>: excitation current</li>
<li><code>rotorDisplacementAngle.rotorDisplacementAngle</code>: rotor displacement angle</li>
<li><code>electricalSensor.powerTotal</code>: total electric real power</li>
<li><code>mechanicalSensor.power</code>: mechanical power</li>
</ul>

<p>Default machine parameters are used.</p>

<h5>Note</h5>
<p>The mains switch is closed at time = 0 in order to avoid non physical noise calculated by the <code>rotorDisplacementAngle</code>.
This noise is caused by the interaction of the high resistance of the switch and the machine, see
<a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2388\">#2388</a>.
</p>
</html>"));
end SMEE_DOL;
