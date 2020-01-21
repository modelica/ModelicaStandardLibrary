within Modelica.Electrical.Machines.BasicMachines.Components;
model AirGapR "Airgap in rotor-fixed coordinate system"
  parameter Modelica.SIunits.Inductance Lmd
    "Main field inductance d-axis";
  parameter Modelica.SIunits.Inductance Lmq
    "Main field inductance q-axis";
  extends PartialAirGap;
  Modelica.SIunits.Current i_mr[2]
    "Magnetizing current space phasor with respect to the rotor fixed frame";
protected
  parameter Modelica.SIunits.Inductance L[2, 2]={{Lmd,0},{0,Lmq}}
    "Inductance matrix";
equation
  // Magnetizing current with respect to the rotor reference frame
  i_mr = i_sr + i_rr;
  // Main flux linkage with respect to the rotor reference frame
  psi_mr = L*i_mr;
  // Main flux linkage with respect to the stator reference frame
  psi_ms = RotationMatrix*psi_mr;
  annotation (
    defaultComponentName="airGap",
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={Text(
          extent={{0,40},{80,-40}},
          textString="R")}),
    Documentation(info="<html>
Model of the airgap in rotor-fixed coordinate system, using only equations.
</html>"));
end AirGapR;
