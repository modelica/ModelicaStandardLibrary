within Modelica.Electrical.Machines.Interfaces.InductionMachines;
record PowerBalanceSMPM
  "Power balance of synchronous machines with permanent magnet"
  extends
    Machines.Interfaces.InductionMachines.PartialPowerBalanceInductionMachines(
      final lossPowerTotal=lossPowerStatorWinding + lossPowerStatorCore +
        lossPowerRotorCore + lossPowerStrayLoad + lossPowerFriction +
        lossPowerRotorWinding + lossPowerPermanentMagnet);
  SI.Power lossPowerRotorWinding "Rotor copper losses";
  SI.Power lossPowerPermanentMagnet
    "Permanent magnet losses";
  annotation (defaultComponentPrefixes="output", Documentation(info="<html>
Power balance of synchronous machines with permanent magnet.
 </html>"));
end PowerBalanceSMPM;
