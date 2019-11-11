within Modelica.Magnetic.FluxTubes.Shapes.FixedShape;
model Cuboid
  "Flux tube with rectangular cross-section; fixed shape; linear or non-linear material characteristics"

  extends BaseClasses.FixedShape;

  parameter SI.Length l=0.01 "Length in direction of flux" annotation (
      Dialog(group="Fixed geometry", groupImage=
          "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/CuboidParallelFlux.png"));
  parameter SI.Length a=0.01 "Width of rectangular cross-section"
    annotation (Dialog(group="Fixed geometry"));
  parameter SI.Length b=0.01 "Height of rectangular cross-section"
    annotation (Dialog(group="Fixed geometry"));

equation
  A = a*b;
  G_m = (mu_0*mu_r*A)/l;

  annotation (Documentation(info="<html>
<p>
Please refer to the enclosing sub-package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.FixedShape\">FixedShape</a> for a description of all elements of this package and to <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Ro41]</a> for derivation and/or coefficients of the equation for permeance G_m.
</p>
</html>"), Icon(graphics={
        Text(
          extent={{-150,50},{150,90}},
          textString="%name",
          textColor={0,0,255}),
        Rectangle(
          extent={{-60,20},{40,-40}},
          lineColor={255,128,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-60,20},{-40,40},{60,40},{40,20},{-60,20}},
          lineColor={255,128,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{40,20},{60,40},{60,-20},{40,-40},{40,20}},
          lineColor={255,128,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Line(points={{-60,0},{-100,0}}, color={255,128,0}),
        Line(points={{90,0},{50,0}},    color={255,128,0})}));
end Cuboid;
