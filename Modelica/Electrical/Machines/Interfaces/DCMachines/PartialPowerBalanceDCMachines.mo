within Modelica.Electrical.Machines.Interfaces.DCMachines;
record PartialPowerBalanceDCMachines
  "Partial power balance of DC machines"
  extends Modelica.Icons.Record;
  Modelica.SIunits.Power powerArmature=0 "Electrical armature power";
  Modelica.SIunits.Power powerMechanical=0 "Mechanical power";
  Modelica.SIunits.Power powerInertiaStator=0 "Stator inertia power";
  Modelica.SIunits.Power powerInertiaRotor=0 "Rotor inertia power";
  Modelica.SIunits.Power lossPowerTotal=0 "Total loss power";
  Modelica.SIunits.Power lossPowerArmature=0 "Armature copper losses";
  Modelica.SIunits.Power lossPowerCore=0 "Core losses";
  Modelica.SIunits.Power lossPowerStrayLoad=0 "Stray load losses";
  Modelica.SIunits.Power lossPowerFriction=0 "Friction losses";
  Modelica.SIunits.Power lossPowerBrush=0 "Brush losses";
  annotation (defaultComponentPrefixes="output", Documentation(info="<html>
Partial power balance of DC machines.
 </html>"));
end PartialPowerBalanceDCMachines;
