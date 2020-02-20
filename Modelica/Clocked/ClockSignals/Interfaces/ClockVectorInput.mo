within Modelica.Clocked.ClockSignals.Interfaces;
connector ClockVectorInput = input Clock
  "Clock input connector used for vector of connectors."
  annotation (
    defaultComponentName = "u",
    Icon(graphics={
      Ellipse(
        extent = {{-100,-100},{100,100}},
        lineColor = {175,175,175},
        fillColor = {95,95,95},
        fillPattern = FillPattern.Solid,
        lineThickness = 0.5,
        pattern = LinePattern.Dot)},
      coordinateSystem(
        extent = {{-100,-100},{100,100}},
        preserveAspectRatio = false,
        initialScale = 0.2)),
    Diagram(coordinateSystem(
      preserveAspectRatio = false,
      initialScale = 0.2,
      extent = {{-100,-100},{100,100}}),
      graphics={
        Text(
          extent = {{0,-58},{0,-84}},
          textColor = {95,95,95},
          textString = "%name"),
        Ellipse(
          extent = {{-50,50},{50,-50}},
          lineColor = {175,175,175},
          fillColor = {95,95,95},
          fillPattern = FillPattern.Solid,
          lineThickness = 0.5,
          pattern = LinePattern.Dot)}),
    Documentation(info = "<html>
<p>
Clock input connector that is used for a vector of connectors and therefore has
a different icon as <code>ClockInput</code> connector.
</p>
</html>"));
