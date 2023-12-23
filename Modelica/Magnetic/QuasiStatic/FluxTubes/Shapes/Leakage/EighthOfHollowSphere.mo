within Modelica.Magnetic.QuasiStatic.FluxTubes.Shapes.Leakage;
model EighthOfHollowSphere
"Leakage flux through one edge and the opposite plane of an eighth of a hollow sphere"

  extends BaseClasses.Leakage;

  parameter SI.Length t(start=0.01) "Thickness of spherical shell"
    annotation (Dialog(group="Parameters", groupImage=
          "modelica:/Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/Leakage/EighthOfHollowSphere.png"));

equation
  G_m = mu_0*0.5*t;

  annotation (Documentation(info="<html>
<p>
In
<a href=\"modelica:/Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Ro41]</a>
the equations for determining the reluctance
<img src=\"modelica:/Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/R_m.png\">
are summarized. As an alternative to the geometry based data a
<a href=\"modelica:/Modelica.Magnetic.QuasiStatic.FluxTubes.Basic.LeakageWithCoefficient\">generic leakage</a> model is provided in this library.
</p></html>"));
end EighthOfHollowSphere;
