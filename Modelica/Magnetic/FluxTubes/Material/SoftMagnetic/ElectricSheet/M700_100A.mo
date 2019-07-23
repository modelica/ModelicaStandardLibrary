within Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.ElectricSheet;
record M700_100A "M700-100A (1.0826) @ 50Hz"
  extends FluxTubes.Material.SoftMagnetic.BaseData(
    mu_i=1120,
    B_myMax=1.2,
    c_a=20750,
    c_b=3.55,
    n=13.15);
  annotation (Documentation(info="<html>
<p>
Please refer to the description of  the enclosing package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.SoftMagnetic\">SoftMagnetic</a> for a description of all soft magnetic material characteristics of this package.
</p>
<p>
Sample: sheet strip<br>
Measurement: Epstein frame
</p>
</html>"));
end M700_100A;
