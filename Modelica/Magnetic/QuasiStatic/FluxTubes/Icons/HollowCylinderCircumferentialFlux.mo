within Modelica.Magnetic.QuasiStatic.FluxTubes.Icons;
partial model HollowCylinderCircumferentialFlux "Icon for cylinder with circumferential flux"
  annotation (Icon(graphics={
        Text(
          extent={{-150,50},{150,90}},
          textString="%name",
          textColor={0,0,255}),
        Line(points={{-60,0},{-100,0}}, color={255,170,85}),
        Line(points={{100,0},{60,0}},   color={255,170,85}),
        Polygon(
          points={{-40,20},{-80,-20},{-60,-20},{-20,20},{-40,20}},
          lineColor={255,170,85},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-60,0},{20,-40}},
          lineColor={255,170,85},
          startAngle=0,
          endAngle=180,
          closure=EllipseClosure.None),
        Ellipse(
          extent={{-80,14},{40,-54}},
          lineColor={255,170,85},
          startAngle=0,
          endAngle=180,
          closure=EllipseClosure.None),
        Polygon(
          points={{60,20},{20,-20},{40,-20},{80,20},{60,20}},
          lineColor={255,170,85},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-20,40},{60,0}},
          lineColor={255,170,85},
          startAngle=52,
          endAngle=180,
          closure=EllipseClosure.None),
        Line(points={{40,-40},{2.22045e-16,1.35963e-32}},
                                        color={255,170,85},
          origin={36,-32},
          rotation=90),
        Line(points={{76,8},{78,12},{80,20}},  color={255,170,85})}));
end HollowCylinderCircumferentialFlux;
