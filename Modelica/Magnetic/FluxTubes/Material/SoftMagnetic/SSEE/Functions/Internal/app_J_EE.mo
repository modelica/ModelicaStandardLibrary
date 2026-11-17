within Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.SSEE.Functions.Internal;
function app_J_EE "Approximation J(H) Exponential Extrapolation"
  extends Modelica.Icons.Function;
  input SI.MagneticFieldStrength H "Magnetic field strength";
  input BaseData material "Material data";
  output SI.MagneticPolarization J "Magnetic polarization";
protected
  SI.MagneticFieldStrength HD[:]=material.HD;
  SI.MagneticPolarization  JD[:]=material.JD;
  Integer k0=material.k0;
  SI.MagneticFieldStrength Hpar=material.Hpar;
  SI.MagneticPolarization  Jsat=material.Jsat;
algorithm
  J:=sign(H)*(JD[k0] + (Jsat - JD[k0])*(1 - exp(-(abs(H) - HD[k0])/Hpar)));
  annotation (Documentation(info="<html>
<p>
Returns magnetic polarization <code>J</code> calculated from exponential extrapolation for magnetic field strength <code>H</code>.
</p>
</html>"));
end app_J_EE;
