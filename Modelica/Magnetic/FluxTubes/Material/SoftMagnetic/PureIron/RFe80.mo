within Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.PureIron;
record RFe80 "Hyperm 0 (RFe80)"
  extends FluxTubes.Material.SoftMagnetic.BaseData(
    mu_i=123,
    B_myMax=1.27,
    c_a=44410,
    c_b=6.4,
    n=10);
  annotation (Documentation(info="<html>
<p>
Please refer to the description of  the enclosing package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.SoftMagnetic\">SoftMagnetic</a> for a description of all soft magnetic material characteristics of this package.
</p>
<p>
Source of B(H) characteristics: Product catalogue <em>Magnequench</em>, 2000
</p>
</html>"));
end RFe80;
