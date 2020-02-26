within Modelica.Magnetic.QuasiStatic.FluxTubes.Icons;
partial model Reluctance "Icon for reluctance / permeance components"
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Line(points={{-70,0},{-100,0}}, color={255,170,85}),
        Rectangle(
          extent={{-70,30},{70,-30}},
          lineColor={255,170,85},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{70,0},{100,0}}, color={255,170,85}),
        Text(
          extent={{-150,50},{150,90}},
          textString="%name",
          textColor={0,0,255})}));
end Reluctance;
