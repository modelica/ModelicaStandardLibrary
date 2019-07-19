within Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.Steel;
record AISI_12L14 "AISI 12L14 (1.0718)"
  extends FluxTubes.Material.SoftMagnetic.BaseData(
    mu_i=10,
    B_myMax=0.94,
    c_a=5900,
    c_b=4.19,
    n=6.4);
  annotation (Documentation(info="<html>
<p>
Please refer to the description of  the enclosing package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.SoftMagnetic\">SoftMagnetic</a> for a description of all soft magnetic material characteristics of this package.
</p>
</html>"));
end AISI_12L14;
