within Modelica.Magnetic.FundamentalWave.Examples;
model AIMC_DOL
  "Direct on line start of asynchronous induction machine with squirrel cage"
  extends Modelica.Icons.Example;

  constant Integer m=3 "Number of phases";
  parameter Modelica.SIunits.Voltage VsNominal=100
    "Nominal RMS voltage per phase";
  parameter Modelica.SIunits.Frequency fsNominal=50 "Nominal frequency";
  parameter Modelica.SIunits.Time tOn=0.1 "Start time of machine";
  parameter Modelica.SIunits.Torque T_Load=161.4 "Nominal load torque";
  parameter Modelica.SIunits.AngularVelocity w_Load(displayUnit="1/min")=1440.45*2*Modelica.Constants.pi/60
    "Nominal load speed";
  parameter Modelica.SIunits.Inertia J_Load=0.29 "Load inertia";

  parameter Integer p = 2 "Number of pole pairs";
  parameter Modelica.SIunits.Resistance Rs=0.03 "Stator resistance per phase";
  parameter Modelica.SIunits.Inductance Lssigma=3*(1 - sqrt(1 - 0.0667))/(2*Modelica.Constants.pi*fsNominal)
    "Stator stray inductance per phase";
  parameter Modelica.SIunits.Inductance Lm=3*sqrt(1 - 0.0667)/(2*Modelica.Constants.pi*fsNominal)
    "Main field inductance";
  parameter Modelica.SIunits.Inductance Lrsigma=3*(1 - sqrt(1 - 0.0667))/(2*Modelica.Constants.pi*fsNominal)
    "Rotor stray inductance (equivalent three phase winding)";
  parameter Modelica.SIunits.Resistance Rr=0.04
    "Rotor resistance (equivalent three phase winding)";

  Modelica.Electrical.Analog.Basic.Ground ground 
    annotation (Placement(transformation(
        origin={-90,90},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.MultiPhase.Basic.Star star(final m=m) 
    annotation (Placement(transformation(extent={{-50,80},{-70,100}}, rotation=
            0)));
  Modelica.Electrical.MultiPhase.Sources.SineVoltage sineVoltage(
    final m=m,
    freqHz=fill(fsNominal, m),
    V=fill(sqrt(2.0/3.0)*VsNominal, m)) 
    annotation (Placement(transformation(
        origin={0,60},
        extent={{10,-10},{-10,10}},
        rotation=270)));
  Modelica.Electrical.Machines.Sensors.CurrentQuasiRMSSensor currentRMSsensorM 
    annotation (Placement(transformation(
        origin={0,0},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  Modelica.Electrical.Machines.Utilities.TerminalBox terminalBoxM(
    terminalConnection="D") 
    annotation (Placement(transformation(extent={{-10,-30},{10,-10}}, rotation=
            0)));
  Machines.AsynchronousInductionMachines.AIM_SquirrelCage aimcM(
    p=p,
    Rs=Rs,
    Lssigma=Lssigma,
    Lm=Lm,
    Lrsigma=Lrsigma,
    Rr=Rr) 
    annotation (Placement(transformation(extent={{-10,-50},{10,-30}}, rotation=
            0)));
  Modelica.Mechanics.Rotational.Components.Inertia loadInertiaM(
    J=J_Load) 
    annotation (Placement(transformation(extent={{40,-50},{60,-30}}, rotation=0)));
  Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
    quadraticLoadTorqueM(
    w_nominal=w_Load,
    tau_nominal=-T_Load,
    TorqueDirection=false,
    useSupport=false) 
    annotation (Placement(transformation(extent={{90,-50},{70,-30}}, rotation=0)));
  Modelica.Electrical.Machines.Sensors.CurrentQuasiRMSSensor currentRMSsensorE 
    annotation (Placement(transformation(
        origin={-20,0},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Machines.Utilities.TerminalBox terminalBoxE(
    terminalConnection=
              "D") 
    annotation (Placement(transformation(extent={{-10,-70},{10,-50}}, rotation=
            0)));
  Modelica.Electrical.Machines.BasicMachines.AsynchronousInductionMachines.AIM_SquirrelCage
    aimcE(
    p=p,
    Rs=Rs,
    Lssigma=Lssigma,
    Lm=Lm,
    Lrsigma=Lrsigma,
    Rr=Rr) 
    annotation (Placement(transformation(extent={{-10,-90},{10,-70}}, rotation=
            0)));
  Modelica.Mechanics.Rotational.Components.Inertia loadInertiaE(
                                                     J=J_Load) 
    annotation (Placement(transformation(extent={{40,-90},{60,-70}}, rotation=0)));
  Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
    quadraticLoadTorqueE(
    w_nominal=w_Load,
    tau_nominal=-T_Load,
    TorqueDirection=false,
    useSupport=false) 
    annotation (Placement(transformation(extent={{90,-90},{70,-70}}, rotation=0)));
  Blocks.Sources.BooleanStep booleanStep[m](
    each startTime=tOn, each startValue=false) 
    annotation (Placement(transformation(extent={{-60,20},{-40,40}}, rotation=0)));
  Electrical.MultiPhase.Ideal.IdealClosingSwitch idealCloser(
    final m=m) 
    annotation (Placement(transformation(
        origin={0,30},
        extent={{-10,10},{10,-10}},
        rotation=270)));
equation
  connect(star.pin_n, ground.p) 
    annotation (Line(points={{-70,90},{-80,90}}, color={0,0,255}));
  connect(sineVoltage.plug_n, star.plug_p) 
    annotation (Line(points={{1.33731e-15,70},{1.33731e-15,90},{-50,90}},
        color={0,0,255}));
  connect(aimcM.flange,   loadInertiaM.flange_a) 
    annotation (Line(points={{10,-40},{10,-40},{40,-40}},
                                                 color={0,0,0}));
  connect(loadInertiaM.flange_b, quadraticLoadTorqueM.flange) 
    annotation (Line(points={{60,-40},{70,-40}}, color={0,0,0}));
  connect(terminalBoxM.plug_sn,             aimcM.plug_sn) 
    annotation (Line(points={{-6,-30},{-6,-34},{-6,-30}},
                                                 color={0,0,255}));
  connect(terminalBoxM.plug_sp,             aimcM.plug_sp) 
    annotation (Line(points={{6,-30},{6,-30}}, color={0,0,255}));
  connect(terminalBoxM.plugSupply, currentRMSsensorM.plug_n) 
    annotation (Line(points={{6.10623e-16,-28},{-1.33731e-15,-28},{-1.33731e-15,
          -10}}, color={0,0,255}));
  connect(aimcE.flange,   loadInertiaE.flange_a) 
    annotation (Line(points={{10,-80},{10,-80},{40,-80}},
                                                 color={0,0,0}));
  connect(loadInertiaE.flange_b, quadraticLoadTorqueE.flange) 
    annotation (Line(points={{60,-80},{70,-80}}, color={0,0,0}));
  connect(terminalBoxE.plug_sn,             aimcE.plug_sn) 
    annotation (Line(points={{-6,-70},{-8,-70},{-6,-70}},
                                                 color={0,0,255}));
  connect(terminalBoxE.plug_sp,             aimcE.plug_sp) 
    annotation (Line(points={{6,-70},{6,-70},{6,-70}},
                                               color={0,0,255}));
  connect(currentRMSsensorE.plug_p, currentRMSsensorM.plug_p) 
    annotation (Line(points={{-20,10},{2.33651e-15,10},{2.33651e-15,10}},
                            color={0,0,255}));
  connect(currentRMSsensorE.plug_n,terminalBoxE.plugSupply) 
    annotation (Line(points={{-20,-10},{-20,-60},{6.10623e-16,-60},{6.10623e-16,
          -68}}, color={0,0,255}));

  connect(sineVoltage.plug_p, idealCloser.plug_p) annotation (Line(
      points={{-2.33651e-15,50},{2.33651e-15,50},{2.33651e-15,40}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(idealCloser.plug_n, currentRMSsensorM.plug_p) annotation (Line(
      points={{-1.33731e-15,20},{2.33651e-15,20},{2.33651e-15,10}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(booleanStep.y, idealCloser.control) annotation (Line(
      points={{-39,30},{-7,30}},
      color={255,0,255},
      smooth=Smooth.None));
  annotation (
    Diagram(graphics),
    experiment(
      StopTime=1.5,
      Interval=0.0002,
      Tolerance=1e-05),
    experimentSetupOutput(doublePrecision=true),
    Documentation(info="<HTML>
<h4>Direct on line (DOL) starting of an asynchronous induction machine with squirrel cage</h4>
<p>
At start time tStart three phase voltage is supplied to the 
<a href=\"Modelica://Modelica.Magnetic.FundamentalWave.Machines.AsynchronousInductionMachines.AIM_SquirrelCage\">asynchronous induction machine with squirrel cage</a>.
The machine starts from standstill, accelerating 
inertias against load torque quadratic dependent on speed, finally reaching nominal speed.</p>

<p>
Simulate for 1.5 seconds and plot (versus time):
</p>
 
<ul>
<li><code>currentRMSsensorM|E.I</code>: equivalent RMS stator current</li>
<li><code>aimcM|E.wMechanical</code>: machine speed</li>
<li><code>aimcM|E.tauElectrical</code>: machine torque</li>
</ul>
</HTML>"));
end AIMC_DOL;
