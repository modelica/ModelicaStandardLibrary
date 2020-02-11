within Modelica.Mechanics.MultiBody.Visualizers.Colors.ColorMaps;
function spring "Returns the \"spring\" color map"
extends Modelica.Mechanics.MultiBody.Interfaces.partialColorMap;
algorithm
  if n_colors > 1 then
     colorMap := 255*[fill(1,n_colors),linspace(0,1.,n_colors),linspace(1,0,n_colors)];
   else
    colorMap:=255*[1,0,1];
   end if;

  annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
ColorMaps.<strong>spring</strong>();
ColorMaps.<strong>spring</strong>(n_colors=64);
</pre></blockquote>
<h4>Description</h4>
<p>
This function returns the color map \"spring.\" A color map
is a Real[:,3] array where every row represents a color.
With the optional argument \"n_colors\" the number of rows
of the returned array can be defined. The default value is
\"n_colors=64\" (it is usually best if n_colors is a multiple of 4).
Image of the \"spring\" color map:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/Colors/ColorMaps/spring.png\">
</blockquote>

<h4>See also</h4>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Colors.ColorMaps\">ColorMaps</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Colors.colorMapToSvg\">colorMapToSvg</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Colors.scalarToColor\">scalarToColor</a>.
</html>"));
end spring;
