within Modelica.Electrical.Machines.Interfaces.InductionMachines;
record PowerBalanceSMR
  "Power balance of synchronous machines with reluctance rotor"
  extends
    Machines.Interfaces.InductionMachines.PartialPowerBalanceInductionMachines(
      final lossPowerTotal=lossPowerStatorWinding + lossPowerStatorCore +
        lossPowerRotorCore + lossPowerStrayLoad + lossPowerFriction +
        lossPowerRotorWinding);
  SI.Power lossPowerRotorWinding "Rotor copper losses";
  annotation (defaultComponentPrefixes="output", Documentation(info="<html>
Power balance of synchronous machines with reluctance rotor.
 </html>"));
end PowerBalanceSMR;
