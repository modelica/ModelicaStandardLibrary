within Modelica.Electrical.Machines.BasicMachines.Components;
model AirGapDC "Linear airgap model of a DC machine"
  extends PartialAirGapDC;
  parameter SI.Inductance Le "Excitation inductance";
equation
  // excitation flux: linearly dependent on excitation current
  psi_e = Le*ie;
  annotation (
    defaultComponentName="airGap",
    Documentation(info="<html>
Linear model of the airgap (without saturation effects) of a DC machine, using only equations.<br>
Induced excitation voltage is calculated from der(flux), where flux is defined by excitation inductance times excitation current.<br>
Induced armature voltage is calculated from flux times angular velocity.
</html>"));
end AirGapDC;
