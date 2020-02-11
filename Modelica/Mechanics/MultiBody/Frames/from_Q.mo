within Modelica.Mechanics.MultiBody.Frames;
function from_Q
  "Return orientation object R from quaternion orientation object Q"

  extends Modelica.Icons.Function;
  input Quaternions.Orientation Q
    "Quaternions orientation object to rotate frame 1 into frame 2";
  input SI.AngularVelocity w[3]
    "Angular velocity from frame 2 with respect to frame 1, resolved in frame 2";
  output Orientation R "Orientation object to rotate frame 1 into frame 2";
algorithm
  /*
  T := (2*Q[4]*Q[4] - 1)*identity(3) + 2*(outerProduct([Q[1:3],[Q[1:3]) - Q[4]*
    skew(Q[1:3]));
*/
  R := Orientation([2*(Q[1]*Q[1] + Q[4]*Q[4]) - 1, 2*(Q[1]*Q[2] + Q[3]*Q[4]),
     2*(Q[1]*Q[3] - Q[2]*Q[4]); 2*(Q[2]*Q[1] - Q[3]*Q[4]), 2*(Q[2]*Q[2] + Q[4]
    *Q[4]) - 1, 2*(Q[2]*Q[3] + Q[1]*Q[4]); 2*(Q[3]*Q[1] + Q[2]*Q[4]), 2*(Q[3]
    *Q[2] - Q[1]*Q[4]), 2*(Q[3]*Q[3] + Q[4]*Q[4]) - 1],w= w);
  annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
R = Frames.<strong>from_Q</strong>(Q, w);
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns an <a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Orientation\">orientation object</a>&nbsp;R
computed from a <a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.Orientation\">quaternion object</a>&nbsp;Q
and an angular velocity vector&nbsp;w.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.to_Q\">to_Q</a>.
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.from_Q\">TransformationMatrices.from_Q</a>.
</p>

</html>"));
end from_Q;
