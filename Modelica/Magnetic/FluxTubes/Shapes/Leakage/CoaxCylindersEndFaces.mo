within Modelica.Magnetic.FluxTubes.Shapes.Leakage;
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

  annotation (defaultComponentName="leakage", Documentation(info="<html>
<p>
Please refer to the enclosing sub-package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.Leakage\">Leakage</a> for a description of all elements of this package and to <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Ro41]</a> for derivation and/or coefficients of the equation for permeance G_m.
</p>
</html>"));
end CoaxCylindersEndFaces;
