within Modelica.Mechanics.MultiBody.Frames;
function angularVelocity2
  "Return angular velocity resolved in frame 2 from orientation object"

  extends Modelica.Icons.Function;
  input Orientation R "Orientation object to rotate frame 1 into frame 2";
  output SI.AngularVelocity w[3]
    "Angular velocity of frame 2 with respect to frame 1 resolved in frame 2";
algorithm
  w := R.w;
  annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
w = Frames.<strong>angularVelocity2</strong>(R);
</pre></blockquote>

<h4>Description</h4>
<p>
The function call <code>Frames.<strong>angularVelocity1</strong>(R12)</code> returns
the angular velocity&nbsp;w of frame&nbsp;2 with respect to frame&nbsp;1, <strong>resolved in frame&nbsp;2</strong>,
from the orientation object R12 that describes the orientation to rotate frame&nbsp;1 into frame&nbsp;2.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.angularVelocity2\">TransformationMatrices.angularVelocity2</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.angularVelocity2\">Quaternions.angularVelocity2</a>.
</p>
</html>"));
end angularVelocity2;
