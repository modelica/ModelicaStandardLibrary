within Modelica.Electrical.Analog.Examples.Utilities;
model NonlinearResistor "Chua's resistor"
  extends Interfaces.OnePort;

  parameter SI.Conductance Ga "conductance in inner voltage range";
  parameter SI.Conductance Gb "conductance in outer voltage range";
  parameter SI.Voltage Ve "inner voltage range limit";
equation
  i = if (v < -Ve) then Gb*(v + Ve) - Ga*Ve else if (v > Ve) then Gb*(v - Ve)
     + Ga*Ve else Ga*v;
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={1,1}), graphics={
        Rectangle(extent={{-70,30},{70,-30}}, lineColor={0,0,255}),
        Line(points={{-90,0},{-70,0}}, color={0,0,255}),
        Line(points={{70,0},{90,0}}, color={0,0,255}),
        Line(points={{-50,-60},{50,60}}, color={0,0,255}),
        Polygon(
          points={{50,60},{38,52},{44,46},{50,60}},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,255})}),
    Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={1,1}), graphics={
        Rectangle(extent={{-70,30},{70,-30}}, lineColor={0,0,255}),
        Line(points={{-90,0},{-70,0}}, color={0,0,255}),
        Line(points={{70,0},{90,0}}, color={0,0,255}),
        Line(points={{-50,-60},{50,60}}, color={0,0,255}),
        Polygon(
          points={{50,60},{38,52},{44,46},{50,60}},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,255}),
        Text(
          extent={{-100,100},{100,70}},
          textString="%name",
          lineColor={0,0,255})}),
    Documentation(info="<html>

</html>"));
end NonlinearResistor;
