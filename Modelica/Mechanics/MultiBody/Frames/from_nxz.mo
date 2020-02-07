within Modelica.Mechanics.MultiBody.Frames;
function from_nxz "Return fixed orientation object from n_x and n_z vectors"
  extends Modelica.Icons.Function;
  input Real n_x[3](each final unit="1")
    "Vector in direction of x-axis of frame 2, resolved in frame 1";
  input Real n_z[3](each final unit="1")
    "Vector in direction of z-axis of frame 2, resolved in frame 1";
  output Orientation R "Orientation object to rotate frame 1 into frame 2";
algorithm
  R := Orientation(T=TransformationMatrices.from_nxz(n_x,n_z),w= zeros(3));
  annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
R = Frames.<strong>from_nxz</strong>(n_x, n_z);
</pre></blockquote>

<h4>Description</h4>
<p>
It is assumed that the two input vectors n_x and n_z are
resolved in frame&nbsp;1 and are directed along the&nbsp;x and z&nbsp;axis
of frame&nbsp;2 (i.e., n_x and n_z are orthogonal to each other).
The function returns the
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Orientation\">orientation object</a>&nbsp;R
to rotate from frame&nbsp;1 to frame&nbsp;2.
</p>
<p>
The function is robust in the sense that it always returns
an orientation object&nbsp;R, even if n_z is not orthogonal to n_x.
This is performed in the following way:
<br>
If n_x and n_z are not orthogonal to each other, first a unit
vector e_z is determined that is orthogonal to n_x and is lying
in the plane spanned by n_x and n_z. If n_x and n_z are parallel
or nearly parallel to each other, a vector e_z is selected
arbitrarily such that n_x and e_z are orthogonal to each other.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.from_nxz\">TransformationMatrices.from_nxz</a>.
</p>
</html>"));
end from_nxz;
