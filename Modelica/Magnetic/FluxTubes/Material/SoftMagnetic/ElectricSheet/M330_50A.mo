within Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.ElectricSheet;
record M330_50A "M330-50A (1.0809) @ 50Hz complete core"
  extends FluxTubes.Material.SoftMagnetic.BaseData(
    label="M330-50A",
    mu_i=500,
    B_myMax=0.7,
    c_a=24000,
    c_b=9.38,
    n=9.6);
  annotation (defaultComponentPrefixes="parameter",
    preferredView="info",
    Documentation(info="<html>
<p>
Please refer to the description of  the enclosing package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.SoftMagnetic\">SoftMagnetic</a> for a description of all soft magnetic material characteristics of this package.
</p>
<p>
Sample: complete core after machining and packet assembling<br>
</p>
<h4>Note</h4>
<p>
This material has been measured under different conditions (complete core / machined and packeted) as the other electric sheets (sheet strip / Epstein frame).
Direct comparison with other material is therefore not possible.
</p>
</html>"));
end M330_50A;
