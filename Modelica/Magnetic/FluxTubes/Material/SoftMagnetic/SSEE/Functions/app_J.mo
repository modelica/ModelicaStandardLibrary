within Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.SSEE.Functions;
function app_J "Approximation J(H)"
  extends Modelica.Icons.Function;
  input SI.MagneticFieldStrength H;
  input BaseData material;
  output SI.MagneticPolarization J;
protected
  Real h=if abs(H)<material.hH1 then 0 elseif abs(H)>material.hH2 then 1 else (abs(H) - material.hH1)/(material.hH2 - material.hH1);
algorithm
  J:=if abs(H) < material.hH1 then Internal.app_J_SS(H, material)
    elseif abs(H) > material.hH2 then Internal.app_J_EE(H, material)
    else (1 - h)*Internal.app_J_SS(H, material) + h*Internal.app_J_EE(H, material);
  annotation (derivative(noDerivative=material)=der_J,
    Documentation(info="<html>
<p>
Returns magnetic polarization <code>J</code> calculated from smoothing splines and exponential extrapolation for magnetic field strength <code>H</code>.
</p>
</html>"));
end app_J;
