within Modelica.Electrical.Machines.Interfaces.InductionMachines;
record PowerBalanceIMS
  "Power balance of induction machines with slipring"
  extends
    Machines.Interfaces.InductionMachines.PartialPowerBalanceInductionMachines(
      final lossPowerTotal=lossPowerStatorWinding + lossPowerStatorCore +
        lossPowerRotorCore + lossPowerStrayLoad + lossPowerFriction +
        lossPowerRotorWinding + lossPowerBrush);
  Modelica.SIunits.Power lossPowerRotorWinding "Rotor copper losses";
  Modelica.SIunits.Power lossPowerBrush "Brush losses";
  Modelica.SIunits.Power powerRotor "Electrical power (rotor)";
  annotation (defaultComponentPrefixes="output", Documentation(info="<html>
Power balance of induction machines with slipring.
 </html>"));
end PowerBalanceIMS;
