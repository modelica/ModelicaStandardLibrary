within Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.SSEE.Functions;
function app_mu_rd "Approximation mu_rd(H)"
  extends Modelica.Icons.Function;
  input SI.MagneticFieldStrength H;
  input BaseData material;
  output SI.RelativePermeability mu_rd;
protected
  Real h=if abs(H)<material.hH1 then 0 elseif abs(H)>material.hH2 then 1 else (abs(H) - material.hH1)/(material.hH2 - material.hH1);
algorithm
  mu_rd:=if abs(H) < material.hH1 then 1 + Internal.app_chi_d_SS(H, material)
     elseif abs(H) > material.hH2 then 1 + Internal.app_chi_d_EE(H, material)
     else 1 + (1 - h)*Internal.app_chi_d_SS(H, material) + h*Internal.app_chi_d_EE(H, material);
  annotation (Documentation(info="<html>
<p>
Returns differential relative permeability <code>mu_rd</code> calculated from smoothing splines and exponential extrapolation for magnetic field strength <code>H</code>.
</p>
</html>"));
end app_mu_rd;
