within Modelica.Magnetic.FluxTubes.Material.HardMagnetic;
record PlasticSmCo "Plastic-bonded Sm-Co, exemplary values"
  extends FluxTubes.Material.HardMagnetic.BaseData(
    H_cBRef=385000,
    B_rRef=0.57,
    T_ref=20 + 273.15,
    alpha_Br=-0.0004);
  annotation (Documentation(info="<html>
<p>
Please refer to the description of  the enclosing package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.HardMagnetic\">HardMagnetic</a> for a description of all permanent magnetic material characteristics of this package.
</p>
</html>"));
end PlasticSmCo;
