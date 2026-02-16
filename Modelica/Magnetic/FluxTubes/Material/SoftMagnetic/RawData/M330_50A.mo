within Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.RawData;
record M330_50A "M330-50A @ 50Hz 0/90 deg"
  extends Modelica.Icons.Record;
  import Modelica.Math.Vectors.interpolate;
  import Modelica.Math.Vectors.find;
  import Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.RawData.Functions.exMax;
  import Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.RawData.Functions.interpolationTable;
  parameter String label="M330-50A @ 50Hz 0/90 deg" "Name of material";
  // saturation
  parameter SI.MagneticPolarization Jsat=2.0 "Saturation polarization";
  parameter SI.MagneticFieldStrength Hsat=50e3 "Field strength to achieve Jsat";
  // given data points
  parameter Integer N=size(J,1) "Length of measurement array";
  parameter SI.MagneticPolarization J[:]={0.5, 0.6, 0.7, 0.8, 0.9, 1.0,
    1.1, 1.2, 1.3, 1.4, 1.5, 1.6, 1.7, 1.8, 1.9} "Polarization";
  parameter SI.MagneticFieldStrength H[N]={53, 60, 69, 79, 93, 112,
    141, 192, 313, 698, 1932, 4284, 7750, 13318, 19610} "Field strength";
  // calculated parameters
  parameter SI.MagneticSusceptibility Chi[N]=1/mu_0*J./H "Susceptibility";
  parameter SI.RelativePermeability mu_r[N]=fill(1, N) + Chi "Relative permeability";
  // additional scalar parameters
  parameter SI.RelativePermeability mu_ri=interpolate(H, mu_r, 0)
    "Initial relative permeability at origin (extrapolation)";
  parameter SI.RelativePermeability mu_rMax=max(mu_r) "Maximum relative permeability";
  parameter Integer iMax=find(mu_rMax, mu_r) "Index of maximum relative permeability";
  parameter SI.RelativePermeability mu_ra=exMax(H, mu_r)
    "Alternative initial relative permeability at origin (extrapolation)";
  // for use with CombiTables: add saturation and mirror at origin
  parameter Real table[:,2]=interpolationTable(x=H, y=J, xSat=Hsat, ySat=Jsat,
    originSymmetric=true, completeOrigin=true) "Table for interpolation";
  annotation (defaultComponentPrefixes="parameter", Documentation(info="<html>
<p>
M330-50A at 50Hz for 0/90 deg magnetization table <code>H(J)</code>taken from manufacturer's datasheet
</p>
</html>"),
    Icon(graphics={Text(
          extent={{-100,-10},{100,-40}},
          textColor={0,0,0},
          textString="     %label     ")}));
end M330_50A;
