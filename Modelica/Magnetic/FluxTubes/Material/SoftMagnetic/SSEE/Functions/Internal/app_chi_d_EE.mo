within Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.SSEE.Functions.Internal;
function app_chi_d_EE
  "Approximation chi_d(H) Exponential Extrapolation"
  extends Modelica.Icons.Function;
  input SI.MagneticFieldStrength H;
  input BaseData material;
  output SI.MagneticSusceptibility chi_d;
protected
  SI.MagneticFieldStrength HD[:]=material.HD;
  SI.MagneticPolarization  JD[:]=material.JD;
  Integer k0=material.k0;
  SI.MagneticFieldStrength Hpar=material.Hpar;
  SI.MagneticPolarization  Jsat=material.Jsat;
algorithm
  chi_d:=(Jsat - JD[k0])/(mu_0*Hpar)*exp(-(abs(H) - HD[k0])/Hpar);
  annotation (Documentation(info="<html>
<p>
Returns differential susceptibility <code>chi_d</code> calculated from exponential extrapolation for magnetic field strength <code>H</code>.
</p>
</html>"));
end app_chi_d_EE;
