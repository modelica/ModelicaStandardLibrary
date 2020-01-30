within Modelica.Electrical.Machines.Interfaces.DCMachines;
record PartialPowerBalanceDCMachines
  "Partial power balance of DC machines"
  extends Modelica.Icons.Record;
  SI.Power powerArmature=0 "Electrical armature power";
  SI.Power powerMechanical=0 "Mechanical power";
  SI.Power powerInertiaStator=0 "Stator inertia power";
  SI.Power powerInertiaRotor=0 "Rotor inertia power";
  SI.Power lossPowerTotal=0 "Total loss power";
  SI.Power lossPowerArmature=0 "Armature copper losses";
  SI.Power lossPowerCore=0 "Core losses";
  SI.Power lossPowerStrayLoad=0 "Stray load losses";
  SI.Power lossPowerFriction=0 "Friction losses";
  SI.Power lossPowerBrush=0 "Brush losses";
  annotation (defaultComponentPrefixes="output", Documentation(info="<html>
Partial power balance of DC machines.
 </html>"));
end PartialPowerBalanceDCMachines;
