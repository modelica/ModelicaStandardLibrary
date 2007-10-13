within Modelica.Electrical.Analog.Examples.Utilities;
model NonlinearResistor "Chua's resistor" 
  extends Interfaces.OnePort;
  annotation (
    Window(
      x=0.4,
      y=0.4,
      width=0.6,
      height=0.6),
    Icon(coordinateSystem(
        preserveAspectRatio=true, 
        extent={{-100,-100},{100,100}}, 
        grid={1,1}), graphics={
        Rectangle(extent={{-70,30},{70,-30}}), 
        Line(points={{-90,0},{-70,0}}), 
        Line(points={{70,0},{90,0}}), 
        Line(points={{-50,-60},{50,60}}), 
        Polygon(
          points={{50,60},{38,52},{44,46},{50,60}}, 
          fillColor={0,0,255}, 
          fillPattern=FillPattern.Solid)}),
    Diagram(coordinateSystem(
        preserveAspectRatio=true, 
        extent={{-100,-100},{100,100}}, 
        grid={1,1}), graphics={
        Rectangle(extent={{-70,30},{70,-30}}), 
        Line(points={{-90,0},{-70,0}}), 
        Line(points={{70,0},{90,0}}), 
        Line(points={{-50,-60},{50,60}}), 
        Polygon(
          points={{50,60},{38,52},{44,46},{50,60}}, 
          fillColor={0,0,255}, 
          fillPattern=FillPattern.Solid), 
        Text(extent={{-100,100},{100,70}}, textString=
                                               "%name")}),
    Documentation(info="<html>
  
</html>"));
  parameter SI.Conductance Ga;
  parameter SI.Conductance Gb;
  parameter SI.Voltage Ve;
equation 
  i = if (v < -Ve) then Gb*(v + Ve) - Ga*Ve else if (v > Ve) then Gb*(v - Ve)
     + Ga*Ve else Ga*v;
end NonlinearResistor;
