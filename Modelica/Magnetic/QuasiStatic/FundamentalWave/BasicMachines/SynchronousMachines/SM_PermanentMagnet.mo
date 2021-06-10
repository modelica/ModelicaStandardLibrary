within Modelica.Magnetic.QuasiStatic.FundamentalWave.BasicMachines.SynchronousMachines;
model SM_PermanentMagnet
  "Permanent magnet synchronous machine with optional damper cage"
  extends BaseClasses.Machine(
    Rs(start=0.03),
    Lssigma(start=0.1/(2*pi*fsNominal)),
    final L0(d=2.0*Lmd/m/effectiveStatorTurns^2, q=2.0*Lmq/m/
          effectiveStatorTurns^2),
    redeclare final
      Modelica.Electrical.Machines.Thermal.SynchronousMachines.ThermalAmbientSMPM
      thermalAmbient(
      final useDamperCage=useDamperCage,
      final Tr=TrOperational,
      final Tpm=TpmOperational),
    redeclare final
      Modelica.Electrical.Machines.Interfaces.InductionMachines.ThermalPortSMPM
      thermalPort(final useDamperCage=useDamperCage),
    redeclare final
      Modelica.Electrical.Machines.Interfaces.InductionMachines.ThermalPortSMPM
      internalThermalPort(final useDamperCage=useDamperCage),
    redeclare final
      Modelica.Electrical.Machines.Interfaces.InductionMachines.PowerBalanceSMPM
      powerBalance(
      final lossPowerRotorWinding=damperCageLossPower,
      final lossPowerRotorCore=0,
      final lossPowerPermanentMagnet=permanentMagnet.lossPower));
  // Main field parameters
  parameter SI.Inductance Lmd(start=0.3/(2*pi*fsNominal))
    "Stator main field inductance per phase, d-axis" annotation (Dialog(
        tab="Nominal resistances and inductances", groupImage=
          "modelica://Modelica/Resources/Images/Electrical/Machines/SMPM.png"));
  parameter SI.Inductance Lmq(start=0.3/(2*pi*fsNominal))
    "Stator main field inductance per phase, q-axis"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  // Rotor cage parameters
  parameter Boolean useDamperCage(start=true)
    "Enable/disable damper cage" annotation (Dialog(tab=
          "Nominal resistances and inductances", group="Damper cage"));
  parameter SI.Inductance Lrsigmad(start=0.05/(2*pi*
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
  parameter SI.Resistance Rrd(start=0.04)
    "Rotor damper cage resistance, d-axis, w.r.t. stator side" annotation (Dialog(
      tab="Nominal resistances and inductances",
      group="Damper cage",
      enable=useDamperCage));
  parameter SI.Resistance Rrq=Rrd
    "Rotor damper cage resistance, q-axis, w.r.t. stator side" annotation (Dialog(
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
  final parameter SI.Temperature TpmOperational=293.15
    "Operational temperature of permanent magnet"
    annotation (Dialog(group="Operational temperatures"));
  parameter SI.Temperature TrOperational(start=293.15)
    "Operational temperature of (optional) damper cage" annotation (
      Dialog(group="Operational temperatures", enable=not useThermalPort
           and useDamperCage));
  // Permanent magnet parameters
  parameter SI.Voltage VsOpenCircuit(start=112.3)
    "Open circuit RMS voltage per phase @ fsNominal";
  parameter
    Modelica.Electrical.Machines.Losses.PermanentMagnetLossParameters
    permanentMagnetLossParameters(IRef(start=100), wRef(start=2*pi*
          fsNominal/p)) "Permanent magnet loss parameter record"
    annotation (Dialog(tab="Losses"));
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
    final effectiveTurns=sqrt(m/2.0)*effectiveStatorTurns) if
    useDamperCage
    "Symmetric rotor cage winding including resistances and stray inductances"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={30,-40})));
  // Permanent magnet components
  FundamentalWave.BasicMachines.Components.PermanentMagnet
    permanentMagnet(
    final V_m=Complex(V_mPM, 0),
    final m=m,
    final permanentMagnetLossParameters=permanentMagnetLossParameters,
    final useHeatPort=true,
    final is=is) "Magnetic potential difference of permanent magnet"
    annotation (Placement(transformation(
        origin={-10,-40},
        extent={{-10,-10},{10,10}},
        rotation=270)));
protected
  final parameter SI.MagneticPotentialDifference V_mPM=(2/
      pi)*sqrt(2)*(m/2)*VsOpenCircuit/effectiveStatorTurns/(Lmd/
      effectiveStatorTurns^2*2*pi*fsNominal)
    "Equivalent excitation magnetic potential difference";
  Modelica.Blocks.Interfaces.RealOutput damperCageLossPower(final
      quantity="Power", final unit="W") "Damper losses";
equation
  connect(ir, rotorCage.i);
  connect(damperCageLossPower, rotorCage.lossPower);
  if not useDamperCage then
    damperCageLossPower = 0;
  end if;
  connect(permanentMagnet.port_p, airGap.port_rn) annotation (Line(
      points={{-10,-30},{-10,-10}}, color={255,170,85}));
  connect(permanentMagnet.support, airGap.support) annotation (Line(
      points={{-20,-40},{-50,-40},{-50,0},{-10,0}}));
  connect(permanentMagnet.heatPort, internalThermalPort.heatPortPermanentMagnet)
    annotation (Line(
      points={{-20,-30},{-40,-30},{-40,-90}}, color={191,0,0}));
  connect(permanentMagnet.flange, inertiaRotor.flange_b) annotation (Line(
      points={{0,-40},{0,-20},{90,-20},{90,0}}));
  connect(airGap.port_rp, rotorCage.port_n) annotation (Line(
      points={{10,-10},{10,-30},{30,-30}}, color={255,170,85}));
  connect(short.port_n, airGap.port_rp) annotation (Line(
      points={{10,-30},{10,-10}}, color={255,170,85}));
  connect(short.port_p, permanentMagnet.port_n) annotation (Line(
      points={{10,-50},{-10,-50}}, color={255,170,85}));
  connect(rotorCage.port_p, permanentMagnet.port_n) annotation (Line(
      points={{30,-50},{-10,-50}}, color={255,170,85}));
  connect(rotorCage.heatPortWinding, internalThermalPort.heatPortRotorWinding)
    annotation (Line(
      points={{40,-40},{40,-80},{-40,-80},{-40,-90}},          color={191,0,0}));
  annotation (
    defaultComponentName="smpm",
    Icon(graphics={
        Rectangle(
          extent={{-130,10},{-100,-10}},
          fillColor={0,255,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-100,10},{-70,-10}},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
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
<li>permanent magnet losses</li>
</ul>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.BasicMachines.SynchronousMachines.SM_ElectricalExcited\">
SM_ElectricalExcited</a>,
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.BasicMachines.SynchronousMachines.SM_ReluctanceRotor\">
SM_ReluctanceRotor</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.SynchronousMachines.SM_PermanentMagnet\">
Magnetic.FundamentalWave.BasicMachines.SM_PermanentMagnet</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.SynchronousMachines.SM_ElectricalExcited\">
Magnetic.FundamentalWave.BasicMachines.SM_ElectricalExcited</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.SynchronousMachines.SM_ReluctanceRotor\">
Magnetic.FundamentalWave.BasicMachines.SM_ReluctanceRotor</a>,
</p>
</html>"));
end SM_PermanentMagnet;
