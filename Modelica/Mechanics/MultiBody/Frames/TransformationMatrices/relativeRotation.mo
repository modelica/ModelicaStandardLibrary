within Modelica.Mechanics.MultiBody.Frames.TransformationMatrices;
function relativeRotation "Return relative orientation object"
  extends Modelica.Icons.Function;
  input TransformationMatrices.Orientation T1
    "Orientation object to rotate frame 0 into frame 1";
  input TransformationMatrices.Orientation T2
    "Orientation object to rotate frame 0 into frame 2";
  output TransformationMatrices.Orientation T_rel
    "Orientation object to rotate frame 1 into frame 2";
algorithm
  T_rel := T2*transpose(T1);
  annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
T_rel = TransformationMatrices.<strong>relativeRotation</strong>(T1, T2);
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.Orientation\">transformation matrix</a> T_rel
that describes the orientation to rotate frame&nbsp;1 to frame&nbsp;2 from the
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.Orientation\">transformation matrix</a>&nbsp;T1
that describes the orientation to rotate from frame&nbsp;0 to frame&nbsp;1 and from the
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.Orientation\">transformation matrix</a>&nbsp;T2
that describes the orientation to rotate from frame&nbsp;0 to frame&nbsp;2.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.relativeRotation\">Frames.relativeRotation</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.relativeRotation\">Quaternions.relativeRotation</a>.
</p>
</html>"));
end relativeRotation;
