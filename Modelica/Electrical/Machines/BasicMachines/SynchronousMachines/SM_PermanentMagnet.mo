within Modelica.Electrical.Machines.BasicMachines.SynchronousMachines;
model SM_PermanentMagnet "Permanent magnet synchronous machine"
  extends Machines.Interfaces.PartialBasicInductionMachine(
    Lssigma(start=0.1/(2*pi*fsNominal)),
    final idq_ss=airGap.i_ss,
    final idq_sr=airGap.i_sr,
    final idq_rs=airGap.i_rs,
    final idq_rr=airGap.i_rr,
    redeclare final Machines.Thermal.SynchronousMachines.ThermalAmbientSMPM
      thermalAmbient(
      final useDamperCage=useDamperCage,
      final Tr=TrOperational,
      final Tpm=TpmOperational),
    redeclare final Machines.Interfaces.InductionMachines.ThermalPortSMPM
      thermalPort(final useDamperCage=useDamperCage),
    redeclare final Machines.Interfaces.InductionMachines.ThermalPortSMPM
      internalThermalPort(final useDamperCage=useDamperCage),
    redeclare final Machines.Interfaces.InductionMachines.PowerBalanceSMPM
      powerBalance(
      final lossPowerRotorWinding=damperCageLossPower,
      final lossPowerRotorCore=0,
      final lossPowerPermanentMagnet=permanentMagnet.lossPower),
    statorCore(final w=statorCoreParameters.wRef));
  Modelica.Blocks.Interfaces.RealOutput ir[2](
    start=zeros(2),
    each final quantity="ElectricCurrent",
    each final unit="A") if useDamperCage "Damper cage currents"
    annotation (Placement(visible=false),Dialog(showStartAttribute=true));
  Modelica.Blocks.Interfaces.RealOutput idq_dr[2](
    each stateSelect=StateSelect.prefer,
    each final quantity="ElectricCurrent",
    each final unit="A") if useDamperCage
    "Damper space phasor current / rotor fixed frame"
    annotation (Placement(visible=false));
  Machines.BasicMachines.Components.AirGapR airGap(
    final p=p,
    final Lmd=Lmd,
    final Lmq=Lmq,
    final m=m) annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=270)));
  final parameter SI.Temperature TpmOperational=293.15
    "Operational temperature of permanent magnet"
    annotation (Dialog(group="Operational temperatures"));
  parameter SI.Temperature TrOperational(start=293.15)
    "Operational temperature of (optional) damper cage" annotation (
      Dialog(group="Operational temperatures", enable=not useThermalPort
           and useDamperCage));
  parameter SI.Voltage VsOpenCircuit(start=112.3)
    "Open circuit RMS voltage per phase @ fsNominal";
  parameter SI.Inductance Lmd(start=0.3/(2*pi*fsNominal))
    "Stator main field inductance per phase in d-axis"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter SI.Inductance Lmq(start=0.3/(2*pi*fsNominal))
    "Stator main field inductance per phase in q-axis"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter Boolean useDamperCage(start=true)
    "Enable / disable damper cage" annotation (Evaluate=true, Dialog(tab=
          "Nominal resistances and inductances", group="Damper cage"));
  parameter SI.Inductance Lrsigmad(start=0.05/(2*pi*
        fsNominal)) "Damper stray inductance in d-axis" annotation (
      Dialog(
      tab="Nominal resistances and inductances",
      group="Damper cage",
      enable=useDamperCage));
  parameter SI.Inductance Lrsigmaq=Lrsigmad
    "Damper stray inductance in q-axis" annotation (Dialog(
      tab="Nominal resistances and inductances",
      group="Damper cage",
      enable=useDamperCage));
  parameter SI.Resistance Rrd(start=0.04)
    "Damper resistance in d-axis at TRef" annotation (Dialog(
      tab="Nominal resistances and inductances",
      group="Damper cage",
      enable=useDamperCage));
  parameter SI.Resistance Rrq=Rrd
    "Damper resistance in q-axis at TRef" annotation (Dialog(
      tab="Nominal resistances and inductances",
      group="Damper cage",
      enable=useDamperCage));
  parameter SI.Temperature TrRef(start=293.15)
    "Reference temperature of damper resistances in d- and q-axis"
    annotation (Dialog(
      tab="Nominal resistances and inductances",
      group="Damper cage",
      enable=useDamperCage));
  parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20r(start=0)
    "Temperature coefficient of damper resistances in d- and q-axis"
    annotation (Dialog(
      tab="Nominal resistances and inductances",
      group="Damper cage",
      enable=useDamperCage));
  parameter Machines.Losses.PermanentMagnetLossParameters permanentMagnetLossParameters(IRef(
        start=100), wRef(start=2*pi*fsNominal/p))
    "Permanent magnet loss parameter record" annotation (Dialog(tab="Losses"));
  Components.PermanentMagnetWithLosses permanentMagnet(
    final Ie=Ie,
    final useHeatPort=true,
    final m=m,
    final permanentMagnetLossParameters=permanentMagnetLossParameters,
    final is=is) annotation (Placement(transformation(
        origin={30,-30},
        extent={{10,10},{-10,-10}},
        rotation=180)));
  Machines.BasicMachines.Components.DamperCage damperCage(
    final Lrsigmad=Lrsigmad,
    final Lrsigmaq=Lrsigmaq,
    final Rrd=Rrd,
    final Rrq=Rrq,
    final T_ref=TrRef,
    final alpha=Machines.Thermal.convertAlpha(alpha20r, TrRef),
    final useHeatPort=true) if useDamperCage annotation (Placement(
        transformation(
        origin={0,-40},
        extent={{-10,-10},{10,10}},
        rotation=270)));
