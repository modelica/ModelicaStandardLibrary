within Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.RawData;
partial record BaseData "BaseData record for RawData"
  extends Modelica.Icons.Record;
  import Modelica.Math.Vectors.interpolate;
  import Modelica.Math.Vectors.find;
  import Modelica.Math.Vectors.reverse;
  import FluxTubesExtensions.Material.SoftMagnetic.RawData.Functions.exMax;
  constant Real lb2kg=0.45359237 "Conversion kg/lb";
  parameter String label="RawData" "Name of material";
  parameter SI.Density rho "Density of material";
  // Losses
  parameter FluxTubesExtensions.Types.SpecificPower p1
    "Specific losses at 1.5 T and f1";
  parameter SI.Frequency f1 "Measurement frequency 1";
  parameter FluxTubesExtensions.Types.SpecificPower p2
    "Specific losses at 1.5 T and f2";
  parameter SI.Frequency f2 "Measurement frequency 2";
  parameter Real ratioHysteresis=(p2/p1*f1/f2 - f2/f1)/(1 - f2/f1)
    "Ratio of hysteresis losses with respect to the total core losses at 1.5 T and f1";
  // saturation
  parameter SI.MagneticPolarization Jsat "Saturation polarization";
  parameter SI.MagneticFieldStrength Hsat "Field strength to achieve Jsat";
  // given data points
  parameter Integer N=size(J,1) "Length of measurement array";
  parameter SI.MagneticPolarization J[:]={1} "Polarization";
  parameter SI.MagneticFieldStrength H[N]={1} "Field strength";
  // calculated parameters
  parameter SI.RelativePermeability mu_r[N]=fill(1, N) + 1/mu_0*J./H "Relative permeability";
  // additional scalar parameters (provided maximum of permability is included in the table)
  parameter SI.RelativePermeability mu_ri=interpolate(H, mu_r, 0)
    "Initial relative permeability at origin (extrapolation)";
  parameter SI.RelativePermeability mu_rMax=max(mu_r) "Maximum relative permeability";
  parameter Integer iMax=find(mu_rMax, mu_r) "Index of maximum relative permeability";
  parameter SI.RelativePermeability mu_ra=exMax(H, mu_r)
    "Alternative initial relative permeability at origin (extrapolation)";
  // for use with CombiTables: add saturation and mirror at origin
  parameter Real table[:,3]=[
    cat(1, -{Hsat}, -reverse(H),    {    0},    H, {Hsat}),
    cat(1, -{Jsat}, -reverse(J),    {    0},    J, {Jsat}),
    cat(1,  {   1},  reverse(mu_r), {mu_ri}, mu_r, {   1})]
    "Table for interpolation H, J, mu_r";
  annotation (defaultComponentPrefixes="parameter", Documentation(info="<html>
<p>
BaseData Record for RawData
</p>
</html>"),
    Icon(graphics={Text(
          extent={{-100,-10},{100,-40}},
          textColor={0,0,0},
          textString="     %label     ")}));
end BaseData;
