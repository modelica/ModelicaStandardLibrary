within Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.ElectricSheet;
record M350_50A "M350-50A (1.0810) @ 50Hz"
  extends FluxTubes.Material.SoftMagnetic.BaseData(
    mu_i=1210,
    B_myMax=1.16,
    c_a=24630,
    c_b=2.44,
    n=14);
  annotation (Documentation(info="<html>
<p>
Please refer to the description of  the enclosing package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.SoftMagnetic\">SoftMagnetic</a> for a description of all soft magnetic material characteristics of this package.
</p>
<p>
Sample: sheet strip<br>
Measurement: Epstein frame
</p>
</html>"));
end M350_50A;
