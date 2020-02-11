within Modelica.Mechanics.MultiBody.Frames.Quaternions;
type Orientation
  "Orientation type defining rotation from a frame 1 into a frame 2 with quaternions {p1,p2,p3,p0}"

  extends Internal.QuaternionBase;

  encapsulated function equalityConstraint
    "Return the constraint residues to express that two frames have the same quaternion orientation"

    import Modelica;
    import Modelica.Mechanics.MultiBody.Frames.Quaternions;
    extends Modelica.Icons.Function;
    input Quaternions.Orientation Q1
      "Quaternions orientation object to rotate frame 0 into frame 1";
    input Quaternions.Orientation Q2
      "Quaternions orientation object to rotate frame 0 into frame 2";
    output Real residue[3]
      "Zero vector if Q1 and Q2 are identical (the first three elements of the relative transformation (is {0,0,0} for the null rotation, guarded by atan2 to make the mirrored solution invalid";
  algorithm
    residue := { Modelica.Math.atan2({ Q1[4],  Q1[3], -Q1[2], -Q1[1]}*Q2, Q1*Q2),
                 Modelica.Math.atan2({-Q1[3],  Q1[4],  Q1[1], -Q1[2]}*Q2, Q1*Q2),
                 Modelica.Math.atan2({ Q1[2], -Q1[1],  Q1[4], -Q1[3]}*Q2, Q1*Q2)};
    annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
residue = Orientation.<strong>equalityConstraint</strong>(Q1, Q2);
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns the Real residue vector with&nbsp;3 elements.
This vector has zero elements if quaternions objects Q1 and Q2 are identical,
i.e. they describe the same orientation.
The residue vector is determined by the relative quaternion object between
Q1 and Q2 to formulate the residue in such a way that only identical
orientation objects lead to a zero residue vector.
</p>
</html>"));
  end equalityConstraint;

  annotation (Documentation(info="<html>
<p>
This type describes the <strong>rotation</strong> to rotate a frame 1 into
a frame 2 using quaternions (also called <strong>Euler parameters</strong>)
according to the following definition:
</p>
<blockquote><pre>
Quaternions.Orientation Q;
Real  n[3];
Real  phi(unit=\"rad\");
Q = [ n*sin(phi/2)
        cos(phi/2) ]
</pre></blockquote>
<p>
where \"n\" is the <strong>axis of rotation</strong> to rotate frame 1 into
frame 2 and \"phi\" is the <strong>rotation angle</strong> for this rotation.
Vector \"n\" is either resolved in frame 1 or in frame 2
(the result is the same since the coordinates of \"n\" with respect to
frame 1 are identical to its coordinates with respect to frame 2).
</p>
<p>
The term \"quaternions\" is preferred over the historically
more reasonable \"Euler parameters\" in order to not get
confused with Modelica \"parameters\".
</p>
</html>"));
end Orientation;
