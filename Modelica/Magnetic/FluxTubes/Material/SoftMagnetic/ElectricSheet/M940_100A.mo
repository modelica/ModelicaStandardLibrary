within Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.ElectricSheet;
record M940_100A "M940-100A @ 50Hz"
  extends FluxTubes.Material.SoftMagnetic.BaseData(
    mu_i=680,
    B_myMax=1.26,
    c_a=17760,
    c_b=3.13,
    n=13.9);
  annotation (Documentation(info="<html>
<p>
Please refer to the description of  the enclosing package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.SoftMagnetic\">SoftMagnetic</a> for a description of all soft magnetic material characteristics of this package.
</p>
<p>
Sample: sheet strip<br>
Measurement: Epstein frame
</p>
</html>"));
end M940_100A;
