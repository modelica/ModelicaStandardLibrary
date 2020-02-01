within Modelica.Electrical.Machines.Interfaces.DCMachines;
record PowerBalanceDCSE
  "Power balance of DC machines with series excitation"
  extends Machines.Interfaces.DCMachines.PartialPowerBalanceDCMachines(final
      lossPowerTotal=lossPowerArmature + lossPowerCore + lossPowerStrayLoad +
        lossPowerFriction + lossPowerBrush + lossPowerSeriesExcitation);
  SI.Power powerSeriesExcitation
    "Electrical series excitation power";
  SI.Power lossPowerSeriesExcitation
    "Series excitation losses";
  annotation (defaultComponentPrefixes="output", Documentation(info="<html>
Power balance of DC machines with series excitation.
 </html>"));
end PowerBalanceDCSE;
