within Modelica.Mechanics.MultiBody.Frames;
function to_Q
  "Return quaternion orientation object Q from orientation object R"

  extends Modelica.Icons.Function;
  input Orientation R "Orientation object to rotate frame 1 into frame 2";
  input Quaternions.Orientation Q_guess=Quaternions.nullRotation()
    "Guess value for output Q (there are 2 solutions; the one closer to Q_guess is used)";
  output Quaternions.Orientation Q
    "Quaternions orientation object to rotate frame 1 into frame 2";
algorithm
  Q := Quaternions.from_T(R.T, Q_guess);
  annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Q = Frames.<strong>to_Q</strong>(R, Q_guess);
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns a <a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.Orientation\">quaternion object</a>&nbsp;Q
computed from an <a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Orientation\">orientation object</a>&nbsp;R
and depending on the initial guess Q_guess.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.from_Q\">from_Q</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.to_Q\">TransformationMatrices.to_Q</a>.
</p>
</html>"));
end to_Q;
