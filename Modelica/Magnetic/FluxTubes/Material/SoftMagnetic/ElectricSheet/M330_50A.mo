within Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.ElectricSheet;
record M330_50A "M330-50A (1.0809) @ 50Hz"
  extends FluxTubes.Material.SoftMagnetic.BaseData(
    mu_i=500,
    B_myMax=0.7,
    c_a=24000,
    c_b=9.38,
    n=9.6);
  annotation (Documentation(info="<html>
<p>
Please refer to the description of  the enclosing package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.SoftMagnetic\">SoftMagnetic</a> for a description of all soft magnetic material characteristics of this package.
</p>
<p>
Sample: complete core after machining and packet assembling<br>
</p>
</html>"));
end M330_50A;
