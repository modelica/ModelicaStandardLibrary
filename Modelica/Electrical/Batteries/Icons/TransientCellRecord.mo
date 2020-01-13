within Modelica.Electrical.Batteries.Icons;
partial record TransientCellRecord "Indicates transient cell data"
  constant String CellType="Cell Data" "Indicates cell type";
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
        Text(
          textColor={0,0,255},
          extent={{-150,60},{150,100}},
          textString="%name"),
        Rectangle(
          origin={0.0,-25.0},
          lineColor={64,64,64},
          fillColor={255,215,136},
          fillPattern=FillPattern.Solid,
          extent={{-100.0,-75.0},{100.0,75.0}},
          radius=25.0),
        Line(
          points={{-100,0},{-6,0}},
          color={64,64,64}),
        Line(
          origin={-6,-5},
          points={{0,25},{0,-15}},
          color={64,64,64}),
        Line(
          origin={6,-5},
          points={{0,25},{0,-15}},
          color={64,64,64}),
        Line(
          points={{6,0},{100,0}},
          color={64,64,64}),
        Line(
          origin={100,-50},
          points={{-60,0},{0,0}},
          color={64,64,64}),
        Line(
          origin={-40,-50},
          points={{-60,0},{0,0}},
          color={64,64,64}),
        Text(
          extent={{-100,-70},{100,-90}},
          textColor={0,0,0},
          textString="%CellType"),
        Rectangle(extent={{-40,-38},{40,-62}}, lineColor={0,0,0})}),
                               Documentation(info="<html>
<p>
This icon is indicates a record.
</p>
</html>"));
end TransientCellRecord;
