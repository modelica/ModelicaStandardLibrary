within Modelica.Mechanics.Rotational.Icons;
model Clutch "Icon of a clutch"

  annotation (Icon(graphics={
      Rectangle(  lineColor={64,64,64},
        fillColor={192,192,192},
        fillPattern=FillPattern.HorizontalCylinder,
        extent={{-100.0,-10.0},{-30.0,10.0}}),
      Rectangle(  lineColor={64,64,64},
        fillColor={255,255,255},
        fillPattern=FillPattern.HorizontalCylinder,
        extent={{-30.0,-60.0},{-10.0,60.0}}),
      Rectangle(  lineColor={64,64,64},
        extent={{-30.0,-60.0},{-10.0,60.0}}),
      Rectangle(  lineColor={64,64,64},
        fillColor={255,255,255},
        fillPattern=FillPattern.HorizontalCylinder,
        extent={{10.0,-60.0},{30.0,60.0}}),
      Rectangle(  lineColor={64,64,64},
        extent={{10.0,-60.0},{30.0,60.0}}),
      Rectangle(  lineColor={64,64,64},
        fillColor={192,192,192},
        fillPattern=FillPattern.HorizontalCylinder,
        extent={{30.0,-10.0},{100.0,10.0}}),
      Polygon(  lineColor={0,0,127},
        fillColor={0,0,127},
        fillPattern=FillPattern.Solid,
        points={{-30.0,40.0},{-60.0,50.0},{-60.0,30.0},{-30.0,40.0}}),
      Polygon(  lineColor={0,0,127},
        fillColor={0,0,127},
        fillPattern=FillPattern.Solid,
        points={{30.0,40.0},{60.0,50.0},{60.0,30.0},{30.0,40.0}}),
      Line(  points={{0.0,90.0},{90.0,70.0},{90.0,40.0},{30.0,40.0}},
        color={0,0,127}),
      Line(  points={{0.0,90.0},{-90.0,70.0},{-90.0,40.0},{-30.0,40.0}},
        color={0,0,127})},
      coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}},
        preserveAspectRatio=true)),
      Documentation(info="<html>
<p>
This is the icon of a clutch from the rotational package.
</p>
</html>"));

end Clutch;
