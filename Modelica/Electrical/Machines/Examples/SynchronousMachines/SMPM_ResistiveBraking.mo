within Modelica.Electrical.Machines.Examples.SynchronousMachines;
model SMPM_ResistiveBraking
  "PermanentMagnetSynchronousMachine braking with a resistor"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  constant Integer m=3 "Number of phases";
  parameter SI.Inertia JLoad=4*smpmData.Jr "Load's moment of inertia";
  parameter SI.AngularVelocity w0(displayUnit="rev/min")=
    2*pi*smpmData.fsNominal/smpmData.p "Initial speed";
  parameter Real k[3]={1,3,5} "Braking resistance stages w.r.t. Rs";
  parameter SI.Current idq_sr[2](each fixed=false)
    "Initial stator current space phasor";
  SI.Torque tauElectrical=smpm.tauElectrical "Electrical torque";
  SI.Torque tauShaft=smpm.tauShaft "Shaft torque";
  SI.AngularVelocity wMechanical(displayUnit="rev/min")=
    smpm.wMechanical "Shaft speed";
  parameter
    Modelica.Electrical.Machines.Utilities.ParameterRecords.SM_PermanentMagnetData
    smpmData(useDamperCage=false)
    annotation (Placement(transformation(extent={{40,-40},{60,-20}})));
  Modelica.Electrical.Machines.BasicMachines.SynchronousMachines.SM_PermanentMagnet
    smpm(
    phiMechanical(start=0, fixed=true),
    useSupport=false,
    useThermalPort=false,
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
    TsOperational=293.15,
    alpha20s=smpmData.alpha20s,
    wMechanical(fixed=true, start=w0),
    TrOperational=293.15,
    alpha20r=smpmData.alpha20r)
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));

  Modelica.Mechanics.Rotational.Components.Inertia inertiaLoad(J=JLoad)
    annotation (Placement(transformation(extent={{70,-10},{90,10}})));
  Modelica.Electrical.Machines.Utilities.TerminalBox terminalBox(m=m,
      terminalConnection="Y")
    annotation (Placement(transformation(extent={{40,6},{60,26}})));
  Modelica.Electrical.Polyphase.Sensors.CurrentQuasiRMSSensor
    currentQuasiRMSSensor(m=m) annotation (Placement(transformation(
        origin={50,30},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  Modelica.Electrical.Polyphase.Basic.Star star(final m=m) annotation (
      Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-72,30})));
  Modelica.Electrical.Analog.Basic.Ground
    ground annotation (Placement(
        transformation(
        origin={-72,0},
        extent={{-10,-10},{10,10}})));
  Modelica.Electrical.Polyphase.Sensors.VoltageQuasiRMSSensor
    voltageRMSSensor(m=m) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={40,70})));
  Modelica.Electrical.Polyphase.Basic.Resistor resistor1(m=m, R=k[1]*fill(
        smpmData.Rs, m))
    annotation (Placement(transformation(extent={{30,60},{10,40}})));
  Modelica.Electrical.Polyphase.Basic.Resistor resistor2(m=m, R=k[2]*fill(
        smpmData.Rs, m))
    annotation (Placement(transformation(extent={{0,60},{-20,40}})));
  Modelica.Electrical.Polyphase.Basic.Resistor resistor3(m=m, R=k[3]*fill(
        smpmData.Rs, m))
    annotation (Placement(transformation(extent={{-30,60},{-50,40}})));
  Modelica.Electrical.Polyphase.Ideal.IdealClosingSwitch switch2(
    m=m,
    Ron=fill(1e-9, m),
    Goff=fill(1e-9, m)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-10,30})));
  Modelica.Electrical.Polyphase.Ideal.IdealClosingSwitch switch3(
    m=m,
    Ron=fill(1e-9, m),
    Goff=fill(1e-9, m)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-40,30})));
  Modelica.Blocks.Routing.BooleanReplicator booleanReplicator2(nout=m)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-10,-2})));
  Modelica.Blocks.Routing.BooleanReplicator booleanReplicator3(nout=m)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-40,0})));
  Modelica.Blocks.Sources.BooleanStep booleanStep2(startTime=0.65)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-10,-30})));
  Modelica.Blocks.Sources.BooleanStep booleanStep3(startTime=0.5)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-40,-30})));
