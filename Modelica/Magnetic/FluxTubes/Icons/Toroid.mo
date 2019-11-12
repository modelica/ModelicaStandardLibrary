within Modelica.Magnetic.FluxTubes.Icons;
partial model Toroid "Icon for toroid"
  annotation (Icon(graphics={
        Text(
          extent={{-150,50},{150,90}},
          textString="%name",
          textColor={0,0,255}),
        Ellipse(
          extent={{-70,10},{-50,-10}},
          lineColor={255,128,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{50,10},{70,-10}},
          lineColor={255,128,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Line(points={{100,0},{60,0}},   color={255,128,0}),
        Line(points={{-60,0},{-100,0}}, color={255,128,0}),
        Ellipse(
          extent={{-70,36},{70,-44}},
          lineColor={255,128,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.None,
          startAngle=195,
          endAngle=345,
          closure=EllipseClosure.None),
        Ellipse(
          extent={{-60,14},{60,-68}},
          lineColor={255,128,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.None,
          startAngle=210,
          endAngle=330,
          closure=EllipseClosure.None)}));
end Toroid;
