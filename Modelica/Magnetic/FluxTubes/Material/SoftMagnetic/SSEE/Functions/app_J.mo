within Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.SSEE.Functions;
function app_J "Approximation J(H)"
  extends Modelica.Icons.Function;
  input SI.MagneticFieldStrength H "Magnetic field strength";
  input BaseData material "Material data";
  output SI.MagneticPolarization J "Magnetic polarization";
protected
  Real h "Helper function";
algorithm
  if abs(H) < material.hH1 then
    h:=0;
    J:=Internal.app_J_SS(H, material);
  elseif abs(H) > material.hH2 then
    h:=1;
    J:=Internal.app_J_EE(H, material);
  else
    h:=(abs(H) - material.hH1)/(material.hH2 - material.hH1);
    J:=(1 - h)*Internal.app_J_SS(H, material) + h*Internal.app_J_EE(H, material);
  end if;
  annotation (derivative(noDerivative=material)=der_J,
    Documentation(info="<html>
<p>
Returns magnetic polarization <code>J</code> calculated from smoothing splines and exponential extrapolation for magnetic field strength <code>H</code>.
</p>
</html>"));
end app_J;
