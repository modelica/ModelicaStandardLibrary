within Modelica.Mechanics.MultiBody.Frames.Quaternions;
function from_T_inv
  "Return quaternion orientation object Q from inverse transformation matrix T_inv"

  extends Modelica.Icons.Function;
  input Real T_inv[3, 3]
    "Inverse transformation matrix to transform vector from frame 2 to frame 1 (v1=T_inv*v2)";
  input Quaternions.Orientation Q_guess=nullRotation()
    "Guess value for output Q (there are 2 solutions; the one closer to Q_guess is used";
  output Quaternions.Orientation Q
    "Quaternions orientation object to rotate frame 1 into frame 2 (Q and -Q have same transformation matrix)";
algorithm
  Q := from_T(transpose(T_inv), Q_guess);
  annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Q = Quaternions.<strong>from_T_inv</strong>(T_inv, Q_guess);
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns a
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.Orientation\">quaternions orientation</a>&nbsp;Q.
computed from an inverse transformation matrix T_inv
and depending on the initial guess Q_guess.
Generally, the transformation matrix T_inv can be gained using a function from the
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices\">TransformationMatrices</a>
package, e.g. using T_inv = <a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.inverseRotation\">inverseRotation</a>(T).
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.from_T\">from_T</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.from_T_inv\">Frames.from_T_inv</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.from_T_inv\">TransformationMatrices.from_T_inv</a>.
</p>
</html>"));
end from_T_inv;
