within Modelica.Electrical.Machines.Interfaces.DCMachines;
record PowerBalanceDCSE
  "Power balance of DC machines with series excitation"
  extends Machines.Interfaces.DCMachines.PartialPowerBalanceDCMachines(final
      lossPowerTotal=lossPowerArmature + lossPowerCore + lossPowerStrayLoad +
        lossPowerFriction + lossPowerBrush + lossPowerSeriesExcitation);
  Modelica.SIunits.Power powerSeriesExcitation
    "Electrical series excitation power";
  Modelica.SIunits.Power lossPowerSeriesExcitation
    "Series excitation losses";
  annotation (defaultComponentPrefixes="output", Documentation(info="<html>
Power balance of DC machines with series excitation.
 </html>"));
end PowerBalanceDCSE;
