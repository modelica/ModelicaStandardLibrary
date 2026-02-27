within Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.RawData;
record M330_50A "M330-50A @ 50Hz 0/90 deg"
  extends Modelica.Icons.Record;
  import Modelica.Math.Vectors.interpolate;
  import Modelica.Math.Vectors.find;
  import Modelica.Math.Vectors.reverse;
  import Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.RawData.Internal.analyzeRawData;
  parameter String label="M330-50A @ 50Hz 0/90 deg" "Name of material";
  parameter Modelica.Units.SI.Density rho=7650 "Density of material";
  // Losses
  parameter FluxTubes.Types.SpecificPower v15=3.30
    "Specific losses at 1.5 T and fRef";
  parameter Modelica.Units.SI.Frequency fRef=50 "Measurement frequency 1";
  // Saturation
  parameter Modelica.Units.SI.MagneticPolarization Jsat=2.0
    "Saturation polarization";
  parameter Modelica.Units.SI.MagneticFieldStrength Hsat=1e5
    "Field strength to achieve Jsat";
  // given data points
  parameter Modelica.Units.SI.MagneticPolarization J[:]={0.5,0.6,0.7,0.8,0.9,
      1.0,1.1,1.2,1.3,1.4,1.5,1.6,1.7,1.8,1.9} "Polarization";
  parameter Modelica.Units.SI.MagneticFieldStrength H[:]={53,60,69,79,93,112,
      141,192,313,698,1932,4284,7750,13318,19610} "Field strength";
  // Calculated parameters
  parameter Modelica.Units.SI.RelativePermeability mu_r[size(J,1)]=
    analyzeRawData(J, H, Jsat, Hsat) "Relative permeability";
  parameter Modelica.Units.SI.RelativePermeability mu_ri=interpolate(H, mu_r, 0)
    "Initial relative permeability at origin (extrapolation)";
  parameter Modelica.Units.SI.RelativePermeability mu_rMax=max(mu_r)
    "Maximum relative permeability";
  parameter Integer iMax=find(mu_rMax, mu_r) "Index of maximum relative permeability";
  // for interpolation add saturation, origin and mirror at origin
  parameter Real table[2*size(J,1) + 3,3]=[
    cat(1, -{Hsat}, -reverse(H),    {    0},    H, {Hsat}),
    cat(1, -{Jsat}, -reverse(J),    {    0},    J, {Jsat}),
    cat(1,  {   1},  reverse(mu_r), {mu_ri}, mu_r, {   1})]
    "Table for interpolation H, J, mu_r";
  annotation (defaultComponentPrefixes="parameter", Documentation(info="<html>
<p>
M330-50A at 50Hz for 0/90 deg magnetization table <code>H(J)</code>taken from manufacturer's datasheet.
</p>
</html>"),
    Icon(graphics={Text(
          extent={{-100,-10},{100,-40}},
          textColor={0,0,0},
          textString="     %label     ")}));
end M330_50A;
