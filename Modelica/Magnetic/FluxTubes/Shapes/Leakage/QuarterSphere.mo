within Modelica.Magnetic.FluxTubes.Shapes.Leakage;
model QuarterSphere
  "Leakage flux through the corners of a quarter sphere"

  extends BaseClasses.Leakage;

  parameter SI.Radius r=0.005 "Radius of quarter sphere"
    annotation (Dialog(group="Parameters", groupImage=
          "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/Leakage/QuarterSphere.png"));

equation
  G_m = mu_0*0.077*2*r;

  annotation (defaultComponentName="leakage", Documentation(info="<html>
<p>
Please refer to the enclosing sub-package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.Leakage\">Leakage</a> for a description of all elements of this package and to <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Ro41]</a> for derivation and/or coefficients of the equation for permeance G_m.
</p>
</html>"));
end QuarterSphere;
