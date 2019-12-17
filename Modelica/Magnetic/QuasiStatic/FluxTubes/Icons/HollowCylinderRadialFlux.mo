within Modelica.Magnetic.QuasiStatic.FluxTubes.Icons;
partial model HollowCylinderRadialFlux "Icon for cylinder with radial flux"
  annotation (Icon(graphics={
        Ellipse(
          extent={{-10,60},{10,-60}},
          lineColor={255,170,85},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          origin={0,-30},
          rotation=90),
        Text(
          extent={{-150,50},{150,90}},
          textString="%name",
          textColor={0,0,255}),
        Rectangle(
          extent={{-60,30},{60,-30}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Ellipse(
          extent={{-10,60},{10,-60}},
          lineColor={255,170,85},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          origin={0,30},
          rotation=90),
        Ellipse(
          extent={{-6,30},{6,-30}},
          lineColor={255,170,85},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          origin={0,30},
          rotation=90),
        Line(
          points={{-2,-1.22465e-16},{60,0}},
          color={255,128,0},
          origin={60,-30},
          rotation=90),
        Line(
          points={{-60,0},{-3.20085e-22,-1.95996e-38}},
          color={255,170,85},
          origin={-60,30},
          rotation=90),
        Line(points={{-60,0},{-100,0}}, color={255,170,85}),
        Line(points={{100,0},{60,0}},   color={255,170,85})}));
end HollowCylinderRadialFlux;
