within Modelica.Magnetic.FluxTubes.Shapes.Force;
model HollowCylinderRadialFlux
  "Hollow cylinder with radial flux; constant permeability"

  extends BaseClasses.Force;

  SI.Length l=s "Axial length (orthogonal to direction of flux)"
    annotation (Dialog(group="Variable geometry", groupImage=
          "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/HollowCylinderRadialFlux.png"));
  parameter SI.Radius r_i=0.01 "Inner radius of hollow cylinder";
  parameter SI.Radius r_o=0.015 "Outer radius of hollow cylinder";

  SI.MagneticFluxDensity B_avg
    "Average flux density (at arithmetic mean radius)";

protected
  SI.Area A_avg
    "Average cross-sectional area orthogonal to direction of flux (at arithmetic mean radius)";

equation
  G_m = mu_0*mu_r*2*pi*l/Modelica.Math.log(r_o/r_i);

  dGmBydx = mu_0*mu_r*2*pi/Modelica.Math.log(r_o/r_i)*dlBydx;

  A_avg = pi*(r_i + r_o)*l;
  B_avg = Phi/A_avg;

  annotation (defaultComponentName="force", Documentation(info="<html>
<p>
Please refer to the enclosing sub-package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.Force\">Force</a> for a description of all elements of this package and to <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Ro41]</a> for derivation and/or coefficients of the equation for permeance G_m.
</p>
</html>"));
end HollowCylinderRadialFlux;
