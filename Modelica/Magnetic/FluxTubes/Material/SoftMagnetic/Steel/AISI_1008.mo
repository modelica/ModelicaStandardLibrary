within Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.Steel;
record AISI_1008 "AISI 1008 (1.0204)"
  extends FluxTubes.Material.SoftMagnetic.BaseData(
    mu_i=200,
    B_myMax=1.17,
    c_a=8100,
    c_b=2.59,
    n=10);
  annotation (Documentation(info="<html>
<p>
Please refer to the description of  the enclosing package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.SoftMagnetic\">SoftMagnetic</a> for a description of all soft magnetic material characteristics of this package.
</p>
</html>"));
end AISI_1008;
