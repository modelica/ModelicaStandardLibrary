within Modelica.Magnetic.QuasiStatic.FluxTubes.Shapes.Leakage;
model EighthOfSphere
"Leakage flux through one edge and the opposite plane of an eighth of a sphere"

  extends BaseClasses.Leakage;

  parameter SI.Radius r=0.01 "Radius of eighth of sphere"
    annotation (Dialog(group="Parameters", groupImage=
          "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/Leakage/EighthOfSphere.png"));

equation
  G_m = mu_0*0.308*r;

  annotation (Documentation(info="<html>
<p>
In
<a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Ro41]</a>
the equations for determining the reluctance
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/R_m.png\">
are summarized. As an alternative to the geometry based data a
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FluxTubes.Basic.LeakageWithCoefficient\">generic leakage</a> model is provided in this library.
</p></html>"));
end EighthOfSphere;
