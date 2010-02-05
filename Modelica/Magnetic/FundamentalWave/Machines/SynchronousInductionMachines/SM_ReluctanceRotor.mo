within Modelica.Magnetic.FundamentalWave.Machines.SynchronousInductionMachines;
model SM_ReluctanceRotor "Reluctance machine with optional damper cage"
  import Modelica.Magnetic.FundamentalWave;
  extends
    Modelica.Magnetic.FundamentalWave.Interfaces.PartialBasicInductionMachine(
    is(start=zeros(m)),
    Rs(start=0.03),
    Lssigma(start=0.1/(2*pi*fsNominal)));

  parameter Real effectiveStatorTurns = 1 "Effective number of stator turns";
  parameter Modelica.SIunits.Inductance Lmd(start=2.9/(2*pi*fsNominal))
    "Main field inductance, d-axis" 
     annotation(Dialog(group="Nominal resistances and inductances"));
  parameter Modelica.SIunits.Inductance Lmq(start=2.9/(2*pi*fsNominal))
    "Main field inductance, q-axis" 
     annotation(Dialog(group="Nominal resistances and inductances"));

  // Rotor cage parameters
  parameter Boolean useDamperCage = true "Enable/disable damper cage" 
     annotation(Dialog(group="Damper cage"));
  parameter Modelica.SIunits.Inductance Lrsigmad(start=0.05/(2*pi*fsNominal))
    "Rotor leakage inductance, d-axis, w.r.t. stator side" 
     annotation(Dialog(group="Damper cage",enable=useDamperCage));
  parameter Modelica.SIunits.Inductance Lrsigmaq=Lrsigmad
    "Rotor leakage inductance, q-axis, w.r.t. stator side" 
     annotation(Dialog(group="Damper cage",enable=useDamperCage));
  parameter Modelica.SIunits.Resistance Rrd(start=0.04)
    "Rotor resistance, d-axis, w.r.t. stator side" 
     annotation(Dialog(group="Damper cage",enable=useDamperCage));
  parameter Modelica.SIunits.Resistance Rrq=Rrd
    "Rotor resistance , q-axis, w.r.t. stator side" 
     annotation(Dialog(group="Damper cage",enable=useDamperCage));

  Components.RotorSaliencyAirGap airGap(final p=p, final L0(d=2.0*Lmd/3.0/
          effectiveStatorTurns^2, q=2.0*Lmq/3.0/effectiveStatorTurns^2)) 
    annotation (Placement(transformation(
        origin={0,0},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  FundamentalWave.Components.Ground groundS "Ground of stator magnetic circuit"
    annotation (Placement(transformation(extent={{-40,0},{-20,20}}, rotation=0)));
  FundamentalWave.Components.Ground groundR "Ground of rotor magnetic circuit" 
    annotation (Placement(transformation(extent={{-40,-30},{-20,-10}}, rotation=
           0)));
  FundamentalWave.Components.Short short if not useDamperCage
    "Magnetic connection in case the damper cage is not present" 
    annotation (Placement(transformation(
        origin={0,-30},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  FundamentalWave.Machines.Components.SaliencyCageWinding rotorCage(
    final R(d=Rrd, q=Rrq),
    final Lsigma(d=Lrsigmad, q=Lrsigmaq),
    final effectiveTurns=sqrt(3.0/2.0)*effectiveStatorTurns) if 
                                                            useDamperCage
    "Symmetric rotor cage winding including resistances and stray inductances" 
    annotation (Placement(transformation(extent={{10,-70},{-10,-50}}, rotation=
            0)));
equation

  connect(airGap.support, internalSupport)         annotation (Line(points={{-10,
          2.33651e-15},{-10,0},{-80,0},{-80,-100},{20,-100}},     color={0,0,0}));
  connect(airGap.flange_a, inertiaRotor.flange_a)         annotation (Line(
        points={{10,-1.33731e-15},{10,0},{60,0},{60,7.25006e-16}},  color={0,0,
          0}));
  connect(groundR.port_p, airGap.port_rn)         annotation (Line(points={{-30,-10},
          {-10,-10},{-10,-10}},                color={255,128,0}));
  connect(airGap.port_rn, short.port_n)         annotation (Line(points={{-10,-10},
          {-10,-20},{-10,-30}},                color={255,128,0}));
  connect(airGap.port_rn, rotorCage.port_n)            annotation (Line(points={{-10,-10},
          {-10,-24},{-10,-60},{-10,-60}},
        color={255,128,0}));
  connect(airGap.port_rp, short.port_p) annotation (Line(points={{10,-10},{10,
          -30},{10,-30}},          color={255,128,0}));
  connect(airGap.port_rp, rotorCage.port_p) 
                                       annotation (Line(points={{10,-10},{10,
          -60}}, color={255,128,0}));
  connect(statorWinding.port_p, airGap.port_sp) annotation (Line(
      points={{10,20},{10,20},{10,10},{10,10}},
      color={255,128,0},
      smooth=Smooth.None));
  connect(statorWinding.port_n, airGap.port_sn) annotation (Line(
      points={{-10,20},{-10,17.5},{-10,17.5},{-10,15},{-10,10},{-10,10}},
      color={255,128,0},
      smooth=Smooth.None));
  connect(statorWinding.port_n, groundS.port_p) annotation (Line(
      points={{-10,20},{-20,20},{-20,20},{-30,20}},
      color={255,128,0},
      smooth=Smooth.None));
  annotation (Diagram(graphics),
                       Icon(graphics={
        Rectangle(extent={{-130,10},{-100,-10}}, lineColor={0,0,0}),
        Rectangle(extent={{-100,10},{-70,-10}}, lineColor={0,0,0}),
        Ellipse(extent={{-134,34},{-66,-34}}, lineColor={0,0,255})}),
  Documentation(info="<html>
<p>
The symmetry of the stator is assumed. For rotor asymmetries can be taken into account by different resistances and stray inductances in the d- and q-axis. Only losses in stator and rotor resistance are taken into account. 
</p>

<h4>See also</h4>
<p>
<a href=\"Modelica://Modelica.Magnetic.FundamentalWave.Machines.SynchronousInductionMachines.SM_PermanentMagnet\">SM_PermanentMagnet</a>,
<a href=\"Modelica://Modelica.Magnetic.FundamentalWave.Machines.SynchronousInductionMachines.SM_ElectricalExcited\">SM_ElectricalExcited</a>,
<a href=\"Modelica://Modelica.Electrical.Machines.BasicMachines.SynchronousInductionMachines.SM_ReluctanceRotorDamperCage\">Electrical.Machines.BasicMachines.SynchronousInductionMachines.SM_ReluctanceRotor</a>
</p>
</html>"));
end SM_ReluctanceRotor;
