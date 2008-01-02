model NonlinearResistor "Chua's resistor" 
  extends Interfaces.OnePort;
  annotation (
    Coordsys(
      extent=[-100, -100; 100, 100],
      grid=[1, 1],
      component=[20, 20]),
    Window(
      x=0.4,
      y=0.4,
      width=0.6,
      height=0.6),
    Icon(
      Rectangle(extent=[-70, 30; 70, -30]),
      Line(points=[-90, 0; -70, 0]),
      Line(points=[70, 0; 90, 0]),
      Line(points=[-50, -60; 50, 60]),
      Polygon(points=[50, 60; 38, 52; 44, 46; 50, 60], style(fillColor=3,
            fillPattern=1))),
    Diagram(
      Rectangle(extent=[-70, 30; 70, -30]),
      Line(points=[-90, 0; -70, 0]),
      Line(points=[70, 0; 90, 0]),
      Line(points=[-50, -60; 50, 60]),
      Polygon(points=[50, 60; 38, 52; 44, 46; 50, 60], style(fillColor=3,
            fillPattern=1)),
      Text(extent=[-100, 100; 100, 70], string="%name")));
  parameter SI.Conductance Ga;
  parameter SI.Conductance Gb;
  parameter SI.Voltage Ve;
equation 
  i = if (v < -Ve) then Gb*(v + Ve) - Ga*Ve else if (v > Ve) then Gb*(v - Ve)
     + Ga*Ve else Ga*v;
end NonlinearResistor;
