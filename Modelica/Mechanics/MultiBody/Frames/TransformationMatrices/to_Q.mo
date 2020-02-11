within Modelica.Mechanics.MultiBody.Frames.TransformationMatrices;
function to_Q
  "Return quaternion orientation object Q from orientation object T"

  extends Modelica.Icons.Function;
  input TransformationMatrices.Orientation T
    "Orientation object to rotate frame 1 into frame 2";
  input Quaternions.Orientation Q_guess=Quaternions.nullRotation()
    "Guess value for output Q (there are 2 solutions; the one closer to Q_guess is used";
  output Quaternions.Orientation Q
    "Quaternions orientation object to rotate frame 1 into frame 2";
algorithm
  Q := Quaternions.from_T(T, Q_guess);
  annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Q = TransformationMatrices.<strong>to_Q</strong>(T, Q_guess);
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns a <a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.Orientation\">quaternion object</a>&nbsp;Q
computed from a <a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.Orientation\">transformation matrix</a>&nbsp;T
and depending on the initial guess Q_guess.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.from_Q\">from_Q</a>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.to_Q\">Frames.to_Q</a>.
</p>
</html>"));
end to_Q;
