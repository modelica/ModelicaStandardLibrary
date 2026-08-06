within Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.SSEE.Functions.Internal;
function app_chi_d_SS "Approximation chi_d(H) Smoothing Splines"
  extends Modelica.Icons.Function;
  input SI.MagneticFieldStrength H;
  input BaseData material;
  output SI.MagneticSusceptibility mu_rd;
protected
  SI.MagneticFieldStrength HD[:]=material.HD;
  Integer N=size(HD, 1);
  Real c1[:]=material.c1;
  Real c2[:]=material.c2;
  Real c3[:]=material.c3;
  Integer k=getInterval(abs(H), HD);
  SI.MagneticFieldStrength dH;
algorithm
  if k<=0 then
    mu_rd:=c1[1]/mu_0;
  elseif k>=N then
    dH:=HD[N] - HD[N - 1];
    mu_rd:=(c1[N - 1] + c2[N - 1]*2*dH + c3[N - 1]*3*dH^2)/mu_0;
  else
    mu_rd:=(c1[k] + c2[k]*2*(abs(H) - HD[k]) + c3[k]*3*(abs(H) - HD[k])^2)/mu_0;
  end if;
  annotation (Documentation(info="<html>
<p>
Returns differential susceptibility <code>chi_d</code> calculated from smoothing splines for magnetic field strength <code>H</code>.
</p>
</html>"));
end app_chi_d_SS;
