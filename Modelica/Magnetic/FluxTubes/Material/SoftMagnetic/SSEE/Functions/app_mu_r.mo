within Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.SSEE.Functions;
function app_mu_r "Approximation mu_r(H)"
  extends Modelica.Icons.Function;
  input SI.MagneticFieldStrength H "Field strength";
  input BaseData material;
  output SI.RelativePermeability mu_r "Relative permeability";
protected
  SI.MagneticFieldStrength Heps=1e-6 "Below Heps mu_ri is returned";
algorithm
  if abs(H)<Heps then
    mu_r:=material.mu_ri;
  else
    mu_r:=1 + app_J(H, material)/(mu_0*H);
  end if;
  annotation (derivative(noDerivative=material)=der_mu_r,
    Documentation(info="<html>
<p>
Returns relative permeability <code>mu_r = J(H)/(mu_0*H)</code>; for <code>H</code> near 0, initial relative permeability <code>mu_ri</code> is used.
</p>
</html>"));
end app_mu_r;
