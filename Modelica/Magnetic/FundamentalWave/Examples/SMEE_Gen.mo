within Modelica.Magnetic.FundamentalWave.Examples;
model SMEE_Gen "Electrical excited synchronous machine operating as generator"
  extends Modelica.Icons.Example;

  constant Integer m=3 "Number of phases";
  parameter Modelica.SIunits.Voltage VsNominal=100
    "Nominal RMS voltage per phase";
  parameter Modelica.SIunits.Frequency fsNominal=50 "Nominal frequency";
  parameter Modelica.SIunits.Conversions.NonSIunits.AngularVelocity_rpm rpm=1499
    "Nominal speed";
  parameter Modelica.SIunits.Current Ie = 19 "Excitation current";
  parameter Modelica.SIunits.Current Ie0 = 10 "Initial excitation current";
  parameter Modelica.SIunits.Conversions.NonSIunits.Angle_deg gamma0 = 0
    "Initial rotor displacement angle";

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

  Modelica.Electrical.MultiPhase.Basic.Star star(
    final m=m) 
    annotation (Placement(transformation(extent={{-50,70},{-70,90}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Ground ground 
    annotation (Placement(transformation(
        origin={-90,80},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.MultiPhase.Sources.SineVoltage sineVoltage(
    final m=m,
    final V=fill(VsNominal*sqrt(2), m),
    final freqHz=fill(fsNominal, m)) 
    annotation (Placement(transformation(extent={{-20,70},{-40,90}}, rotation=0)));
  Modelica.Electrical.Machines.Utilities.TerminalBox terminalBoxM 
    annotation (Placement(transformation(extent={{-20,20},{0,40}}, rotation=0)));
  Machines.SynchronousInductionMachines.SM_ElectricalExcited smeeM(
    phiMechanical(start=-(Modelica.Constants.pi +
          Modelica.SIunits.Conversions.from_deg(gamma0))/p),
    Rs=Rs,
    Lssigma=Lssigma,
    Lmd=Lmd,
    Lmq=Lmq,
    Lrsigmad=Lrsigmad,
    Lrsigmaq=Lrsigmaq,
    Rrd=Rrd,
    Rrq=Rrq) 
    annotation (Placement(transformation(extent={{-20,0},{0,20}}, rotation=0)));
  Modelica.Electrical.Analog.Sources.RampCurrent rampCurrentM(
    duration=0.1,
    I=Ie - Ie0,
    offset=Ie0) 
    annotation (Placement(transformation(
        origin={-50,10},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Electrical.Analog.Basic.Ground groundM 
    annotation (Placement(transformation(
        origin={-88,0},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Machines.Sensors.RotorDisplacementAngle rotorAngleM(
                                                              p=p) 
    annotation (Placement(transformation(
        origin={20,10},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  Modelica.Electrical.Machines.Sensors.MechanicalPowerSensor
    mechanicalPowerSensorM 
    annotation (Placement(transformation(extent={{40,0},{60,20}}, rotation=0)));
  Modelica.Mechanics.Rotational.Sources.ConstantSpeed constantSpeedM(
    final w_fixed=Modelica.SIunits.Conversions.from_rpm(rpm), useSupport=false) 
    annotation (Placement(transformation(extent={{90,0},{70,20}}, rotation=0)));
  Modelica.Electrical.Machines.Utilities.TerminalBox terminalBoxE 
    annotation (Placement(transformation(extent={{-20,-40},{0,-20}}, rotation=0)));
  Modelica.Electrical.Machines.BasicMachines.SynchronousInductionMachines.SM_ElectricalExcited
    smeeE(
    phiMechanical(       start=-(Modelica.Constants.pi + Modelica.SIunits.Conversions.from_deg(gamma0))/p),
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
    annotation (Placement(transformation(extent={{-20,-60},{0,-40}}, rotation=0)));
  Modelica.Electrical.Analog.Sources.RampCurrent rampCurrentE(
    duration=0.1,
    I=Ie - Ie0,
    offset=Ie0) 
    annotation (Placement(transformation(
        origin={-50,-50},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Electrical.Analog.Basic.Ground groundE 
    annotation (Placement(transformation(
        origin={-88,-60},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Machines.Sensors.RotorDisplacementAngle rotorAngleE(
    p=p) 
    annotation (Placement(transformation(
        origin={20,-50},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  Modelica.Electrical.Machines.Sensors.MechanicalPowerSensor
    mechanicalPowerSensorE 
    annotation (Placement(transformation(extent={{40,-60},{60,-40}}, rotation=0)));
  Modelica.Mechanics.Rotational.Sources.ConstantSpeed constantSpeedE(
    final w_fixed=Modelica.SIunits.Conversions.from_rpm(rpm), useSupport=false) 
    annotation (Placement(transformation(extent={{90,-60},{70,-40}}, rotation=0)));
equation
  connect(rotorAngleE.plug_n,smeeE. plug_sn)  annotation (Line(points={{26,-40},
          {26,-30},{-16,-30},{-16,-40}}, color={0,0,255}));
  connect(rotorAngleE.plug_p,smeeE. plug_sp)  annotation (Line(points={{14,-40},
          {-4,-40}}, color={0,0,255}));
  connect(rotorAngleE.flange,smeeE.flange) 
    annotation (Line(points={{10,-50},{5.55112e-16,-50}}, color={0,0,0}));
  connect(star.pin_n, ground.p) 
    annotation (Line(points={{-70,80},{-80,80}}, color={0,0,255}));
  connect(star.plug_p, sineVoltage.plug_n)   annotation (Line(points={{-50,80},
          {-40,80}}, color={0,0,255}));
  connect(smeeE.flange,  mechanicalPowerSensorE. flange_a) 
    annotation (Line(points={{5.55112e-16,-50},{40,-50}}, color={0,0,0}));
  connect(mechanicalPowerSensorE.flange_b,constantSpeedE. flange) 
    annotation (Line(points={{60,-50},{70,-50}}, color={0,0,0}));
  connect(rampCurrentE.p,groundE. p) annotation (Line(points={{-50,-60},{-78,
          -60}}, color={0,0,255}));
  connect(rampCurrentE.p,smeeE. pin_en)  annotation (Line(points={{-50,-60},{
          -40,-60},{-40,-56},{-20,-56}}, color={0,0,255}));
  connect(rampCurrentE.n,smeeE. pin_ep)  annotation (Line(points={{-50,-40},{
          -40,-40},{-40,-44},{-20,-44}}, color={0,0,255}));
  connect(smeeE.plug_sn,terminalBoxE.plug_sn)               annotation (Line(
        points={{-16,-40},{-16,-40}}, color={0,0,255}));
  connect(smeeE.plug_sp,terminalBoxE.plug_sp)               annotation (Line(
        points={{-4,-40},{-4,-40}}, color={0,0,255}));
  connect(rotorAngleM.plug_n, smeeM.plug_sn)  annotation (Line(points={{26,20},
          {26,30},{-16,30},{-16,20}}, color={0,0,255}));
  connect(rotorAngleM.plug_p, smeeM.plug_sp)  annotation (Line(points={{14,20},
          {-4,20}}, color={0,0,255}));
  connect(rotorAngleM.flange,smeeM.flange) 
    annotation (Line(points={{10,10},{5,10},{5,10},{5.55112e-16,10}},
                                                        color={0,0,0}));
  connect(smeeM.flange,   mechanicalPowerSensorM.flange_a) 
    annotation (Line(points={{5.55112e-16,10},{40,10}}, color={0,0,0}));
  connect(mechanicalPowerSensorM.flange_b, constantSpeedM.flange) 
    annotation (Line(points={{60,10},{70,10}}, color={0,0,0}));
  connect(rampCurrentM.p, groundM.p) annotation (Line(points={{-50,-5.55112e-16},
          {-58,0},{-64,5.56792e-16},{-64,-1.22629e-15},{-78,-1.22629e-15}},
                                                                        color={
          0,0,255}));
  connect(rampCurrentM.p, smeeM.pin_en)  annotation (Line(points={{-50,
          -5.55112e-16},{-40,-5.55112e-16},{-40,4},{-20,4}}, color={0,0,255}));
  connect(rampCurrentM.n, smeeM.pin_ep)  annotation (Line(points={{-50,20},{-40,
          20},{-40,16},{-20,16}}, color={0,0,255}));
  connect(smeeM.plug_sn,terminalBoxM.plug_sn)               annotation (Line(
        points={{-16,20},{-16,20}}, color={0,0,255}));
  connect(smeeM.plug_sp,terminalBoxM.plug_sp)               annotation (Line(
        points={{-4,20},{-4,20}}, color={0,0,255}));
  connect(sineVoltage.plug_p,terminalBoxE.plugSupply)  annotation (Line(points=
          {{-20,80},{-10,80},{-10,40},{-30,40},{-30,-20},{-10,-20},{-10,-38}},
        color={0,0,255}));
  connect(sineVoltage.plug_p,terminalBoxM.plugSupply)  annotation (Line(points=
          {{-20,80},{-10,80},{-10,22}}, color={0,0,255}));

  annotation (
    Diagram(graphics),
    experiment(
      StopTime=30,
      Interval=0.005,
      Tolerance=1e-05),
    experimentSetupOutput(doublePrecision=true),
    Documentation(info="<HTML>
<h4>Electrical excited synchronous induction machine as generator</h4>
<p>
An 
<a href=\"Modelica://Modelica.Magnetic.FundamentalWave.Machines.SynchronousInductionMachines.SM_ElectricalExcited\">electrically excited synchronous generator</a> is connected to the grid and driven with constant speed. 
Since speed is slightly smaller than synchronous speed corresponding to mains frequency, 
rotor angle is very slowly increased. This allows to see several charactersistics dependent on rotor angle.
</p>

<p>
Simulate for 30 seconds and plot (versus <code>rotorAngleM.rotorDisplacementAngle</code>):
</p>

<ul>
<li><code>speedM|E.tauElectrical</code>: machine torque</li>
<li><code>mechanicalPowerSensorM|E.P</code>: mechanical power</li>
</ul>
</HTML>"));
end SMEE_Gen;
