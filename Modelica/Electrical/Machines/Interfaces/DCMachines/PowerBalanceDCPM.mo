within Modelica.Electrical.Machines.Interfaces.DCMachines;
record PowerBalanceDCPM
  "Power balance of DC machines with permanent magnet"
  extends Machines.Interfaces.DCMachines.PartialPowerBalanceDCMachines(final
      lossPowerTotal=lossPowerArmature + lossPowerCore + lossPowerStrayLoad +
        lossPowerFriction + lossPowerBrush + lossPowerPermanentMagnet);
  SI.Power lossPowerPermanentMagnet
    "Permanent magnet losses";
  annotation (defaultComponentPrefixes="output", Documentation(info="<html>
Power balance of DC machines with permanent magnet.
 </html>"));
end PowerBalanceDCPM;
