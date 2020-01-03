within Modelica.Electrical.Batteries.Icons;
model BatteryIcon "Icon for cells and stacks"
  input Real displaySOC "SOC for display"
    annotation(HideResult=true);
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Polygon(
          points={{-90,30},{-100,30},{-110,10},{-110,-10},{-100,-30},{-90,-30},{
              -90,30}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-90,60},{90,-60}},
          lineColor={0,0,255},
          radius=10),
        Text(
          extent={{-150,70},{150,110}},
          textColor={0,0,255},
          textString="%name"),
        Rectangle(
          extent={{90,40},{110,-40}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent=DynamicSelect({{70,-40},{-70,40}},{{70,-40},{70-140*displaySOC,40}}),
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid)}));
end BatteryIcon;
