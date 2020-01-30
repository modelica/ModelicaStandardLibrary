within Modelica.Electrical.Machines.Interfaces.DCMachines;
record PowerBalanceDCEE
  "Power balance of DC machines with electrical excitation"
  extends Machines.Interfaces.DCMachines.PartialPowerBalanceDCMachines(final
      lossPowerTotal=lossPowerArmature + lossPowerCore + lossPowerStrayLoad +
        lossPowerFriction + lossPowerBrush + lossPowerExcitation);
  SI.Power powerExcitation
    "Electrical (shunt) excitation power";
  SI.Power lossPowerExcitation "Excitation losses";
  annotation (defaultComponentPrefixes="output", Documentation(info="<html>
Power balance of DC machines with electrical excitation.
 </html>"));
end PowerBalanceDCEE;
