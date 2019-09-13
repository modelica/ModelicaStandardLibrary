within Modelica.Magnetic.FluxTubes.Shapes.Leakage;
model HalfHollowCylinder
  "Leakage flux in circumferential direction through a half hollow cylinder"

  extends BaseClasses.Leakage;

  parameter SI.Length l=0.1
    "Axial length orthogonal to flux (=2*pi*r for cylindrical pole and r>>r_i)"
    annotation (Dialog(group="Parameters", groupImage=
          "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/Leakage/HalfHollowCylinder.png"));
  parameter Real ratio(start=1) "Constant ratio t/r_i";

equation
  G_m = mu_0*l*Modelica.Math.log(1 + ratio)/pi;

  annotation (defaultComponentName="leakage", Documentation(info="<html>
<p>
Please refer to the enclosing sub-package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.Leakage\">Leakage</a> for a description of all elements of this package and to <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Ro41]</a> for derivation and/or coefficients of the equation for permeance G_m.
</p>
</html>"));
end HalfHollowCylinder;
