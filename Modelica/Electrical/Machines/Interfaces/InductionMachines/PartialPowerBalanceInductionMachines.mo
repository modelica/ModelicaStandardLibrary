within Modelica.Electrical.Machines.Interfaces.InductionMachines;
record PartialPowerBalanceInductionMachines
  "Partial power balance of induction machines"
  extends Modelica.Icons.Record;
  Modelica.SIunits.Power powerStator=0 "Electrical power (stator)";
  Modelica.SIunits.Power powerMechanical=0 "Mechanical power";
  Modelica.SIunits.Power powerInertiaStator=0 "Stator inertia power";
  Modelica.SIunits.Power powerInertiaRotor=0 "Rotor inertia power";
  Modelica.SIunits.Power lossPowerTotal=0 "Total loss power";
  Modelica.SIunits.Power lossPowerStatorWinding=0 "Stator copper losses";
  Modelica.SIunits.Power lossPowerStatorCore=0 "Stator core losses";
  Modelica.SIunits.Power lossPowerRotorCore=0 "Rotor core losses";
  Modelica.SIunits.Power lossPowerStrayLoad=0 "Stray load losses";
  Modelica.SIunits.Power lossPowerFriction=0 "Friction losses";
  annotation (defaultComponentPrefixes="output", Documentation(info="<html>
Partial power balance of induction machines.
 </html>"));
end PartialPowerBalanceInductionMachines;
