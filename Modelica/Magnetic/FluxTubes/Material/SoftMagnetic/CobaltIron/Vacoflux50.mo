within Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.CobaltIron;
record Vacoflux50 "Vacoflux 50 (50% CoFe)"
  extends FluxTubes.Material.SoftMagnetic.BaseData(
    mu_i=3850,
    B_myMax=1.75,
    c_a=11790,
    c_b=2.63,
    n=15.02);
  annotation (Documentation(info="<html>
<p>
Please refer to the description of  the enclosing package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.SoftMagnetic\">SoftMagnetic</a> for a description of all soft magnetic material characteristics of this package.
</p>
<p>
Source of B(H) characteristics: VACUUMSCHMELZE GmbH &amp; Co. KG, Germany
</p>
</html>"));
end Vacoflux50;
