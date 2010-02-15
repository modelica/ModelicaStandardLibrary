within Modelica.Magnetic.FundamentalWave.Examples;
model SMR_Inverter "Starting of synchronous reluctance machine with inverter"
  extends Modelica.Icons.Example;

  constant Integer m=3 "Number of phases";
  parameter Modelica.SIunits.Voltage VsNominal=100
    "Nominal RMS voltage per phase";
  parameter Modelica.SIunits.Frequency fsNominal=50 "Nominal frequency";
  parameter Modelica.SIunits.Frequency f=50 "Actual frequency";
  parameter Modelica.SIunits.Time tRamp=1 "Frequency ramp";
  parameter Modelica.SIunits.Torque T_Load=46 "Nominal load torque";
  parameter Modelica.SIunits.Time tStep=1.2 "Nime of load torque step";
  parameter Modelica.SIunits.Inertia J_Load=0.29 "Load's moment of inertia";

  parameter Integer p = 2 "Number of pole pairs";
  parameter Modelica.SIunits.Resistance Rs=0.03
    "warm stator resistance per phase";
  parameter Modelica.SIunits.Inductance Lssigma=3*(1 - sqrt(1 - 0.0667))/(2*Modelica.Constants.pi*fsNominal)
    "stator stray inductance per phase";
  parameter Modelica.SIunits.Inductance Lmd=3*sqrt(1 - 0.0667)/(2*Modelica.Constants.pi*fsNominal)
    "main field inductance";
  parameter Modelica.SIunits.Inductance Lmq=0.8*Lmd "main field inductance";
  parameter Modelica.SIunits.Inductance Lrsigmad=3*(1 - sqrt(1 - 0.0667))/(2*Modelica.Constants.pi*fsNominal)
    "rotor stray inductance (equivalent three phase winding)";
  parameter Modelica.SIunits.Inductance Lrsigmaq=0.8*Lrsigmad
    "rotor stray inductance (equivalent three phase winding)";
  parameter Modelica.SIunits.Resistance Rrd=0.04
    "warm rotor resistance (equivalent three phase winding)";
  parameter Modelica.SIunits.Resistance Rrq=0.8*Rrd
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
  Modelica.Blocks.Sources.Ramp ramp(height=f, duration=tRamp) 
    annotation (Placement(transformation(extent={{-80,50},{-60,70}}, rotation=0)));
  Modelica.Electrical.Machines.Utilities.VfController vfController(
    final m=m,
    VNominal=VsNominal,
    fNominal=fsNominal) 
    annotation (Placement(transformation(extent={{-40,50},{-20,70}}, rotation=0)));
  Modelica.Electrical.Machines.Sensors.CurrentQuasiRMSSensor currentRMSsensorM 
    annotation (Placement(transformation(
        origin={-20,30},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  Modelica.Electrical.Machines.Utilities.TerminalBox terminalBoxM 
    annotation (Placement(transformation(extent={{-30,0},{-10,20}}, rotation=0)));
  Machines.SynchronousInductionMachines.SM_ReluctanceRotor smrM(
    p=p,
    Rs=Rs,
    Lssigma=Lssigma,
    Lmd=Lmd,
    Lmq=Lmq,
    Lrsigmad=Lrsigmad,
    Lrsigmaq=Lrsigmaq,
    Rrd=Rrd,
    Rrq=Rrq) 
    annotation (Placement(transformation(extent={{-30,-20},{-10,0}}, rotation=0)));
  Modelica.Electrical.Machines.Sensors.RotorDisplacementAngle rotorAngleM(
    p=p) 
    annotation (Placement(transformation(
        origin={10,-10},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  Modelica.Mechanics.Rotational.Components.Inertia loadInertiaM(
    J=J_Load) 
    annotation (Placement(transformation(extent={{30,-20},{50,0}}, rotation=0)));
  Modelica.Mechanics.Rotational.Sources.TorqueStep torqueStepM(
    startTime=tStep,
    stepTorque=-T_Load,
    useSupport=false) 
    annotation (Placement(transformation(extent={{80,-20},{60,0}}, rotation=0)));
  Modelica.Electrical.Machines.Sensors.CurrentQuasiRMSSensor currentRMSsensorE 
    annotation (Placement(transformation(
        origin={-60,30},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Machines.Utilities.TerminalBox terminalBoxE 
    annotation (Placement(transformation(extent={{-30,-60},{-10,-40}}, rotation=
           0)));
  Modelica.Electrical.Machines.BasicMachines.SynchronousInductionMachines.SM_ReluctanceRotor
    smrE(
    p=p,
    Rs=Rs,
    Lssigma=Lssigma,
    Lmd=Lmd,
    Lmq=Lmq,
    Lrsigmad=
            Lrsigmad,
    Lrsigmaq=Lrsigmaq,
    Rrd=
       Rrd,
    Rrq=Rrq) 
    annotation (Placement(transformation(extent={{-30,-80},{-10,-60}}, rotation=
           0)));
  Modelica.Electrical.Machines.Sensors.RotorDisplacementAngle rotorAngleE(
    p=p) 
    annotation (Placement(transformation(
        origin={10,-70},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  Modelica.Mechanics.Rotational.Components.Inertia loadInertiaE(
    J=J_Load) 
    annotation (Placement(transformation(extent={{30,-80},{50,-60}}, rotation=0)));
  Modelica.Mechanics.Rotational.Sources.TorqueStep torqueStepE(
    startTime=tStep,
    stepTorque=-T_Load,
    useSupport=false) 
    annotation (Placement(transformation(extent={{80,-80},{60,-60}}, rotation=0)));
equation
  connect(signalVoltage.plug_n, star.plug_p) 
    annotation (Line(points={{1.83697e-015,70},{1.83697e-015,90},{-50,90}},
        color={0,0,255}));
  connect(star.pin_n, ground.p) 
    annotation (Line(points={{-70,90},{-80,90}}, color={0,0,255}));
  connect(smrE.flange,   loadInertiaE.flange_a) annotation (Line(points={{-10,
          -70},{30,-70}}, color={0,0,0}));
  connect(ramp.y, vfController.u) 
    annotation (Line(points={{-59,60},{-42,60}}, color={0,0,255}));
  connect(vfController.y, signalVoltage.v) 
    annotation (Line(points={{-19,60},{7,60}},  color={0,0,255}));
  connect(loadInertiaE.flange_b, torqueStepE.flange) 
    annotation (Line(points={{50,-70},{60,-70}}, color={0,0,0}));
  connect(smrE.plug_sn,rotorAngleE. plug_n)  annotation (Line(points={{-26,-60},
          {-26,-52},{16,-52},{16,-60}}, color={0,0,255}));
  connect(smrE.plug_sp,rotorAngleE. plug_p)  annotation (Line(points={{-14,-60},
          {4,-60}}, color={0,0,255}));
  connect(smrE.flange,  rotorAngleE. flange) 
    annotation (Line(points={{-10,-70},{0,-70}},            color={0,0,0}));
  connect(terminalBoxE.plug_sp,            smrE. plug_sp)  annotation (Line(
        points={{-14,-60},{-14,-60}}, color={0,0,255}));
  connect(terminalBoxE.plug_sn,            smrE. plug_sn)  annotation (Line(
        points={{-26,-60},{-26,-60}}, color={0,0,255}));
  connect(terminalBoxE.plugSupply,currentRMSsensorE. plug_n) annotation (Line(
        points={{-20,-58},{-20,-40},{-60,-40},{-60,20}}, color={0,0,255}));
  connect(smrM.flange,   loadInertiaM.flange_a) annotation (Line(points={{-10,
          -10},{30,-10}}, color={0,0,0}));
  connect(loadInertiaM.flange_b, torqueStepM.flange) 
    annotation (Line(points={{50,-10},{60,-10}}, color={0,0,0}));
  connect(smrM.plug_sn, rotorAngleM.plug_n)  annotation (Line(points={{-26,0},{
          -26,8},{16,8},{16,0}},                         color={0,0,255}));
  connect(smrM.plug_sp, rotorAngleM.plug_p)  annotation (Line(points={{-14,0},{
          -4,0},{-4,0},{4,0}},                                           color=
          {0,0,255}));
  connect(smrM.flange,   rotorAngleM.flange) 
    annotation (Line(points={{-10,-10},{0,-10}},            color={0,0,0}));
  connect(terminalBoxM.plug_sp,             smrM.plug_sp)  annotation (Line(
        points={{-14,0},{-14,0}},                      color={0,0,255}));
  connect(terminalBoxM.plug_sn,             smrM.plug_sn)  annotation (Line(
        points={{-26,0},{-26,0}},                      color={0,0,255}));
  connect(currentRMSsensorM.plug_n,terminalBoxM.plugSupply)  annotation (Line(
        points={{-20,20},{-20,11},{-20,2},{-20,2}},
                                   color={0,0,255}));
  connect(signalVoltage.plug_p, currentRMSsensorM.plug_p) annotation (Line(
        points={{-1.83697e-015,50},{-1.83697e-015,40},{-20,40}},
                                                             color={0,0,255}));
  connect(signalVoltage.plug_p, currentRMSsensorE.plug_p) annotation (Line(
        points={{-1.83697e-015,50},{0,50},{0,40},{-60,40}},
                                                          color={0,0,255}));

  annotation (
    Diagram(graphics),
    experiment(
      StopTime=1.5,
      Interval=0.001,
      Tolerance=1e-05),
    experimentSetupOutput(doublePrecision=true),
    Documentation(info="<HTML>
<h4>Synchronous induction machine with reluctance rotor fed by an ideal inverter</h4>
<p>
An ideal frequency inverter is modeled by using a 
<a href=\"Modelica://Modelica.Electrical.Machines.Utilities.VfController\">VfController</a> 
and a threephase <a href=\"Modelica://Modelica.Electrical.MultiPhase.Sources.SignalVoltage\">SignalVoltage</a>.
Frequency is raised by a ramp, causing the 
<a href=\"Modelcia://Modelica.Magnetic.FundamentalWave.Machines.SynchronousInductionMachines.SM_ReluctanceRotor\">reluctance machine</a> to start, 
and accelerating inertias. At time <code>tStep</code> a load step is applied.
</p>

<p>
Simulate for 1.5 seconds and plot (versus time):
</p>

<ul>
<li><code>currentRMSsensorM|E.I</code>: equivalent RMS stator current</li>
<li><code>smrM|E.wMechanical</code>: machine speed</li>
<li><code>smrM|E.tauElectrical</code>: machine torque</li>
<li><code>rotorAngleM|R.rotorDisplacementAngle</code>: rotor displacement angle</li>
</ul>
</HTML>"));
end SMR_Inverter;
