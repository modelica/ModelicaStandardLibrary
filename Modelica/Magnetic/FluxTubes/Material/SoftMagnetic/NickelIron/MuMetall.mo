within Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.NickelIron;
record MuMetall "MUMETALL (77% NiFe)"
  extends FluxTubes.Material.SoftMagnetic.BaseData(
    mu_i=27300,
    B_myMax=0.46,
    c_a=1037500,
    c_b=3.67,
    n=10);
  annotation (Documentation(info="<html>
<p>
Please refer to the description of  the enclosing package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.SoftMagnetic\">SoftMagnetic</a> for a description of all soft magnetic material characteristics of this package.
</p>
<p>
Source of B(H) characteristics:
</p>
<ul>
<li><em>Boll, R.</em>: Weichmagnetische Werkstoffe: Einf&uuml;hrung in den Magnetismus, VAC-Werkstoffe und ihre Anwendungen. 4th ed. Berlin, M&uuml;nchen: Siemens Aktiengesellschaft 1990</li>
</ul>
</html>"));
end MuMetall;
