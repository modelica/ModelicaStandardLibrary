within Modelica.Magnetic.FluxTubes.Material.HardMagnetic;
record Sm2Co17 "Sm2Co17 sintered, exemplary values"
  extends FluxTubes.Material.HardMagnetic.BaseData(
    H_cBRef=750000,
    B_rRef=1.02,
    T_ref=20 + 273.15,
    alpha_Br=-0.0003);
  annotation (Documentation(info="<html>
<p>
Please refer to the description of  the enclosing package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.HardMagnetic\">HardMagnetic</a> for a description of all permanent magnetic material characteristics of this package.
</p>
</html>"));
end Sm2Co17;
