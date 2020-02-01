within Modelica.Electrical.Machines.Interfaces.InductionMachines;
record PowerBalanceSMEE
  "Power balance of synchronous machines with electrical excitation"
  extends
    Machines.Interfaces.InductionMachines.PartialPowerBalanceInductionMachines(
      final lossPowerTotal=lossPowerStatorWinding + lossPowerStatorCore +
        lossPowerRotorCore + lossPowerStrayLoad + lossPowerFriction +
        lossPowerRotorWinding + lossPowerExcitation + lossPowerBrush);
  SI.Power lossPowerRotorWinding "Rotor copper losses";
  SI.Power powerExcitation "Electrical excitation power";
  SI.Power lossPowerExcitation "Excitation losses";
  SI.Power lossPowerBrush "Brush losses";
  annotation (defaultComponentPrefixes="output", Documentation(info="<html>
Power balance of synchronous machines with electrical excitation.
 </html>"));
end PowerBalanceSMEE;
