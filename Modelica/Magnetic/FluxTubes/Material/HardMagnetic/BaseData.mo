within Modelica.Magnetic.FluxTubes.Material.HardMagnetic;
record BaseData "Record for permanent magnetic material data"
  extends Modelica.Icons.Record;

  parameter SI.MagneticFieldStrength H_cBRef=1
    "Coercivity at reference temperature";
  parameter SI.MagneticFluxDensity B_rRef=1
    "Remanence at reference temperature";
  parameter SI.Temperature T_ref=293.15 "Reference temperature";
  parameter SI.LinearTemperatureCoefficient alpha_Br=0
    "Temperature coefficient of remanence at reference temperature";

  parameter SI.Temperature T_op=293.15 "Operating temperature";

  final parameter SI.MagneticFluxDensity B_r=B_rRef*(1 + alpha_Br*(T_op
       - T_ref)) "Remanence at operating temperature";
  final parameter SI.MagneticFieldStrength H_cB=H_cBRef*(1 + alpha_Br*(
      T_op - T_ref)) "Coercivity at operating temperature";
  final parameter SI.RelativePermeability mu_r=B_r/(mu_0*H_cB)
    "Relative permeability";

  annotation (Documentation(info="<html>
<p>
Please refer to the description of  the enclosing package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.HardMagnetic\">HardMagnetic</a> for a description of all permanent magnetic material characteristics of this package.
</p>
</html>"));
end BaseData;
