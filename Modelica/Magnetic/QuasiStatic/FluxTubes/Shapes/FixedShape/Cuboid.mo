within Modelica.Magnetic.QuasiStatic.FluxTubes.Shapes.FixedShape;
model Cuboid
"Flux tube with rectangular cross-section of fixed shape and linear material characteristics"

  extends BaseClasses.FixedShape;
  extends Modelica.Magnetic.QuasiStatic.FluxTubes.Icons.Cuboid;

  parameter SI.Length l=0.01 "Length in direction of flux" annotation (
      Dialog(group="Fixed geometry", groupImage=
          "modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/CuboidParallelFlux_qs.png"));
  parameter SI.Length a=0.01 "Width of rectangular cross-section"
    annotation (Dialog(group="Fixed geometry"));
  parameter SI.Length b=0.01 "Height of rectangular cross-section"
    annotation (Dialog(group="Fixed geometry"));

equation
  A = a*b;
  G_m = (mu_0*mu_r*A)/l;

  annotation (Documentation(info="<html>
<p>
The cuboid models the reluctance with rectangular dimensions <code>a</code> and <code>b</code>, and length, <code>l</code>
the magnetic reluctance by:</p>
<dl><dd>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/R_m_cuboid.png\">
</dd></dl>

<p>The area of cross section is determined by:</p>
<dl><dd>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/A_cuboid.png\">
</dd></dl>

<div>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/CuboidParallelFlux_qs.png\">
</div></html>"));
end Cuboid;
