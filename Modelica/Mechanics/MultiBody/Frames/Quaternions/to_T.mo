within Modelica.Mechanics.MultiBody.Frames.Quaternions;
function to_T
  "Return transformation matrix T from quaternion orientation object Q"

  extends Modelica.Icons.Function;
  input Quaternions.Orientation Q
    "Quaternions orientation object to rotate frame 1 into frame 2";
  output Real T[3, 3]
    "Transformation matrix to transform vector from frame 1 to frame 2 (v2=T*v1)";
algorithm
  /*
  T := (2*Q[4]*Q[4] - 1)*identity(3) + 2*(outerProduct(Q[1:3],Q[1:3]) - Q[4]*
    skew(Q[1:3]));
*/
  T := [2*(Q[1]*Q[1] + Q[4]*Q[4]) - 1, 2*(Q[1]*Q[2] + Q[3]*Q[4]), 2*(Q[1]*Q[
    3] - Q[2]*Q[4]); 2*(Q[2]*Q[1] - Q[3]*Q[4]), 2*(Q[2]*Q[2] + Q[4]*Q[4])
     - 1, 2*(Q[2]*Q[3] + Q[1]*Q[4]); 2*(Q[3]*Q[1] + Q[2]*Q[4]), 2*(Q[3]*Q[2]
     - Q[1]*Q[4]), 2*(Q[3]*Q[3] + Q[4]*Q[4]) - 1];
  annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
T = Quaternions.<strong>to_T</strong>(Q);
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns a real matrix&nbsp;T
<!--<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.Orientation\">transformation matrix</a>&nbsp;T-->
computed from a
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.Orientation\">quaternions orientation</a>&nbsp;Q.
The matrix&nbsp;T is considered to be an object transformation matrix.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.from_T\">from_T</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.to_T_inv\">to_T_inv</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.to_T\">Frames.to_T</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.to_T\">TransformationMatrices.to_T</a>.
</p>
</html>"));
end to_T;
