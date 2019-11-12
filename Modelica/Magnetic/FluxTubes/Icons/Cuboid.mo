within Modelica.Magnetic.FluxTubes.Icons;
partial model Cuboid "Icon for cuboid"
  annotation (Icon(graphics={
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
        Line(points={{100,0},{50,0}},   color={255,128,0})}));
end Cuboid;
