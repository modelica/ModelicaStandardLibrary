within Modelica.Magnetic.FluxTubes.Material.HardMagnetic;
record PlasticHardFerrite "Plastic-bonded hard ferrite, exemplary values"
  extends FluxTubes.Material.HardMagnetic.BaseData(
    H_cBRef=130000,
    B_rRef=0.21,
    T_ref=20 + 273.15,
    alpha_Br=-0.002);
  annotation (Documentation(info="<html>
<p>
Please refer to the description of  the enclosing package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.HardMagnetic\">HardMagnetic</a> for a description of all permanent magnetic material characteristics of this package.
</p>
</html>"));
end PlasticHardFerrite;
