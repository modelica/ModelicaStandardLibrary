within Modelica.Electrical.Batteries;
package BatteryStacksWithSensors "Battery cells and stacks with sensors"
  extends Modelica.Icons.Package;

  annotation (Documentation(info="<html>
<p>Cells and stacks with measurement</p>
</html>"),
         Icon(graphics={
        Rectangle(extent={{-13,20},{13,-20}}, lineColor={95,95,95},
          fillColor={215,215,215},
          fillPattern=FillPattern.HorizontalCylinder,
          origin={0,73},
          rotation=90),
        Rectangle(extent={{-70,50},{70,-50}}, lineColor={95,95,95},
          fillColor={215,215,215},
          fillPattern=FillPattern.HorizontalCylinder,
          origin={-7.10543e-15,-10},
          rotation=90),
        Polygon(
          points={{-40,25},{40,25},{50,15},{40,-20},{30,-25},{-30,-25},{-40,-20},{-50,15}},
          fillColor={255,204,51},
          fillPattern=FillPattern.Solid,
          smooth=Smooth.Bezier),
        Ellipse(
          extent={{-22.5,7.5},{-17.5,12.5}},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{17.5,12.5},{22.5,7.5}},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-2.5,-7.5},{2.5,-12.5}},
          fillPattern=FillPattern.Solid)}));
end BatteryStacksWithSensors;
