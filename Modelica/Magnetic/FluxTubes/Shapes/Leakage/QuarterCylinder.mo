within Modelica.Magnetic.FluxTubes.Shapes.Leakage;
model QuarterCylinder
  "Leakage flux from one edge to the opposite plane through a quarter cylinder"

  extends BaseClasses.Leakage;

  parameter SI.Length l=0.1
    "Axial length orthogonal to flux (=2*pi*r for cylindrical pole and r>>distance between edge and plane)"
    annotation (Dialog(group="Parameters", groupImage=
          "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/Leakage/QuarterCylinder.png"));
equation
  G_m = mu_0*0.52*l;

  annotation (defaultComponentName="leakage", Documentation(info="<html>
<p>
Please refer to the enclosing sub-package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.Leakage\">Leakage</a> for a description of all elements of this package and to <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Ro41]</a> for derivation and/or coefficients of the equation for permeance G_m.
</p>
</html>"));
end QuarterCylinder;
