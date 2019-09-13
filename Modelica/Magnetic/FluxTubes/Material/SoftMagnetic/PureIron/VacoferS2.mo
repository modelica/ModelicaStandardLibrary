within Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.PureIron;
record VacoferS2 "VACOFER S2 (99.95% Fe)"
  extends FluxTubes.Material.SoftMagnetic.BaseData(
    mu_i=2666,
    B_myMax=1.15,
    c_a=187000,
    c_b=4.24,
    n=19);
  annotation (Documentation(info="<html>
<p>
Please refer to the description of  the enclosing package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.SoftMagnetic\">SoftMagnetic</a> for a description of all soft magnetic material characteristics of this package.
</p>
<dl>
<dt>Source of B(H) characteristics:</dt>
    <dd><p><em>Boll, R.</em>: Weichmagnetische Werkstoffe: Einf&uuml;hrung in den Magnetismus, VAC-Werkstoffe und ihre Anwendungen. 4th ed. Berlin, M&uuml;nchen: Siemens Aktiengesellschaft 1990</p>
    </dd>
</dl>
</html>"));
end VacoferS2;