protected
  final parameter SI.Current Ie=sqrt(2)*VsOpenCircuit/(Lmd*
      2*pi*fsNominal) "Equivalent excitation current";
  Modelica.Blocks.Interfaces.RealOutput damperCageLossPower(final
      quantity="Power", final unit="W") "Damper losses";
equation
  connect(ir, damperCage.i);
  connect(idq_dr, damperCage.i);
  connect(damperCageLossPower, damperCage.lossPower);
  if not useDamperCage then
    damperCageLossPower = 0;
  end if;
  connect(airGap.spacePhasor_r, damperCage.spacePhasor_r)
    annotation (Line(points={{10,-10},{10,-30}}, color={0,0,255}));
  connect(airGap.spacePhasor_r, permanentMagnet.spacePhasor_r)
    annotation (Line(points={{10,-10},{10,-20},{20,-20}}, color={0,0,255}));
  connect(airGap.support, internalSupport) annotation (Line(
      points={{-10,0},{-40,0},{-40,-90},{60,-90},{60,-100}}));
  connect(lssigma.spacePhasor_b, airGap.spacePhasor_s) annotation (Line(
      points={{20,10},{10,10}}, color={0,0,255}));
  connect(airGap.flange, inertiaRotor.flange_a) annotation (Line(
      points={{10,0},{70,0}}));
  connect(permanentMagnet.heatPort, internalThermalPort.heatPortPermanentMagnet)
    annotation (Line(
      points={{20,-40},{20,-80},{0,-80}}, color={191,0,0}));
  connect(permanentMagnet.flange, inertiaRotor.flange_b) annotation (Line(
      points={{30,-20},{90,-20},{90,0}}));
  connect(damperCage.heatPort, internalThermalPort.heatPortRotorWinding)
    annotation (Line(
      points={{-10,-40},{-10,-80},{0,-80},{0,-80}}, color={191,0,0}));
  connect(internalSupport, permanentMagnet.support) annotation (Line(
      points={{60,-100},{60,-100},{60,-90},{30,-90},{30,-40},{30,-40}}));
  annotation (
    defaultComponentName="smpm",
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Rectangle(
          extent={{-130,10},{-100,-10}},
          fillColor={0,255,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-100,10},{-70,-10}},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Ellipse(extent={{-134,34},{-66,-34}}, lineColor={0,0,255})}),
    Documentation(info="<html>
<p><strong>Model of a three-phase permanent magnet synchronous machine.</strong><br>
Resistance and stray inductance of stator is modeled directly in stator phases, then using space phasor transformation and a rotor-fixed <em>AirGap</em> model. Resistance and stray inductance of rotor's squirrel cage is modeled in two axis of the rotor-fixed coordinate system. Permanent magnet excitation is modelled by a constant equivalent excitation current feeding the d-axis. The machine models take the following loss effects into account:
</p>

<ul>
<li>heat losses in the temperature dependent stator winding resistances</li>
<li>optional, when enabled: heat losses in the temperature dependent damper cage resistances</li>
<li>friction losses</li>
<li>core losses (only eddy current losses, no hysteresis losses)</li>
<li>stray load losses</li>
<li>permanent magnet losses</li>
</ul>

<p>Whether a damper cage is present or not, can be selected with Boolean parameter useDamperCage (default = true).
<br><strong>Default values for machine's parameters (a realistic example) are:</strong><br></p>
<table>
<tr>
<td>number of pole pairs p</td>
<td>2</td><td> </td>
</tr>
<tr>
<td>stator's moment of inertia</td>
<td>0.29</td><td>kg.m2</td>
</tr>
<tr>
<td>rotor's moment of inertia</td>
<td>0.29</td><td>kg.m2</td>
</tr>
<tr>
<td>nominal frequency fNominal</td>
<td>50</td><td>Hz</td>
</tr>
<tr>
<td>nominal voltage per phase</td>
<td>100</td><td>V RMS</td>
</tr>
<tr>
<td>no-load voltage per phase</td>
<td>112.3</td><td>V RMS @ nominal speed</td>
</tr>
<tr>
<td>nominal current per phase</td>
<td>100</td><td>A RMS</td>
</tr>
<tr>
<td>nominal torque</td>
<td>181.4</td><td>Nm</td>
</tr>
<tr>
<td>nominal speed</td>
<td>1500</td><td>rpm</td>
</tr>
<tr>
<td>nominal mechanical output</td>
<td>28.5</td><td>kW</td>
</tr>
<tr>
<td>nominal rotor angle</td>
<td>20.75</td><td>degree</td>
</tr>
<tr>
<td>efficiency</td>
<td>95.0</td><td>%</td>
</tr>
<tr>
<td>power factor</td>
<td>0.98</td><td> </td>
</tr>
<tr>
<td>stator resistance</td>
<td>0.03</td><td>Ohm per phase at reference temperature</td>
</tr>
<tr>
<td>reference temperature TsRef</td>
<td>20</td><td>&deg;C</td>
</tr>
<tr>
<td>temperature coefficient alpha20s </td>
<td>0</td><td>1/K</td>
</tr>
<tr>
<td>stator reactance Xd</td>
<td>0.4</td><td>Ohm per phase in d-axis</td>
</tr>
<tr>
<td>stator reactance Xq</td>
<td>0.4</td><td>Ohm per phase in q-axis</td>
</tr>
<tr>
<td>stator stray reactance Xss</td>
<td>0.1</td><td>Ohm per phase</td>
</tr>
<tr>
<td>damper resistance in d-axis</td>
<td>0.04</td><td>Ohm at reference temperature</td>
</tr>
<tr>
<td>damper resistance in q-axis</td>
<td>same as d-axis</td><td> </td>
</tr>
<tr>
<td>reference temperature TrRef</td>
<td>20</td><td>&deg;C</td>
</tr>
<tr>
<td>temperature coefficient alpha20r </td>
<td>0</td><td>1/K</td>
</tr>
<tr>
<td>damper stray reactance in d-axis XDds</td>
<td>0.05</td><td>Ohm</td>
</tr>
<tr>
<td>damper stray reactance in q-axis XDqs</td>
<td>same as d-axis</td><td> </td>
</tr>
<tr>
<td>stator operational temperature TsOperational</td>
<td>20</td><td>&deg;C</td>
</tr>
<tr>
<td>damper operational temperature TrOperational</td>
<td>20</td><td>&deg;C</td>
</tr>
<tr>
<td>These values give the following inductances:</td>
<td> </td><td> </td>
</tr>
<tr>
<td>main field inductance in d-axis</td>
<td>(Xd - Xss)/(2*pi*fNominal)</td><td> </td>
</tr>
<tr>
<td>main field inductance in q-axis</td>
<td>(Xq - Xss)/(2*pi*fNominal)</td><td> </td>
</tr>
<tr>
<td>stator stray inductance per phase</td>
<td>Xss/(2*pi*fNominal)</td><td> </td>
</tr>
<tr>
<td>damper stray inductance in d-axis</td>
<td>XDds/(2*pi*fNominal)</td><td> </td>
</tr>
<tr>
<td>damper stray inductance in q-axis</td>
<td>XDqs/(2*pi*fNominal)</td><td> </td>
</tr>
</table>
</html>"));
end SM_PermanentMagnet;
