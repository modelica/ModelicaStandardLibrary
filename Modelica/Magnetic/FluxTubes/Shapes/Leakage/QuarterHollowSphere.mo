within Modelica.Magnetic.FluxTubes.Shapes.Leakage;
model QuarterHollowSphere
  "Leakage flux through the edges of a quarter hollow sphere"

  extends BaseClasses.Leakage;

  parameter SI.Length t(start=0.01) "Thickness of spherical shell"
    annotation (Dialog(group="Parameters", groupImage=
          "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/Leakage/QuarterHollowSphere.png"));

equation
  G_m = mu_0*0.25*t;

  annotation (defaultComponentName="leakage", Documentation(info="<html>
<p>
Please refer to the enclosing sub-package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.Leakage\">Leakage</a> for a description of all elements of this package and to <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Ro41]</a> for derivation and/or coefficients of the equation for permeance G_m.
</p>
</html>"));
end QuarterHollowSphere;
