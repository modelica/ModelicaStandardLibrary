within Modelica.Magnetic.FluxTubes.Material.HysteresisEverettParameter;
record BaseData "Base Data Record"
  extends Modelica.Icons.Record;
  parameter SI.MagneticFieldStrength Hsat=100
    "Hysteresis region between -Hsat .. Hsat";
  parameter Real M(final unit="1")=0.95
    "Related to saturation value of magnetization";
  parameter Real r(final unit="1")=0.55
    "Proportion of the straight region in the vicinity of Hc";
  parameter Real q(final unit="m/A")=2.4e-1
    "Slope of the straight region in the vicinity of Hc";
  parameter Real p1(final unit="m/A")=1.2e-1 "Sharpness of major loop";
  parameter Real p2(final unit="m/A")=8e-1 "Sharpness of major loop";
  parameter SI.MagneticFieldStrength Hc=7.4 "Major loop coercivity";
  parameter Real K(final unit="1")=1
    "Slope in saturation region mu_0*K";
  parameter SI.Conductivity sigma = 1
    "Electrical conductivity of material";

  annotation (Documentation(info="<html>
<table cellspacing=\"0\" cellpadding=\"2\" border=\"0\">
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Material/HysteresisEverettParameter/hyst_BaseData.png\">
   </td>
  </tr>
</table>
</html>"));
end BaseData;
