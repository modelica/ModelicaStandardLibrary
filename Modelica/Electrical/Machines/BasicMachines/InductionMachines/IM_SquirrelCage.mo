within Modelica.Electrical.Machines.BasicMachines.InductionMachines;
model IM_SquirrelCage
  "Induction machine with squirrel cage rotor"
  extends Machines.Interfaces.PartialBasicInductionMachine(
    final idq_ss=airGap.i_ss,
    final idq_sr=airGap.i_sr,
    final idq_rs=airGap.i_rs,
    final idq_rr=airGap.i_rr,
    redeclare final Machines.Thermal.InductionMachines.ThermalAmbientIMC
      thermalAmbient(final Tr=TrOperational),
    redeclare final Machines.Interfaces.InductionMachines.ThermalPortIMC
      thermalPort,
    redeclare final Machines.Interfaces.InductionMachines.ThermalPortIMC
      internalThermalPort,
    redeclare final Machines.Interfaces.InductionMachines.PowerBalanceIMC
      powerBalance(final lossPowerRotorWinding=squirrelCageR.LossPower, final
        lossPowerRotorCore=0),
    statorCore(final w=statorCoreParameters.wRef));
  output SI.Current ir[2]=squirrelCageR.i
    "Rotor cage currents";
  Machines.BasicMachines.Components.AirGapS airGap(
    final p=p,
    final Lm=Lm,
    final m=m) annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=270)));
  parameter SI.Inductance Lm(start=3*sqrt(1 - 0.0667)/(2*pi
        *fsNominal)) "Stator main field inductance per phase"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter SI.Inductance Lrsigma(start=3*(1 - sqrt(1 -
        0.0667))/(2*pi*fsNominal))
    "Rotor stray inductance per phase (equivalent three-phase winding)"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter SI.Resistance Rr(start=0.04)
    "Rotor resistance per phase (equivalent three-phase winding) at TRef"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter SI.Temperature TrRef(start=293.15)
    "Reference temperature of rotor resistance"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20r(start=0)
    "Temperature coefficient of rotor resistance at 20 degC"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter SI.Temperature TrOperational(start=293.15)
    "Operational temperature of rotor resistance" annotation (Dialog(
        group="Operational temperatures", enable=not useThermalPort));
  Machines.BasicMachines.Components.SquirrelCage squirrelCageR(
    final Lrsigma=Lrsigma,
    final Rr=Rr,
    final useHeatPort=true,
    final T_ref=TrRef,
    final alpha=Machines.Thermal.convertAlpha(alpha20r, TrRef)) annotation (
      Placement(transformation(
        origin={0,-40},
        extent={{-10,-10},{10,10}},
        rotation=270)));
equation
  connect(airGap.spacePhasor_r, squirrelCageR.spacePhasor_r)
    annotation (Line(points={{10,-10},{10,-30}}, color={0,0,255}));
  connect(airGap.flange, inertiaRotor.flange_a) annotation (Line(
      points={{10,0},{36,0},{36,0},{70,0}}));
  connect(lssigma.spacePhasor_b, airGap.spacePhasor_s) annotation (Line(
      points={{20,10},{10,10}}, color={0,0,255}));
  connect(squirrelCageR.heatPort, internalThermalPort.heatPortRotorWinding)
    annotation (Line(
      points={{-10,-40},{-10,-60},{0,-60},{0,-80}}, color={191,0,0}));
  connect(airGap.support, internalSupport) annotation (Line(
      points={{-10,0},{-40,0},{-40,-90},{60,-90},{60,-100}}));
  annotation (defaultComponentName="imc", Documentation(info="<html>
<p><strong>Model of a three-phase induction machine with squirrel cage.</strong><br>
Resistance and stray inductance of stator is modeled directly in stator phases, then using space phasor transformation. Resistance and stray inductance of rotor's squirrel cage is modeled in two axis of the rotor-fixed coordinate system. Both together connected via a stator-fixed <em>AirGap</em> model. The machine models take the following loss effects into account:
</p>

<ul>
<li>heat losses in the temperature dependent stator winding resistances</li>
<li>heat losses in the temperature dependent cage resistances</li>
<li>friction losses</li>
<li>core losses (only eddy current losses, no hysteresis losses)</li>
<li>stray load losses</li>
</ul>

<p><strong>Default values for machine's parameters (a realistic example) are:</strong><br></p>
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
<td>nominal current per phase</td>
<td>100</td><td>A RMS</td>
</tr>
<tr>
<td>nominal torque</td>
<td>161.4</td><td>Nm</td>
</tr>
<tr>
<td>nominal speed</td>
<td>1440.45</td><td>rpm</td>
</tr>
<tr>
<td>nominal mechanical output</td>
<td>24.346</td><td>kW</td>
</tr>
<tr>
<td>efficiency</td>
<td>92.7</td><td>%</td>
</tr>
<tr>
<td>power factor</td>
<td>0.875</td><td> </td>
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
<td>rotor resistance</td>
<td>0.04</td><td>Ohm at reference temperature</td>
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
<td>stator reactance Xs</td>
<td>3</td><td>Ohm per phase</td>
</tr>
<tr>
<td>rotor reactance Xr</td>
<td>3</td><td>Ohm</td>
</tr>
<tr>
<td>total stray coefficient sigma</td>
<td>0.0667</td><td> </td>
</tr>
<tr>
<td>stator operational temperature TsOperational</td>
<td>20</td><td>&deg;C</td>
</tr>
<tr>
<td>rotor operational temperature TrOperational</td>
<td>20</td><td>&deg;C</td>
</tr>
<tr>
<td>These values give the following inductances:</td>
<td> </td><td> </td>
</tr>
<tr>
<td>stator stray inductance per phase</td>
<td>Xs * (1 - sqrt(1-sigma))/(2*pi*fNominal)</td><td> </td>
</tr>
<tr>
<td>rotor stray inductance</td>
<td>Xr * (1 - sqrt(1-sigma))/(2*pi*fNominal)</td><td> </td>
</tr>
<tr>
<td>main field inductance per phase</td>
<td>sqrt(Xs*Xr * (1-sigma))/(2*pi*fNominal)</td><td> </td>
</tr>
</table>
</html>"));
end IM_SquirrelCage;
