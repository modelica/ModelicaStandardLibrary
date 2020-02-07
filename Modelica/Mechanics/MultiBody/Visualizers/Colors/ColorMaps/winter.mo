within Modelica.Mechanics.MultiBody.Visualizers.Colors.ColorMaps;
function winter "Returns the \"winter\" color map"
extends Modelica.Mechanics.MultiBody.Interfaces.partialColorMap;
algorithm
  if n_colors > 1 then
     colorMap := 255*[zeros(n_colors),linspace(0,1,n_colors),linspace(1,0.5,n_colors)];
   else
    colorMap:=[0,0,255];
   end if;

  annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
ColorMaps.<strong>winter</strong>();
ColorMaps.<strong>winter</strong>(n_colors=64);
</pre></blockquote>
<h4>Description</h4>
<p>
This function returns the color map \"winter.\" A color map
is a Real[:,3] array where every row represents a color.
With the optional argument \"n_colors\" the number of rows
of the returned array can be defined. The default value is
\"n_colors=64\" (it is usually best if n_colors is a multiple of 4).
Image of the \"winter\" color map:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/Colors/ColorMaps/winter.png\">
</blockquote>

<h4>See also</h4>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Colors.ColorMaps\">ColorMaps</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Colors.colorMapToSvg\">colorMapToSvg</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Colors.scalarToColor\">scalarToColor</a>.
</html>"));
end winter;
