within Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.ElectricSheet;
record M530_50A "M530-50A (1.0813) @ 50Hz"
  extends FluxTubes.Material.SoftMagnetic.BaseData(
    mu_i=2120,
    B_myMax=1.25,
    c_a=12400,
    c_b=1.6,
    n=13.5);
  annotation (Documentation(info="<html>
<p>
Please refer to the description of  the enclosing package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.SoftMagnetic\">SoftMagnetic</a> for a description of all soft magnetic material characteristics of this package.
</p>
<p>
Sample: sheet strip<br>
Measurement: Epstein frame
</p>
</html>"));
end M530_50A;
