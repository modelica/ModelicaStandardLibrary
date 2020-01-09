within Modelica.Electrical.Machines.Interfaces.InductionMachines;
record PowerBalanceSMEE
  "Power balance of synchronous machines with electrical excitation"
  extends
    Machines.Interfaces.InductionMachines.PartialPowerBalanceInductionMachines(
      final lossPowerTotal=lossPowerStatorWinding + lossPowerStatorCore +
        lossPowerRotorCore + lossPowerStrayLoad + lossPowerFriction +
        lossPowerRotorWinding + lossPowerExcitation + lossPowerBrush);
  Modelica.SIunits.Power lossPowerRotorWinding "Rotor copper losses";
  Modelica.SIunits.Power powerExcitation "Electrical excitation power";
  Modelica.SIunits.Power lossPowerExcitation "Excitation losses";
  Modelica.SIunits.Power lossPowerBrush "Brush losses";
  annotation (defaultComponentPrefixes="output", Documentation(info="<html>
Power balance of synchronous machines with electrical excitation.
 </html>"));
end PowerBalanceSMEE;
