within Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.SSEE.Functions.Internal;
function app_J_SS "Approximation J(H) Smoothing Splines"
  extends Modelica.Icons.Function;
  input SI.MagneticFieldStrength H;
  input BaseData material;
  output SI.MagneticPolarization J;
protected
  SI.MagneticFieldStrength HD[:]=material.HD;
  Integer N=size(HD, 1);
  Real c0[:]=material.c0; // <> JD (smoothing splines)
  Real c1[:]=material.c1;
  Real c2[:]=material.c2;
  Real c3[:]=material.c3;
  Integer k=getInterval(abs(H), HD);
  SI.MagneticFieldStrength dH;
algorithm
  if k<=0 then
    J:=sign(H)*(c0[1] + c1[1]*(abs(H) - HD[1]));
  elseif k>=N then
    dH:=HD[N] - HD[N - 1];
    J:=sign(H)*(c0[N-1] + (c1[N - 1] + c2[N - 1]*2*dH + c3[N - 1]*3*dH^2)*(abs(H) - HD[N]));
  else
    J:=sign(H)*(c0[k] + c1[k]*(abs(H) - HD[k]) + c2[k]*(abs(H) - HD[k])^2 + c3[k]*(abs(H) - HD[k])^3);
  end if;
  annotation (Documentation(info="<html>
<p>
Returns magnetic polarization <code>J</code> calculated from smoothing splines for magnetic field strength <code>H</code>.
</p>
</html>"));
end app_J_SS;
