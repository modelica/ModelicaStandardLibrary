within Modelica.Blocks.Interfaces;
partial block PartialConversionBlock
  "Partial block defining the interface for conversion blocks"

  RealInput u "Connector of Real input signal to be converted" annotation (
      Placement(transformation(extent={{-140,-20},{-100,20}})));
  RealOutput y
    "Connector of Real output signal containing input signal u in another unit"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  annotation (
    Icon(
      coordinateSystem(preserveAspectRatio=true,
        extent={{-100.0,-100.0},{100.0,100.0}}),
        graphics={
      Rectangle(
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid,
        extent={{-100.0,-100.0},{100.0,100.0}}),
      Line(
        points={{-90.0,0.0},{30.0,0.0}},
        color={191,0,0}),
      Polygon(
        lineColor={191,0,0},
        fillColor={191,0,0},
        fillPattern=FillPattern.Solid,
        points={{90.0,0.0},{30.0,20.0},{30.0,-20.0},{90.0,0.0}}),
      Text(
        textColor={0,0,255},
        extent={{-150,110},{150,150}},
        textString="%name")}), Documentation(info="<html>
<p>
This block defines the interface of a conversion block that
converts from one unit into another one.
</p>

</html>"));

end PartialConversionBlock;
