within Modelica.Magnetic.FluxTubes.Shapes.FixedShape;
model HollowCylinderAxialFlux
  "(Hollow) cylinder with axial flux; fixed shape; linear or non-linear material characteristics"

  extends BaseClasses.FixedShape;
  extends Modelica.Magnetic.FluxTubes.Icons.HollowCylinderAxialFlux;

  parameter SI.Length l=0.01 "Axial length (in direction of flux)"
    annotation (Dialog(group="Fixed geometry", groupImage=
          "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/HollowCylinderAxialFlux.png"));
  parameter SI.Radius r_i=0
    "Inner radius of hollow cylinder (zero for cylinder)"
    annotation (Dialog(group="Fixed geometry"));
  parameter SI.Radius r_o=0.01 "Outer radius of (hollow) cylinder"
    annotation (Dialog(group="Fixed geometry"));

equation
  A = pi*(r_o^2 - r_i^2);
  G_m = (mu_0*mu_r*A)/l;

  annotation (defaultComponentName="cylinder", Documentation(info="<html>
<p>
Please refer to the enclosing sub-package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.FixedShape\">FixedShape</a> for a description of all elements of this package and to <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Ro41]</a> for derivation and/or coefficients of the equation for permeance G_m.
</p>

<p>
Set the inner radius r_i=0 for modelling of a solid cylindric flux tube.
</p>
</html>"),
    Icon(graphics={
        Text(
          extent={{-150,50},{150,90}},
          textString="%name",
          textColor={0,0,255})}));
end HollowCylinderAxialFlux;
