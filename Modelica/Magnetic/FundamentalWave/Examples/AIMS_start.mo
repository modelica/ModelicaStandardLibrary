within Modelica.Magnetic.FundamentalWave.Examples;
model AIMS_start "Starting of asynchronous induction machine with slip rings"
  extends Modelica.Icons.Example;

  constant Integer m=3 "Number of phases";
  parameter Modelica.SIunits.Voltage VsNominal=100
    "Nominal RMS voltage per phase";
  parameter Modelica.SIunits.Frequency fsNominal=50 "Nominal frequency";
  parameter Modelica.SIunits.Time tOn=0.1 "Start time of machine";
  parameter Modelica.SIunits.Resistance RStart=0.16 "starting resistance";
  parameter Modelica.SIunits.Time tRheostat=1.0
    "Time of shortening the rheostat";
  parameter Modelica.SIunits.Torque T_Load=161.4 "Nominal load torque";
  parameter Modelica.SIunits.AngularVelocity w_Load(displayUnit="1/min")=1440.45*2*Modelica.Constants.pi/60
    "Nominal load speed";
  parameter Modelica.SIunits.Inertia J_Load=0.29 "Load's moment of inertia";

  parameter Integer p = 2 "Number of pole pairs";
  parameter Modelica.SIunits.Resistance Rs = 0.03 "Stator resistance per phase";
  parameter Modelica.SIunits.Inductance Lssigma = 3*(1 - sqrt(1 - 0.0667))/(2*Modelica.Constants.pi*fsNominal)
    "Stator stray inductance per phase";
  parameter Modelica.SIunits.Inductance Lm = 3*sqrt(1 - 0.0667)/(2*Modelica.Constants.pi*fsNominal)
    "Main field inductance";
  parameter Modelica.SIunits.Inductance Lrsigma = 3*(1 - sqrt(1 - 0.0667))/(2*Modelica.Constants.pi*fsNominal)
    "Rotor stray inductance (equivalent three phase winding)";
  parameter Modelica.SIunits.Resistance Rr = 0.04
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
  Modelica.Electrical.MultiPhase.Ideal.IdealClosingSwitch idealCloser(
    final m=m) 
    annotation (Placement(transformation(
        origin={0,30},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  Modelica.Blocks.Sources.BooleanStep booleanStep[m](
    each startTime=tOn) 
    annotation (Placement(transformation(extent={{-60,20},{-40,40}}, rotation=0)));
  Modelica.Electrical.Machines.Sensors.CurrentQuasiRMSSensor
    currentRMSsensorElectricalE 
    annotation (Placement(transformation(
        origin={30,-10},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  Modelica.Electrical.Machines.Utilities.TerminalBox terminalBoxElectrical(
                          terminalConnection=
                                    "D") 
    annotation (Placement(transformation(extent={{20,-40},{40,-20}}, rotation=0)));
  Modelica.Electrical.Machines.BasicMachines.AsynchronousInductionMachines.AIM_SlipRing
    aimsE(
    p=p,
    fsNominal=
             fsNominal,
    Rs=Rs,
    Lssigma=Lssigma,
    Lm=Lm,
    Lrsigma=Lrsigma,
    Rr=Rr,
    turnsRatio=0.7,
    useTurnsRatio=true) 
    annotation (Placement(transformation(extent={{20,-60},{40,-40}}, rotation=0)));
  Electrical.Machines.Utilities.SwitchedRheostat rheostatElectricalE(
                        RStart=RStart, tStart=tRheostat) 
   annotation (Placement(transformation(extent={{0,-60},{20,-40}}, rotation=0)));
  Modelica.Mechanics.Rotational.Components.Inertia loadInertiaElectricalE(
                                                               J=J_Load) 
    annotation (Placement(transformation(extent={{50,-60},{70,-40}}, rotation=0)));
  Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
    quadraticLoadTorqueElectricalE(
    tau_nominal=-T_Load,
    TorqueDirection=false,
    useSupport=false,
    w_nominal=w_Load) 
    annotation (Placement(transformation(extent={{100,-60},{80,-40}}, rotation=
            0)));
  Modelica.Electrical.Machines.Sensors.CurrentQuasiRMSSensor currentRMSsensorM 
    annotation (Placement(transformation(
        origin={-30,-10},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Machines.Utilities.TerminalBox terminalBox(
    terminalConnection=
              "D") 
    annotation (Placement(transformation(extent={{-20,-40},{-40,-20}}, rotation=
           0)));
  Machines.AsynchronousInductionMachines.AIM_SlipRing aimsM(
    Rs=Rs,
    Lssigma=Lssigma,
    Lm=Lm,
    Lrsigma=Lrsigma,
    Rr=Rr,
    p=p,
    TurnsRatio=0.7,
  useTurnsRatio=true) 
    annotation (Placement(transformation(extent={{-20,-60},{-40,-40}}, rotation=
           0)));
  Electrical.Machines.Utilities.SwitchedRheostat rheostatM(
      RStart=RStart, tStart=tRheostat) 
                                annotation (Placement(transformation(extent={{0,-60},
            {-20,-40}},      rotation=0)));
  Modelica.Mechanics.Rotational.Components.Inertia loadInertiaM(
                                                     J=J_Load) 
    annotation (Placement(transformation(extent={{-50,-60},{-70,-40}}, rotation=
           0)));
  Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
    quadraticLoadTorqueM(
    tau_nominal=-T_Load,
    TorqueDirection=false,
    useSupport=false,
    w_nominal=w_Load) 
    annotation (Placement(transformation(extent={{-100,-60},{-80,-40}},
          rotation=0)));
equation
  connect(star.pin_n, ground.p) 
    annotation (Line(points={{-70,90},{-80,90}}, color={0,0,255}));
  connect(sineVoltage.plug_n, star.plug_p) 
    annotation (Line(points={{1.33731e-15,70},{1.33731e-15,90},{-50,90}},
        color={0,0,255}));
  connect(sineVoltage.plug_p, idealCloser.plug_p) 
    annotation (Line(points={{-2.33651e-15,50},{0,48},{1.22461e-15,46},{
          2.33651e-15,46},{2.33651e-15,40}}, color={0,0,255}));
  connect(loadInertiaElectricalE.flange_b, quadraticLoadTorqueElectricalE.
    flange) 
    annotation (Line(points={{70,-50},{80,-50}}, color={0,0,0}));
  connect(aimsE.flange,   loadInertiaElectricalE.flange_a) 
                                                 annotation (Line(points={{40,
          -50},{50,-50}}, color={0,0,0}));
  connect(booleanStep.y, idealCloser.control)   annotation (Line(points={{-39,
          30},{-7,30}}, color={255,0,255}));
  connect(idealCloser.plug_n, currentRMSsensorElectricalE.plug_p) 
                                                         annotation (Line(
        points={{-1.33731e-15,20},{-1.33731e-15,10},{30,10},{30,5.55112e-16}},
        color={0,0,255}));
  connect(terminalBoxElectrical.plug_sn,             aimsE.plug_sn) 
                                                           annotation (Line(
        points={{24,-40},{24,-40}}, color={0,0,255}));
  connect(terminalBoxElectrical.plug_sp,             aimsE.plug_sp) 
                                                           annotation (Line(
        points={{36,-40},{36,-40}}, color={0,0,255}));
  connect(terminalBoxElectrical.plugSupply, currentRMSsensorElectricalE.plug_n) 
                                                             annotation (Line(
        points={{30,-38},{30,-29},{30,-20},{30,-20}},
                                    color={0,0,255}));
  connect(rheostatElectricalE.plug_p, aimsE.plug_rp) 
                                                   annotation (Line(points={{20,-44},
          {20,-44}},      color={0,0,255}));
  connect(rheostatElectricalE.plug_n, aimsE.plug_rn) 
                                                   annotation (Line(points={{20,-56},
          {20,-56}},      color={0,0,255}));
  connect(loadInertiaM.flange_b, quadraticLoadTorqueM.flange) 
    annotation (Line(points={{-70,-50},{-80,-50}}, color={0,0,0}));
  connect(aimsM.flange,   loadInertiaM.flange_a) annotation (Line(points={{-40,
          -50},{-50,-50}}, color={0,0,0}));
  connect(rheostatM.plug_n, aimsM.plug_rn)         annotation (Line(points={{-20,-56},
          {-20,-56}},          color={0,0,255}));
  connect(terminalBox.plug_sp,             aimsM.plug_sp) 
                                                         annotation (Line(
        points={{-36,-40},{-36,-40}}, color={0,0,255}));
  connect(terminalBox.plug_sn,             aimsM.plug_sn) 
                                                         annotation (Line(
        points={{-24,-40},{-24,-40}}, color={0,0,255}));
  connect(currentRMSsensorM.plug_n,terminalBox.plugSupply) annotation (Line(
        points={{-30,-20},{-30,-29},{-30,-29},{-30,-38}},
                                      color={0,0,255}));
  connect(currentRMSsensorM.plug_p, idealCloser.plug_n) 
                                                       annotation (Line(points={{-30,
          5.55112e-16},{-30,10},{-1.33731e-15,10},{-1.33731e-15,20}},
        color={0,0,255}));
  connect(aimsM.plug_rp, rheostatM.plug_p) 
                                         annotation (Line(points={{-20,-44},{-20,
          -44}},     color={0,0,255}));

  annotation (
    Diagram(graphics),
    experiment(
      StopTime=1.5,
      Interval=0.001,
      Tolerance=1e-05),
    experimentSetupOutput(doublePrecision=true),
    Documentation(info="<HTML>
<h4>Starting of an asynchronous induction machine with slipring rotor resistance starting</h4>
<p>
At start time <code>tOn</code> three phase voltage is supplied to the 
<a href=\"Modelica://Modelica.Magnetic.FundamentalWave.Machines.AsynchronousInductionMachines.AIM_SlipRing\">asynchronous induction machine with sliprings</a>.
The machine starts from standstill, accelerating inertias against load torque quadratic dependent on speed,
using a starting resistance. At time tRheostat external rotor resistance is shortened, finally reaching nominal speed.</p>

<p>
Simulate for 1.5 seconds and plot (versus time):
</p>

<ul>
<li><code>currentRMSsensorM|E.I</code>: equivalent RMS stator current</li>
<li><code>aimsM/E.wMechanical</code>: machine speed</li>
<li><code>aimsM|E.tauElectrical</code>: machine torque</li>
</ul>
</HTML>"));
end AIMS_start;
