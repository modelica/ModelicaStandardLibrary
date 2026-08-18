within Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.SSEE.Functions;
function der_mu_r "Approximation der_mu_r(H)"
  extends Modelica.Icons.Function;
  input SI.MagneticFieldStrength H "Magnetic field strength";
  input BaseData material
                         " Material data";
  input Modelica.Magnetic.FluxTubes.Types.MagneticFieldStrengthSlope derH
    "Slope of magnetic field strength";
  output Real dermu_r "Slope of relative magnetic permeability";
protected
  SI.MagneticFieldStrength Heps=1e-6 "Below Heps dermu_r=0 is returned";
algorithm
  if abs(H)<Heps then
    dermu_r:=0;
  else
    dermu_r:=(app_mu_rd(H, material) - app_mu_r(H, material))/H*derH;
  end if;
  annotation (Documentation(info="<html>
<p>
Returns slope of relative permeability <code>mu_r = J(H)/(mu_0*H)</code>.
</p>
</html>"));
end der_mu_r;
