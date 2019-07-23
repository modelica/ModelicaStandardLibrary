within Modelica.Electrical.PowerConverters.Icons;
partial model Converter "Converter icon"

  annotation (Icon(graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-100,-100},{100,100}},
          color={0,0,127}),
        Text(
          extent={{-150,150},{150,110}},
          textString="%name",
          textColor={0,0,255})}));
end Converter;
