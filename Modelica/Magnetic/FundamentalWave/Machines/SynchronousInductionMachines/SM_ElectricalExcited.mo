within Modelica.Magnetic.FundamentalWave.Machines.SynchronousInductionMachines;
model SM_ElectricalExcited
  "Electrical excited synchronous machine with optional damper cage"
  import Modelica.Magnetic.FundamentalWave;
  extends
    Modelica.Magnetic.FundamentalWave.Interfaces.PartialBasicInductionMachine(
    is(start=zeros(m)),
    Rs(start=0.03),
    Lssigma(start=0.1/(2*pi*fsNominal)));

  parameter Real effectiveStatorTurns = 1 "Effective number of stator turns";
  parameter Modelica.SIunits.Inductance Lmd(start=1.5/(2*pi*fsNominal))
    "Main field inductance, d-axis" 
     annotation(Dialog(group="Nominal resistances and inductances"));
  parameter Modelica.SIunits.Inductance Lmq(start=1.5/(2*pi*fsNominal))
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

  // Excitaiton parameters
  parameter Modelica.SIunits.Voltage VsNominal=100 "Nominal stator voltage" 
     annotation(Dialog(group="Excitation"));
  parameter Modelica.SIunits.Current Ie0=10
    "no-load excitation current @ nominal voltage and frequency" 
     annotation(Dialog(group="Excitation"));
  parameter Modelica.SIunits.Resistance Re=2.5 "warm excitation resistance" 
     annotation(Dialog(group="Excitation"));
  parameter Real sigmae(min=0, max=1)=0.025
    "stray fraction of total excitation inductance" 
     annotation(Dialog(group="Excitation"));
  output Modelica.SIunits.Voltage ve = pin_ep.v-pin_en.v "Excitation voltage";
  output Modelica.SIunits.Current ie = pin_ep.i "Excitation current";
protected
  final parameter Real turnsRatio=
    sqrt(2)*VsNominal/(2*pi*fsNominal*Lmd*Ie0)
    "Stator current / excitation current";
  final parameter Modelica.SIunits.Inductance Lesigma=
     Lmd*turnsRatio^2*3/2 * sigmae/(1-sigmae)
    "Leakage inductance of the excitation winding";

public
  Components.RotorSaliencyAirGap airGap(
    final p=p, final L0(d=2.0*Lmd/3.0/effectiveStatorTurns^2, q=2.0*Lmq/3.0/
          effectiveStatorTurns^2)) 
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
        origin={0,-60},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  FundamentalWave.Machines.Components.SaliencyCageWinding rotorCage(
    final R(d=Rrd, q=Rrq),
    final Lsigma(d=Lrsigmad, q=Lrsigmaq),
    final effectiveTurns=sqrt(3.0/2.0)*effectiveStatorTurns) if 
                                                            useDamperCage
    "Symmetric rotor cage winding including resistances and stray inductances" 
    annotation (Placement(transformation(extent={{10,-100},{-10,-80}}, rotation=0)));
  FundamentalWave.Machines.Components.SinglePhaseWinding excitationWinding(
    final windingAngle=0,
    final R=Re,
    final Lsigma=Lesigma,
    final effectiveTurns=effectiveStatorTurns*turnsRatio*m/2)
    "Excitation winding including resistance and stray inductance" 
    annotation (Placement(transformation(extent={{-30,-50},{-10,-30}}, rotation=0)));
  Modelica.Electrical.Analog.Interfaces.PositivePin pin_ep 
    annotation (Placement(transformation(extent={{-110,70},{-90,50}}, rotation=0)));
  Modelica.Electrical.Analog.Interfaces.NegativePin pin_en 
    annotation (Placement(transformation(extent={{-90,-50},{-110,-70}},rotation=0)));
equation

  connect(airGap.support, internalSupport)         annotation (Line(points={{-10,
          2.33651e-15},{-10,0},{-60,0},{-60,-100},{20,-100}},     color={0,0,0}));
  connect(airGap.flange_a, inertiaRotor.flange_a)         annotation (Line(
        points={{10,-1.33731e-15},{10,0},{60,0},{60,7.25006e-16}},  color={0,0,
          0}));
  connect(groundR.port_p, airGap.port_rn)         annotation (Line(points={{-30,-10},
          {-10,-10},{-10,-10}},                color={255,128,0}));
  connect(airGap.port_rp, short.port_p) annotation (Line(points={{10,-10},{10,
          -60},{10,-60}},          color={255,128,0}));
  connect(airGap.port_rp, rotorCage.port_p) 
                                       annotation (Line(points={{10,-10},{10,
          -90}}, color={255,128,0}));
  connect(short.port_n, rotorCage.port_n) 
                                     annotation (Line(points={{-10,-60},{-10,
          -90},{-10,-90}},           color={255,128,0}));
  connect(airGap.port_rn, excitationWinding.port_p) annotation (Line(points={{-10,-10},
          {-10,-20},{-10,-30}},                    color={255,128,0}));
  connect(excitationWinding.port_n, short.port_n) annotation (Line(points={{-10,
          -50},{-10,-60}}, color={255,128,0}));
  connect(excitationWinding.port_n, rotorCage.port_n) 
                                                 annotation (Line(points={{-10,-50},
          {-10,-90},{-10,-90}},                color={255,128,0}));
  connect(pin_en, excitationWinding.pin_n) annotation (Line(points={{-100,-60},
          {-30,-60},{-30,-50}}, color={0,0,255}));
  connect(excitationWinding.pin_p, pin_ep) annotation (Line(points={{-30,-30},{
          -80,-30},{-80,60},{-100,60}}, color={0,0,255}));
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
        Ellipse(extent={{-134,34},{-66,-34}}, lineColor={0,0,255}),
        Line(points={{-100,50},{-100,20},{-130,20},{-130,-4}}, color={0,0,255}),
        Line(points={{-130,-4},{-129,1},{-125,5},{-120,6},{-115,5},{-111,1},{
              -110,-4}}, color={0,0,255}),
        Line(points={{-110,-4},{-109,1},{-105,5},{-100,6},{-95,5},{-91,1},{-90,
              -4}}, color={0,0,255}),
        Line(points={{-90,-4},{-89,1},{-85,5},{-80,6},{-75,5},{-71,1},{-70,-4}},
            color={0,0,255}),
        Line(points={{-100,-50},{-100,-20},{-70,-20},{-70,-2}}, color={0,0,255})}),
  Documentation(info="<html>
<p>
The symmetry of the stator is assumed. For rotor asymmetries can be taken into account by different resistances and stray inductances in the d- and q-axis. Only losses in stator and rotor resistance are taken into account. 
</p>

<h4>See also</h4>
<p>
<a href=\"Modelica://Modelica.Magnetic.FundamentalWave.Machines.SynchronousInductionMachines.SM_PermanentMagnet\">SM_PermanentMagnet</a>,
<a href=\"Modelica://Modelica.Magnetic.FundamentalWave.Machines.SynchronousInductionMachines.SM_ReluctanceRotor\">SM_ReluctanceRotor</a>,
<a href=\"Modelica://Modelica.Electrical.Machines.BasicMachines.SynchronousInductionMachines.SM_ElectricalExcitedDamperCage\">Electrical.Machines.BasicMachines.SynchronousInductionMachines.SM_ElectricalExcited</a>
</p>
</html>"));
end SM_ElectricalExcited;
