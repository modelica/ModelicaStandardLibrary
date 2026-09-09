within Modelica.Magnetic.FluxTubes.Material.SoftMagnetic;
record BaseData
  "Coefficients for approximation of soft magnetic materials"

  extends Modelica.Icons.Record;
  parameter String label="SoftMagnetic" "Name of material";
  parameter SI.RelativePermeability mu_i=1
    "Initial relative permeability at B=0";
  parameter SI.MagneticFluxDensity B_myMax=1
    "Flux density at maximum relative permeability";
  parameter Real c_a=1 "Coefficient of approximation function";
  parameter Real c_b=1 "Coefficient of approximation function";
  parameter Real n=1 "Exponent of approximation function";

  annotation (defaultComponentPrefixes="parameter",
    Documentation(info="<html>
<p>
The parameters needed for <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.mu_rApprox\">approximation of the magnetisation characteristics</a> of included soft magnetic materials are declared in this record.
</p>
</html>"), Icon(graphics={Text(
          extent={{-100,-10},{100,-40}},
          textColor={0,0,255},
          textString="%label")}));
end BaseData;
