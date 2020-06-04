within Modelica.Magnetic.QuasiStatic.FluxTubes.Shapes.FixedShape;
model HollowCylinderAxialFlux
"(Hollow) cylinder with axial flux of fixed shape and linear material characteristics"

  extends BaseClasses.FixedShape;
  extends Modelica.Magnetic.QuasiStatic.FluxTubes.Icons.HollowCylinderAxialFlux;

  parameter SI.Length l=0.01 "Axial length (in direction of flux)"
    annotation (Dialog(group="Fixed geometry", groupImage=
          "modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/HollowCylinderAxialFlux_qs.png"));
  parameter SI.Radius r_i=0
  "Inner radius of hollow cylinder (zero for cylinder)"
    annotation (Dialog(group="Fixed geometry"));
  parameter SI.Radius r_o=0.01 "Outer radius of (hollow) cylinder"
    annotation (Dialog(group="Fixed geometry"));
  parameter SI.Angle alpha=2*Modelica.Constants.pi
  "Central angle";
equation
  A = pi*(r_o^2 - r_i^2)*alpha/(2*Modelica.Constants.pi);
  G_m = (mu_0*mu_r*A)/l;

  annotation (Documentation(info="<html>
<p>The axial cylinder models is characterized by the outer diameter, <img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/r_o.png\"/>, the inner diameter, <img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/r_i.png\"/>, length, <img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/l.png\"/>. The magnetic reluctance is determined by:</p>
<div><img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/R_m_cuboid.png\"/></div>
<p>The area of cross section yields:</p>
<div><img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/A_axial.png\"/></div>
<div><img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/HollowCylinderAxialFlux_qs.png\"/></div>
<p>A hollow cylinder is depicted in the above figure left for <img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/alpha2pi.png\"/>. A solid cylindric flux tube an be considered by setting the inner radius, <img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/r_i.png\"/>, equal to zero.</p>
<p>A circular sector of the area of cross section with central angle <img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/alpha.png\"/> is depicted in the above figure right.</p>
</html>"));
end HollowCylinderAxialFlux;
