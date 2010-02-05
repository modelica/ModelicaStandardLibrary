within Modelica.Magnetic.FundamentalWave.Machines.SynchronousInductionMachines;
model SM_PermanentMagnet
  "Permanent magnet synchronous machine with optional damper cage"
  extends
    Modelica.Magnetic.FundamentalWave.Interfaces.PartialBasicInductionMachine(
    is(start=zeros(m)),
    Rs(start=0.03),
    Lssigma(start=0.1/(2*pi*fsNominal)));

  parameter Real effectiveStatorTurns = 1 "Effective number of stator turns";
  parameter Modelica.SIunits.Inductance Lmd(start=0.3/(2*pi*fsNominal))
    "Main field inductance, d-axis" 
     annotation(Dialog(group="Nominal resistances and inductances"));
  parameter Modelica.SIunits.Inductance Lmq(start=0.3/(2*pi*fsNominal))
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

  parameter Modelica.SIunits.Voltage VsOpenCircuit(start=112.3)
    "Open circuit RMS voltage per phase @ fsNominal" 
     annotation(Dialog(group="Excitation"));

protected
  final parameter Modelica.SIunits.MagneticPotentialDifference V_mPM=
    (2/pi)*sqrt(2)*(m/2)*VsOpenCircuit/effectiveStatorTurns/(Lmd/effectiveStatorTurns^2*2*pi*fsNominal)
    "Equivalent excitation magnetic potential difference";

public
  Components.RotorSaliencyAirGap airGap(
    final p=p, final L0(d=2.0*Lmd/3.0/effectiveStatorTurns^2, q=2.0*Lmq/3.0/
          effectiveStatorTurns^2)) 
    annotation (Placement(transformation(
        origin={0,0},
        extent={{-10,-10},{10,10}},
        rotation=270)));
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
    final effectiveTurns=sqrt(3.0/2.0)*effectiveStatorTurns) if useDamperCage
    "Symmetric rotor cage winding including resistances and stray inductances" 
    annotation (Placement(transformation(extent={{10,-70},{-10,-50}}, rotation=
            0)));
  FundamentalWave.Sources.ConstantMagneticPotentialDifference permanentMagnet(
    final V_m=Complex(V_mPM, 0))
    "Magnetic potential difference of permanent magnet" 
    annotation (Placement(transformation(
        origin={30,-20},
        extent={{10,-10},{-10,10}},
        rotation=270)));
  FundamentalWave.Components.Ground groundS "Ground of stator magnetic circuit"
    annotation (Placement(transformation(extent={{-40,0},{-20,20}}, rotation=0)));
equation

  connect(airGap.support, internalSupport)         annotation (Line(points={{-10,
          2.33651e-15},{-10,0},{-60,0},{-60,-100},{20,-100}},     color={0,0,0}));
  connect(airGap.flange_a, inertiaRotor.flange_a)         annotation (Line(
        points={{10,-1.33731e-15},{10,0},{60,0},{60,7.25006e-16}},  color={0,0,
          0}));
  connect(groundR.port_p, airGap.port_rn)         annotation (Line(points={{-30,-10},
          {-10,-10},{-10,-10}},                color={255,128,0}));
  connect(airGap.port_rn, short.port_n)         annotation (Line(points={{-10,-10},
          {-10,-20},{-10,-30}},                color={255,128,0}));
  connect(airGap.port_rn, rotorCage.port_n)            annotation (Line(points={{-10,-10},
          {-10,-10},{-16,-10},{-20,-10},{-20,-60},{-10,-60}},            color=
          {255,128,0}));
  connect(airGap.port_rp, permanentMagnet.port_n) 
                                              annotation (Line(points={{10,-10},
          {20,-10},{20,-10},{30,-10}}, color={255,128,0}));
  connect(permanentMagnet.port_p, short.port_p) 
                                            annotation (Line(points={{30,-30},{
          10,-30}}, color={255,128,0}));
  connect(permanentMagnet.port_p, rotorCage.port_p) 
                                           annotation (Line(points={{30,-30},{
          30,-60},{10,-60}}, color={255,128,0}));
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
                       Icon(graphics={
        Rectangle(
          extent={{-130,10},{-100,-10}},
          lineColor={0,0,0},
          fillColor={0,255,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-100,10},{-70,-10}},
          lineColor={0,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Ellipse(extent={{-134,34},{-66,-34}}, lineColor={0,0,255})}),
  Documentation(info="<html>
<p>
Resistances and stray inductances of the machine refer to the stator phases. The symmetry of the stator is assumed. For rotor asymmetries can be taken into account by different resistances and stray inductances in the d- and q-axis. Only losses in stator and rotor resistance are taken into account. 
</p>

<h4>See also</h4>
<p>
<a href=\"Modelica://Modelica.Magnetic.FundamentalWave.Machines.SynchronousInductionMachines.SM_ElectricalExcited\">SM_ElectricalExcited</a>,
<a href=\"Modelica://Modelica.Magnetic.FundamentalWave.Machines.SynchronousInductionMachines.SM_ReluctanceRotor\">SM_ReluctanceRotor</a>,
<a href=\"Modelica://Modelica.Electrical.Machines.BasicMachines.SynchronousInductionMachines.SM_PermanentMagnetDamperCage\">Electrical.Machines.BasicMachines.SynchronousInductionMachines.SM_PermanentMagnet</a>
</p>
</html>"));
end SM_PermanentMagnet;
