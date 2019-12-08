within Modelica.Magnetic.FluxTubes.Shapes.FixedShape;
model GenericFluxTube
  "Flux tube with fixed cross-section and length; linear or non-linear material characteristics"

  extends BaseClasses.FixedShape;
  extends Modelica.Magnetic.FluxTubes.Icons.Reluctance;

  parameter SI.Length l=0.01 "Length in direction of flux"
    annotation(Dialog(group="Fixed geometry", groupImage=
      "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/GenericFluxTube.png"));
  parameter SI.CrossSection area=0.0001 "Area of cross section"
    annotation (Dialog(group="Fixed geometry"));
equation
  A=area;
  G_m = (mu_0*mu_r*A)/l;

  annotation (defaultComponentName="generic", Documentation(info="<html>
<p>
Please refer to the enclosing sub-package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.FixedShape\">FixedShape</a> for a description of all elements of this package and to <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Ro41]</a> for derivation and/or coefficients of the equation for permeance G_m.
</p>
</html>",
    revisions="<html>
<h5>Version 3.2.2, 2014-01-15 (Christian&nbsp;Kral)</h5>
<ul>
<li>Added GenericFluxTube</li>
</ul>

</html>"));
end GenericFluxTube;
