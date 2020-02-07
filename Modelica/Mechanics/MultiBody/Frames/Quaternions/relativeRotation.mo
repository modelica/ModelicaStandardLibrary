within Modelica.Mechanics.MultiBody.Frames.Quaternions;
function relativeRotation "Return relative quaternions orientation object"
  extends Modelica.Icons.Function;
  input Quaternions.Orientation Q1
    "Quaternions orientation object to rotate frame 0 into frame 1";
  input Quaternions.Orientation Q2
    "Quaternions orientation object to rotate frame 0 into frame 2";
  output Quaternions.Orientation Q_rel
    "Quaternions orientation object to rotate frame 1 into frame 2";
algorithm
  Q_rel := [ Q1[4],  Q1[3], -Q1[2], -Q1[1];
            -Q1[3],  Q1[4],  Q1[1], -Q1[2];
             Q1[2], -Q1[1],  Q1[4], -Q1[3];
             Q1[1],  Q1[2],  Q1[3],  Q1[4]]*Q2;
  annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Q_rel = Quaternions.<strong>relativeRotation</strong>(Q1, Q2);
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.Orientation\">quaternions orientation</a>&nbsp;Q_rel
that describes the orientation to rotate frame&nbsp;1 to frame&nbsp;2 from the
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.Orientation\">quaternions orientation</a>&nbsp;Q1
that describes the orientation to rotate from frame&nbsp;0 to frame&nbsp;1 and from the
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.Orientation\">quaternions orientation</a>&nbsp;Q2
that describes the orientation to rotate from frame&nbsp;0 to frame&nbsp;2.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.relativeRotation\">Frames.relativeRotation</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.relativeRotation\">TransformationMatrices.relativeRotation</a>.
</p>
</html>"));
end relativeRotation;
