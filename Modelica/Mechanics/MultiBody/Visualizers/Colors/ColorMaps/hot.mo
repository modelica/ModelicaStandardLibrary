within Modelica.Mechanics.MultiBody.Visualizers.Colors.ColorMaps;
function hot "Returns the \"hot\" color map"
extends Modelica.Mechanics.MultiBody.Interfaces.partialColorMap;
protected
   Real a=ceil(n_colors/3);
   Real d=1/a;
   Real v1[:]=0+d:d:1;
   Real cm[integer(ceil(n_colors/3))*3,3];
algorithm
 cm := 255*[v1, zeros(size(v1, 1)),zeros(size(v1, 1));
                          fill(1., size(v1, 1)), v1,zeros(size(v1, 1));
                          fill(1., size(v1, 1)),fill(1., size(v1, 1)),v1];
 colorMap:=cm[1:n_colors,:];

  annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
ColorMaps.<strong>hot</strong>();
ColorMaps.<strong>hot</strong>(n_colors=64);
</pre></blockquote>
<h4>Description</h4>
<p>
This function returns the color map \"hot.\" A color map
is a Real[:,3] array where every row represents a color.
With the optional argument \"n_colors\" the number of rows
of the returned array can be defined. The default value is
\"n_colors=64\" (it is usually best if n_colors is a multiple of 4).
Image of the \"hot\" color map:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/Colors/ColorMaps/hot.png\">
</blockquote>

<h4>See also</h4>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Colors.ColorMaps\">ColorMaps</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Colors.colorMapToSvg\">colorMapToSvg</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Colors.scalarToColor\">scalarToColor</a>.
</html>"));
end hot;
