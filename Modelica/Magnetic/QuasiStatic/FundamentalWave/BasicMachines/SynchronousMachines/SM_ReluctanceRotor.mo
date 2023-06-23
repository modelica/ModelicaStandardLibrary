within Modelica.Magnetic.QuasiStatic.FundamentalWave.BasicMachines.SynchronousMachines;
model SM_ReluctanceRotor
  "Synchronous reluctance machine with optional damper cage"
  extends BaseClasses.Machine(
    Rs(start=0.03*ZsRef),
    Lssigma(start=0.1*ZsRef/(2*pi*fsNominal)),
    final L0(d=2.0*Lmd/m/effectiveStatorTurns^2, q=2.0*Lmq/m/
          effectiveStatorTurns^2),
    redeclare final
      Modelica.Electrical.Machines.Thermal.SynchronousMachines.ThermalAmbientSMR
      thermalAmbient(final useDamperCage=useDamperCage, final Tr=
          TrOperational),
    redeclare final
      Modelica.Electrical.Machines.Interfaces.InductionMachines.ThermalPortSMR
      thermalPort(final useDamperCage=useDamperCage),
    redeclare final
      Modelica.Electrical.Machines.Interfaces.InductionMachines.ThermalPortSMR
      internalThermalPort(final useDamperCage=useDamperCage),
    redeclare final
      Modelica.Electrical.Machines.Interfaces.InductionMachines.PowerBalanceSMR
      powerBalance(final lossPowerRotorWinding=damperCageLossPower,
        final lossPowerRotorCore=0));

  parameter SI.Inductance Lmd(start=2.9*ZsRef/(2*pi*fsNominal))
    "Stator main field inductance per phase, d-axis" annotation (Dialog(
        tab="Nominal resistances and inductances", groupImage=
          "modelica://Modelica/Resources/Images/Electrical/Machines/SMR.png"));
  parameter SI.Inductance Lmq(start=0.9*ZsRef/(2*pi*fsNominal))
    "Stator main field inductance per phase, q-axis"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  // Rotor cage parameters
  parameter Boolean useDamperCage(start=true)
    "Enable/disable damper cage" annotation (Dialog(tab=
          "Nominal resistances and inductances", group="Damper cage"));
  parameter SI.Inductance Lrsigmad(start=0.05*ZsRef/(2*pi*
        fsNominal))
    "Rotor damper cage leakage inductance, d-axis, w.r.t. stator side" annotation (
      Dialog(
      tab="Nominal resistances and inductances",
      group="Damper cage",
      enable=useDamperCage));
  parameter SI.Inductance Lrsigmaq=Lrsigmad
    "Rotor damper cage leakage inductance, q-axis, w.r.t. stator side" annotation (
      Dialog(
      tab="Nominal resistances and inductances",
      group="Damper cage",
      enable=useDamperCage));
  parameter SI.Resistance Rrd(start=0.04*ZsRef)
    "Rotor damper cage resistance, d-axis, w.r.t. stator side" annotation (Dialog(
      tab="Nominal resistances and inductances",
      group="Damper cage",
      enable=useDamperCage));
  parameter SI.Resistance Rrq=Rrd
    "Rotor damper cage resistance , q-axis, w.r.t. stator side" annotation (Dialog(
      tab="Nominal resistances and inductances",
      group="Damper cage",
      enable=useDamperCage));
  parameter SI.Temperature TrRef(start=293.15)
    "Reference temperature of damper resistances in d- and q-axis"
    annotation (Dialog(
      tab="Nominal resistances and inductances",
      group="Damper cage",
      enable=useDamperCage));
  parameter
    Modelica.Electrical.Machines.Thermal.LinearTemperatureCoefficient20
    alpha20r(start=0)
    "Temperature coefficient of damper resistances in d- and q-axis"
    annotation (Dialog(
      tab="Nominal resistances and inductances",
      group="Damper cage",
      enable=useDamperCage));
  // Operational temperatures
  parameter SI.Temperature TrOperational(start=293.15)
    "Operational temperature of (optional) damper cage" annotation (
      Dialog(group="Operational temperatures", enable=not useThermalPort
           and useDamperCage));
  // Rotor cage components
  Modelica.ComplexBlocks.Interfaces.ComplexOutput ir[2] if useDamperCage
    "Damper cage currents"
  annotation (Placement(visible=false));
  FundamentalWave.Components.Short short if not useDamperCage
    "Magnetic connection in case the damper cage is not present"
    annotation (Placement(transformation(
        origin={10,-40},
        extent={{10,10},{-10,-10}},
        rotation=270)));
  Components.SaliencyCageWinding rotorCage(
    final RRef(d=Rrd, q=Rrq),
    final Lsigma(d=Lrsigmad, q=Lrsigmaq),
    final useHeatPort=true,
    final TRef=TrRef,
    final TOperational=TrOperational,
    final alpha20=alpha20r,
    final effectiveTurns=sqrt(m/2.0)*effectiveStatorTurns)
 if useDamperCage
    "Symmetric rotor cage winding including resistances and stray inductances"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={30,-40})));
