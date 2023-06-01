within Modelica.Electrical;
package Batteries "Simple battery models"
  extends Modelica.Icons.Package;

  annotation (Icon(graphics={
        Ellipse(extent={{-10,50},{10,-50}},  lineColor={95,95,95},
          fillColor={215,215,215},
          fillPattern=FillPattern.Sphere,
          origin={0,-80},
          rotation=90),
        Rectangle(extent={{-70,50},{70,-50}}, lineColor={95,95,95},
          fillColor={215,215,215},
          fillPattern=FillPattern.HorizontalCylinder,
          origin={0,-10},
          rotation=90),
        Ellipse(extent={{-10,50},{10,-50}},lineColor={95,95,95},
          fillColor={215,215,215},
          fillPattern=FillPattern.Sphere,
          origin={0,60},
          rotation=90),
        Ellipse(extent={{-4,20},{4,-20}},    lineColor={95,95,95},
          fillColor={215,215,215},
          fillPattern=FillPattern.Sphere,
          origin={0,60},
          rotation=90),
        Rectangle(extent={{-13,20},{13,-20}}, lineColor={95,95,95},
          fillColor={215,215,215},
          fillPattern=FillPattern.HorizontalCylinder,
          origin={0,73},
          rotation=90),
        Ellipse(extent={{-4,20},{4,-20}},    lineColor={95,95,95},
          fillColor={215,215,215},
          fillPattern=FillPattern.Sphere,
          origin={0,86},
          rotation=90)}), Documentation(info="<html>
<p>Library offering simple battery models</p>
</html>"));
end Batteries;
