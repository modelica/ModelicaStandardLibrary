within Modelica.Electrical.Machines.Interfaces.InductionMachines;
record PowerBalanceIMC
  "Power balance of induction machines with squirrel cage"
  extends
    Machines.Interfaces.InductionMachines.PartialPowerBalanceInductionMachines(
      final lossPowerTotal=lossPowerStatorWinding + lossPowerStatorCore +
        lossPowerRotorCore + lossPowerStrayLoad + lossPowerFriction +
        lossPowerRotorWinding);
  SI.Power lossPowerRotorWinding "Rotor copper losses";
  annotation (defaultComponentPrefixes="output", Documentation(info="<html>
Power balance of induction machines with squirrel cage.
 </html>"));
end PowerBalanceIMC;