protected
  Modelica.Blocks.Interfaces.RealOutput damperCageLossPower(final
      quantity="Power", final unit="W") "Damper losses";
equation
  connect(ir, rotorCage.i);
  connect(damperCageLossPower, rotorCage.lossPower);
  if not useDamperCage then
    damperCageLossPower = 0;
  end if;
  connect(rotorCage.port_n, airGap.port_rp) annotation (Line(
      points={{30,-30},{10,-30},{10,-10}}, color={255,170,85}));
  connect(short.port_n, airGap.port_rp) annotation (Line(
      points={{10,-30},{10,-10}}, color={255,170,85}));
  connect(rotorCage.port_p, airGap.port_rn) annotation (Line(
      points={{30,-50},{-10,-50},{-10,-10}}, color={255,170,85}));
  connect(short.port_p, airGap.port_rn) annotation (Line(
      points={{10,-50},{-10,-50},{-10,-10}}, color={255,170,85}));
  connect(rotorCage.heatPortWinding, internalThermalPort.heatPortRotorWinding)
    annotation (Line(
      points={{40,-40},{40,-80},{-40,-80},{-40,-90}},          color={191,0,0}));
  annotation (
    defaultComponentName="smr",
    Icon(graphics={
        Rectangle(extent={{-130,10},{-100,-10}}),
        Rectangle(extent={{-100,10},{-70,-10}}),
        Ellipse(extent={{-134,34},{-66,-34}}, lineColor={85,170,255})}),
    Documentation(info="<html>
<p>
Resistances and stray inductances of the machine refer to an <code>m</code>-phase stator. The symmetry of the stator and the supply are assumed. For rotor asymmetries can be taken into account by different resistances and stray inductances in the d- and q-axis. The machine models take the following loss effects into account:
</p>

<ul>
<li>heat losses in the temperature dependent stator winding resistances</li>
<li>optional, when enabled: heat losses in the temperature dependent damper cage resistances</li>
<li>friction losses</li>
<li>core losses (only eddy current losses, no hysteresis losses)</li>
<li>stray load losses</li>
</ul>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.BasicMachines.SynchronousMachines.SM_PermanentMagnet\">
SM_PermanentMagnet</a>,
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.BasicMachines.SynchronousMachines.SM_ElectricalExcited\">
SM_ElectricalExcited</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.SynchronousMachines.SM_PermanentMagnet\">
Magnetic.FundamentalWave.BasicMachines.SM_PermanentMagnet</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.SynchronousMachines.SM_ElectricalExcited\">
Magnetic.FundamentalWave.BasicMachines.SM_ElectricalExcited</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.SynchronousMachines.SM_ReluctanceRotor\">
Magnetic.FundamentalWave.BasicMachines.SM_ReluctanceRotor</a>,
</p>
</html>"));
end SM_ReluctanceRotor;
