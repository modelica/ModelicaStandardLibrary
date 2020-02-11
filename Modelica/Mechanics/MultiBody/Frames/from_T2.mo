within Modelica.Mechanics.MultiBody.Frames;
function from_T2
  "Return orientation object R from transformation matrix T and its derivative der(T)"
  extends Modelica.Icons.Function;
  input Real T[3, 3]
    "Transformation matrix to transform vector from frame 1 to frame 2 (v2=T*v1)";
  input Real der_T[3,3] "= der(T)";
  output Orientation R "Orientation object to rotate frame 1 into frame 2";

algorithm
  R := Orientation(T=T,w={T[3, :]*der_T[2, :],-T[3, :]*der_T[1, :],T[2, :]*der_T[1, :]});
  annotation (Inline=true,Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
R = Frames.<strong>from_T2</strong>(T, der_T);
</pre></blockquote>

<h4>Description</h4>
<p>
Computes the orientation object from a transformation matrix T and
the derivative der(T) of the transformation matrix.
Usually, it is more efficient to use function \"from_T\" instead, where
the angular velocity has to be given as input argument. Only if this
is not possible or too difficult to compute, use function from_T2(&hellip;).
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.from_T\">from_T</a>.
</p>
</html>"));
end from_T2;
