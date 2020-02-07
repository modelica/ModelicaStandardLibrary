within Modelica.Mechanics.MultiBody.Frames.TransformationMatrices;
function from_nxz "Return orientation object from n_x and n_z vectors"
  extends Modelica.Icons.Function;
  import Modelica.Math.Vectors.length;
  import Modelica.Math.Vectors.normalize;

  input Real n_x[3](each final unit="1")
    "Vector in direction of x-axis of frame 2, resolved in frame 1";
  input Real n_z[3](each final unit="1")
    "Vector in direction of z-axis of frame 2, resolved in frame 1";
  output TransformationMatrices.Orientation T
    "Orientation object to rotate frame 1 into frame 2";
protected
  Real e_x[3](each final unit="1")=if length(n_x) < 1e-10 then {1,0,0} else normalize(n_x);
  Real e_z[3](each final unit="1")=if length(n_z) < 1e-10 then {0,0,1} else normalize(n_z);
  Real n_y_aux[3](each final unit="1")=cross(e_z, e_x);
  Real n_z_aux[3](each final unit="1")=if n_y_aux*n_y_aux > 1.0e-6 then e_z
         else if abs(e_x[1]) > 1.0e-6 then {0,0,1} else {1,0,0};
  Real e_y_aux[3](each final unit="1")=cross(n_z_aux, e_x);
  Real e_y[3](each final unit="1")=normalize(e_y_aux);
algorithm
  T := {e_x,e_y,cross(e_x, e_y)};
  annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
T = TransformationMatrices.<strong>from_nxz</strong>(n_x, n_z);
</pre></blockquote>

<h4>Description</h4>
<p>
It is assumed that the two input vectors n_x and n_z are
resolved in frame&nbsp;1 and are directed along the&nbsp;x and z&nbsp;axis
of frame&nbsp;2 (i.e., n_x and n_z are orthogonal to each other).
The function returns the orientation object&nbsp;T to rotate from
frame&nbsp;1 to frame&nbsp;2.
</p>
<p>
The function is robust in the sense that it returns always
an orientation object&nbsp;T, even if n_z is not orthogonal to n_x.
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
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.from_nxz\">Frames.from_nxz</a>.
</p>
</html>"));
end from_nxz;
