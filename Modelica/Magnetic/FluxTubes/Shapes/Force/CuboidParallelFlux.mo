within Modelica.Magnetic.FluxTubes.Shapes.Force;
model CuboidParallelFlux
  "Cuboid with flux in direction of motion, e.g., air gap with rectangular cross-section; constant permeability"

  extends BaseClasses.Force;

  SI.Length l=s "Axial length (in direction of flux)" annotation (Dialog(
        group="Variable geometry", groupImage=
          "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/CuboidParallelFlux.png"));
  parameter SI.Length a=0.01 "Width of rectangular cross-section";
  parameter SI.Length b=0.01 "Height of rectangular cross-section";

  SI.MagneticFluxDensity B "Homogeneous flux density";

protected
  parameter SI.Area A=a*b
    "Cross-sectional area orthogonal to direction of flux";

equation
  G_m = mu_0*mu_r*A/l;

  dGmBydx = -1*mu_0*mu_r*A/l^2*dlBydx;

  B = Phi/A;

  annotation (defaultComponentName="force", Documentation(info="<html>
<p>
Please refer to the enclosing sub-package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.Force\">Force</a> for a description of all elements of this package and to <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Ro41]</a> for derivation and/or coefficients of the equation for permeance G_m.
</p>
</html>"));
end CuboidParallelFlux;
