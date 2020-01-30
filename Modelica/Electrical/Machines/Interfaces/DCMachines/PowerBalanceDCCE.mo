within Modelica.Electrical.Machines.Interfaces.DCMachines;
record PowerBalanceDCCE
  "Power balance of DC machines with compound excitation"
  extends Machines.Interfaces.DCMachines.PartialPowerBalanceDCMachines(final
      lossPowerTotal=lossPowerArmature + lossPowerCore + lossPowerStrayLoad +
        lossPowerFriction + lossPowerBrush + lossPowerShuntExcitation +
        lossPowerSeriesExcitation);
  SI.Power powerShuntExcitation
    "Electrical (shunt) excitation power";
  SI.Power powerSeriesExcitation
    "Electrical series excitation power";
  SI.Power lossPowerShuntExcitation
    "(Shunt) excitation losses";
  SI.Power lossPowerSeriesExcitation
    "Series excitation losses";
  annotation (defaultComponentPrefixes="output", Documentation(info="<html>
Power balance of DC machines with compound excitation.
 </html>"));
end PowerBalanceDCCE;
