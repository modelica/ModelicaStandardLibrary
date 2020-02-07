within Modelica.Mechanics.MultiBody.Frames;
function axis "Return unit vector for x-, y-, or z-axis"
  extends Modelica.Icons.Function;
  input Integer axis(min=1, max=3) "Axis vector to be returned";
  output Real e[3](each final unit="1") "Unit axis vector";
algorithm
  e := if axis == 1 then {1,0,0} else (if axis == 2 then {0,1,0} else {0,0,1});
  annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
e = Frames.<strong>axis</strong>(axis);
</pre></blockquote>

<h4>Description</h4>
<p>
A unit vector&nbsp;e is returned depending on whether x-, y-, or z-axis is required.
</p>
<blockquote><pre>
 axis  |    e
-------+-----------
  1    |  {1,0,0}
  2    |  {1,0,0}
  3    |  {1,0,0}
</pre></blockquote>
</html>"));
end axis;
