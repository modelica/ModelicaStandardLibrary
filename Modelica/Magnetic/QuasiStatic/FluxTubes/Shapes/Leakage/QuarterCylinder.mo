within Modelica.Magnetic.QuasiStatic.FluxTubes.Shapes.Leakage;
model QuarterCylinder
"Leakage flux from one edge to the opposite plane through a quarter cylinder"

  extends BaseClasses.Leakage;

  parameter SI.Length l=0.1
  "Axial length orthogonal to flux (=2*pi*r for cylindrical pole and r>>distance between edge and plane)"
    annotation (Dialog(group="Parameters", groupImage=
          "modelica:/Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/Leakage/QuarterCylinder.png"));
equation
  G_m = mu_0*0.52*l;

  annotation (Documentation(info="<html>
<p>
In
<a href=\"modelica:/Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Ro41]</a>
the equations for determining the reluctance
<img src=\"modelica:/Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/R_m.png\">
are summarized. As an alternative to the geometry based data a
<a href=\"modelica:/Modelica.Magnetic.QuasiStatic.FluxTubes.Basic.LeakageWithCoefficient\">generic leakage</a> model is provided in this library.
</p></html>"));
end QuarterCylinder;
