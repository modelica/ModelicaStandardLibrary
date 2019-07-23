within Modelica.Magnetic.QuasiStatic.FluxTubes.Shapes.Leakage;
model CoaxCylindersEndFaces
"Leakage flux between the end planes of a inner solid cylinder and a coaxial outer hollow cylinder"

  extends BaseClasses.Leakage;

  parameter SI.Radius r_0=10e-3 "Radius of inner solid cylinder"
    annotation (Dialog(group="Parameters", groupImage=
          "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/Leakage/CoaxCylindersEndFaces.png"));
  parameter SI.Radius r_1=17e-3 "Inner radius of outer hollow cylinder";
  parameter SI.Radius r_2=20e-3 "Outer radius of outer hollow cylinder";

  final parameter SI.Distance l_g=r_1 - r_0
  "Radial gap length between both cylinders";
  final parameter SI.Length t=r_2 - r_1
  "Radial thickness of outer hollow cylinder";

equation
  // [Ro41], p. 139, Eq. (22)
  G_m = if t <= r_0 then 2*mu_0*(r_0 + l_g/2)*Modelica.Math.log(1 + 2*t/
    l_g) else 2*mu_0*(r_0 + l_g/2)*Modelica.Math.log(1 + 2*r_0/l_g);

  annotation (Documentation(info="<html>
<p>
In
<a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Ro41]</a>
the equations for determining the reluctance
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/R_m.png\">
are summarized. As an alternative to the geometry based data a
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FluxTubes.Basic.LeakageWithCoefficient\">generic leakage</a> model is provided in this library.
</p></html>"));
end CoaxCylindersEndFaces;
