within Modelica.Magnetic.FluxTubes.Shapes.Force;
model LeakageAroundPoles
  "Leakage flux tube around cylindrical or prismatic poles"

  extends BaseClasses.Force;
  SI.Length l=s "Axial length (in direction of flux)" annotation (Dialog(
        group="Variable geometry", groupImage=
          "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/LeakageAroundPoles.png"));
  parameter SI.Length w=0.1
    "Width orthogonal to flux; mean circumference of flux tube in case of cylindrical poles";
  parameter SI.Radius r=0.01 "Radius of leakage field";

equation
  //adapted from [Ka08], but corrected
  //(in [Ka08] equation accidentally swapped with that of a similar element)
  G_m = mu_0*w/pi*Modelica.Math.log(1 + pi*r/l);

  //derivative at full length:
  //  dGmBydx = mu_0 * w /pi * 1/(1 + pi * r/l) * (-1)*pi*r/l^2  * dlBydx;
  //simplified:
  dGmBydx = -mu_0*w*r*dlBydx/(l^2*(1 + pi*r/l));

  annotation (defaultComponentName="force", Documentation(info="<html>
<p>
Please refer to the description of  the enclosing sub-package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.Force\">Force</a> for a description of all elements of this package.
</p>

<p>
Leakage flux around a prismatic or cylindric air gap between to poles can be described with this model. Due to its constant radius of the leakage field r, the model is rather simple. Whereas in reality the leakage radius is approximately constant for air gap lengths l greater than this radius, it decreases with air gap lengths less than the leakage radius. This decrease for small air gaps is neglected here, since the influence of the leakage flux tube compared to that of the enclosed main air gap (connected in parallel) decreases for decreasing air gap length l.
</p>

<p>
Note that in <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Ka08]</a> the equation for G_m is accidentally swapped with that of a similar element.
</p>
</html>"));
end LeakageAroundPoles;