initial equation
  0 = (1 + sum(k))*smpmData.Rs*idq_sr[1] - w0*smpmData.p*(smpmData.Lssigma + smpmData.Lmq)*idq_sr[2];
  0 = (1 + sum(k))*smpmData.Rs*idq_sr[2] + w0*smpmData.p*(smpmData.Lssigma + smpmData.Lmd)*idq_sr[1] + sqrt(2)*smpmData.VsOpenCircuit;
  smpm.idq_sr=idq_sr;
equation
  connect(smpm.flange, inertiaLoad.flange_a)
    annotation (Line(points={{60,0},{70,0}}));
  connect(terminalBox.plug_sn, smpm.plug_sn)
    annotation (Line(points={{44,10},{44,10}}, color={0,0,255}));
  connect(terminalBox.plug_sp, smpm.plug_sp)
    annotation (Line(points={{56,10},{56,10}},
                                             color={0,0,255}));
  connect(star.pin_n, ground.p)
    annotation (Line(points={{-72,20},{-72,10}}, color={0,0,255}));
  connect(currentQuasiRMSSensor.plug_n, terminalBox.plugSupply)
    annotation (Line(points={{50,20},{50,12}},
                                             color={0,0,255}));
  connect(resistor1.plug_p, currentQuasiRMSSensor.plug_p)
    annotation (Line(points={{30,50},{50,50},{50,40}}, color={0,0,255}));
  connect(currentQuasiRMSSensor.plug_p, voltageRMSSensor.plug_p)
    annotation (Line(points={{50,40},{50,70}},        color={0,0,255}));
  connect(star.plug_p, voltageRMSSensor.plug_n)
    annotation (Line(points={{-72,40},{-72,70},{30,70}},  color={0,0,255}));
  connect(resistor1.plug_n, resistor2.plug_p)
    annotation (Line(points={{10,50},{0,50}}, color={0,0,255}));
  connect(resistor2.plug_n, resistor3.plug_p)
    annotation (Line(points={{-20,50},{-30,50}}, color={0,0,255}));
  connect(resistor3.plug_n, star.plug_p)
    annotation (Line(points={{-50,50},{-72,50},{-72,40}}, color={0,0,255}));
  connect(resistor2.plug_n, switch2.plug_n)
    annotation (Line(points={{-20,50},{-20,30}}, color={0,0,255}));
  connect(resistor2.plug_p, switch2.plug_p)
    annotation (Line(points={{0,50},{0,30}}, color={0,0,255}));
  connect(resistor3.plug_n, switch3.plug_n)
    annotation (Line(points={{-50,50},{-50,30}}, color={0,0,255}));
  connect(resistor3.plug_p, switch3.plug_p)
    annotation (Line(points={{-30,50},{-30,30}}, color={0,0,255}));
  connect(booleanReplicator2.y, switch2.control)
    annotation (Line(points={{-10,9},{-10,18}}, color={255,0,255}));
  connect(booleanReplicator3.y, switch3.control)
    annotation (Line(points={{-40,11},{-40,18}}, color={255,0,255}));
  connect(booleanStep3.y, booleanReplicator3.u) annotation (Line(points={{-40,-19},
          {-40,-12}},                color={255,0,255}));
  connect(booleanStep2.y, booleanReplicator2.u) annotation (Line(points={{-10,-19},
          {-10,-14}},                color={255,0,255}));
  annotation (experiment(StopTime=1.0, Interval=0.001, Tolerance=1e-06),              Documentation(
        info="<html>
<p>
The voltages induced by the permanent magnets of the synchronous machine is shortened over the inductance and resistance of the stator winding
and the (optional) external braking resistors. The currents driven by these voltages cause a braking torque.
</p>
<p>
The external braking resistor is implemented with three stages which get shortened at different points during braking.
Note that the first (smallest) stage is not shortened, which ensures a minimum damping to avoid oscillations of angular velocity around zero.
The total braking resistance (sum of all stages) has to be adapted to the angular velocity at which braking starts.
</p>
<p>
Plot tauElectrical and tauShaft versus wMechanical.
</p>
<p>Default machine parameters are used.</p>
</html>"));
end SMPM_ResistiveBraking;
