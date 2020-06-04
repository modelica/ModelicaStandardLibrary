within Modelica.Magnetic.QuasiStatic.FluxTubes.Shapes.FixedShape;
model GenericFluxTube
"Flux tube with fixed cross-section, fixed length and linear material characteristics"

  extends BaseClasses.FixedShape;
  extends Modelica.Magnetic.QuasiStatic.FluxTubes.Icons.Reluctance;

  parameter SI.Length l=0.01 "Length in direction of flux"
    annotation(Dialog(group="Fixed geometry", groupImage=
      "modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/GenericFluxTube_qs.png"));
  parameter SI.CrossSection area=0.0001 "Area of cross section"
    annotation (Dialog(group="Fixed geometry"));
equation
  A=area;
  G_m = (mu_0*mu_r*A)/l;

  annotation (Documentation(info="<html>
<p>
The generic flux tube models the reluctance with constant
<code>area</code> of cross section, and length, <code>l</code>
the magnetic reluctance by:</p>
<dl><dd>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/R_m_generic.png\">,
</dd></dl>

<div>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/GenericFluxTube_qs.png\">
</div></html>",
    revisions="<html>
<h5>Version 3.2.2, 2014-01-15 (Christian&nbsp;Kral)</h5>
<ul>
<li>Added GenericFluxTube</li>
</ul>

</html>"));
end GenericFluxTube;
