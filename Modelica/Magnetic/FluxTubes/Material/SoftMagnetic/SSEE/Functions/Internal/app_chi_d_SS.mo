within Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.SSEE.Functions.Internal;
function app_chi_d_SS "Approximation chi_d(H) Smoothing Splines"
  extends Modelica.Icons.Function;
  input SI.MagneticFieldStrength H "Magnetic field strength";
  input BaseData material "Material data";
  output SI.MagneticSusceptibility chi_d "Differential magnetic susceptibility";
protected
  SI.MagneticFieldStrength HD[:]=material.HD;
  Integer N=size(HD, 1);
  Real c1[:]=material.c1;
  Real c2[:]=material.c2;
  Real c3[:]=material.c3;
  Integer k=findInterval(abs(H), HD);
  SI.MagneticFieldStrength dH;
algorithm
  if k<=0 then
    chi_d:=c1[1]/mu_0;
  elseif k>=N then
    dH:=HD[N] - HD[N - 1];
    chi_d:=(((3*c3[N - 1]*dH + 2*c2[N - 1]))*dH + c1[N - 1])/mu_0;
  else
    chi_d:=((3*c3[k]*(abs(H) - HD[k]) + 2*c2[k])*(abs(H) - HD[k]) + c1[k])/mu_0;
  end if;
  annotation (Documentation(info="<html>
<p>
Returns differential susceptibility <code>chi_d</code> calculated from smoothing splines for magnetic field strength <code>H</code>.
</p>
</html>"));
end app_chi_d_SS;
