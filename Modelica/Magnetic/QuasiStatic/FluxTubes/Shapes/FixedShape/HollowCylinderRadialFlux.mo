within Modelica.Magnetic.QuasiStatic.FluxTubes.Shapes.FixedShape;
model HollowCylinderRadialFlux
"Hollow cylinder with radial flux of fixed shape and linear material characteristics"

  extends BaseClasses.FixedShape;
  extends Modelica.Magnetic.QuasiStatic.FluxTubes.Icons.HollowCylinderRadialFlux;

  parameter SI.Length l=0.01 "Width (orthogonal to flux direction)"
                                           annotation (Dialog(group=
          "Fixed geometry", groupImage=
          "modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/HollowCylinderRadialFlux_qs.png"));
  parameter SI.Radius r_i=0.01 "Inner radius of hollow cylinder"
    annotation (Dialog(group="Fixed geometry"));
  parameter SI.Radius r_o=0.02 "Outer radius of hollow cylinder"
    annotation (Dialog(group="Fixed geometry"));
  parameter SI.Angle alpha=2*Modelica.Constants.pi
  "Central angle";
equation
  A = l*pi*(r_o + r_i);
  // Area at arithmetic mean radius for calculation of average flux density
  G_m = 2*pi*mu_0*mu_r*l/Modelica.Math.log(r_o/r_i)*alpha/(2*Modelica.Constants.pi);

  annotation (Documentation(info="<html>
<p>The radial cylinder model is characterized by the outer diameter, <img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/r_o.png\"/>, the inner diameter, <img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/r_i.png\"/>, length, <img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/l.png\"/>, and the angle <img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/alpha.png\"/>. The magnetic reluctance is determined by:</p>
<div><img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/R_m_radial.png\"/></div>
<p>In this model the magnetic flux and the magnetic potential difference, respectively, are radially oriented.</p>
<div><img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/HollowCylinderRadialFlux_qs.png\"/></div>
<p>The above figure left shows a radial flux cylinder with <img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/alpha2pi.png\"/>. The figure on the right indicates the central angle <img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/alpha.png\"/> in case a cylinder section shall be considered.</p>
</html>"));
end HollowCylinderRadialFlux;
