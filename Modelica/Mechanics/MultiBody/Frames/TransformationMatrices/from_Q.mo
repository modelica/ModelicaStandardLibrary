within Modelica.Mechanics.MultiBody.Frames.TransformationMatrices;
function from_Q
  "Return orientation object T from quaternion orientation object Q"

  extends Modelica.Icons.Function;
  input Quaternions.Orientation Q
    "Quaternions orientation object to rotate frame 1 into frame 2";
  output TransformationMatrices.Orientation T
    "Orientation object to rotate frame 1 into frame 2";
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
T = TransformationMatrices.<strong>from_Q</strong>(Q);
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns a
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.Orientation\">transformation matrix</a>&nbsp;T
computed from a <a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.Orientation\">quaternion object</a>&nbsp;Q
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.to_Q\">to_Q</a>.
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.from_Q\">Frames.from_Q</a>.
</p>
</html>"));
end from_Q;
