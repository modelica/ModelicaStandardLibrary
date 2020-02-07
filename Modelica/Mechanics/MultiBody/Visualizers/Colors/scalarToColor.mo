within Modelica.Mechanics.MultiBody.Visualizers.Colors;
function scalarToColor "Map a scalar to a color using a color map"
  extends Modelica.Icons.Function;

  input Real T "Scalar value" annotation(Dialog);
  input Real T_min "T <= T_min is mapped to colorMap[1,:]" annotation(Dialog);
  input Real T_max "T >= T_max is mapped to colorMap[end,:]" annotation(Dialog);
  input Real colorMap[:,3] "Color map" annotation(Dialog);
  output Real color[3] "Color of scalar value T";
algorithm
  /* old version, that could give an error
  color :=colorMap[integer((size(colorMap, 1) - 1)/(T_max - T_min)*
                            min((max(T,T_min) - T_min), T_max) + 1), :];
  */
  color := colorMap[1 + integer((size(colorMap,1)-1)*(max(T_min,min(T,T_max))-T_min)
                              / (T_max-T_min)), :];
  annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
//Real T, T_min, T_max, colorMap[:,3];
Colors.<strong>scalarToColor</strong>(T, T_min, T_max, colorMap);
</pre></blockquote>
<h4>Description</h4>
<p>
This function returns an rgb color Real[3] that corresponds to the value of \"T\".
The color is selected from the colorMap by interpolation so that
\"T_min\" corresponds to \"colorMap[1,:]\" and
\"T_max\" corresponds to \"colorMap[end,:]\".
</p>

<h4>See also</h4>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Colors.ColorMaps\">ColorMaps</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Colors.colorMapToSvg\">colorMapToSvg</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.PipeWithScalarField\">PipeWithScalarField</a>.

</html>"));
end scalarToColor;
