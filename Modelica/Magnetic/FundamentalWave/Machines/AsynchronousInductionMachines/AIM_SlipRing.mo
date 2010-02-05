within Modelica.Magnetic.FundamentalWave.Machines.AsynchronousInductionMachines;
model AIM_SlipRing "Asynchronous induction machine with slip ring rotor"
  extends
    Modelica.Magnetic.FundamentalWave.Interfaces.PartialBasicInductionMachine(
    is(start=zeros(m)),
    Rs(start=0.03),
    Lssigma(start=3*(1 - sqrt(1 - 0.0667))/(2*pi*fsNominal)));

  Modelica.Electrical.MultiPhase.Interfaces.NegativePlug plug_rn(final m=m) 
    annotation (Placement(transformation(extent={{-110,-50},{-90,-70}},rotation=0)));
  Modelica.Electrical.MultiPhase.Interfaces.PositivePlug plug_rp(final m=m) 
    annotation (Placement(transformation(extent={{-110,70},{-90,50}}, rotation=0)));

  parameter Real effectiveStatorTurns = 1 "Effective number of stator turns";
  parameter Modelica.SIunits.Resistance Rs(start = 0.03) "Stator resistance" 
     annotation(Dialog(group="Nominal resistances and inductances"));
  parameter Modelica.SIunits.Inductance Lssigma(start = 3*(1 - sqrt(1 - 0.0667))/(2*pi*fsNominal))
    "Stator leakage inductance" 
     annotation(Dialog(group="Nominal resistances and inductances"));
  parameter Modelica.SIunits.Inductance Lm(start=3*sqrt(1 - 0.0667)/(2*pi*fsNominal))
    "Main field inductance" 
     annotation(Dialog(group="Nominal resistances and inductances"));
  parameter Modelica.SIunits.Inductance Lrsigma(start = 3*(1 - sqrt(1 - 0.0667))/(2*pi*fsNominal))
    "Rotor leakage inductance w.r.t. stator side" 
     annotation(Dialog(group="Nominal resistances and inductances"));
  parameter Modelica.SIunits.Resistance Rr(start = 0.04)
    "Rotor resistance w.r.t. stator side" 
     annotation(Dialog(group="Nominal resistances and inductances"));

  parameter Boolean useTurnsRatio=true
    "Use TurnsRatio or calculate from locked-rotor voltage?";
  parameter Real TurnsRatio(final min=Modelica.Constants.small)=1
    "(ws*xis) / (wr*xir)" 
    annotation(Dialog(enable=useTurnsRatio));
  parameter Modelica.SIunits.Voltage VsNominal=100
    "Nominal stator voltage per phase" 
    annotation(Dialog(enable=not useTurnsRatio));
  parameter Modelica.SIunits.Voltage VrLockedRotor=100*
    (2*pi*fsNominal*Lm)/sqrt(Rs^2+(2*pi*fsNominal*(Lm+Lssigma))^2)
    "Locked-rotor voltage per phase" 
    annotation(Dialog(enable=not useTurnsRatio));
protected
  final parameter Real internalTurnsRatio=if useTurnsRatio then TurnsRatio else 
    VsNominal/VrLockedRotor*(2*pi*fsNominal*Lm)/sqrt(Rs^2+(2*pi*fsNominal*(Lm+Lssigma))^2);
public
  Modelica.Magnetic.FundamentalWave.Machines.Components.RotorSaliencyAirGap
    airGap(
    final p=p, final L0(d=2.0*Lm/3.0/effectiveStatorTurns^2, q=2.0*Lm/3.0/
          effectiveStatorTurns^2)) 
    annotation (Placement(transformation(
        origin={0,0},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Magnetic.FundamentalWave.Machines.Components.SymmetricMultiPhaseWinding
    rotorWinding(
    final m=3,
    final R=Rr,
    final Lsigma=Lrsigma,
    final effectiveTurns=effectiveStatorTurns/internalTurnsRatio)
    "Symmetric rotor winding including resistances and stray inductances" 
    annotation (Placement(transformation(
        origin={0,-30},
        extent={{-10,10},{10,-10}},
        rotation=90)));
  Modelica.Magnetic.FundamentalWave.Components.Ground groundS
    "Ground of stator magnetic circuit" 
    annotation (Placement(transformation(extent={{-40,0},{-20,20}}, rotation=0)));
  Modelica.Magnetic.FundamentalWave.Components.Ground groundR
    "Ground of rotor magnetic circuit" 
    annotation (Placement(transformation(extent={{-40,-30},{-20,-10}}, rotation=
           0)));
equation

  connect(airGap.support, internalSupport)         annotation (Line(points={{-10,
          2.33651e-15},{-10,0},{-60,0},{-60,-100},{20,-100}},
                                                        color={0,0,0}));
  connect(airGap.flange_a, inertiaRotor.flange_a)         annotation (Line(
        points={{10,-1.33731e-15},{10,0},{60,0},{60,7.25006e-16}},
                                                         color={0,0,0}));
  connect(airGap.port_rn, rotorWinding.port_n)      annotation (Line(points={{-10,-10},
          {-10,-11},{-10,-14},{-10,-20}},                             color={
          255,128,0}));
  connect(airGap.port_rp, rotorWinding.port_p)      annotation (Line(points={{10,-10},
          {10,-20},{10,-20}},
                            color={255,128,0}));
  connect(groundR.port_p, airGap.port_rn)         annotation (Line(points={{-30,-10},
          {-20,-10},{-20,-10},{-10,-10}},    color={255,128,0}));
  connect(rotorWinding.plug_n, plug_rn) annotation (Line(points={{-10,-40},{-10,
          -60},{-100,-60}}, color={0,0,255}));
  connect(rotorWinding.plug_p, plug_rp) annotation (Line(points={{10,-40},{10,
          -80},{-80,-80},{-80,60},{-100,60}}, color={0,0,255}));
  connect(statorWinding.port_n, airGap.port_sn) annotation (Line(
      points={{-10,20},{-10,17.5},{-10,17.5},{-10,15},{-10,10},{-10,10}},
      color={255,128,0},
      smooth=Smooth.None));
  connect(statorWinding.port_p, airGap.port_sp) annotation (Line(
      points={{10,20},{10,20},{10,10},{10,10}},
      color={255,128,0},
      smooth=Smooth.None));
  connect(groundS.port_p, statorWinding.port_n) annotation (Line(
      points={{-30,20},{-10,20}},
      color={255,128,0},
      smooth=Smooth.None));
  annotation (Diagram(graphics),
                       Icon(graphics={Line(points={{-100,50},{-100,20},{-60,20}},
            color={0,0,255}), Line(points={{-100,-50},{-100,-20},{-60,-20}},
            color={0,0,255})}),
  Documentation(info="<html>
<p>
Resistances and stray inductances of the machine always refer to either stator or rotor phases. The symmetry of the stator and rotor is assumed. Only losses in stator and rotor resistances are taken into account. 
</p>

<h4>See also</h4>
<p>
<a href=\"Modelica://Modelica.Magnetic.FundamentalWave.Machines.AsynchronousInductionMachines.AIM_SquirrelCage\">AIM_SquirrelCage</a>,
<a href=\"Modelica://Modelica.Electrical.Machines.BasicMachines.AsynchronousInductionMachines.AIM_SlipRing\">Electrical.Machines.BasicMachines.AsynchronousInductionMachines.AIM_SlipRing</a>,
</p>
</html>"));
end AIM_SlipRing;
