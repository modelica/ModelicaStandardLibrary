within Modelica.Mechanics.MultiBody.Frames.Quaternions;
function angularVelocity2
  "Compute angular velocity resolved in frame 2 from quaternions orientation object and its derivative"

  extends Modelica.Icons.Function;
  input Quaternions.Orientation Q
    "Quaternions orientation object to rotate frame 1 into frame 2";
  input der_Orientation der_Q "Derivative of Q";
  output SI.AngularVelocity w[3]
    "Angular velocity of frame 2 with respect to frame 1 resolved in frame 2";
algorithm
  w := 2*([Q[4], Q[3], -Q[2], -Q[1]; -Q[3], Q[4], Q[1], -Q[2]; Q[2], -Q[1],
     Q[4], -Q[3]]*der_Q);
  annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
w = Quaternions.<strong>angularVelocity2</strong>(Q, der_Q);
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns the angular velocity&nbsp;w of frame&nbsp;2 with
respect to frame&nbsp;1, <strong>resolved in frame&nbsp;2</strong>, from the
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.Orientation\">quaternions orientation</a>&nbsp;Q
that describes the orientation to rotate frame&nbsp;1 into frame&nbsp;2
and from its first time derivative der_Q.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.angularVelocity2\">Frames.angularVelocity2</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.angularVelocity2\">TransformationMatrices.angularVelocity2</a>.
</p>
</html>"));
end angularVelocity2;
