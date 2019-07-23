within Modelica.Magnetic.FluxTubes.Shapes.Force;
model CuboidOrthogonalFlux
  "Cuboid with flux orthogonal to direction of motion; constant permeability"

  extends BaseClasses.Force;

  SI.Length l=s "Length in direction of motion (orthogonal to flux)"
    annotation (Dialog(group="Variable geometry", groupImage=
          "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/CuboidOrthogonalFlux.png"));
  parameter SI.Length a=0.01 "Width of rectangular cross-section";
  parameter SI.Length b=0.01
    "Height of rectangular cross-section (in flux direction)";

  SI.MagneticFluxDensity B "Homogeneous flux density";

protected
  SI.Area A "Cross-sectional area orthogonal to direction of flux";

equation
  A = a*l;
  G_m = mu_0*mu_r*A/b;

  dGmBydx = mu_0*mu_r*a/b*dlBydx;

  B = Phi/A;

  annotation (defaultComponentName="force", Documentation(info="<html>
<p>
Please refer to the enclosing sub-package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.Force\">Force</a> for a description of all elements of this package and to <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Ro41]</a> for derivation and/or coefficients of the equation for permeance G_m.
</p>
</html>"));
end CuboidOrthogonalFlux;
