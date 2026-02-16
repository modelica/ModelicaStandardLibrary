within Modelica.Mechanics.MultiBody.Visualizers.Colors.ColorMaps;
function coolWarm "Returns the \"CoolWarm\" color map"
extends Modelica.Mechanics.MultiBody.Interfaces.partialColorMap;

protected
  final Real Start[3] = {59/255, 76/255, 192/255};   // blue
  final Real Mid[3]   = {242/255, 242/255, 242/255}; // gray
  final Real End[3]   = {180/255, 4/255, 38/255};    // red

  final Real cm[n_colors,3];
  final Real t;                // normalized position
  final Real u;                // interpolation factor

algorithm
  if n_colors >= 1 then
    for i in 1:n_colors loop
      t := (i-1)/(n_colors-1);

      if t <= 0.5 then
        u := t/0.5;
        cm[i,:] := (1-u)*Start + u*Mid;
      else
        u := (t-0.5)/0.5;
        cm[i,:] := (1-u)*Mid + u*End;
      end if;
    end for;

    colorMap := 255*cm;
  else
    colorMap := [59,76,192];
  end if;

  annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
ColorMaps.<strong>CoolWarm</strong>();
ColorMaps.<strong>CoolWarm</strong>(n_colors=64);
</pre></blockquote>
<h4>Description</h4>
<p>
This function returns the color map \"CoolWarm.\" A color map
is a Real[:,3] array where every row represents a color.
With the optional argument \"n_colors\" the number of rows
of the returned array can be defined. The default value is
\"n_colors=64\" (it is usually best if n_colors is a multiple of 4).
Image of the \"CoolWarm\" color map:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/Colors/ColorMaps/CoolWarm.png\">
</blockquote>

<h4>See also</h4>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Colors.ColorMaps\">ColorMaps</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Colors.colorMapToSvg\">colorMapToSvg</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Colors.scalarToColor\">scalarToColor</a>.
</html>"));
end coolWarm;
