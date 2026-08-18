within Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.SSEE.Functions;
function der_J "Derivative of J(H)"
  extends Modelica.Icons.Function;
  input SI.MagneticFieldStrength H "Magnetic field strength";
  input BaseData material "Material data";
  input Modelica.Magnetic.FluxTubes.Types.MagneticFieldStrengthSlope derH
    "Slope of magnetic field strength";
  output Modelica.Magnetic.FluxTubes.Types.MagneticFluxDensitySlope derJ=
    mu_0*(app_mu_rd(H, material) - 1)*derH "Slope of magnetic polarization";
  annotation (Documentation(info="<html>
<p>
Returns slope of magnetic polarization <code>J</code> calculated from susceptibility.
</p>
</html>"));
end der_J;
