within Modelica.Mechanics.MultiBody.Frames;
function from_nxy "Return fixed orientation object from n_x and n_y vectors"
  extends Modelica.Icons.Function;
  input Real n_x[3](each final unit="1")
    "Vector in direction of x-axis of frame 2, resolved in frame 1";
  input Real n_y[3](each final unit="1")
    "Vector in direction of y-axis of frame 2, resolved in frame 1";
  output Orientation R "Orientation object to rotate frame 1 into frame 2";
algorithm
  R := Orientation(T=TransformationMatrices.from_nxy(n_x,n_y),w= zeros(3));
  annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
R = Frames.<strong>from_nxy</strong>(n_x, n_y);
</pre></blockquote>

<h4>Description</h4>
<p>
It is assumed that the two input vectors n_x and n_y are
resolved in frame&nbsp;1 and are directed along the&nbsp;x and y&nbsp;axis
of frame&nbsp;2 (i.e., n_x and n_y are orthogonal to each other).
The function returns the orientation object&nbsp;R to rotate from
frame&nbsp;1 to frame&nbsp;2.
</p>
<p>
The function is robust in the sense that it returns always
an orientation object&nbsp;R, even if n_y is not orthogonal to n_x.
This is performed in the following way:
<br>
If n_x and n_y are not orthogonal to each other, first a unit
vector e_y is determined that is orthogonal to n_x and is lying
in the plane spanned by n_x and n_y. If n_x and n_y are parallel
or nearly parallel to each other, a vector e_y is selected
arbitrarily such that e_x and e_y are orthogonal to each other.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.from_nxy\">TransformationMatrices.from_nxy</a>.
</p>
</html>"));
end from_nxy;
