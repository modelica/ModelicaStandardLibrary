within Modelica.Electrical.Machines.Interfaces.InductionMachines;
record PowerBalanceSMPM
  "Power balance of synchronous machines with permanent magnet"
  extends
    Machines.Interfaces.InductionMachines.PartialPowerBalanceInductionMachines(
      final lossPowerTotal=lossPowerStatorWinding + lossPowerStatorCore +
        lossPowerRotorCore + lossPowerStrayLoad + lossPowerFriction +
        lossPowerRotorWinding + lossPowerPermanentMagnet);
  Modelica.SIunits.Power lossPowerRotorWinding "Rotor copper losses";
  Modelica.SIunits.Power lossPowerPermanentMagnet
    "Permanent magnet losses";
  annotation (defaultComponentPrefixes="output", Documentation(info="<html>
Power balance of synchronous machines with permanent magnet.
 </html>"));
end PowerBalanceSMPM;
