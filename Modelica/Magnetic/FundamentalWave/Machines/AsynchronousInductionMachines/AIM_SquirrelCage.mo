within Modelica.Magnetic.FundamentalWave.Machines.AsynchronousInductionMachines;
model AIM_SquirrelCage "Asynchronous induction machine with squirrel cage"
  import Modelica.Magnetic.FundamentalWave;
  extends
    Modelica.Magnetic.FundamentalWave.Interfaces.PartialBasicInductionMachine(
    is(start=zeros(m)),
    Rs(start=0.03),
    Lssigma(start=3*(1 - sqrt(1 - 0.0667))/(2*pi*fsNominal)));

  parameter Modelica.SIunits.Resistance Rs(start = 0.03) "Stator resistance" 
     annotation(Dialog(group="Nominal resistances and inductances"));
  parameter Modelica.SIunits.Inductance Lssigma(start = 3*(1 - sqrt(1 - 0.0667))/(2*pi*fsNominal))
    "Stator leakage inductance" 
     annotation(Dialog(group="Nominal resistances and inductances"));
  parameter Modelica.SIunits.Inductance Lm(start=3*sqrt(1 - 0.0667)/(2*pi*fsNominal))
    "Main field inductance" 
     annotation(Dialog(group="Nominal resistances and inductances"));
  parameter Modelica.SIunits.Inductance Lrsigma(start=3*(1 - sqrt(1 - 0.0667))/(2*pi*fsNominal))
    "Rotor leakage inductance w.r.t. stator side" 
     annotation(Dialog(group="Nominal resistances and inductances"));
  parameter Modelica.SIunits.Resistance Rr(start=0.04)
    "Rotor resistance w.r.t. stator side" 
     annotation(Dialog(group="Nominal resistances and inductances"));

  FundamentalWave.Machines.Components.SymmetricMultiPhaseCageWinding
    rotorCageWinding(
    final Lsigma=Lrsigma,
    final R=Rr,
    final m=m,
    final effectiveTurns=effectiveStatorTurns)
    "Symmetric rotor cage winding including resistances and stray inductances" 
    annotation (Placement(transformation(extent={{10,-50},{-10,-30}}, rotation=
            0)));

public
  FundamentalWave.Machines.Components.RotorSaliencyAirGap airGap(
    final p=p, final L0(d=2.0*Lm/3.0/effectiveStatorTurns^2, q=2.0*Lm/3.0/
          effectiveStatorTurns^2)) 
    annotation (Placement(transformation(
        origin={0,0},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  FundamentalWave.Components.Ground groundR "Ground of rotor magnetic circuit" 
    annotation (Placement(transformation(extent={{-40,-30},{-20,-10}}, rotation=
           0)));
  FundamentalWave.Components.Ground groundS "Ground of stator magnetic circuit"
    annotation (Placement(transformation(extent={{-40,0},{-20,20}}, rotation=0)));
equation
  connect(airGap.port_rp, rotorCageWinding.port_p) annotation (Line(
      points={{10,-10},{10,-40}},
      color={255,128,0},
      smooth=Smooth.None));
  connect(airGap.port_rn, rotorCageWinding.port_n) annotation (Line(
      points={{-10,-10},{-10,-17.5},{-10,-17.5},{-10,-25},{-10,-40},{-10,-40}},
      color={255,128,0},
      smooth=Smooth.None));

  connect(airGap.support, internalSupport)         annotation (Line(points={{-10,
          2.33651e-15},{-10,2.33651e-15},{-60,0},{-60,-100},{20,-100}},
                                                        color={0,0,0}));
  connect(airGap.flange_a, inertiaRotor.flange_a)         annotation (Line(
        points={{10,-1.33731e-15},{10,0},{60,0},{60,7.25006e-16}},
                                                         color={0,0,0}));
  connect(statorWinding.port_n,airGap. port_sn) annotation (Line(points={{-10,20},
          {-10,17.5},{-10,10},{-10,10}},                     color={255,128,0}));
  connect(statorWinding.port_p,airGap. port_sp) annotation (Line(points={{10,20},
          {10,20},{10,10},{10,10}}, color={255,128,0}));
  connect(groundR.port_p,airGap. port_rn)         annotation (Line(points={{-30,-10},
          {-20,-10},{-20,-10},{-10,-10}},    color={255,128,0}));
  connect(groundS.port_p, statorWinding.port_n) annotation (Line(
      points={{-30,20},{-10,20}},
      color={255,128,0},
      smooth=Smooth.None));
  annotation (Diagram(graphics),
                       Icon(graphics),
  Documentation(info="<html>
<p>
Resistances and stray inductances of the machine refer to the stator phases. The symmetry of the stator and rotor is assumed. Only losses in stator and rotor resistances are taken into account. 
</p>

<h4>See also</h4>
<p>
<a href=\"Modelica://Modelica.Magnetic.FundamentalWave.Machines.AsynchronousInductionMachines.AIM_SlipRing\">AIM_SlipRing</a>,
<a href=\"Modelica://Modelica.Electrical.Machines.BasicMachines.AsynchronousInductionMachines.AIM_SquirrelCage\">Electrical.Machines.BasicMachines.AsynchronousInductionMachines.AIM_SquirrelCage</a>,
</p>
</html>"));
end AIM_SquirrelCage;
