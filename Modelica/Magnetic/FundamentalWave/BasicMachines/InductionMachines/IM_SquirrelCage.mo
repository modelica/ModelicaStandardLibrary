within Modelica.Magnetic.FundamentalWave.BasicMachines.InductionMachines;
model IM_SquirrelCage
  "Induction machine with squirrel cage"
  extends Magnetic.FundamentalWave.BaseClasses.Machine(
    is(start=zeros(m)),
    Rs(start=0.03),
    Lssigma(start=3*(1 - sqrt(1 - 0.0667))/(2*pi*fsNominal)),
    final L0(d=2.0*Lm/m/effectiveStatorTurns^2, q=2.0*Lm/m/effectiveStatorTurns
          ^2),
    redeclare final
      Modelica.Electrical.Machines.Thermal.InductionMachines.ThermalAmbientIMC
      thermalAmbient(final Tr=TrOperational),
    redeclare final
      Modelica.Electrical.Machines.Interfaces.InductionMachines.ThermalPortIMC
      thermalPort,
    redeclare final
      Modelica.Electrical.Machines.Interfaces.InductionMachines.ThermalPortIMC
      internalThermalPort,
    redeclare final
      Modelica.Electrical.Machines.Interfaces.InductionMachines.PowerBalanceIMC
      powerBalance(final lossPowerRotorWinding=sum(rotorCage.resistor.resistor.LossPower),
        final lossPowerRotorCore=0));
  parameter SI.Inductance Lm(start=3*sqrt(1 - 0.0667)/(2*pi
        *fsNominal)) "Stator main field inductance" annotation (Dialog(
        tab="Nominal resistances and inductances", groupImage=
          "modelica://Modelica/Resources/Images/Electrical/Machines/IMC.png"));
  parameter SI.Inductance Lrsigma(start=3*(1 - sqrt(1 -
        0.0667))/(2*pi*fsNominal))
    "Rotor leakage inductance of equivalent m phase winding w.r.t. stator side"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter SI.Resistance Rr(start=0.04)
    "Rotor resistance of equivalent m phase winding w.r.t. stator side"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter SI.Temperature TrRef(start=293.15)
    "Reference temperature of rotor resistance"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter
    Modelica.Electrical.Machines.Thermal.LinearTemperatureCoefficient20
    alpha20r(start=0)
    "Temperature coefficient of rotor resistance at 20 degC"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter SI.Temperature TrOperational(start=293.15)
    "Operational temperature of rotor resistance" annotation (Dialog(
        group="Operational temperatures", enable=not useThermalPort));
  output SI.Current ir[m]=rotorCage.i "Rotor cage currents";
  Magnetic.FundamentalWave.BasicMachines.Components.SymmetricPolyphaseCageWinding
    rotorCage(
    final Lsigma=Lrsigma,
    final effectiveTurns=effectiveStatorTurns,
    final useHeatPort=true,
    final RRef=Rr,
    final TRef=TrRef,
    final TOperational=TrRef,
    final m=m,
    final alpha20=alpha20r)
    "Symmetric rotor cage winding including resistances and stray inductances"
    annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
equation
  connect(rotorCage.heatPortWinding, internalThermalPort.heatPortRotorWinding)
    annotation (Line(
      points={{0,-40},{-40,-40},{-40,-90}}, color={191,0,0}));
  connect(airGap.port_rn, rotorCage.port_p) annotation (Line(
      points={{-10,-10},{-10,-30}}, color={255,128,0}));
  connect(airGap.port_rp, rotorCage.port_n) annotation (Line(
      points={{10,-10},{10,-30}}, color={255,128,0}));
  annotation (
    defaultComponentName="imc",
    Documentation(info="<html>
<p>
Resistances and stray inductances of the machine refer to an <code>m</code>-phase stator. The symmetry of the stator and rotor is assumed. The machine models take the following loss effects into account:
</p>

<ul>
<li>heat losses in the temperature dependent stator winding resistances</li>
<li>heat losses in the temperature dependent cage resistances</li>
<li>friction losses</li>
<li>core losses (only eddy current losses, no hysteresis losses)</li>
<li>stray load losses</li>
</ul>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.InductionMachines.IM_SlipRing\">IM_SlipRing</a>,
</p>
</html>"));
end IM_SquirrelCage;
