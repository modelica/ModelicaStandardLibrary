within Modelica.Mechanics.MultiBody.Frames.Quaternions;
function smallRotation "Return rotation angles valid for a small rotation"
  extends Modelica.Icons.Function;
  input Quaternions.Orientation Q
    "Quaternions orientation object to rotate frame 1 into frame 2";
  output SI.Angle phi[3]
    "The rotation angles around x-, y-, and z-axis of frame 1 to rotate frame 1 into frame 2 for a small relative rotation";
algorithm
  phi := 2*{Q[1],Q[2],Q[3]};
  annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
phi = Quaternions.<strong>smallRotation</strong>(Q);
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns rotation angles valid for a small rotation of x-y-z sequence (i.e. {1,2,3}).
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.smallRotation\">Frames.smallRotation</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.smallRotation\">TransformationMatrices.smallRotation</a>.
</p>
</html>"));
end smallRotation;
