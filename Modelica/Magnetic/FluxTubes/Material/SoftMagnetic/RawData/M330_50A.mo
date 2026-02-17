within Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.RawData;
record M330_50A "M330-50A @ 50Hz 0/90 deg"
  extends Modelica.Icons.Record;
  import Modelica.Math.Vectors.interpolate;
  import Modelica.Math.Vectors.find;
  import Modelica.Math.Vectors.reverse;
  import Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.RawData.Functions.exMax;
  constant Real lb2kg=0.45359237 "Conversion kg/lb";
  parameter String label="M330-50A @ 50Hz 0/90 deg" "Name of material";
  parameter SI.Density rho=7650 "Density of material";
  // Losses
  parameter FluxTubes.Types.SpecificPower p1=3.30
    "Specific losses at 1.5 T and f1";
  parameter SI.Frequency f1=50 "Measurement frequency 1";
  parameter FluxTubes.Types.SpecificPower p2=21.9/lb2kg
    "Specific losses at 1.5 T and f2";
  parameter SI.Frequency f2=60 "Measurement frequency 2";
  parameter Real ratioHysteresis=(p2/p1*f1/f2 - f2/f1)/(1 - f2/f1)
    "Ratio of hysteresis losses with respect to the total core losses at 1.5 T and f1";
  // saturation
  parameter SI.MagneticPolarization Jsat=2.0 "Saturation polarization";
  parameter SI.MagneticFieldStrength Hsat=1e5 "Field strength to achieve Jsat";
  // given data points
  parameter Integer N=size(J,1) "Length of measurement array";
  parameter SI.MagneticPolarization J[:]={0.5, 0.6, 0.7, 0.8, 0.9, 1.0,
       1.1, 1.2, 1.3, 1.4, 1.5, 1.6, 1.7, 1.8, 1.9} "Polarization";
  parameter SI.MagneticFieldStrength H[N]={53, 60, 69, 79, 93, 112,
       141, 192, 313, 698, 1932, 4284, 7750, 13318, 19610} "Field strength";
  // calculated parameters
  parameter SI.RelativePermeability mu_r[N]={1 + J[k]/(mu_0*H[k]) for k in 1:N} "Relative permeability";
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
M330-50A at 50Hz for 0/90 deg magnetization table <code>H(J)</code>taken from manufacturer's datasheet, 
also BaseData record definition.
</p>
</html>"),
    Icon(graphics={Text(
          extent={{-100,-10},{100,-40}},
          textColor={0,0,0},
          textString="     %label     ")}));
end M330_50A;
