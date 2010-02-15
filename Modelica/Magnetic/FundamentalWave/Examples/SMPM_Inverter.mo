within Modelica.Magnetic.FundamentalWave.Examples;
model SMPM_Inverter
  "Starting of permanent magnet synchronous machine with inverter"
  extends Modelica.Icons.Example;

  constant Integer m=3 "Number of phases";
  parameter Modelica.SIunits.Voltage VsNominal=100
    "Nominal RMS voltage per phase";
  parameter Modelica.SIunits.Frequency fsNominal=50 "Nominal frequency";
  parameter Modelica.SIunits.Frequency f=50 "Actual frequency";
  parameter Modelica.SIunits.Time tRamp=1 "Frequency ramp";
  parameter Modelica.SIunits.Torque T_Load=181.4 "Nominal load torque";
  parameter Modelica.SIunits.Time tStep=2 "Time of load torque step";
  parameter Modelica.SIunits.Inertia J_Load=0.29 "Load's moment of inertia";

  parameter Integer p = 2 "Number of pole pairs";
  parameter Modelica.SIunits.Resistance Rs=0.03
    "warm stator resistance per phase";
  parameter Modelica.SIunits.Inductance Lssigma=3*(1 - sqrt(1 - 0.0667))/(2*Modelica.Constants.pi*fsNominal)
    "stator stray inductance per phase";
  parameter Modelica.SIunits.Inductance Lmd=3*sqrt(1 - 0.0667)/(2*Modelica.Constants.pi*fsNominal)
    "main field inductance";
  parameter Modelica.SIunits.Inductance Lmq=1.0*Lmd "main field inductance";
  parameter Modelica.SIunits.Inductance Lrsigmad=3*(1 - sqrt(1 - 0.0667))/(2*Modelica.Constants.pi*fsNominal)
    "rotor stray inductance (equivalent three phase winding)";
  parameter Modelica.SIunits.Inductance Lrsigmaq=0.8*Lrsigmad
    "rotor stray inductance (equivalent three phase winding)";
  parameter Modelica.SIunits.Resistance Rrd=0.04
    "warm rotor resistance (equivalent three phase winding)";
  parameter Modelica.SIunits.Resistance Rrq=1.0*Rrd
    "warm rotor resistance (equivalent three phase winding)";

  Modelica.Electrical.Analog.Basic.Ground ground 
    annotation (Placement(transformation(
        origin={-90,90},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.MultiPhase.Basic.Star star(
    final m=m) 
    annotation (Placement(transformation(extent={{-50,80},{-70,100}}, rotation=
            0)));
  Modelica.Electrical.MultiPhase.Sources.SignalVoltage signalVoltage(
    final m=m) 
    annotation (Placement(transformation(
        origin={0,60},
        extent={{10,-10},{-10,10}},
        rotation=270)));
  Modelica.Blocks.Sources.Ramp ramp(
    height=f,
    duration=tRamp) 
    annotation (Placement(transformation(extent={{-80,50},{-60,70}}, rotation=0)));
  Modelica.Electrical.Machines.Utilities.VfController vfController(
    final m=m,
    VNominal=VsNominal,
    fNominal=fsNominal,
    BasePhase=+Modelica.Constants.pi/2) 
    annotation (Placement(transformation(extent={{-40,50},{-20,70}}, rotation=0)));
  Modelica.Electrical.Machines.Sensors.CurrentQuasiRMSSensor currentRMSsensorM 
    annotation (Placement(transformation(
        origin={0,30},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  Modelica.Electrical.Machines.Utilities.TerminalBox terminalBoxM 
    annotation (Placement(transformation(extent={{-20,0},{0,20}}, rotation=0)));
  Machines.SynchronousInductionMachines.SM_PermanentMagnet smpmM(
    Rs=Rs,
    Lssigma=Lssigma,
    Lmd=Lmd,
    Lmq=Lmq,
    Lrsigmad=Lrsigmad,
    Lrsigmaq=Lrsigmaq,
    Rrd=Rrd,
    Rrq=Rrq,
    useDamperCage=true,
    p=p) 
    annotation (Placement(transformation(extent={{-20,-20},{0,0}}, rotation=0)));
  Modelica.Electrical.Machines.Sensors.RotorDisplacementAngle rotorAngleM(
     p=p) 
    annotation (Placement(transformation(
        origin={20,-10},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  Modelica.Mechanics.Rotational.Components.Inertia loadInertiaM(
    J=J_Load) 
    annotation (Placement(transformation(extent={{40,-20},{60,0}}, rotation=0)));
  Modelica.Mechanics.Rotational.Sources.TorqueStep torqueStepM(
    startTime=tStep,
    stepTorque=-T_Load,
    useSupport=false) 
    annotation (Placement(transformation(extent={{90,-20},{70,0}}, rotation=0)));
  Modelica.Electrical.Machines.Sensors.CurrentQuasiRMSSensor currentRMSsensorE 
    annotation (Placement(transformation(
        origin={-40,30},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Machines.Utilities.TerminalBox terminalBoxE 
    annotation (Placement(transformation(extent={{-20,-52},{0,-32}}, rotation=0)));
  Modelica.Electrical.Machines.BasicMachines.SynchronousInductionMachines.SM_PermanentMagnet
    smpmE(
    Rs=Rs,
    Lssigma=Lssigma,
    Lmd=Lmd,
    Lmq=Lmq,
    Lrsigmad=
            Lrsigmad,
    Lrsigmaq=Lrsigmaq,
    Rrd=
       Rrd,
    Rrq=Rrq,
    useDamperCage=
               true,
    p=p) 
    annotation (Placement(transformation(extent={{-20,-72},{0,-52}}, rotation=0)));
  Modelica.Electrical.Machines.Sensors.RotorDisplacementAngle rotorAngleE(
    p=p) 
    annotation (Placement(transformation(
        origin={20,-62},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  Modelica.Mechanics.Rotational.Components.Inertia loadInertiaE(
    J=J_Load) 
    annotation (Placement(transformation(extent={{40,-72},{60,-52}}, rotation=0)));
  Modelica.Mechanics.Rotational.Sources.TorqueStep torqueStepE(
    startTime=tStep,
    stepTorque=-T_Load,
    useSupport=false) 
    annotation (Placement(transformation(extent={{90,-72},{70,-52}}, rotation=0)));
equation
  connect(signalVoltage.plug_n, star.plug_p) 
    annotation (Line(points={{1.83697e-015,70},{1.83697e-015,90},{-50,90}},
        color={0,0,255}));
  connect(star.pin_n, ground.p) 
    annotation (Line(points={{-70,90},{-80,90}}, color={0,0,255}));
  connect(ramp.y, vfController.u) 
    annotation (Line(points={{-59,60},{-42,60}}, color={0,0,255}));
  connect(vfController.y, signalVoltage.v) 
    annotation (Line(points={{-19,60},{7,60}},  color={0,0,255}));
  connect(loadInertiaM.flange_b, torqueStepM.flange) 
    annotation (Line(points={{60,-10},{70,-10}}, color={0,0,0}));
  connect(signalVoltage.plug_p,currentRMSsensorM. plug_p)  annotation (Line(
        points={{-1.83697e-015,50},{0,50},{0,40},{1.83697e-015,40}},
                                                                  color={0,0,
          255}));
  connect(rotorAngleM.plug_n, smpmM.plug_sn)  annotation (Line(points={{26,
          -3.55271e-015},{26,6},{-16,6},{-16,0}},        color={0,0,255}));
  connect(rotorAngleM.plug_p, smpmM.plug_sp)  annotation (Line(points={{14,0},{
          10,0},{6,1.47798e-015},{6,0},{-4,0}},
        color={0,0,255}));
  connect(rotorAngleM.flange,smpmM.flange) 
    annotation (Line(points={{10,-10},{5,-10},{5,-10},{0,-10}},
                                                          color={0,0,0}));
  connect(smpmM.flange,   loadInertiaM.flange_a) 
    annotation (Line(points={{0,-10},{40,-10}},           color={0,0,0}));
  connect(terminalBoxM.plug_sn,             smpmM.plug_sn)  annotation (Line(
        points={{-16,0},{-16,0}},                      color={0,0,255}));
  connect(terminalBoxM.plug_sp,             smpmM.plug_sp)  annotation (Line(
        points={{-4,0},{-4,-2.77556e-016},{-4,-2.77556e-016},{-4,-2.43843e-022},
          {-4,0},{-4,0}},                                   color={0,0,255}));
  connect(terminalBoxM.plugSupply,currentRMSsensorM. plug_n) annotation (Line(
        points={{-10,2},{-10,20},{-1.83697e-015,20}},color={0,0,255}));
  connect(loadInertiaE.flange_b, torqueStepE.flange) 
    annotation (Line(points={{60,-62},{70,-62}}, color={0,0,0}));
  connect(rotorAngleE.plug_n, smpmE.plug_sn)  annotation (Line(points={{26,-52},
          {26,-46},{-16,-46},{-16,-52}}, color={0,0,255}));
  connect(rotorAngleE.plug_p, smpmE.plug_sp)  annotation (Line(points={{14,-52},
          {-4,-52}}, color={0,0,255}));
  connect(rotorAngleE.flange,smpmE.flange) 
    annotation (Line(points={{10,-62},{0,-62}},           color={0,0,0}));
  connect(smpmE.flange,   loadInertiaE.flange_a) 
    annotation (Line(points={{0,-62},{40,-62}},           color={0,0,0}));
  connect(terminalBoxE.plug_sn,             smpmE.plug_sn)  annotation (Line(
        points={{-16,-52},{-16,-52}}, color={0,0,255}));
  connect(terminalBoxE.plug_sp,             smpmE.plug_sp)  annotation (Line(
        points={{-4,-52},{-4,-52}}, color={0,0,255}));

  connect(currentRMSsensorE.plug_p, currentRMSsensorM.plug_p)  annotation (Line(
        points={{-40,40},{1.83697e-015,40}},color={0,0,255}));
  connect(currentRMSsensorE.plug_n,terminalBoxE.plugSupply)   annotation (Line(
        points={{-40,20},{-40,-40},{-10,-40},{-10,-50}}, color={0,0,255}));
  annotation (
    Diagram(graphics),
    experiment(
      StopTime=4,
      Interval=0.0005,
      Tolerance=1e-05),
    experimentSetupOutput(doublePrecision=true),
    Documentation(info="<HTML>
<h4>Permanent magnet synchronous induction machine fed by an ideal inverter</h4>
<p>

An ideal frequency inverter is modeled by using a 
<a href=\"Modelica://Modelica.Electrical.Machines.Utilities.VfController\">VfController</a> 
and a threephase <a href=\"Modelica://Modelica.Electrical.MultiPhase.Sources.SignalVoltage\">SignalVoltage</a>.
Frequency is raised by a ramp, causing the 
<a href=\"Modelica://Modelica.Magnetic.FundamentalWave.Machines.SynchronousInductionMachines.SM_PermanentMagnet\">permanent magnet synchronous induction machine</a> to start, 
and accelerate the inertias.</p>

<p>At time tStep a load step is applied. Simulate for 1.5 seconds and plot (versus time):</p>

<ul>
<li><code>currentRMSsensorM|E.I</code>: equivalent RMS stator current</li>
<licode>pmsmM|E.wMechanical</code>: machine speed</li>
<li><code>pmsmM|E.tauElectrical</code>: machine torque</li>
<li><code>rotorAnglepmsmM|E.rotorDisplacementAngle</code>: rotor displacement angle</li>
</ul>
</HTML>"));
end SMPM_Inverter;
