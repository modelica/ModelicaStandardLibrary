within Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.Macfadyen;
record BaseData "Coefficients for approximation of soft magnetic materials"
  extends Modelica.Icons.Record;
  parameter String label="Macfadyen" "Name of material";
  parameter SI.RelativePermeability mu_ri=1 + sum(Chi_mk) - Chi_mc "Initial relative permeability";
  parameter SI.MagneticPolarization Jsat=mu_0*sum(Chi_mk.*Hk) "Saturation polarization";
  parameter Integer N=1 "Number of exponential terms";
  parameter SI.MagneticFieldStrength Hk[N]={1} "Field strength coefficients";
  parameter SI.MagneticSusceptibility Chi_mk[N]={1} "Susceptibility coefficients";
  parameter SI.MagneticFieldStrength Hc=1 "Field strength for correction at origin";
  parameter SI.MagneticSusceptibility Chi_mc=0 "Susceptibility for correction at origin";
  annotation (defaultComponentPrefixes="parameter",
    Icon(graphics={Text(
          extent={{-100,-10},{100,-40}},
          textColor={0,0,255},
          textString="%label")}));
end BaseData;
