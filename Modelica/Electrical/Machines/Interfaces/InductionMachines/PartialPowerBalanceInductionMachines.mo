within Modelica.Electrical.Machines.Interfaces.InductionMachines;
record PartialPowerBalanceInductionMachines
  "Partial power balance of induction machines"
  extends Modelica.Icons.Record;
  SI.Power powerStator=0 "Electrical power (stator)";
  SI.Power powerMechanical=0 "Mechanical power";
  SI.Power powerInertiaStator=0 "Stator inertia power";
  SI.Power powerInertiaRotor=0 "Rotor inertia power";
  SI.Power lossPowerTotal=0 "Total loss power";
  SI.Power lossPowerStatorWinding=0 "Stator copper losses";
  SI.Power lossPowerStatorCore=0 "Stator core losses";
  SI.Power lossPowerRotorCore=0 "Rotor core losses";
  SI.Power lossPowerStrayLoad=0 "Stray load losses";
  SI.Power lossPowerFriction=0 "Friction losses";
  annotation (defaultComponentPrefixes="output", Documentation(info="<html>
Partial power balance of induction machines.
 </html>"));
end PartialPowerBalanceInductionMachines;
