within Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.SSEE.Functions;
function app_mu_rd "Approximation mu_rd(H)"
  extends Modelica.Icons.Function;
  input SI.MagneticFieldStrength H "Magnetic field strength";
  input BaseData material "Material data";
  output SI.RelativePermeability mu_rd "Relative differential magnetic permeability";
protected
  Real h "Helper function";
algorithm
  if abs(H) < material.hH1 then
    h:=0;
    mu_rd:=1 + Internal.app_chi_d_SS(H, material);
  elseif abs(H) > material.hH2 then
    h:=1;
    mu_rd:=1 + Internal.app_chi_d_EE(H, material);
  else
    h:=(abs(H) - material.hH1)/(material.hH2 - material.hH1);
    mu_rd:=1 + (1 - h)*Internal.app_chi_d_SS(H, material) + h*Internal.app_chi_d_EE(H, material);
  end if;
  annotation (Documentation(info="<html>
<p>
Returns differential relative permeability <code>mu_rd</code> calculated from smoothing splines and exponential extrapolation for magnetic field strength <code>H</code>.
</p>
</html>"));
end app_mu_rd;
