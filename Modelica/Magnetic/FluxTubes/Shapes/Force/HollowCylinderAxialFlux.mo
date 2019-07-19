within Modelica.Magnetic.FluxTubes.Shapes.Force;
model HollowCylinderAxialFlux
  "(Hollow) cylinder with axial flux; constant permeability"

  extends BaseClasses.Force;

  SI.Length l=s "Axial length (in direction of flux)" annotation (Dialog(
        group="Variable geometry", groupImage=
          "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/HollowCylinderAxialFlux.png"));
  parameter SI.Radius r_i=0 "Inner radius of (hollow) cylinder";
  parameter SI.Radius r_o=0.01 "Outer radius of (hollow) cylinder";

  SI.MagneticFluxDensity B "Homogeneous flux density";

protected
  parameter SI.Area A=pi*(r_o^2 - r_i^2)
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
end HollowCylinderAxialFlux;
