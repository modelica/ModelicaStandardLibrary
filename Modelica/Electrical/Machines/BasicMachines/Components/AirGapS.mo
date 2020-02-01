within Modelica.Electrical.Machines.BasicMachines.Components;
model AirGapS "Airgap in stator-fixed coordinate system"
  parameter SI.Inductance Lm "Main field inductance";
  extends PartialAirGap;
  SI.Current i_ms[2]
    "Magnetizing current space phasor with respect to the stator fixed frame";
protected
  parameter SI.Inductance L[2, 2]={{Lm,0},{0,Lm}}
    "Inductance matrix";
equation
  // Magnetizing current with respect to the stator reference frame
  i_ms = i_ss + i_rs;
  // Magnetizing flux linkage with respect to the stator reference frame
  psi_ms = L*i_ms;
  // Magnetizing flux linkage with respect to the rotor reference frame
  psi_mr = transpose(RotationMatrix)*psi_ms;
  annotation (
    defaultComponentName="airGap",
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={Text(
          extent={{-80,40},{0,-40}},
          textString="S")}),
    Documentation(info="<html>
Model of the airgap in stator-fixed coordinate system, using only equations.
</html>"));
end AirGapS;
