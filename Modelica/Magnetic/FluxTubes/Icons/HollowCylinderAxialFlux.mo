within Modelica.Magnetic.FluxTubes.Icons;
partial model HollowCylinderAxialFlux "Icon for cylinder with axial flux"
  annotation (Icon(graphics={
        Ellipse(
          extent={{-70,30},{-50,-30}},
          lineColor={255,128,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-60,30},{60,-30}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-150,50},{150,90}},
          textString="%name",
          textColor={0,0,255}),
        Ellipse(
          extent={{50,30},{70,-30}},
          lineColor={255,128,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{56,10},{64,-10}},
          lineColor={255,128,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-60,30},{60,30}}, color={255,128,0}),
        Line(points={{-60,-30},{60,-30}}, color={255,128,0}),
        Line(points={{-70,0},{-100,0}}, color={255,128,0}),
        Line(points={{100,0},{60,0}},   color={255,128,0})}));
end HollowCylinderAxialFlux;
