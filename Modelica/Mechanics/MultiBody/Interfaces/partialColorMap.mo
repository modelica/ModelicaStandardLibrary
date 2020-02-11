within Modelica.Mechanics.MultiBody.Interfaces;
partial function partialColorMap
  "Interface for a function returning a color map"
  extends Modelica.Icons.Function;
  input Integer n_colors=64 "Number of colors in the color map";
  output Real colorMap[n_colors,3] "Color map to map a scalar to a color";
  annotation (Documentation(info="<html>
<p>
This partial function defines the interface of a function that returns
a color map. Predefined color map functions are defined in package
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Colors.ColorMaps\">Modelica.Mechanics.MultiBody.Visualizers.Colors.ColorMaps</a>.
</p>
</html>"));
end partialColorMap;
