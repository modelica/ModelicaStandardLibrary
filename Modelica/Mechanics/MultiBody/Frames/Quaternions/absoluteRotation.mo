within Modelica.Mechanics.MultiBody.Frames.Quaternions;
function absoluteRotation
  "Return absolute quaternions orientation object from another absolute and a relative quaternions orientation object"

  extends Modelica.Icons.Function;
  input Quaternions.Orientation Q1
    "Quaternions orientation object to rotate frame 0 into frame 1";
  input Quaternions.Orientation Q_rel
    "Quaternions orientation object to rotate frame 1 into frame 2";
  output Quaternions.Orientation Q2
    "Quaternions orientation object to rotate frame 0 into frame 2";
algorithm
  Q2 := [Q_rel[4], Q_rel[3], -Q_rel[2], Q_rel[1]; -Q_rel[3], Q_rel[4],
    Q_rel[1], Q_rel[2]; Q_rel[2], -Q_rel[1], Q_rel[4], Q_rel[3]; -Q_rel[1],
     -Q_rel[2], -Q_rel[3], Q_rel[4]]*Q1;
  annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Q2 = Quaternions.<strong>absoluteRotation</strong>(Q1, Q_rel);
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.Orientation\">quaternions orientation</a>&nbsp;Q2
that describes the orientation frame&nbsp;0 to frame&nbsp;2 from the
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.Orientation\">quaternions orientation</a>&nbsp;Q1
that describes the orientation to rotate from frame&nbsp;0 to frame&nbsp;1 and from the relative
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.Orientation\">quaternions orientation</a> Q_rel
that describes the orientation to rotate from frame&nbsp;1 to frame&nbsp;2.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.absoluteRotation\">Frames.absoluteRotation</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.absoluteRotation\">TransformationMatrices.absoluteRotation</a>.
</p>
</html>"));
end absoluteRotation;
