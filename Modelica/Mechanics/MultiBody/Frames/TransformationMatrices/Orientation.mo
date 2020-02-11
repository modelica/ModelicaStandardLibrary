within Modelica.Mechanics.MultiBody.Frames.TransformationMatrices;
type Orientation
  "Orientation type defining rotation from a frame 1 into a frame 2 with a transformation matrix"

  extends Internal.TransformationMatrix;

  encapsulated function equalityConstraint
    "Return the constraint residues to express that two frames have the same orientation"

    import Modelica;
    import Modelica.Mechanics.MultiBody.Frames.TransformationMatrices;
    extends Modelica.Icons.Function;
    input TransformationMatrices.Orientation T1
      "Orientation object to rotate frame 0 into frame 1";
    input TransformationMatrices.Orientation T2
      "Orientation object to rotate frame 0 into frame 2";
    output Real residue[3]
      "The rotation angles around x-, y-, and z-axis of frame 1 to rotate frame 1 into frame 2 for a small rotation (should be zero)";
  algorithm
    residue := {
      cross(T1[1, :], T1[2, :]) * T2[2, :],
      -cross(T1[1, :], T1[2, :]) * T2[1, :],
      T1[2, :]*T2[1, :]};
    annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
residue = Orientation.<strong>equalityConstraint</strong>(T1, T2);
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns the Real residue vector with&nbsp;3 elements.
This vector has zero elements if transformation matrices T1 and T2 are identical,
i.e. they describe the same orientation. The residue vector is determined by computing the relative
transformation matrix between T1 and T2 and using the outer-diagonal elements of this matrix to
formulate the residue in such a way that only identical orientation objects lead to a zero residue vector.
</p>
</html>"));
  end equalityConstraint;
  annotation (Documentation(info="<html>
<p>
This type describes the <strong>rotation</strong> from a <strong>frame 1</strong> into a <strong>frame 2</strong>.
An instance <strong>R</strong> of type <strong>Orientation</strong> has the following interpretation:
</p>
<blockquote><pre>
<strong>T</strong> = [<strong>e</strong><sub>x</sub>, <strong>e</strong><sub>y</sub>, <strong>e</strong><sub>z</sub>];
    e.g., <strong>T</strong> = [1,0,0; 0,1,0; 0,0,1]
</pre></blockquote>
<p>
where <strong>e</strong><sub>x</sub>,<strong>e</strong><sub>y</sub>,<strong>e</strong><sub>z</sub>
are unit vectors in the direction of the x-axis, y-axis, and z-axis
of frame 1, resolved in frame 2, respectively. Therefore, if <strong>v</strong><sub>1</sub>
is vector <strong>v</strong> resolved in frame 1 and <strong>v</strong><sub>2</sub> is
vector <strong>v</strong> resolved in frame 2, the following relationship holds:
</p>
<blockquote><pre>
<strong>v</strong><sub>2</sub> = <strong>T</strong> * <strong>v</strong><sub>1</sub>
</pre></blockquote>
<p>
The <strong>inverse</strong> orientation
<strong>T_inv</strong> = <strong>T</strong><sup>T</sup> describes the rotation
from frame 2 into frame 1.
</p>
<p>
Since the orientation is described by 9 variables, there are
6 constraints between these variables. These constraints
are defined in function <strong>TransformationMatrices.orientationConstraint</strong>.
</p>
<p>
Note, that in the MultiBody library the rotation object is
never directly accessed but only with the access functions provided
in package TransformationMatrices. As a consequence, other implementations of
Rotation can be defined by adapting this package correspondingly.
</p>
</html>"));
end Orientation;
