within Modelica.Mechanics.MultiBody;
package Frames "Functions to transform rotational frame quantities"

  extends Modelica.Icons.Package;

  record Orientation
    "Orientation object defining rotation from a frame 1 into a frame 2"

    extends Modelica.Icons.Record;
    Real T[3, 3] "Transformation matrix from world frame to local frame";
    SI.AngularVelocity w[3]
      "Absolute angular velocity of local frame, resolved in local frame";

    encapsulated function equalityConstraint
      "Return the constraint residues to express that two frames have the same orientation"

      import Modelica;
      import Modelica.Mechanics.MultiBody.Frames;
      extends Modelica.Icons.Function;
      input Frames.Orientation R1
        "Orientation object to rotate frame 0 into frame 1";
      input Frames.Orientation R2
        "Orientation object to rotate frame 0 into frame 2";
      output Real residue[3]
        "The rotation angles around x-, y-, and z-axis of frame 1 to rotate frame 1 into frame 2 for a small rotation (should be zero)";
    algorithm
      residue := {
         Modelica.Math.atan2(cross(R1.T[1, :], R1.T[2, :])*R2.T[2, :],R1.T[1,:]*R2.T[1,:]),
         Modelica.Math.atan2(-cross(R1.T[1, :],R1.T[2, :])*R2.T[1, :],R1.T[2,:]*R2.T[2,:]),
         Modelica.Math.atan2(R1.T[2, :]*R2.T[1, :],R1.T[3,:]*R2.T[3,:])};
      annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
residue = Orientation.<strong>equalityConstraint</strong>(R1, R2);
</pre></blockquote>

<h4>Description</h4>
<p>
The function call <code>Orientation.<strong>equalityConstrain</strong>(R1,R2)</code> returns the Real residue vector
with 3 elements. This vector has zero elements if orientation objects R1 and R2 are identical
(= describe the same orientation). The residue vector is determined by computing the relative
orientation object between R1 and R2 and using the outer-diagonal elements of this matrix to
formulate the residue in such a way that only identical orientation objects lead to a zero residue vector.
</p>
</html>"));
    end equalityConstraint;

    annotation (Documentation(info="<html>
<p>
This object describes the <strong>rotation</strong> from a <strong>frame&nbsp;1</strong> into a <strong>frame&nbsp;2</strong>.
An instance of this type should never be directly accessed but
only with the access functions provided
in package Modelica.Mechanics.MultiBody.Frames. As a consequence, it is not necessary to know
the internal representation of this object as described in the next paragraphs.
</p>
<p>
\"Orientation\" is defined to be a record consisting of two
elements: \"Real T[3,3]\", the transformation matrix to rotate frame&nbsp;1
into frame&nbsp;2 and \"Real w[3]\", the angular velocity of frame&nbsp;2 with
respect to frame&nbsp;1, resolved in frame&nbsp;2. Element \"T\"
has the following interpretation:
</p>

<blockquote><pre>
Orientation R;
<strong>R.T</strong> = [<strong>e</strong><sub>x</sub>, <strong>e</strong><sub>y</sub>, <strong>e</strong><sub>z</sub>];
    e.g., <strong>R.T</strong> = [1,0,0; 0,1,0; 0,0,1]
</pre></blockquote>

<p>
where <strong>e</strong><sub>x</sub>,<strong>e</strong><sub>y</sub>,<strong>e</strong><sub>z</sub>
are unit vectors in the direction of the x-axis, y-axis, and z-axis
of frame&nbsp;1, resolved in frame&nbsp;2, respectively. Therefore, if <strong>v</strong><sub>1</sub>
is vector <strong>v</strong> resolved in frame&nbsp;1 and <strong>v</strong><sub>2</sub> is
vector <strong>v</strong> resolved in frame&nbsp;2, the following relationship holds:
</p>

<blockquote><pre>
<strong>v</strong><sub>2</sub> = <strong>R.T</strong> * <strong>v</strong><sub>1</sub>
</pre></blockquote>

<p>
The <strong>inverse</strong> orientation
<strong>R_inv.T</strong> = <strong>R.T</strong><sup>T</sup> describes the rotation
from frame&nbsp;2 into frame&nbsp;1.
</p>
<p>
Since the orientation is described by 9 variables, there are
6 constraints between these variables. These constraints
are defined in function <strong>Frames.orientationConstraint</strong>.
</p>
<p>
R.w is the angular velocity of frame&nbsp;2 with respect to frame&nbsp;1, resolved
in frame&nbsp;2. Formally, R.w is defined as:<br>
<strong>skew</strong>(R.w) = R.T*<strong>der</strong>(transpose(R.T))
with
</p>
<blockquote><pre>
          |   0   -w[3]  w[2] |
<strong>skew</strong>(w) = |  w[3]   0   -w[1] |
          | -w[2]  w[1]     0 |
</pre></blockquote>
</html>"));
  end Orientation;

  function orientationConstraint
    "Return residues of orientation constraints (shall be zero)"
    extends Modelica.Icons.Function;
    input Orientation R "Orientation object to rotate frame 1 into frame 2";
    output Real residue[6]
      "Residues of constraints between elements of orientation object (shall be zero)";
  algorithm
    residue := {R.T[:, 1]*R.T[:, 1] - 1,R.T[:, 2]*R.T[:, 2] - 1,R.T[:, 3]*R.T[:,
       3] - 1,R.T[:, 1]*R.T[:, 2],R.T[:, 1]*R.T[:, 3],R.T[:, 2]*R.T[:, 3]};
    annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
residue = Frames.<strong>orientationConstraint</strong>(R);
</pre></blockquote>

<h4>Description</h4>
<p>
The function call <code>Frames.<strong>orientationConstraint</strong>(R)</code> returns the Real residue vector
with&nbsp;6 elements that describes the constraints between the&nbsp;9 elements of the orientation matrix.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.orientationConstraint\">TransformationMatrices.orientationConstraint</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.orientationConstraint\">Quaternions.orientationConstraint</a>.
</p>
</html>"));
  end orientationConstraint;

  function angularVelocity1
    "Return angular velocity resolved in frame 1 from orientation object"

    extends Modelica.Icons.Function;
    input Orientation R "Orientation object to rotate frame 1 into frame 2";
    output Modelica.SIunits.AngularVelocity w[3]
      "Angular velocity of frame 2 with respect to frame 1 resolved in frame 1";
  algorithm
    w := resolve1(R, R.w);
    annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
w = Frames.<strong>angularVelocity1</strong>(R);
</pre></blockquote>

<h4>Description</h4>
<p>
The function call <code>Frames.<strong>angularVelocity1</strong>(R12)</code> returns
the angular velocity&nbsp;w of frame&nbsp;2 with respect to frame&nbsp;1, <strong>resolved in frame&nbsp;1</strong>,
from the orientation object R12 that describes the orientation to rotate frame&nbsp;1 into frame&nbsp;2.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.angularVelocity1\">TransformationMatrices.angularVelocity1</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.angularVelocity1\">Quaternions.angularVelocity1</a>.
</p>
</html>"));
  end angularVelocity1;

  function angularVelocity2
    "Return angular velocity resolved in frame 2 from orientation object"

    extends Modelica.Icons.Function;
    input Orientation R "Orientation object to rotate frame 1 into frame 2";
    output Modelica.SIunits.AngularVelocity w[3]
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

  function resolve1 "Transform vector from frame 2 to frame 1"
    extends Modelica.Icons.Function;
    input Orientation R "Orientation object to rotate frame 1 into frame 2";
    input Real v2[3] "Vector in frame 2";
    output Real v1[3] "Vector in frame 1";
  algorithm
    v1 := transpose(R.T)*v2;
    annotation (
      derivative(noDerivative=R) = Internal.resolve1_der,
      InlineAfterIndexReduction=true,
      Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
v1 = Frames.<strong>resolve1</strong>(R, v2);
</pre></blockquote>

<h4>Description</h4>
<p>
The function call <code>Frames.<strong>resolve1</strong>(R12, v2)</code> returns vector v
resolved in frame&nbsp;1 (= v1) from vector v resolved in frame&nbsp;2 (= v2) using the
orientation object R12 that describes the orientation to rotate frame&nbsp;1 into frame&nbsp;2.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.resolve2\">resolve2</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.resolve1\">TransformationMatrices.resolve1</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.resolve1\">Quaternions.resolve1</a>.
</p>
</html>"));
  end resolve1;

  function resolve2 "Transform vector from frame 1 to frame 2"
    extends Modelica.Icons.Function;
    input Orientation R "Orientation object to rotate frame 1 into frame 2";
    input Real v1[3] "Vector in frame 1";
    output Real v2[3] "Vector in frame 2";
  algorithm
    v2 := R.T*v1;
    annotation (derivative(noDerivative=R) = Internal.resolve2_der,
        InlineAfterIndexReduction=true,
      Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
v2 = Frames.<strong>resolve2</strong>(R, v1);
</pre></blockquote>

<h4>Description</h4>
<p>
The function call <code>Frames.<strong>resolve2</strong>(R12, v1)</code> returns vector v
resolved in frame&nbsp;2 (= v2) from vector v resolved in frame&nbsp;1 (= v1) using the
orientation object R12 that describes the orientation  to rotate frame&nbsp;1 into frame&nbsp;2.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.resolve1\">resolve1</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.resolve2\">TransformationMatrices.resolve2</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.resolve2\">Quaternions.resolve2</a>.
</p>
</html>"));
  end resolve2;

  function resolveRelative
    "Transform vector from frame 1 to frame 2 using absolute orientation objects of frame 1 and of frame 2"

    extends Modelica.Icons.Function;
    input Real v1[3] "Vector in frame 1";
    input Orientation R1 "Orientation object to rotate frame 0 into frame 1";
    input Orientation R2 "Orientation object to rotate frame 0 into frame 2";
    output Real v2[3] "Vector in frame 2";
  algorithm
    v2 := resolve2(R2, resolve1(R1, v1));
    annotation (derivative(noDerivative=R1, noDerivative=R2) = Internal.resolveRelative_der,
        InlineAfterIndexReduction=true,
      Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
v2 = Frames.<strong>resolveRelative</strong>(v1, R1, R2);
</pre></blockquote>

<h4>Description</h4>
<p>
The function call <code>Frames.<strong>resolveRelative</strong>(v1,R1,R2)</code> returns vector v
resolved in frame&nbsp;2 (= v1) from vector v resolved in frame&nbsp;1 (= v1) given the
orientation object R1 that describes the orientation to rotate frame&nbsp;0 into frame&nbsp;1 and
orientation object R2 that describes the orientation to rotate frame&nbsp;0 into frame&nbsp;2.
</p>
</html>"));
  end resolveRelative;

  function resolveDyade1
    "Transform second order tensor from frame 2 to frame 1"
    extends Modelica.Icons.Function;
    input Orientation R "Orientation object to rotate frame 1 into frame 2";
    input Real D2[3, 3] "Second order tensor resolved in frame 2";
    output Real D1[3, 3] "Second order tensor resolved in frame 1";
  algorithm
    D1 := transpose(R.T)*D2*R.T;
    annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
D1 = Frames.<strong>resolveDyade1</strong>(R, D2);
</pre></blockquote>

<h4>Description</h4>
<p>
The function call <code>Frames.<strong>Dyade1</strong>(R12, D2)</code> returns the second order tensor D
resolved in frame&nbsp;1 (= D1) from its representation in frame&nbsp;2 (= D2) using the
orientation object R12 that describes the orientation to rotate frame&nbsp;1 into frame&nbsp;2.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.resolveDyade1\">TransformationMatrices.resolveDyade1</a>.
</p>
</html>"));
  end resolveDyade1;

  function resolveDyade2
    "Transform second order tensor from frame 1 to frame 2"
    extends Modelica.Icons.Function;
    input Orientation R "Orientation object to rotate frame 1 into frame 2";
    input Real D1[3, 3] "Second order tensor resolved in frame 1";
    output Real D2[3, 3] "Second order tensor resolved in frame 2";
  algorithm
    D2 := R.T*D1*transpose(R.T);
    annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
D2 = Frames.<strong>resolveDyade2</strong>(R, D1);
</pre></blockquote>

<h4>Description</h4>
<p>
The function call <code>Frames.<strong>Dyade2</strong>(R12, D1)</code> returns the second order tensor D
resolved in frame&nbsp;2 (= D2) from its representation in frame&nbsp;1 (= D1) using the
orientation object R12 that describes the orientation to rotate frame&nbsp;1 into frame&nbsp;2.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.resolveDyade2\">TransformationMatrices.resolveDyade2</a>.
</p>
</html>"));
  end resolveDyade2;

  function nullRotation
    "Return orientation object that does not rotate a frame"
    extends Modelica.Icons.Function;
    output Orientation R
      "Orientation object such that frame 1 and frame 2 are identical";
  algorithm
    R := Orientation(T=identity(3),w= zeros(3));
    annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
R = Frames.<strong>nullRotation</strong>();
</pre></blockquote>

<h4>Description</h4>
<p>
The function call <code>Frames.<strong>nullRotation</strong>()</code> returns an orientation matrix&nbsp;R
describing the orientation object to rotate frame&nbsp;1 into frame&nbsp;2, if frame&nbsp;1 and frame&nbsp;2 are identical.
(= transformation matrix is identity matrix and angular velocity is zero).
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.nullRotation\">TransformationMatrices.nullRotation</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.nullRotation\">Quaternions.nullRotation</a>.
</p>
</html>"));
  end nullRotation;

  function inverseRotation "Return inverse orientation object"
    extends Modelica.Icons.Function;
    input Orientation R "Orientation object to rotate frame 1 into frame 2";
    output Orientation R_inv
      "Orientation object to rotate frame 2 into frame 1";
  algorithm
    R_inv := Orientation(T=transpose(R.T),w= -resolve1(R, R.w));
    annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
R_inv = Frames.<strong>inverseRotation</strong>(R);
</pre></blockquote>

<h4>Description</h4>
<p>
The function call <code>Frames.<strong>inverseRotation</strong>(R)</code> returns
orientation object R_inv that describes the orientation to rotate from frame&nbsp;2 to frame&nbsp;1
from the orientation object R that describes the orientation to rotate from frame&nbsp;1 into frame&nbsp;2.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.inverseRotation\">TransformationMatrices.inverseRotation</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.inverseRotation\">Quaternions.inverseRotation</a>.
</p>
</html>"));
  end inverseRotation;

  function relativeRotation "Return relative orientation object"
    extends Modelica.Icons.Function;
    input Orientation R1 "Orientation object to rotate frame 0 into frame 1";
    input Orientation R2 "Orientation object to rotate frame 0 into frame 2";
    output Orientation R_rel
      "Orientation object to rotate frame 1 into frame 2";
  algorithm
    R_rel := Orientation(T=R2.T*transpose(R1.T),w= R2.w - resolve2(R2, resolve1(
       R1, R1.w)));
    annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
R_rel = Frames.<strong>relativeRotation</strong>(R1,R2);
</pre></blockquote>

<h4>Description</h4>
<p>
The function call <code>Frames.<strong>relativeRotation</strong>(R1,R2)</code> returns
orientation object R_rel that describes the orientation to rotate frame&nbsp;1 to frame&nbsp;2
from the orientation object R1 that describes the orientation to rotate from frame&nbsp;0 to frame&nbsp;1 and
from the orientation object R2 that describes the orientation to rotate from frame&nbsp;0 to frame&nbsp;2.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.relativeRotation\">TransformationMatrices.relativeRotation</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.relativeRotation\">Quaternions.relativeRotation</a>.
</p>
</html>"));
  end relativeRotation;

  function absoluteRotation
    "Return absolute orientation object from another absolute and a relative orientation object"

    extends Modelica.Icons.Function;
    input Orientation R1 "Orientation object to rotate frame 0 into frame 1";
    input Orientation R_rel "Orientation object to rotate frame 1 into frame 2";
    output Orientation R2 "Orientation object to rotate frame 0 into frame 2";
  algorithm
    R2 := Orientation(T=R_rel.T*R1.T,w= resolve2(R_rel, R1.w) + R_rel.w);
    annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
R2 = Frames.<strong>absoluteRotation</strong>(R1,R_rel);
</pre></blockquote>

<h4>Description</h4>
<p>
The function call <code>Frames.<strong>absoluteRotation</strong>(R1,R_rel)</code> returns
orientation object R2 that describes the orientation frame&nbsp;0 to frame&nbsp;2
from the orientation object R1 that describes the orientation to rotate from frame&nbsp;0 to frame&nbsp;1 and
from the relative orientation object R_rel that describes the orientation to rotate from frame&nbsp;1 to frame&nbsp;2.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.absoluteRotation\">TransformationMatrices.absoluteRotation</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.absoluteRotation\">Quaternions.absoluteRotation</a>.
</p>
</html>"));
  end absoluteRotation;

  function planarRotation "Return orientation object of a planar rotation"
    import Modelica.Math;
    extends Modelica.Icons.Function;
    input Real e[3](each final unit="1")
      "Normalized axis of rotation (must have length=1)";
    input Modelica.SIunits.Angle angle
      "Rotation angle to rotate frame 1 into frame 2 along axis e";
    input Modelica.SIunits.AngularVelocity der_angle "= der(angle)";
    output Orientation R "Orientation object to rotate frame 1 into frame 2";
  algorithm
    R := Orientation(T=outerProduct(e,e) + (identity(3) - outerProduct(e,e))*
      Math.cos(angle) - skew(e)*Math.sin(angle),w= e*der_angle);

    annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
R = Frames.<strong>planarRotation</strong>(e, angle, der_angle);
</pre></blockquote>

<h4>Description</h4>
<p>
The function call <code>Frames.<strong>planarRotation</strong>(e, angle, der_angle)</code> returns
orientation object R that describes the orientation to rotate in the plane along unit
axis <strong>e</strong> from frame&nbsp;1 into frame&nbsp;2 with angle <strong>angle</strong> and derivative of angle <strong>der_angle</strong>.
Note, \"e\" must be a unit vector. However, this is not checked in this function and the function will
return a wrong result, if length(e) is not one.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.planarRotationAngle\">planarRotationAngle</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.planarRotation\">TransformationMatrices.planarRotation</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.planarRotation\">Quaternions.planarRotation</a>.
</p>
</html>"));
  end planarRotation;

  function planarRotationAngle
    "Return angle of a planar rotation, given the rotation axis and the representations of a vector in frame 1 and frame 2"

    extends Modelica.Icons.Function;
    input Real e[3](each final unit="1")
      "Normalized axis of rotation to rotate frame 1 around e into frame 2 (must have length=1)";
    input Real v1[3]
      "A vector v resolved in frame 1 (shall not be parallel to e)";
    input Real v2[3]
      "Vector v resolved in frame 2, i.e., v2 = resolve2(planarRotation(e,angle),v1)";
    output Modelica.SIunits.Angle angle
      "Rotation angle to rotate frame 1 into frame 2 along axis e in the range: -pi <= angle <= pi";
  algorithm
    /* Vector v is resolved in frame 1 and frame 2 according to:
        (1)  v2 = (e*transpose(e) + (identity(3) - e*transpose(e))*cos(angle) - skew(e)*sin(angle))*v1;
                = e*(e*v1) + (v1 - e*(e*v1))*cos(angle) - cross(e,v1)*sin(angle)
       Equation (1) is multiplied with "v1" resulting in (note: e*e = 1)
            v1*v2 = (e*v1)*(e*v2) + (v1*v1 - (e*v1)*(e*v1))*cos(angle)
       and therefore:
        (2) cos(angle) = ( v1*v2 - (e*v1)*(e*v2)) / (v1*v1 - (e*v1)*(e*v1))
       Similarly, equation (1) is multiplied with cross(e,v1), i.e.,
       a vector that is orthogonal to e and to v1:
              cross(e,v1)*v2 = - cross(e,v1)*cross(e,v1)*sin(angle)
       and therefore:
          (3) sin(angle) = -cross(e,v1)*v2/(cross(e,v1)*cross(e,v1));
       We have e*e=1; Therefore:
          (4) v1*v1 - (e*v1)*(e*v1) = |v1|^2 - (|v1|*cos(e,v1))^2
       and
          (5) cross(e,v1)*cross(e,v1) = (|v1|*sin(e,v1))^2
                                      = |v1|^2*(1 - cos(e,v1)^2)
                                      = |v1|^2 - (|v1|*cos(e,v1))^2
       The denominators of (2) and (3) are identical, according to (4) and (5).
       Furthermore, the denominators are always positive according to (5).
       Therefore, in the equation "angle = atan2(sin(angle), cos(angle))" the
       denominators of sin(angle) and cos(angle) can be removed,
       resulting in:
          angle = atan2(-cross(e,v1)*v2, v1*v2 - (e*v1)*(e*v2));
    */
    angle := Modelica.Math.atan2(-cross(e, v1)*v2, v1*v2 - (e*v1)*(e*v2));
    annotation (Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
angle = Frames.<strong>planarRotationAngle</strong>(e, v1, v2);
</pre></blockquote>

<h4>Description</h4>
<p>
A call to this function of the form
</p>
<pre>
    Real[3]                e, v1, v2;
    Modelica.SIunits.Angle angle;
  <strong>equation</strong>
    angle = <strong>planarRotationAngle</strong>(e, v1, v2);
</pre>
<p>
computes the rotation angle \"<strong>angle</strong>\" of a planar
rotation along unit vector <strong>e</strong>, rotating frame&nbsp;1 into frame&nbsp;2, given
the coordinate representations of a vector \"v\" in frame&nbsp;1 (<strong>v1</strong>)
and in frame&nbsp;2 (<strong>v2</strong>). Therefore, the result of this function
fulfills the following equation:
</p>
<pre>
    v2 = <strong>resolve2</strong>(<strong>planarRotation</strong>(e,angle), v1)
</pre>
<p>
The rotation angle is returned in the range
</p>
<pre>
    -<font face=\"Symbol\">p</font> &lt;= angle &lt;= <font face=\"Symbol\">p</font>
</pre>
<p>
This function makes the following assumptions on the input arguments
</p>
<ul>
<li> Vector <strong>e</strong> has length 1, i.e., length(e) = 1</li>
<li> Vector \"v\" is not parallel to <strong>e</strong>, i.e.,
     length(cross(e,v1)) &ne; 0</li>
</ul>
<p>
The function does not check the above assumptions. If these
assumptions are violated, a wrong result will be returned
and/or a division by zero will occur.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.planarRotation\">planarRotation</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.planarRotationAngle\">TransformationMatrices.planarRotationAngle</a>.
</p>
</html>"));
  end planarRotationAngle;

  function axisRotation
    "Return rotation object to rotate around an angle along one frame axis"

    extends Modelica.Icons.Function;
    input Integer axis(min=1, max=3) "Rotate around 'axis' of frame 1";
    input Modelica.SIunits.Angle angle
      "Rotation angle to rotate frame 1 into frame 2 along 'axis' of frame 1";
    input Modelica.SIunits.AngularVelocity der_angle "= der(angle)";
    output Orientation R "Orientation object to rotate frame 1 into frame 2";
  algorithm
    R := Orientation(T=(if axis == 1 then [1, 0, 0; 0, Modelica.Math.cos(angle), Modelica.Math.sin(angle);
      0, -Modelica.Math.sin(angle), Modelica.Math.cos(angle)] else if axis == 2 then [Modelica.Math.cos(angle), 0, -Modelica.Math.sin(
      angle); 0, 1, 0; Modelica.Math.sin(angle), 0, Modelica.Math.cos(angle)] else [Modelica.Math.cos(angle), Modelica.Math.sin(angle),
       0; -Modelica.Math.sin(angle), Modelica.Math.cos(angle), 0; 0, 0, 1]),w= if axis == 1 then {der_angle,
      0,0} else if axis == 2 then {0,der_angle,0} else {0,0,der_angle});
    annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
R = Frames.<strong>axisRotation</strong>(axis, angle, der_angle);
</pre></blockquote>

<h4>Description</h4>
<p>
The function call <code>Frames.<strong>axisRotation</strong>(axis, angle, der_angle)</code> returns
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Orientation\">orientation object</a>&nbsp;R
that describes the orientation to rotate along unit axis <strong>axis</strong>
from frame&nbsp;1 into frame&nbsp;2 with angle <strong>angle</strong> and derivative of angle <strong>der_angle</strong>.
For example, Frames.axisRotation(2, phi, der_phi) returns the same orientation object as with the call
Frames.planarRotation({0,1,0}, phi, der_phi)
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.planarRotation\">planarRotation</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.axisRotation\">TransformationMatrices.axisRotation</a>.
</p>
</html>"));
  end axisRotation;

  function axesRotations
    "Return fixed rotation object to rotate in sequence around fixed angles along 3 axes"

    import TM = Modelica.Mechanics.MultiBody.Frames.TransformationMatrices;
    extends Modelica.Icons.Function;
    input Integer sequence[3](
      min={1,1,1},
      max={3,3,3}) = {1,2,3}
      "Sequence of rotations from frame 1 to frame 2 along axis sequence[i]";
    input Modelica.SIunits.Angle angles[3]
      "Rotation angles around the axes defined in 'sequence'";
    input Modelica.SIunits.AngularVelocity der_angles[3] "= der(angles)";
    output Orientation R "Orientation object to rotate frame 1 into frame 2";
  algorithm
    /*
  R := absoluteRotation(absoluteRotation(axisRotation(sequence[1], angles[1],
    der_angles[1]), axisRotation(sequence[2], angles[2], der_angles[2])),
    axisRotation(sequence[3], angles[3], der_angles[3]));
*/
    R := Orientation(T=TM.axisRotation(sequence[3], angles[3])*TM.axisRotation(
      sequence[2], angles[2])*TM.axisRotation(sequence[1], angles[1]),w=
      Frames.axis(sequence[3])*der_angles[3] + TM.resolve2(TM.axisRotation(
      sequence[3], angles[3]), Frames.axis(sequence[2])*der_angles[2]) +
      TM.resolve2(TM.axisRotation(sequence[3], angles[3])*TM.axisRotation(
      sequence[2], angles[2]), Frames.axis(sequence[1])*der_angles[1]));
    annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
R = Frames.<strong>axesRotations</strong>(sequence, angles, der_angles);
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Orientation\">orientation object</a>&nbsp;R
that describes the orientation defined by three elementary rotations in
a given <strong>sequence</strong>, each rotated by <strong>angles</strong>.
The angular velocity vector R.w is calculated from the angle derivatives
<strong>der_angles</strong>.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.axesRotations\">TransformationMatrices.axesRotations</a>.
</p>
</html>"));
  end axesRotations;

  function axesRotationsAngles
    "Return the 3 angles to rotate in sequence around 3 axes to construct the given orientation object"

    extends Modelica.Icons.Function;
    input Orientation R "Orientation object to rotate frame 1 into frame 2";
    input Integer sequence[3](
      min={1,1,1},
      max={3,3,3}) = {1,2,3}
      "Sequence of rotations from frame 1 to frame 2 along axis sequence[i]";
    input SI.Angle guessAngle1=0
      "Select angles[1] such that |angles[1] - guessAngle1| is a minimum";
    output SI.Angle angles[3]
      "Rotation angles around the axes defined in 'sequence' such that R=Frames.axesRotation(sequence,angles); -pi < angles[i] <= pi";
  protected
    Real e1_1[3](each final unit="1")
      "First rotation axis, resolved in frame 1";
    Real e2_1a[3](each final unit="1")
      "Second rotation axis, resolved in frame 1a";
    Real e3_1[3](each final unit="1")
      "Third rotation axis, resolved in frame 1";
    Real e3_2[3](each final unit="1")
      "Third rotation axis, resolved in frame 2";
    Real A
      "Coefficient A in the equation A*cos(angles[1])+B*sin(angles[1]) = 0";
    Real B
      "Coefficient B in the equation A*cos(angles[1])+B*sin(angles[1]) = 0";
    SI.Angle angle_1a "Solution 1 for angles[1]";
    SI.Angle angle_1b "Solution 2 for angles[1]";
    TransformationMatrices.Orientation T_1a
      "Orientation object to rotate frame 1 into frame 1a";
  algorithm
    /* The rotation object R is constructed by:
     (1) Rotating frame 1 along axis e1 (= axis sequence[1]) with angles[1]
         arriving at frame 1a.
     (2) Rotating frame 1a along axis e2 (= axis sequence[2]) with angles[2]
         arriving at frame 1b.
     (3) Rotating frame 1b along axis e3 (= axis sequence[3]) with angles[3]
         arriving at frame 2.
     The goal is to determine angles[1:3]. This is performed in the following way:
     1. e2 and e3 are perpendicular to each other, i.e., e2*e3 = 0;
        Both vectors are resolved in frame 1 (T_ij is transformation matrix
        from frame j to frame i; e1_1*e2_1a = 0, since the vectors are
        perpendicular to each other):
           e3_1 = T_12*e3_2
                = R[sequence[3],:];
           e2_1 = T_11a*e2_1a
                = ( e1_1*transpose(e1_1) + (identity(3) - e1_1*transpose(e1_1))*cos(angles[1])
                    + skew(e1_1)*sin(angles[1]) )*e2_1a
                = e2_1a*cos(angles[1]) + cross(e1_1, e2_1a)*sin(angles[1]);
        From this follows finally an equation for angles[1]
           e2_1*e3_1 = 0
                     = (e2_1a*cos(angles[1]) + cross(e1_1, e2_1a)*sin(angles[1]))*e3_1
                     = (e2_1a*e3_1)*cos(angles[1]) + cross(e1_1, e2_1a)*e3_1*sin(angles[1])
                     = A*cos(angles[1]) + B*sin(angles[1])
                       with A = e2_1a*e3_1, B = cross(e1_1, e2_1a)*e3_1
        This equation has two solutions in the range -pi < angles[1] <= pi:
           sin(angles[1]) =  k*A/sqrt(A*A + B*B)
           cos(angles[1]) = -k*B/sqrt(A*A + B*B)
                        k = +/-1
           tan(angles[1]) = k*A/(-k*B)
        that is:
           angles[1] = atan2(k*A, -k*B)
        If A and B are both zero at the same time, there is a singular configuration
        resulting in an infinite number of solutions for angles[1] (every value
        is possible).
     2. angles[2] is determined with function Frames.planarRotationAngle.
        This function requires to provide e_3 in frame 1a and in frame 1b:
          e3_1a = Frames.resolve2(planarRotation(e1_1,angles[1]), e3_1);
          e3_1b = e3_2
     3. angles[3] is determined with function Frames.planarRotationAngle.
        This function requires to provide e_2 in frame 1b and in frame 2:
          e2_1b = e2_1a
          e2_2  = Frames.resolve2( R, Frames.resolve1(planarRotation(e1_1,angles[1]), e2_1a));
  */
    assert(sequence[1] <> sequence[2] and sequence[2] <> sequence[3],
      "input argument 'sequence[1:3]' is not valid");
    e1_1 := if sequence[1] == 1 then {1,0,0} else if sequence[1] == 2 then {0,1,
      0} else {0,0,1};
    e2_1a := if sequence[2] == 1 then {1,0,0} else if sequence[2] == 2 then {0,
      1,0} else {0,0,1};
    e3_1 := R.T[sequence[3], :];
    e3_2 := if sequence[3] == 1 then {1,0,0} else if sequence[3] == 2 then {0,1,
      0} else {0,0,1};

    A := e2_1a*e3_1;
    B := cross(e1_1, e2_1a)*e3_1;
    if abs(A) <= 1e-12 and abs(B) <= 1e-12 then
      angles[1] := guessAngle1;
    else
      angle_1a := Modelica.Math.atan2(A, -B);
      angle_1b := Modelica.Math.atan2(-A, B);
      angles[1] := if abs(angle_1a - guessAngle1) <= abs(angle_1b - guessAngle1) then
              angle_1a else angle_1b;
    end if;
    T_1a := TransformationMatrices.planarRotation(e1_1, angles[1]);
    angles[2] := planarRotationAngle(e2_1a, TransformationMatrices.resolve2(
      T_1a, e3_1), e3_2);
    angles[3] := planarRotationAngle(e3_2, e2_1a,
      TransformationMatrices.resolve2(R.T, TransformationMatrices.resolve1(T_1a,
       e2_1a)));

    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
angles = Frames.<strong>axesRotationsAngles</strong>(R, sequence, guessAngle1);
</pre></blockquote>

<h4>Description</h4>
<p>
A call to this function of the form
</p>
<blockquote><pre>
  Frames.Orientation R;
  <strong>parameter</strong> Integer sequence[3] = {1,2,3};
  Modelica.SIunits.Angle angles[3];
<strong>equation</strong>
  angle = <strong>axesRotationAngles</strong>(R, sequence);
</pre></blockquote>
<p>
computes the rotation angles \"<strong>angles</strong>[1:3]\" to rotate frame&nbsp;1
into frame&nbsp;2 along axes <strong>sequence</strong>[1:3], given the orientation
object <strong>R</strong> from frame&nbsp;1 to frame&nbsp;2. Therefore, the result of
this function fulfills the following equation:
</p>
<blockquote><pre>
R = <strong>axesRotation</strong>(sequence, angles)
</pre></blockquote>
<p>
The rotation angles are returned in the range
</p>
<blockquote><pre>
-<font face=\"Symbol\">p</font> &lt;= angles[i] &lt;= <font face=\"Symbol\">p</font>
</pre></blockquote>
<p>
There are <strong>two solutions</strong> for \"angles[1]\" in this range.
Via the third argument <strong>guessAngle1</strong> (default = 0) the
returned solution is selected such that |angles[1] - guessAngle1| is
minimal. The orientation object R may be in a singular configuration, i.e.,
there is an infinite number of angle values leading to the same R. The returned solution is
selected by setting angles[1] = guessAngle1. Then angles[2]
and angles[3] can be uniquely determined in the above range.
</p>
<p>
Note, that input argument <strong>sequence</strong> has the restriction that
only values 1,2,3 can be used and that sequence[1] &ne; sequence[2]
and sequence[2] &ne; sequence[3]. Often used values are:
</p>
<blockquote><pre>
sequence = <strong>{1,2,3}</strong>  // Cardan angle sequence
         = <strong>{3,1,3}</strong>  // Euler angle sequence
         = <strong>{3,2,1}</strong>  // Tait-Bryan angle sequence
</pre></blockquote>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.axesRotationsAngles\">TransformationMatrices.axesRotationsAngles</a>.
</p>
</html>"));
  end axesRotationsAngles;

  function smallRotation
    "Return rotation angles valid for a small rotation and optionally residues that should be zero"

    extends Modelica.Icons.Function;
    input Orientation R "Orientation object to rotate frame 1 into frame 2";
    input Boolean withResidues=false
      "= false/true, if 'angles'/'angles and residues' are returned in phi";
    output Modelica.SIunits.Angle phi[if withResidues then 6 else 3]
      "The rotation angles around x-, y-, and z-axis of frame 1 to rotate frame 1 into frame 2 for a small rotation + optionally 3 residues that should be zero";
  algorithm
    /* Planar rotation:
       Trel = outerProduct(e,e) + (identity(3) - outerProduct(e,e))*cos(angle) - skew(e)*sin(angle)
            = identity(3) - skew(e)*angle, for small angles
            = identity(3) - skew(e*angle)
               define phi = e*angle, then
       Trel = [1,      phi3,   -phi2;
               -phi3,     1,    phi1;
                phi2, -phi1,       1 ];
  */
    phi := if withResidues then {R.T[2, 3],-R.T[1, 3],R.T[1, 2],R.T[1, 1] - 1,R.
       T[2, 2] - 1,R.T[1, 1]*R.T[2, 2] - R.T[2, 1]*R.T[1, 2] - 1} else {R.T[2,
      3],-R.T[1, 3],R.T[1, 2]};
    annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
phi = Frames.<strong>smallRotation</strong>(R, withResidues);
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns rotation angles valid for a small rotation of x-y-z sequence (i.e. {1,2,3}).
Optionally, residues are returned as well if <code>withResidues=true</code>.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.smallRotation\">TransformationMatrices.smallRotation</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.smallRotation\">Quaternions.smallRotation</a>.
</p>
</html>"));
  end smallRotation;

  function from_nxy "Return fixed orientation object from n_x and n_y vectors"
    extends Modelica.Icons.Function;
    input Real n_x[3](each final unit="1")
      "Vector in direction of x-axis of frame 2, resolved in frame 1";
    input Real n_y[3](each final unit="1")
      "Vector in direction of y-axis of frame 2, resolved in frame 1";
    output Orientation R "Orientation object to rotate frame 1 into frame 2";
  algorithm
    R := Orientation(T=TransformationMatrices.from_nxy(n_x,n_y),w= zeros(3));
    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
R = Frames.<strong>from_nxy</strong>(n_x, n_y);
</pre></blockquote>

<h4>Description</h4>
<p>
It is assumed that the two input vectors n_x and n_y are
resolved in frame&nbsp;1 and are directed along the x and y axis
of frame&nbsp;2 (i.e., n_x and n_y are orthogonal to each other)
The function returns the orientation object&nbsp;R to rotate from
frame&nbsp;1 to frame&nbsp;2.
</p>
<p>
The function is robust in the sense that it returns always
an orientation object&nbsp;R, even if n_y is not orthogonal to n_x.
This is performed in the following way:
<br>
If n_x and n_y are not orthogonal to each other, first a unit
vector e_y is determined that is orthogonal to n_x and is lying
in the plane spanned by n_x and n_y. If n_x and n_y are parallel
or nearly parallel to each other, a vector e_y is selected
arbitrarily such that e_x and e_y are orthogonal to each other.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.from_nxy\">TransformationMatrices.from_nxy</a>.
</p>
</html>"));
  end from_nxy;

  function from_nxz "Return fixed orientation object from n_x and n_z vectors"
    extends Modelica.Icons.Function;
    input Real n_x[3](each final unit="1")
      "Vector in direction of x-axis of frame 2, resolved in frame 1";
    input Real n_z[3](each final unit="1")
      "Vector in direction of z-axis of frame 2, resolved in frame 1";
    output Orientation R "Orientation object to rotate frame 1 into frame 2";
  algorithm
    R := Orientation(T=TransformationMatrices.from_nxz(n_x,n_z),w= zeros(3));
    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
R = Frames.<strong>from_nxz</strong>(n_x, n_z);
</pre></blockquote>

<h4>Description</h4>
<p>
It is assumed that the two input vectors n_x and n_z are
resolved in frame 1 and are directed along the x and z axis
of frame 2 (i.e., n_x and n_z are orthogonal to each other).
The function returns the
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Orientation\">orientation object</a>&nbsp;R
to rotate from frame 1 to frame 2.
</p>
<p>
The function is robust in the sense that it always returns
an orientation object R, even if n_z is not orthogonal to n_x.
This is performed in the following way:
<br>
If n_x and n_z are not orthogonal to each other, first a unit
vector e_z is determined that is orthogonal to n_x and is lying
in the plane spanned by n_x and n_z. If n_x and n_z are parallel
or nearly parallel to each other, a vector e_z is selected
arbitrarily such that n_x and e_z are orthogonal to each other.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.from_nxz\">TransformationMatrices.from_nxz</a>.
</p>
</html>"));
  end from_nxz;

  function from_T "Return orientation object R from transformation matrix T"
    extends Modelica.Icons.Function;
    input Real T[3, 3]
      "Transformation matrix to transform vector from frame 1 to frame 2 (v2=T*v1)";
    input Modelica.SIunits.AngularVelocity w[3]
      "Angular velocity from frame 2 with respect to frame 1, resolved in frame 2 (skew(w)=T*der(transpose(T)))";
    output Orientation R "Orientation object to rotate frame 1 into frame 2";
  algorithm
    R := Orientation(T=T,w= w);
    annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
R = Frames.<strong>from_T</strong>(T, w);
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns an
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Orientation\">orientation object</a>&nbsp;R
assembled from a transformation matrix&nbsp;T and an angular velocity vector&nbsp;w.
Generally, the transformation matrix&nbsp;T can be gained using a function from the
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices\">TransformationMatrices</a>
package.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.to_T\">to_T</a>.
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.from_T_inv\">from_T_inv</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.from_T\">TransformationMatrices.from_T</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.from_T\">Quaternions.from_T</a>.
</p>
</html>"));
  end from_T;

  function from_T2
    "Return orientation object R from transformation matrix T and its derivative der(T)"
    extends Modelica.Icons.Function;
    input Real T[3, 3]
      "Transformation matrix to transform vector from frame 1 to frame 2 (v2=T*v1)";
    input Real der_T[3,3] "= der(T)";
    output Orientation R "Orientation object to rotate frame 1 into frame 2";

  algorithm
    R := Orientation(T=T,w={T[3, :]*der_T[2, :],-T[3, :]*der_T[1, :],T[2, :]*der_T[1, :]});
    annotation (Inline=true,Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
R = Frames.<strong>from_T2</strong>(T, der_T);
</pre></blockquote>

<h4>Description</h4>
<p>
Computes the orientation object from a transformation matrix T and
the derivative der(T) of the transformation matrix.
Usually, it is more efficient to use function \"from_T\" instead, where
the angular velocity has to be given as input argument. Only if this
is not possible or too difficult to compute, use function from_T2(..).
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.from_T\">from_T</a>.
</p>
</html>"));
  end from_T2;

  function from_T_inv
    "Return orientation object R from inverse transformation matrix T_inv"

    extends Modelica.Icons.Function;
    input Real T_inv[3, 3]
      "Inverse transformation matrix to transform vector from frame 2 to frame 1 (v1=T_inv*v2)";
    input Modelica.SIunits.AngularVelocity w[3]
      "Angular velocity from frame 1 with respect to frame 2, resolved in frame 1 (skew(w)=T_inv*der(transpose(T_inv)))";
    output Orientation R "Orientation object to rotate frame 1 into frame 2";
  algorithm
    R := Orientation(T=transpose(T_inv),w= -w);
    annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
R = Frames.<strong>from_T_inv</strong>(T_inv, w);
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns an
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Orientation\">orientation object</a>&nbsp;R
assembled from an inverse transformation matrix T_inv and a correspondent angular velocity vector&nbsp;w.
Generally, the transformation matrix T_inv can be gained using a function from the
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices\">TransformationMatrices</a>
package, e.g. using T_inv = <a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.inverseRotation\">inverseRotation</a>(T).
Note that the velocity vector&nbsp;w has to be calculated accordingly.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.from_T\">from_T</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.from_T_inv\">TransformationMatrices.from_T_inv</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.from_T_inv\">Quaternions.from_T_inv</a>.
</p>
</html>"));
  end from_T_inv;

  function from_Q
    "Return orientation object R from quaternion orientation object Q"

    extends Modelica.Icons.Function;
    input Quaternions.Orientation Q
      "Quaternions orientation object to rotate frame 1 into frame 2";
    input Modelica.SIunits.AngularVelocity w[3]
      "Angular velocity from frame 2 with respect to frame 1, resolved in frame 2";
    output Orientation R "Orientation object to rotate frame 1 into frame 2";
  algorithm
    /*
  T := (2*Q[4]*Q[4] - 1)*identity(3) + 2*(outerProduct([Q[1:3],[Q[1:3]) - Q[4]*
    skew(Q[1:3]));
*/
    R := Orientation([2*(Q[1]*Q[1] + Q[4]*Q[4]) - 1, 2*(Q[1]*Q[2] + Q[3]*Q[4]),
       2*(Q[1]*Q[3] - Q[2]*Q[4]); 2*(Q[2]*Q[1] - Q[3]*Q[4]), 2*(Q[2]*Q[2] + Q[4]
      *Q[4]) - 1, 2*(Q[2]*Q[3] + Q[1]*Q[4]); 2*(Q[3]*Q[1] + Q[2]*Q[4]), 2*(Q[3]
      *Q[2] - Q[1]*Q[4]), 2*(Q[3]*Q[3] + Q[4]*Q[4]) - 1],w= w);
    annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
R = Frames.<strong>from_Q</strong>(Q, w);
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns an <a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Orientation\">orientation object</a>&nbsp;R
computed from a <a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.Orientation\">quaternion object</a>&nbsp;Q
and an angular velocity vector&nbsp;w.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.to_Q\">to_Q</a>.
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.from_Q\">TransformationMatrices.from_Q</a>.
</p>

</html>"));
  end from_Q;

  function to_T "Return transformation matrix T from orientation object R"
    extends Modelica.Icons.Function;
    input Orientation R "Orientation object to rotate frame 1 into frame 2";
    output Real T[3, 3]
      "Transformation matrix to transform vector from frame 1 to frame 2 (v2=T*v1)";
  algorithm
    T := R.T;
    annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
T = Frames.<strong>to_T</strong>(R);
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns a real matrix&nbsp;T
<!--<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.Orientation\">transformation matrix</a>&nbsp;T-->
computed from an
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Orientation\">orientation object</a>&nbsp;R.
The matrix&nbsp;T is considered to be an object transformation matrix.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.from_T\">from_T</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.to_T_inv\">to_T_inv</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.to_T\">TransformationMatrices.to_T</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.to_T\">Quaternions.to_T</a>.
</p>
</html>"));
  end to_T;

  function to_T_inv
    "Return inverse transformation matrix T_inv from orientation object R"

    extends Modelica.Icons.Function;
    input Orientation R "Orientation object to rotate frame 1 into frame 2";
    output Real T_inv[3, 3]
      "Inverse transformation matrix to transform vector from frame 2 into frame 1 (v1=T_inv*v2)";
  algorithm
    T_inv := transpose(R.T);
    annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
T_inv = Frames.<strong>to_T_inv</strong>(R);
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns a real matrix T_inv
<!--<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.Orientation\">transformation matrix</a>&nbsp;T_inv-->
computed from an
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Orientation\">orientation object</a>&nbsp;R.
The matrix T_inv is considered to be an inverse transformation matrix.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.from_T_inv\">from_T_inv</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.to_T\">to_T</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.to_T_inv\">TransformationMatrices.to_T_inv</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.to_T_inv\">Quaternions.to_T_inv</a>.
</p>
</html>"));
  end to_T_inv;

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

  function to_vector "Map rotation object into vector"
    extends Modelica.Icons.Function;
    input Orientation R "Orientation object to rotate frame 1 into frame 2";
    output Real vec[9] "Elements of R in one vector";
  algorithm
    vec := {R.T[1, 1],R.T[2, 1],R.T[3, 1],R.T[1, 2],R.T[2, 2],R.T[3, 2],R.T[1,
      3],R.T[2, 3],R.T[3, 3]};
    annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
vec = Frames.<strong>to_vector</strong>(R);
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns a vector vec which contains elements of a transformation matrix&nbsp;T
computed from an
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Orientation\">orientation object</a>&nbsp;R.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.to_T\">to_T</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.to_vector\">TransformationMatrices.to_vector</a>.
</p>
</html>"));
  end to_vector;

  function to_exy
    "Map rotation object into e_x and e_y vectors of frame 2, resolved in frame 1"

    extends Modelica.Icons.Function;
    input Orientation R "Orientation object to rotate frame 1 into frame 2";
    output Real exy[3, 2]
      "= [e_x, e_y] where e_x and e_y are axes unit vectors of frame 2, resolved in frame 1";
  algorithm
    exy := [R.T[1, :], R.T[2, :]];
    annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
exy = Frames.<strong>to_exy</strong>(R);
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns unit vectors e_x and e_y which define axes of frame&nbsp;2 resolved in frame&nbsp;1,
provided&nbsp;R is an <a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Orientation\">orientation object</a>
to rotate frame&nbsp;1 into frame&nbsp;2.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.from_nxy\">from_nxy</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.from_nxz\">from_nxz</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.to_exy\">TransformationMatrices.to_exy</a>.
</p>
</html>"));
  end to_exy;

  function axis "Return unit vector for x-, y-, or z-axis"
    extends Modelica.Icons.Function;
    input Integer axis(min=1, max=3) "Axis vector to be returned";
    output Real e[3](each final unit="1") "Unit axis vector";
  algorithm
    e := if axis == 1 then {1,0,0} else (if axis == 2 then {0,1,0} else {0,0,1});
    annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
e = Frames.<strong>axis</strong>(axis);
</pre></blockquote>

<h4>Description</h4>
<p>
A unit vector&nbsp;e is returned depending on whether x-, y-, or z-axis is required.
</p>
<blockquote><pre>
 axis  |    e
-------+-----------
  1    |  {1,0,0}
  2    |  {1,0,0}
  3    |  {1,0,0}
</pre></blockquote>
</html>"));
  end axis;

  package Quaternions
    "Functions to transform rotational frame quantities based on quaternions (also called Euler parameters)"
    extends Modelica.Icons.FunctionsPackage;

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
<pre>
   Quaternions.Orientation Q;
   Real  n[3];
   Real  phi(unit=\"rad\");
   Q = [ n*sin(phi/2)
           cos(phi/2) ]
</pre>
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

    type der_Orientation = Real[4] (each unit="1/s")
      "First time derivative of Quaternions.Orientation";

    function orientationConstraint
      "Return residues of orientation constraints (shall be zero)"
      extends Modelica.Icons.Function;
      input Quaternions.Orientation Q
        "Quaternions orientation object to rotate frame 1 into frame 2";
      output Real residue[1] "Residue constraint (shall be zero)";
    algorithm
      residue := {Q*Q - 1};
      annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
residue = Quaternions.<strong>orientationConstraint</strong>(Q);
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns the Real residue vector with&nbsp;1 element only that describes the constraints
between the&nbsp;4 elements of the
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.Orientation\">quaternions orientation</a>&nbsp;Q.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.orientationConstraint\">Frames.orientationConstraint</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.orientationConstraint\">TransformationMatrices.orientationConstraint</a>.
</p>
</html>"));
    end orientationConstraint;

    function angularVelocity1
      "Compute angular velocity resolved in frame 1 from quaternions orientation object and its derivative"

      extends Modelica.Icons.Function;
      input Quaternions.Orientation Q
        "Quaternions orientation object to rotate frame 1 into frame 2";
      input der_Orientation der_Q "Derivative of Q";
      output Modelica.SIunits.AngularVelocity w[3]
        "Angular velocity of frame 2 with respect to frame 1 resolved in frame 1";
    algorithm
      w := 2*([Q[4], -Q[3], Q[2], -Q[1]; Q[3], Q[4], -Q[1], -Q[2]; -Q[2], Q[1],
         Q[4], -Q[3]]*der_Q);
      annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
w = Quaternions.<strong>angularVelocity1</strong>(Q, der_Q);
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns the angular velocity&nbsp;w of frame&nbsp;2 with
respect to frame&nbsp;1, <strong>resolved in frame&nbsp;1</strong>, from the
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.Orientation\">quaternions orientation</a>&nbsp;Q
that describes the orientation to rotate frame&nbsp;1 into frame&nbsp;2
and from its first time derivative der_Q.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.angularVelocity1\">Frames.angularVelocity1</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.angularVelocity1\">TransformationMatrices.angularVelocity1</a>.
</p>
</html>"));
    end angularVelocity1;

    function angularVelocity2
      "Compute angular velocity resolved in frame 2 from quaternions orientation object and its derivative"

      extends Modelica.Icons.Function;
      input Quaternions.Orientation Q
        "Quaternions orientation object to rotate frame 1 into frame 2";
      input der_Orientation der_Q "Derivative of Q";
      output Modelica.SIunits.AngularVelocity w[3]
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

    function resolve1 "Transform vector from frame 2 to frame 1"
      extends Modelica.Icons.Function;
      input Quaternions.Orientation Q
        "Quaternions orientation object to rotate frame 1 into frame 2";
      input Real v2[3] "Vector in frame 2";
      output Real v1[3] "Vector in frame 1";
    algorithm
      v1 := 2*((Q[4]*Q[4] - 0.5)*v2 + (Q[1:3]*v2)*Q[1:3] + Q[4]*cross(Q[1:3],
        v2));
      annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
v1 = Quaternions.<strong>resolve1</strong>(Q, v2);
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns vector&nbsp;v resolved in frame&nbsp;1 (=v1) from vector&nbsp;v
resolved in frame&nbsp;2 (=v2) using the
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.Orientation\">quaternions orientation</a>&nbsp;Q
that describes the orientation to rotate frame&nbsp;1 into frame&nbsp;2.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.resolve2\">resolve2</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.resolve1\">Frames.resolve1</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.resolve1\">TransformationMatrices.resolve1</a>.
</p>
</html>"));
    end resolve1;

    function resolve2 "Transform vector from frame 1 to frame 2"
      extends Modelica.Icons.Function;
      input Quaternions.Orientation Q
        "Quaternions orientation object to rotate frame 1 into frame 2";
      input Real v1[3] "Vector in frame 1";
      output Real v2[3] "Vector in frame 2";
    algorithm
      v2 := 2*((Q[4]*Q[4] - 0.5)*v1 + (Q[1:3]*v1)*Q[1:3] - Q[4]*cross(Q[1:3],
        v1));
      annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
v2 = Quaternions.<strong>resolve2</strong>(Q, v1);
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns vector&nbsp;v resolved in frame&nbsp;2 (=v2) from vector&nbsp;v
resolved in frame&nbsp;1 (=v1) using the
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.Orientation\">quaternions orientation</a>&nbsp;Q
that describes the orientation to rotate frame&nbsp;1 into frame&nbsp;2.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.resolve1\">resolve1</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.resolve2\">Frames.resolve2</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.resolve2\">TransformationMatrices.resolve2</a>.
</p>
</html>"));
    end resolve2;

    function multipleResolve1
      "Transform several vectors from frame 2 to frame 1"
      extends Modelica.Icons.Function;
      input Quaternions.Orientation Q
        "Quaternions orientation object to rotate frame 1 into frame 2";
      input Real v2[3, :] "Vectors in frame 2";
      output Real v1[3, size(v2, 2)] "Vectors in frame 1";
    algorithm
      v1 := ((2*Q[4]*Q[4] - 1)*identity(3) + 2*(outerProduct(Q[1:3],Q[1:3]) +
        Q[4]*skew(Q[1:3])))*v2;
      annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
v1 = Quaternions.<strong>multipleResolve1</strong>(Q, v2);
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns vectors&nbsp;v resolved in frame&nbsp;1 (=v1) from vectors&nbsp;v
resolved in frame&nbsp;2 (=v2) using the
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.Orientation\">quaternions orientation</a>&nbsp;Q
that describes the orientation to rotate frame&nbsp;1 into frame&nbsp;2.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.multipleResolve1\">TransformationMatrices.multipleResolve1</a>.
</p>
</html>"));
    end multipleResolve1;

    function multipleResolve2
      "Transform several vectors from frame 1 to frame 2"
      extends Modelica.Icons.Function;
      input Quaternions.Orientation Q
        "Quaternions orientation object to rotate frame 1 into frame 2";
      input Real v1[3, :] "Vectors in frame 1";
      output Real v2[3, size(v1, 2)] "Vectors in frame 2";
    algorithm
      v2 := ((2*Q[4]*Q[4] - 1)*identity(3) + 2*(outerProduct(Q[1:3],Q[1:3]) -
        Q[4]*skew(Q[1:3])))*v1;
      annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
v2 = Quaternions.<strong>multipleResolve2</strong>(Q, v1);
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns vectors&nbsp;v resolved in frame&nbsp;2 (=v2) from vectors&nbsp;v
resolved in frame&nbsp;1 (=v1) using the
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.Orientation\">quaternions orientation</a>&nbsp;Q
that describes the orientation to rotate frame&nbsp;1 into frame&nbsp;2.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.multipleResolve2\">TransformationMatrices.multipleResolve2</a>.
</p>
</html>"));
    end multipleResolve2;

    function nullRotation
      "Return quaternion orientation object that does not rotate a frame"

      extends Modelica.Icons.Function;
      output Quaternions.Orientation Q
        "Quaternions orientation object to rotate frame 1 into frame 2";
    algorithm
      Q := {0,0,0,1};
      annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Q = Quaternions.<strong>nullRotation</strong>();
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns a
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.Orientation\">quaternions orientation</a>&nbsp;Q
describing the orientation object to rotate frame&nbsp;1 into frame&nbsp;2, if frame&nbsp;1 and frame&nbsp;2 are identical.
(= transformation matrix is identity matrix and angular velocity is zero).
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.nullRotation\">Frames.nullRotation</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.nullRotation\">TransformationMatrices.nullRotation</a>.
</p>
</html>"));
    end nullRotation;

    function inverseRotation "Return inverse quaternions orientation object"
      extends Modelica.Icons.Function;
      input Quaternions.Orientation Q
        "Quaternions orientation object to rotate frame 1 into frame 2";
      output Quaternions.Orientation Q_inv
        "Quaternions orientation object to rotate frame 2 into frame 1";
    algorithm
      Q_inv := {-Q[1],-Q[2],-Q[3],Q[4]};
      annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Q_inv = Quaternions.<strong>inverseRotation</strong>(Q);
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.Orientation\">quaternions orientation</a>&nbsp;Q_inv
that describes the orientation to rotate from frame&nbsp;2 to frame&nbsp;1
from the
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.Orientation\">quaternions orientation</a>&nbsp;Q
that describes the orientation to rotate from frame&nbsp;1 into frame&nbsp;2.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.inverseRotation\">Frames.inverseRotation</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.inverseRotation\">TransformationMatrices.inverseRotation</a>.

</p>
</html>"));
    end inverseRotation;

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

    function planarRotation
      "Return quaternion orientation object of a planar rotation"
      import Modelica.Math;
      extends Modelica.Icons.Function;
      input Real e[3](each final unit="1")
        "Normalized axis of rotation (must have length=1)";
      input Modelica.SIunits.Angle angle
        "Rotation angle to rotate frame 1 into frame 2 along axis e";
      output Quaternions.Orientation Q
        "Quaternions orientation object to rotate frame 1 into frame 2 along axis e";
    algorithm
      Q := vector([e*Math.sin(angle/2); Math.cos(angle/2)]);
      annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Q = Quaternions.<strong>planarRotation</strong>(e, angle);
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.Orientation\">quaternions orientation</a>&nbsp;Q
that describes the orientation to rotate in the plane along unit
axis <strong>e</strong> from frame 1 into frame 2 with angle <strong>angle</strong>.
Note, \"e\" must be a unit vector. However, this is not checked in this function and the function will
return a wrong result, if length(e) is not one.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.planarRotation\">Frames.planarRotation</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.planarRotation\">TransformationMatrices.planarRotation</a>.
</p>
</html>"));
    end planarRotation;

    function smallRotation "Return rotation angles valid for a small rotation"
      extends Modelica.Icons.Function;
      input Quaternions.Orientation Q
        "Quaternions orientation object to rotate frame 1 into frame 2";
      output Modelica.SIunits.Angle phi[3]
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

    function from_T
      "Return quaternion orientation object Q from transformation matrix T"

      extends Modelica.Icons.Function;
      input Real T[3, 3]
        "Transformation matrix to transform vector from frame 1 to frame 2 (v2=T*v1)";
      input Quaternions.Orientation Q_guess=nullRotation()
        "Guess value for Q (there are 2 solutions; the one close to Q_guess is used";
      output Quaternions.Orientation Q
        "Quaternions orientation object to rotate frame 1 into frame 2 (Q and -Q have same transformation matrix)";
    protected
      Real paux;
      Real paux4;
      Real c1;
      Real c2;
      Real c3;
      Real c4;
      constant Real p4limit=0.1;
      constant Real c4limit=4*p4limit*p4limit;
    algorithm
      /*
   Note, for quaternions, Q and -Q have the same transformation matrix.
   Calculation of quaternions from transformation matrix T:
   It is guaranteed that c1>=0, c2>=0, c3>=0, c4>=0 and
   that not all of them can be zero at the same time
   (e.g., if 3 of them are zero, the 4th variable is 1).
   Since the sqrt(..) has to be performed on one of these variables,
   it is applied on a variable which is far enough from zero.
   This guarantees that the sqrt(..) is never taken near zero
   and therefore the derivative of sqrt(..) can never be infinity.
   There is an ambiguity for quaternions, since Q and -Q
   lead to the same transformation matrix. The ambiguity
   is resolved here by selecting the Q that is closer to
   the input argument Q_guess.
*/
      c1 := 1 + T[1, 1] - T[2, 2] - T[3, 3];
      c2 := 1 + T[2, 2] - T[1, 1] - T[3, 3];
      c3 := 1 + T[3, 3] - T[1, 1] - T[2, 2];
      c4 := 1 + T[1, 1] + T[2, 2] + T[3, 3];

      if c4 > c4limit or (c4 > c1 and c4 > c2 and c4 > c3) then
        paux := sqrt(c4)/2;
        paux4 := 4*paux;
        Q := {(T[2, 3] - T[3, 2])/paux4,(T[3, 1] - T[1, 3])/paux4,(T[1, 2] - T[
          2, 1])/paux4,paux};

      elseif c1 > c2 and c1 > c3 and c1 > c4 then
        paux := sqrt(c1)/2;
        paux4 := 4*paux;
        Q := {paux,(T[1, 2] + T[2, 1])/paux4,(T[1, 3] + T[3, 1])/paux4,(T[2, 3]
           - T[3, 2])/paux4};

      elseif c2 > c1 and c2 > c3 and c2 > c4 then
        paux := sqrt(c2)/2;
        paux4 := 4*paux;
        Q := {(T[1, 2] + T[2, 1])/paux4,paux,(T[2, 3] + T[3, 2])/paux4,(T[3, 1]
           - T[1, 3])/paux4};

      else
        paux := sqrt(c3)/2;
        paux4 := 4*paux;
        Q := {(T[1, 3] + T[3, 1])/paux4,(T[2, 3] + T[3, 2])/paux4,paux,(T[1, 2]
           - T[2, 1])/paux4};
      end if;

      if Q*Q_guess < 0 then
        Q := -Q;
      end if;
      annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Q = Quaternions.<strong>from_T</strong>(T, Q_guess);
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns a
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.Orientation\">quaternions orientation</a>&nbsp;Q.
computed from a transformation matrix&nbsp;T
and depending on the initial guess Q_guess.
Generally, the transformation matrix&nbsp;T can be gained using a function from the
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices\">TransformationMatrices</a>
package.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.to_T\">to_T</a>.
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.from_T_inv\">from_T_inv</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.from_T\">Frames.from_T</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.from_T\">TransformationMatrices.from_T</a>.
</p>
</html>"));
    end from_T;

    function from_T_inv
      "Return quaternion orientation object Q from inverse transformation matrix T_inv"

      extends Modelica.Icons.Function;
      input Real T_inv[3, 3]
        "Inverse transformation matrix to transform vector from frame 2 to frame 1 (v1=T_inv*v2)";
      input Quaternions.Orientation Q_guess=nullRotation()
        "Guess value for output Q (there are 2 solutions; the one closer to Q_guess is used";
      output Quaternions.Orientation Q
        "Quaternions orientation object to rotate frame 1 into frame 2 (Q and -Q have same transformation matrix)";
    algorithm
      Q := from_T(transpose(T_inv), Q_guess);
      annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Q = Quaternions.<strong>from_T_inv</strong>(T_inv, Q_guess);
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns a
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.Orientation\">quaternions orientation</a>&nbsp;Q.
computed from an inverse transformation matrix T_inv
and depending on the initial guess Q_guess.
Generally, the transformation matrix T_inv can be gained using a function from the
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices\">TransformationMatrices</a>
package, e.g. using T_inv = <a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.inverseRotation\">inverseRotation</a>(T).
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.from_T\">from_T</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.from_T_inv\">Frames.from_T_inv</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.from_T_inv\">TransformationMatrices.from_T_inv</a>.
</p>
</html>"));
    end from_T_inv;

    function to_T
      "Return transformation matrix T from quaternion orientation object Q"

      extends Modelica.Icons.Function;
      input Quaternions.Orientation Q
        "Quaternions orientation object to rotate frame 1 into frame 2";
      output Real T[3, 3]
        "Transformation matrix to transform vector from frame 1 to frame 2 (v2=T*v1)";
    algorithm
      /*
  T := (2*Q[4]*Q[4] - 1)*identity(3) + 2*(outerProduct(Q[1:3],Q[1:3]) - Q[4]*
    skew(Q[1:3]));
*/
      T := [2*(Q[1]*Q[1] + Q[4]*Q[4]) - 1, 2*(Q[1]*Q[2] + Q[3]*Q[4]), 2*(Q[1]*Q[
        3] - Q[2]*Q[4]); 2*(Q[2]*Q[1] - Q[3]*Q[4]), 2*(Q[2]*Q[2] + Q[4]*Q[4])
         - 1, 2*(Q[2]*Q[3] + Q[1]*Q[4]); 2*(Q[3]*Q[1] + Q[2]*Q[4]), 2*(Q[3]*Q[2]
         - Q[1]*Q[4]), 2*(Q[3]*Q[3] + Q[4]*Q[4]) - 1];
      annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
T = Quaternions.<strong>to_T</strong>(Q);
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns a real matrix&nbsp;T
<!--<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.Orientation\">transformation matrix</a>&nbsp;T-->
computed from a
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.Orientation\">quaternions orientation</a>&nbsp;Q.
The matrix&nbsp;T is considered to be an object transformation matrix.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.from_T\">from_T</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.to_T_inv\">to_T_inv</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.to_T\">Frames.to_T</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.to_T\">TransformationMatrices.to_T</a>.
</p>
</html>"));
    end to_T;

    function to_T_inv
      "Return inverse transformation matrix T_inv from quaternion orientation object Q"

      extends Modelica.Icons.Function;
      input Quaternions.Orientation Q
        "Quaternions orientation object to rotate frame 1 into frame 2";
      output Real T_inv[3, 3]
        "Transformation matrix to transform vector from frame 2 to frame 1 (v1=T*v2)";
    algorithm
      /*
  T_inv := (2*Q[4]*Q[4] - 1)*identity(3) + 2*(outerProduct(Q[1:3],Q[1:3]) + Q[
    4]*skew(Q[1:3]));
*/
      T_inv := [2*(Q[1]*Q[1] + Q[4]*Q[4]) - 1, 2*(Q[2]*Q[1] - Q[3]*Q[4]), 2*(Q[
        3]*Q[1] + Q[2]*Q[4]); 2*(Q[1]*Q[2] + Q[3]*Q[4]), 2*(Q[2]*Q[2] + Q[4]*Q[
        4]) - 1, 2*(Q[3]*Q[2] - Q[1]*Q[4]); 2*(Q[1]*Q[3] - Q[2]*Q[4]), 2*(Q[2]*
        Q[3] + Q[1]*Q[4]), 2*(Q[3]*Q[3] + Q[4]*Q[4]) - 1];
      annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
T_inv = Quaternions.<strong>to_T_inv</strong>(Q);
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns a real matrix&nbsp;T_inv
computed from a
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.Orientation\">quaternions orientation</a>&nbsp;Q.
The matrix&nbsp;T is considered to be an inverse transformation matrix.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.to_T\">to_T</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.from_T_inv\">from_T_inv</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.to_T_inv\">Frames.to_T_inv</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.to_T_inv\">TransformationMatrices.to_T_inv</a>.
</p>
</html>"));
    end to_T_inv;

    annotation (Documentation(info="<html>
<p>
Package <strong>Frames.Quaternions</strong> contains type definitions and
functions to transform rotational frame quantities with quaternions.
Functions of this package are currently only utilized in
MultiBody.Parts.Body components, when quaternions shall be used
as parts of the body states.
Some functions are also used in a new Modelica package for
B-Spline interpolation that is able to interpolate paths consisting of
position vectors and orientation objects.
</p>
<h4>Content</h4>
<p>In the table below an example is given for every function definition.
The used variables have the following declaration:
</p>
<pre>
   Quaternions.Orientation Q, Q1, Q2, Q_rel, Q_inv;
   Real[3,3]   T, T_inv;
   Real[3]     v1, v2, w1, w2, n_x, n_y, n_z, res_ori, phi;
   Real[6]     res_equal;
   Real        L, angle;
</pre>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><th><strong><em>Function/type</em></strong></th><th><strong><em>Description</em></strong></th></tr>
  <tr><td><strong>Orientation Q;</strong></td>
      <td>New type defining a quaternion object that describes<br>
          the rotation of frame 1 into frame 2.
      </td>
  </tr>
  <tr><td><strong>der_Orientation</strong> der_Q;</td>
      <td>New type defining the first time derivative
         of Frames.Quaternions.Orientation.
      </td>
  </tr>
  <tr><td>res_ori = <strong>orientationConstraint</strong>(Q);</td>
      <td>Return the constraints between the variables of a quaternion object<br>
      (shall be zero).</td>
  </tr>
  <tr><td>w1 = <strong>angularVelocity1</strong>(Q, der_Q);</td>
      <td>Return angular velocity resolved in frame 1 from
          quaternion object Q<br> and its derivative der_Q.
     </td>
  </tr>
  <tr><td>w2 = <strong>angularVelocity2</strong>(Q, der_Q);</td>
      <td>Return angular velocity resolved in frame 2 from
          quaternion object Q<br> and its derivative der_Q.
     </td>
  </tr>
  <tr><td>v1 = <strong>resolve1</strong>(Q,v2);</td>
      <td>Transform vector v2 from frame 2 to frame 1.
      </td>
  </tr>
  <tr><td>v2 = <strong>resolve2</strong>(Q,v1);</td>
      <td>Transform vector v1 from frame 1 to frame 2.
     </td>
  </tr>
  <tr><td>[v1,w1] = <strong>multipleResolve1</strong>(Q, [v2,w2]);</td>
      <td>Transform several vectors from frame 2 to frame 1.
      </td>
  </tr>
  <tr><td>[v2,w2] = <strong>multipleResolve2</strong>(Q, [v1,w1]);</td>
      <td>Transform several vectors from frame 1 to frame 2.
      </td>
  </tr>
  <tr><td>Q = <strong>nullRotation</strong>()</td>
      <td>Return quaternion object R that does not rotate a frame.
      </td>
  </tr>
  <tr><td>Q_inv = <strong>inverseRotation</strong>(Q);</td>
      <td>Return inverse quaternion object.
      </td>
  </tr>
  <tr><td>Q_rel = <strong>relativeRotation</strong>(Q1,Q2);</td>
      <td>Return relative quaternion object from two absolute
          quaternion objects.
      </td>
  </tr>
  <tr><td>Q2 = <strong>absoluteRotation</strong>(Q1,Q_rel);</td>
      <td>Return absolute quaternion object from another
          absolute<br> and a relative quaternion object.
      </td>
  </tr>
  <tr><td>Q = <strong>planarRotation</strong>(e, angle);</td>
      <td>Return quaternion object of a planar rotation.
      </td>
  </tr>
  <tr><td>phi = <strong>smallRotation</strong>(Q);</td>
      <td>Return rotation angles phi valid for a small rotation.
      </td>
  </tr>
  <tr><td>Q = <strong>from_T</strong>(T);</td>
      <td>Return quaternion object Q from transformation matrix T.
      </td>
  </tr>
  <tr><td>Q = <strong>from_T_inv</strong>(T_inv);</td>
      <td>Return quaternion object Q from inverse transformation matrix T_inv.
      </td>
  </tr>
  <tr><td>T = <strong>to_T</strong>(Q);</td>
      <td>Return transformation matrix T from quaternion object Q.
      </td>
  </tr>
  <tr><td>T_inv = <strong>to_T_inv</strong>(Q);</td>
      <td>Return inverse transformation matrix T_inv from quaternion object Q.
      </td>
  </tr>
</table>
</html>"));
  end Quaternions;

  package TransformationMatrices "Functions for transformation matrices"
    extends Modelica.Icons.FunctionsPackage;
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
<pre>
   <strong>T</strong> = [<strong>e</strong><sub>x</sub>, <strong>e</strong><sub>y</sub>, <strong>e</strong><sub>z</sub>];
       e.g., <strong>T</strong> = [1,0,0; 0,1,0; 0,0,1]
</pre>
<p>
where <strong>e</strong><sub>x</sub>,<strong>e</strong><sub>y</sub>,<strong>e</strong><sub>z</sub>
are unit vectors in the direction of the x-axis, y-axis, and z-axis
of frame 1, resolved in frame 2, respectively. Therefore, if <strong>v</strong><sub>1</sub>
is vector <strong>v</strong> resolved in frame 1 and <strong>v</strong><sub>2</sub> is
vector <strong>v</strong> resolved in frame 2, the following relationship holds:
</p>
<pre>
    <strong>v</strong><sub>2</sub> = <strong>T</strong> * <strong>v</strong><sub>1</sub>
</pre>
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

    type der_Orientation = Real[3, 3] (each unit="1/s")
      "New type defining the first time derivative of Orientation";

    function orientationConstraint
      "Return residues of orientation constraints (shall be zero)"
      extends Modelica.Icons.Function;
      input TransformationMatrices.Orientation T
        "Orientation object to rotate frame 1 into frame 2";
      output Real residue[6]
        "Residues of constraints between elements of orientation object (shall be zero)";
    algorithm
      residue := {T[:, 1]*T[:, 1] - 1,T[:, 2]*T[:, 2] - 1,T[:, 3]*T[:, 3] - 1,T[
        :, 1]*T[:, 2],T[:, 1]*T[:, 3],T[:, 2]*T[:, 3]};
      annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
residue = TransformationMatrices.<strong>orientationConstraint</strong>(T);
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns the Real residue vector with&nbsp;6 elements that describes the constraints
between the&nbsp;9 elements of the
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.Orientation\">transformation matrix</a>&nbsp;T.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.orientationConstraint\">Frames.orientationConstraint</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.orientationConstraint\">Quaternions.orientationConstraint</a>.
</p>
</html>"));
    end orientationConstraint;

    function angularVelocity1
      "Return angular velocity resolved in frame 1 from orientation object and its derivative"

      extends Modelica.Icons.Function;
      input TransformationMatrices.Orientation T
        "Orientation object to rotate frame 1 into frame 2";
      input der_Orientation der_T "Derivative of T";
      output Modelica.SIunits.AngularVelocity w[3]
        "Angular velocity of frame 2 with respect to frame 1 resolved in frame 1";
    algorithm
      /* The angular velocity w of frame 2 with respect to frame 1 resolved in frame 1,
     is defined as:
        w = vec(der(transpose(T))*T );
     where
                   |   0 -w3  w2 |
         skew(w) = |  w3   0 -w1 | and w = vec(skew(w))
                   | -w2  w1   0 |
     i.e.
         W = der(transpose(T))*T)
         w = {W(3,2), -W(3,1), W(2,1)}
     Therefore, only 3 values of W need to be computed:
             | der(T[:,1]) |
         W = | der(T[:,2]) | * | T[:,1], T[:,2], T[:,3] |
             | der(T[:,3]) |
             |  W(3,2) |   |  der(T[:,3])*T[:,2] |
         w = | -W(3,1) | = | -der(T[:,3])*T[:,1] |
             |  W(2,1) |   |  der(T[:,2])*T[:,1] |
  */
      w := {der_T[:, 3]*T[:, 2],-der_T[:, 3]*T[:, 1],der_T[:, 2]*T[:, 1]};
      annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
w = TransformationMatrices.<strong>angularVelocity1</strong>(T, der_T);
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns the angular velocity&nbsp;w of frame&nbsp;2 with
respect to frame&nbsp;1, <strong>resolved in frame&nbsp;1</strong>, from the
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.Orientation\">transformation matrix</a>&nbsp;T
that describes the orientation to rotate frame&nbsp;1 into frame&nbsp;2
and from its first time derivative der_T:
</p>
<blockquote><pre>
w = vec( der(transpose(T)) * T ).
</pre></blockquote>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.angularVelocity1\">Frames.angularVelocity1</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.angularVelocity1\">Quaternions.angularVelocity1</a>.
</p>
</html>"));
    end angularVelocity1;

    function angularVelocity2
      "Return angular velocity resolved in frame 2 from orientation object and its derivative"

      extends Modelica.Icons.Function;
      input TransformationMatrices.Orientation T
        "Orientation object to rotate frame 1 into frame 2";
      input der_Orientation der_T "Derivative of T";
      output Modelica.SIunits.AngularVelocity w[3]
        "Angular velocity of frame 2 with respect to frame 1 resolved in frame 2";
    algorithm
      /* The angular velocity w of frame 2 with respect to frame 1 resolved in frame 2,
     is defined as:
        w = vec(T*der(transpose(T)));
     where
                   |   0 -w3  w2 |
         skew(w) = |  w3   0 -w1 | and w = vec(skew(w))
                   | -w2  w1   0 |
     i.e.
         W = T*der(transpose(T))
         w = {W(3,2), -W(3,1), W(2,1)}
     Therefore, only 3 values of W need to be computed:
             | T[1,:] |
         W = | T[2,:] | * | der(T[1,:]), der(T[2,:]), der(T[3,:]) |
             | T[3,:] |
             |  W(3,2) |   |  T[3,:]*der(T[2,:]) |
         w = | -W(3,1) | = | -T[3,:]*der(T[1,:]) |
             |  W(2,1) |   |  T[2,:]*der(T[1,:]) |
  */
      w := {T[3, :]*der_T[2, :],-T[3, :]*der_T[1, :],T[2, :]*der_T[1, :]};
      annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
w = TransformationMatrices.<strong>angularVelocity2</strong>(T, der_T);
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns the angular velocity&nbsp;w of frame&nbsp;2 with
respect to frame&nbsp;1, <strong>resolved in frame&nbsp;2</strong>, from the
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.Orientation\">transformation matrix</a>&nbsp;T
that describes the orientation to rotate frame&nbsp;1 into frame&nbsp;2
and from its first time derivative der_T:
</p>
<blockquote><pre>
w = vec( T * der(transpose(T)) ).
</pre></blockquote>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.angularVelocity2\">Frames.angularVelocity2</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.angularVelocity2\">Quaternions.angularVelocity2</a>.
</p>
</html>"));
    end angularVelocity2;

    function resolve1 "Transform vector from frame 2 to frame 1"
      extends Modelica.Icons.Function;
      input TransformationMatrices.Orientation T
        "Orientation object to rotate frame 1 into frame 2";
      input Real v2[3] "Vector in frame 2";
      output Real v1[3] "Vector in frame 1";
    algorithm
      v1 := transpose(T)*v2;
      annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
v1 = TransformationMatrices.<strong>resolve1</strong>(T, v2);
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns vector&nbsp;v resolved in frame&nbsp;1 (=v1) from vector&nbsp;v
resolved in frame&nbsp;2 (=v2) using the
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.Orientation\">transformation matrix</a>&nbsp;T
that describes the orientation to rotate frame&nbsp;1 into frame&nbsp;2.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.resolve2\">resolve2</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.resolve1\">Frames.resolve1</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.resolve1\">Quaternions.resolve1</a>.
</p>
</html>"));
    end resolve1;

    function resolve2 "Transform vector from frame 1 to frame 2"
      extends Modelica.Icons.Function;
      input TransformationMatrices.Orientation T
        "Orientation object to rotate frame 1 into frame 2";
      input Real v1[3] "Vector in frame 1";
      output Real v2[3] "Vector in frame 2";
    algorithm
      v2 := T*v1;
      annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
v2 = TransformationMatrices.<strong>resolve2</strong>(T, v1);
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns vector&nbsp;v resolved in frame&nbsp;2 (=v2) from vector&nbsp;v
resolved in frame&nbsp;1 (=v1) using the
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.Orientation\">transformation matrix</a>&nbsp;T
that describes the orientation to rotate frame&nbsp;1 into frame&nbsp;2.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.resolve1\">resolve1</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.resolve2\">Frames.resolve2</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.resolve2\">Quaternions.resolve2</a>.
</p>
</html>"));
    end resolve2;

    function multipleResolve1
      "Transform several vectors from frame 2 to frame 1"

      extends Modelica.Icons.Function;
      input TransformationMatrices.Orientation T
        "Orientation object to rotate frame 1 into frame 2";
      input Real v2[3, :] "Vectors in frame 2";
      output Real v1[3, size(v2, 2)] "Vectors in frame 1";
    algorithm
      v1 := transpose(T)*v2;
      annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
v1 = TransformationMatrices.<strong>multipleResolve1</strong>(T, v2);
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns vectors&nbsp;v resolved in frame&nbsp;1 (=v1) from vectors&nbsp;v
resolved in frame&nbsp;2 (=v2) using the
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.Orientation\">transformation matrix</a>&nbsp;T
that describes the orientation to rotate frame&nbsp;1 into frame&nbsp;2.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.multipleResolve1\">Quaternions.multipleResolve1</a>.
</p>
</html>"));
    end multipleResolve1;

    function multipleResolve2
      "Transform several vectors from frame 1 to frame 2"

      extends Modelica.Icons.Function;
      input TransformationMatrices.Orientation T
        "Orientation object to rotate frame 1 into frame 2";
      input Real v1[3, :] "Vectors in frame 1";
      output Real v2[3, size(v1, 2)] "Vectors in frame 2";
    algorithm
      v2 := T*v1;
      annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
v2 = TransformationMatrices.<strong>multipleResolve2</strong>(T, v1);
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns vectors&nbsp;v resolved in frame&nbsp;2 (=v2) from vectors&nbsp;v
resolved in frame&nbsp;1 (=v1) using the
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.Orientation\">transformation matrix</a>&nbsp;T
that describes the orientation to rotate frame&nbsp;1 into frame&nbsp;2.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.multipleResolve2\">Quaternions.multipleResolve2</a>.
</p>
</html>"));
    end multipleResolve2;

    function resolveDyade1
      "Transform second order tensor from frame 2 to frame 1"
      extends Modelica.Icons.Function;
      input TransformationMatrices.Orientation T
        "Orientation object to rotate frame 1 into frame 2";
      input Real D2[3, 3] "Second order tensor resolved in frame 2";
      output Real D1[3, 3] "Second order tensor resolved in frame 1";
    algorithm
      D1 := transpose(T)*D2*T;
      annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
D1 = TransformationMatrices.<strong>resolveDyade1</strong>(T, D2);
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns the second order tensor&nbsp;D
resolved in frame&nbsp;1 (= D1) from its representation in frame&nbsp;2 (= D2) using the
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.Orientation\">transformation matrix</a>&nbsp;T
that describes the orientation to rotate frame&nbsp;1 into frame&nbsp;2.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.resolveDyade1\">Frames.resolveDyade1</a>.
</p>
</html>"));
    end resolveDyade1;

    function resolveDyade2
      "Transform second order tensor from frame 1 to frame 2"
      extends Modelica.Icons.Function;
      input TransformationMatrices.Orientation T
        "Orientation object to rotate frame 1 into frame 2";
      input Real D1[3, 3] "Second order tensor resolved in frame 1";
      output Real D2[3, 3] "Second order tensor resolved in frame 2";
    algorithm
      D2 := T*D1*transpose(T);
      annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
D2 = TransformationMatrices.<strong>resolveDyade2</strong>(T, D1);
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns the second order tensor&nbsp;D
resolved in frame&nbsp;2 (= D2) from its representation in frame&nbsp;1 (= D1) using the
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.Orientation\">transformation matrix</a>&nbsp;T
that describes the orientation to rotate frame&nbsp;1 into frame&nbsp;2.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.resolveDyade2\">Frames.resolveDyade2</a>.
</p>
</html>"));
    end resolveDyade2;

    function nullRotation
      "Return orientation object that does not rotate a frame"
      extends Modelica.Icons.Function;
      output TransformationMatrices.Orientation T
        "Orientation object such that frame 1 and frame 2 are identical";
    algorithm
      T := identity(3);
      annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
T = TransformationMatrices.<strong>nullRotation</strong>();
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns a
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.Orientation\">transformation matrix</a>&nbsp;T
describing the orientation object to rotate frame&nbsp;1 into frame&nbsp;2, if frame&nbsp;1 and frame&nbsp;2 are identical.
(= transformation matrix is identity matrix and angular velocity is zero).
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.nullRotation\">Frames.nullRotation</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.nullRotation\">Quaternions.nullRotation</a>.
</p>
</html>"));
    end nullRotation;

    function inverseRotation "Return inverse orientation object"
      extends Modelica.Icons.Function;
      input TransformationMatrices.Orientation T
        "Orientation object to rotate frame 1 into frame 2";
      output TransformationMatrices.Orientation T_inv
        "Orientation object to rotate frame 2 into frame 1";
    algorithm
      T_inv := transpose(T);
      annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
T_inv = TransformationMatrices.<strong>inverseRotation</strong>(T);
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.Orientation\">transformation matrix</a> T_inv
that describes the orientation to rotate from frame&nbsp;2 to frame&nbsp;1
from the
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.Orientation\">transformation matrix</a>&nbsp;T
that describes the orientation to rotate from frame&nbsp;1 into frame&nbsp;2.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.inverseRotation\">Frames.inverseRotation</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.inverseRotation\">Quaternions.inverseRotation</a>.
</p>
</html>"));
    end inverseRotation;

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

    function absoluteRotation
      "Return absolute orientation object from another absolute and a relative orientation object"

      extends Modelica.Icons.Function;
      input TransformationMatrices.Orientation T1
        "Orientation object to rotate frame 0 into frame 1";
      input TransformationMatrices.Orientation T_rel
        "Orientation object to rotate frame 1 into frame 2";
      output TransformationMatrices.Orientation T2
        "Orientation object to rotate frame 0 into frame 2";
    algorithm
      T2 := T_rel*T1;
      annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
T2 = TransformationMatrices.<strong>absoluteRotation</strong>(T1, T_rel);
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.Orientation\">transformation matrix</a>&nbsp;T2
that describes the orientation frame&nbsp;0 to frame&nbsp;2 from the
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.Orientation\">transformation matrix</a>&nbsp;T1
that describes the orientation to rotate from frame&nbsp;0 to frame&nbsp;1 and from the relative
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.Orientation\">transformation matrix</a> T2_rel
that describes the orientation to rotate from frame&nbsp;1 to frame&nbsp;2.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.absoluteRotation\">Frames.absoluteRotation</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.absoluteRotation\">Quaternions.absoluteRotation</a>.
</p>
</html>"));
    end absoluteRotation;

    function planarRotation "Return orientation object of a planar rotation"
      import Modelica.Math;
      extends Modelica.Icons.Function;
      input Real e[3](each final unit="1")
        "Normalized axis of rotation (must have length=1)";
      input Modelica.SIunits.Angle angle
        "Rotation angle to rotate frame 1 into frame 2 along axis e";
      output TransformationMatrices.Orientation T
        "Orientation object to rotate frame 1 into frame 2";
    algorithm
      T := outerProduct(e,e) + (identity(3) - outerProduct(e,e))*Math.cos(
        angle) - skew(e)*Math.sin(angle);
      annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
T = TransformationMatrices.<strong>planarRotation</strong>(e, angle);
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.Orientation\">transformation matrix</a>&nbsp;T
that describes the orientation to rotate in the plane along unit
axis <strong>e</strong> from frame 1 into frame 2 with angle <strong>angle</strong>.
Note, \"e\" must be a unit vector. However, this is not checked in this function and the function will
return a wrong result, if length(e) is not one.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.planarRotationAngle\">planarRotationAngle</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.planarRotation\">Frames.planarRotation</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.planarRotation\">Quaternions.planarRotation</a>.
</p>
</html>"));
    end planarRotation;

    function planarRotationAngle
      "Return angle of a planar rotation, given the rotation axis and the representations of a vector in frame 1 and frame 2"

      extends Modelica.Icons.Function;
      input Real e[3](each final unit="1")
        "Normalized axis of rotation to rotate frame 1 around e into frame 2 (must have length=1)";
      input Real v1[3]
        "A vector v resolved in frame 1 (shall not be parallel to e)";
      input Real v2[3]
        "Vector v resolved in frame 2, i.e., v2 = resolve2(planarRotation(e,angle),v1)";
      output Modelica.SIunits.Angle angle
        "Rotation angle to rotate frame 1 into frame 2 along axis e in the range: -pi <= angle <= pi";
    algorithm
      /* Vector v is resolved in frame 1 and frame 2 according to:
        (1)  v2 = (e*transpose(e) + (identity(3) - e*transpose(e))*cos(angle) - skew(e)*sin(angle))*v1;
                = e*(e*v1) + (v1 - e*(e*v1))*cos(angle) - cross(e,v1)*sin(angle)
       Equation (1) is multiplied with "v1" resulting in (note: e*e = 1)
            v1*v2 = (e*v1)*(e*v2) + (v1*v1 - (e*v1)*(e*v1))*cos(angle)
       and therefore:
        (2) cos(angle) = ( v1*v2 - (e*v1)*(e*v2)) / (v1*v1 - (e*v1)*(e*v1))
       Similarly, equation (1) is multiplied with cross(e,v1), i.e., a
       a vector that is orthogonal to e and to v1:
              cross(e,v1)*v2 = - cross(e,v1)*cross(e,v1)*sin(angle)
       and therefore:
          (3) sin(angle) = -cross(e,v1)*v2/(cross(e,v1)*cross(e,v1));
       We have e*e=1; Therefore:
          (4) v1*v1 - (e*v1)*(e*v1) = |v1|^2 - (|v1|*cos(e,v1))^2
       and
          (5) cross(e,v1)*cross(e,v1) = (|v1|*sin(e,v1))^2
                                      = |v1|^2*(1 - cos(e,v1)^2)
                                      = |v1|^2 - (|v1|*cos(e,v1))^2
       The denominators of (2) and (3) are identical, according to (4) and (5).
       Furthermore, the denominators are always positive according to (5).
       Therefore, in the equation "angle = atan2(sin(angle), cos(angle))" the
       denominators of sin(angle) and cos(angle) can be removed,
       resulting in:
          angle = atan2(-cross(e,v1)*v2, v1*v2 - (e*v1)*(e*v2));
    */
      angle := Modelica.Math.atan2(-cross(e, v1)*v2, v1*v2 - (e*v1)*(e*v2));
      annotation (Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
angle = TransformationMatrices.<strong>planarRotationAngle</strong>(e, v1, v2);
</pre></blockquote>

<h4>Description</h4>
<p>
A call to this function of the form
</p>
<blockquote><pre>
  Real[3]                e, v1, v2;
  Modelica.SIunits.Angle angle;
<strong>equation</strong>
  angle = <strong>planarRotationAngle</strong>(e, v1, v2);
</pre></blockquote>
<p>
computes the rotation angle \"<strong>angle</strong>\" of a planar
rotation along unit vector <strong>e</strong>, rotating frame 1 into frame 2, given
the coordinate representations of a vector \"v\" in frame 1 (<strong>v1</strong>)
and in frame 2 (<strong>v2</strong>). Therefore, the result of this function
fulfills the following equation:
</p>
<blockquote><pre>
v2 = <strong>resolve2</strong>(<strong>planarRotation</strong>(e,angle), v1)
</pre></blockquote>
<p>
The rotation angle is returned in the range
</p>
<blockquote><pre>
-<font face=\"Symbol\">p</font> &lt;= angle &lt;= <font face=\"Symbol\">p</font>
</pre></blockquote>
<p>
This function makes the following assumptions on the input arguments
</p>
<ul>
<li> Vector <strong>e</strong> has length 1, i.e., length(e) = 1</li>
<li> Vector \"v\" is not parallel to <strong>e</strong>, i.e.,
     length(cross(e,v1)) &ne; 0</li>
</ul>
<p>
The function does not check the above assumptions. If these
assumptions are violated, a wrong result will be returned
and/or a division by zero will occur.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.planarRotation\">planarRotation</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.planarRotationAngle\">Frames.planarRotationAngle</a>.
</p>
</html>"));
    end planarRotationAngle;

    function axisRotation
      "Return rotation object to rotate around one frame axis"
      extends Modelica.Icons.Function;
      input Integer axis(min=1, max=3) "Rotate around 'axis' of frame 1";
      input Modelica.SIunits.Angle angle
        "Rotation angle to rotate frame 1 into frame 2 along 'axis' of frame 1";
      output TransformationMatrices.Orientation T
        "Orientation object to rotate frame 1 into frame 2";
    algorithm
      T := if axis == 1 then [1, 0, 0; 0, Modelica.Math.cos(angle), Modelica.Math.sin(angle); 0, -Modelica.Math.sin(angle),
         Modelica.Math.cos(angle)] else if axis == 2 then [Modelica.Math.cos(angle), 0, -Modelica.Math.sin(angle); 0, 1, 0;
         Modelica.Math.sin(angle), 0, Modelica.Math.cos(angle)] else [Modelica.Math.cos(angle), Modelica.Math.sin(angle), 0;
        -Modelica.Math.sin(angle), Modelica.Math.cos(angle), 0; 0, 0, 1];
      annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
T = TransformationMatrices.<strong>axisRotation</strong>(axis, angle);
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.Orientation\">transformation matrix</a>&nbsp;T
that describes the orientation to rotate along unit axis <strong>axis</strong>
from frame 1 into frame 2 with angle <strong>angle</strong>.
For example, TransformationMatrices.axisRotation(2, phi) returns the same orientation object as with the call
TransformationMatrices.planarRotation({0,1,0}, phi)
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.planarRotation\">planarRotation</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.axisRotation\">Frames.axisRotation</a>.
</p>
</html>"));
    end axisRotation;

    function axesRotations
      "Return rotation object to rotate in sequence around 3 axes"
      extends Modelica.Icons.Function;
      input Integer sequence[3](
        min={1,1,1},
        max={3,3,3}) = {1,2,3}
        "Sequence of rotations from frame 1 to frame 2 along axis sequence[i]";
      input Modelica.SIunits.Angle angles[3]={0,0,0}
        "Rotation angles around the axes defined in 'sequence'";
      output TransformationMatrices.Orientation T
        "Orientation object to rotate frame 1 into frame 2";
    algorithm
      T := absoluteRotation(absoluteRotation(axisRotation(sequence[1], angles[1]),
         axisRotation(sequence[2], angles[2])), axisRotation(sequence[3],
        angles[3]));
      annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
T = TransformationMatrices.<strong>axesRotations</strong>(sequence, angles);
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.Orientation\">transformation matrix</a>&nbsp;T
that describes the orientation defined by three elementary rotations in
a given <strong>sequence</strong>, each rotated by <strong>angles</strong>.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.axesRotations\">Frames.axesRotations</a>.
</p>
</html>"));
    end axesRotations;

    function axesRotationsAngles
      "Return the 3 angles to rotate in sequence around 3 axes to construct the given orientation object"

      extends Modelica.Icons.Function;
      input TransformationMatrices.Orientation T
        "Orientation object to rotate frame 1 into frame 2";
      input Integer sequence[3](
        min={1,1,1},
        max={3,3,3}) = {1,2,3}
        "Sequence of rotations from frame 1 to frame 2 along axis sequence[i]";
      input SI.Angle guessAngle1=0
        "Select angles[1] such that |angles[1] - guessAngle1| is a minimum";
      output SI.Angle angles[3]
        "Rotation angles around the axes defined in 'sequence' such that T=TransformationMatrices.axesRotation(sequence,angles); -pi < angles[i] <= pi";
    protected
      Real e1_1[3](each final unit="1")
        "First rotation axis, resolved in frame 1";
      Real e2_1a[3](each final unit="1")
        "Second rotation axis, resolved in frame 1a";
      Real e3_1[3](each final unit="1")
        "Third rotation axis, resolved in frame 1";
      Real e3_2[3](each final unit="1")
        "Third rotation axis, resolved in frame 2";
      Real A
        "Coefficient A in the equation A*cos(angles[1])+B*sin(angles[1]) = 0";
      Real B
        "Coefficient B in the equation A*cos(angles[1])+B*sin(angles[1]) = 0";
      SI.Angle angle_1a "Solution 1 for angles[1]";
      SI.Angle angle_1b "Solution 2 for angles[1]";
      TransformationMatrices.Orientation T_1a
        "Orientation object to rotate frame 1 into frame 1a";
    algorithm
      /* The rotation object T is constructed by:
     (1) Rotating frame 1 along axis e1 (= axis sequence[1]) with angles[1]
         arriving at frame 1a.
     (2) Rotating frame 1a along axis e2 (= axis sequence[2]) with angles[2]
         arriving at frame 1b.
     (3) Rotating frame 1b along axis e3 (= axis sequence[3]) with angles[3]
         arriving at frame 2.
     The goal is to determine angles[1:3]. This is performed in the following way:
     1. e2 and e3 are perpendicular to each other, i.e., e2*e3 = 0;
        Both vectors are resolved in frame 1 (T_ij is transformation matrix
        from frame j to frame i; e1_1*e2_1a = 0, since the vectors are
        perpendicular to each other):
           e3_1 = T_12*e3_2
                = T[sequence[3],:];
           e2_1 = T_11a*e2_1a
                = ( e1_1*transpose(e1_1) + (identity(3) - e1_1*transpose(e1_1))*cos(angles[1])
                    + skew(e1_1)*sin(angles[1]) )*e2_1a
                = e2_1a*cos(angles[1]) + cross(e1_1, e2_1a)*sin(angles[1]);
        From this follows finally an equation for angles[1]
           e2_1*e3_1 = 0
                     = (e2_1a*cos(angles[1]) + cross(e1_1, e2_1a)*sin(angles[1]))*e3_1
                     = (e2_1a*e3_1)*cos(angles[1]) + cross(e1_1, e2_1a)*e3_1*sin(angles[1])
                     = A*cos(angles[1]) + B*sin(angles[1])
                       with A = e2_1a*e3_1, B = cross(e1_1, e2_1a)*e3_1
        This equation has two solutions in the range -pi < angles[1] <= pi:
           sin(angles[1]) =  k*A/sqrt(A*A + B*B)
           cos(angles[1]) = -k*B/sqrt(A*A + B*B)
                        k = +/-1
           tan(angles[1]) = k*A/(-k*B)
        that is:
           angles[1] = atan2(k*A, -k*B)
        If A and B are both zero at the same time, there is a singular configuration
        resulting in an infinite number of solutions for angles[1] (every value
        is possible).
     2. angles[2] is determined with function TransformationMatrices.planarRotationAngle.
        This function requires to provide e_3 in frame 1a and in frame 1b:
          e3_1a = TransformationMatrices.resolve2(planarRotation(e1_1,angles[1]), e3_1);
          e3_1b = e3_2
     3. angles[3] is determined with function TransformationMatrices.planarRotationAngle.
        This function requires to provide e_2 in frame 1b and in frame 2:
          e2_1b = e2_1a
          e2_2  = TransformationMatrices.resolve2( T, TransformationMatrices.resolve1(planarRotation(e1_1,angles[1]), e2_1a));
  */
      assert(sequence[1] <> sequence[2] and sequence[2] <> sequence[3],
        "input argument 'sequence[1:3]' is not valid");
      e1_1 := if sequence[1] == 1 then {1,0,0} else if sequence[1] == 2 then {0,
        1,0} else {0,0,1};
      e2_1a := if sequence[2] == 1 then {1,0,0} else if sequence[2] == 2 then {
        0,1,0} else {0,0,1};
      e3_1 := T[sequence[3], :];
      e3_2 := if sequence[3] == 1 then {1,0,0} else if sequence[3] == 2 then {0,
        1,0} else {0,0,1};

      A := e2_1a*e3_1;
      B := cross(e1_1, e2_1a)*e3_1;
      if abs(A) <= 1e-12 and abs(B) <= 1e-12 then
        angles[1] := guessAngle1;
      else
        angle_1a := Modelica.Math.atan2(A, -B);
        angle_1b := Modelica.Math.atan2(-A, B);
        angles[1] := if abs(angle_1a - guessAngle1) <= abs(angle_1b -
          guessAngle1) then angle_1a else angle_1b;
      end if;
      T_1a := planarRotation(e1_1, angles[1]);
      angles[2] := TransformationMatrices.planarRotationAngle(e2_1a,
        TransformationMatrices.resolve2(T_1a, e3_1), e3_2);
      angles[3] := TransformationMatrices.planarRotationAngle(e3_2, e2_1a,
        TransformationMatrices.resolve2(T, TransformationMatrices.resolve1(T_1a,
         e2_1a)));

      annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
angles = TransformationMatrices.<strong>axesRotationsAngles</strong>(T, sequence, guessAngle1);
</pre></blockquote>

<h4>Description</h4>
<p>
A call to this function of the form
</p>
<blockquote><pre>
  TransformationMatrices.Orientation T;
  <strong>parameter</strong> Integer sequence[3] = {1,2,3};
  Modelica.SIunits.Angle angles[3];
<strong>equation</strong>
  angle = <strong>axesRotationAngles</strong>(T, sequence);
</pre></blockquote>
<p>
computes the rotation angles \"<strong>angles</strong>[1:3]\" to rotate frame 1
into frame 2 along axes <strong>sequence</strong>[1:3], given the
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.Orientation\">transformation matrix</a>&nbsp;T
from frame 1 to frame 2. Therefore, the result of
this function fulfills the following equation:
</p>
<blockquote><pre>
T = <strong>axesRotation</strong>(sequence, angles)
</pre></blockquote>
<p>
The rotation angles are returned in the range
</p>
<blockquote><pre>
-<font face=\"Symbol\">p</font> &lt;= angles[i] &lt;= <font face=\"Symbol\">p</font>
</pre></blockquote>
<p>
There are <strong>two solutions</strong> for \"angles[1]\" in this range.
Via the third argument <strong>guessAngle1</strong> (default = 0) the
returned solution is selected such that |angles[1] - guessAngle1| is
minimal. The orientation object T may be in a singular configuration, i.e.,
there is an infinite number of angle values leading to the same T. The returned solution is
selected by setting angles[1] = guessAngle1. Then angles[2]
and angles[3] can be uniquely determined in the above range.
</p>
<p>
Note, that input argument <strong>sequence</strong> has the restriction that
only values 1,2,3 can be used and that sequence[1] &ne; sequence[2]
and sequence[2] &ne; sequence[3]. Often used values are:
</p>
<blockquote><pre>
sequence = <strong>{1,2,3}</strong>  // Cardan angle sequence
         = <strong>{3,1,3}</strong>  // Euler angle sequence
         = <strong>{3,2,1}</strong>  // Tait-Bryan angle sequence
</pre></blockquote>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.axesRotationsAngles\">Frames.axesRotationsAngles</a>.
</p>
</html>"));
    end axesRotationsAngles;

    function smallRotation
      "Return rotation angles valid for a small rotation and optionally residues that should be zero"

      extends Modelica.Icons.Function;
      input TransformationMatrices.Orientation T
        "Orientation object to rotate frame 1 into frame 2";
      input Boolean withResidues=false
        "= false/true, if 'angles'/'angles and residues' are returned in phi";
      output Modelica.SIunits.Angle phi[if withResidues then 6 else 3]
        "The rotation angles around x-, y-, and z-axis of frame 1 to rotate frame 1 into frame 2 for a small rotation + optionally 3 residues that should be zero";
    algorithm
      /* Planar rotation:
       Trel = outerProduct(e,e) + (identity(3) - outerProduct(e,e))*cos(angle) - skew(e)*sin(angle)
            = identity(3) - skew(e)*angle, for small angles
            = identity(3) - skew(e*angle)
               define phi = e*angle, then
       Trel = [1,      phi3,   -phi2;
               -phi3,     1,    phi1;
                phi2, -phi1,       1 ];
  */
      phi := if withResidues then {T[2, 3],-T[1, 3],T[1, 2],T[1, 1] - 1,T[2, 2]
         - 1,T[1, 1]*T[2, 2] - T[2, 1]*T[1, 2] - 1} else {T[2, 3],-T[1, 3],T[1,
         2]};
      annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
phi = TransformationMatrices.<strong>smallRotation</strong>(T, withResidues);
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns rotation angles valid for a small rotation of x-y-z sequence (i.e. {1,2,3}).
Optionally, residues are returned as well if <code>withResidues=true</code>.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.smallRotation\">Frames.smallRotation</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.smallRotation\">Quaternions.smallRotation</a>.
</p>
</html>"));
    end smallRotation;

    function from_nxy "Return orientation object from n_x and n_y vectors"
      extends Modelica.Icons.Function;
      import Modelica.Math.Vectors.length;
      import Modelica.Math.Vectors.normalize;

      input Real n_x[3](each final unit="1")
        "Vector in direction of x-axis of frame 2, resolved in frame 1";
      input Real n_y[3](each final unit="1")
        "Vector in direction of y-axis of frame 2, resolved in frame 1";
      output TransformationMatrices.Orientation T
        "Orientation object to rotate frame 1 into frame 2";
    protected
      Real e_x[3](each final unit="1")=if length(n_x) < 1e-10 then {1,0,0} else normalize(n_x);
      Real n_z_aux[3](each final unit="1")=cross(e_x, n_y);
      Real n_y_aux[3](each final unit="1")=if n_z_aux*n_z_aux > 1.0e-6 then n_y
             else (if abs(e_x[1]) > 1.0e-6 then {0,1,0} else {1,0,0});
      Real e_z_aux[3](each final unit="1")=cross(e_x, n_y_aux);
      Real e_z[3](each final unit="1")=normalize(e_z_aux);
    algorithm
      T := {e_x,cross(e_z, e_x),e_z};
      annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
T = TransformationMatrices.<strong>from_nxy</strong>(n_x, n_y);
</pre></blockquote>

<h4>Description</h4>
<p>
It is assumed that the two input vectors n_x and n_y are
resolved in frame&nbsp;1 and are directed along the&nbsp;x and&nbsp;y axis
of frame&nbsp;2 (i.e., n_x and n_y are orthogonal to each other)
The function returns the orientation object&nbsp;T to rotate from
frame&nbsp;1 to frame&nbsp;2.
</p>
<p>
The function is robust in the sense that it returns always
an orientation object&nbsp;T, even if n_y is not orthogonal to n_x.
This is performed in the following way:
<br>
If n_x and n_y are not orthogonal to each other, first a unit
vector e_y is determined that is orthogonal to n_x and is lying
in the plane spanned by n_x and n_y. If n_x and n_y are parallel
or nearly parallel to each other, a vector e_y is selected
arbitrarily such that e_x and e_y are orthogonal to each other.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.from_nxy\">Frames.from_nxy</a>.
</p>
</html>"));
    end from_nxy;

    function from_nxz "Return orientation object from n_x and n_z vectors"
      extends Modelica.Icons.Function;
      import Modelica.Math.Vectors.length;
      import Modelica.Math.Vectors.normalize;

      input Real n_x[3](each final unit="1")
        "Vector in direction of x-axis of frame 2, resolved in frame 1";
      input Real n_z[3](each final unit="1")
        "Vector in direction of z-axis of frame 2, resolved in frame 1";
      output TransformationMatrices.Orientation T
        "Orientation object to rotate frame 1 into frame 2";
    protected
      Real e_x[3](each final unit="1")=if length(n_x) < 1e-10 then {1,0,0} else normalize(n_x);
      Real n_y_aux[3](each final unit="1")=cross(n_z, e_x);
      Real n_z_aux[3](each final unit="1")=if n_y_aux*n_y_aux > 1.0e-6 then n_z
             else (if abs(e_x[1]) > 1.0e-6 then {0,0,1} else {1,0,0});
      Real e_y_aux[3](each final unit="1")=cross(n_z_aux, e_x);
      Real e_y[3](each final unit="1")=normalize(e_y_aux);
    algorithm
      T := {e_x,e_y,cross(e_x, e_y)};
      annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
T = TransformationMatrices.<strong>from_nxz</strong>(n_x, n_z);
</pre></blockquote>

<h4>Description</h4>
<p>
It is assumed that the two input vectors n_x and n_z are
resolved in frame&nbsp;1 and are directed along the&nbsp;x and&nbsp;z axis
of frame&nbsp;2 (i.e., n_x and n_z are orthogonal to each other)
The function returns the orientation object&nbsp;T to rotate from
frame&nbsp;1 to frame&nbsp;2.
</p>
<p>
The function is robust in the sense that it returns always
an orientation object&nbsp;T, even if n_z is not orthogonal to n_x.
This is performed in the following way:
<br>
If n_x and n_z are not orthogonal to each other, first a unit
vector e_z is determined that is orthogonal to n_x and is lying
in the plane spanned by n_x and n_z. If n_x and n_z are parallel
or nearly parallel to each other, a vector e_z is selected
arbitrarily such that n_x and e_z are orthogonal to each other.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.from_nxz\">Frames.from_nxz</a>.
</p>
</html>"));
    end from_nxz;

    function from_T "Return orientation object R from transformation matrix T"
      extends Modelica.Icons.Function;
      input Real T[3, 3]
        "Transformation matrix to transform vector from frame 1 to frame 2 (v2=T*v1)";
      output TransformationMatrices.Orientation R
        "Orientation object to rotate frame 1 into frame 2";
    algorithm
      R := T;
      annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
R = TransformationMatrices.<strong>from_T</strong>(T);
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns a
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.Orientation\">transformation matrix</a>&nbsp;R
which is equal to a real input matrix&nbsp;T.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.from_T_inv\">from_T_inv</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.to_T\">to_T</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.from_T\">Frames.from_T</a>.
</p>
</html>"));
    end from_T;

    function from_T_inv
      "Return orientation object R from inverse transformation matrix T_inv"

      extends Modelica.Icons.Function;
      input Real T_inv[3, 3]
        "Inverse transformation matrix to transform vector from frame 2 to frame 1 (v1=T_inv*v2)";
      output TransformationMatrices.Orientation R
        "Orientation object to rotate frame 1 into frame 2";
    algorithm
      R := transpose(T_inv);
      annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
R = TransformationMatrices.<strong>from_T_inv</strong>(T_inv);
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns a
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.Orientation\">transformation matrix</a>&nbsp;R
which is inverse to real input matrix T_inv.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.to_T_inv\">to_T_inv</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.from_T\">from_T</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.from_T_inv\">Frames.from_T_inv</a>.
</p>
</html>"));
    end from_T_inv;

    function from_Q
      "Return orientation object T from quaternion orientation object Q"

      extends Modelica.Icons.Function;
      input Quaternions.Orientation Q
        "Quaternions orientation object to rotate frame 1 into frame 2";
      output TransformationMatrices.Orientation T
        "Orientation object to rotate frame 1 into frame 2";
    algorithm
      /*
  T := (2*Q[4]*Q[4] - 1)*identity(3) + 2*(outerProduct(Q[1:3],Q[1:3]) - Q[4]*
    skew(Q[1:3]));
*/
      T := [2*(Q[1]*Q[1] + Q[4]*Q[4]) - 1, 2*(Q[1]*Q[2] + Q[3]*Q[4]), 2*(Q[1]*Q[
        3] - Q[2]*Q[4]); 2*(Q[2]*Q[1] - Q[3]*Q[4]), 2*(Q[2]*Q[2] + Q[4]*Q[4])
         - 1, 2*(Q[2]*Q[3] + Q[1]*Q[4]); 2*(Q[3]*Q[1] + Q[2]*Q[4]), 2*(Q[3]*Q[2]
         - Q[1]*Q[4]), 2*(Q[3]*Q[3] + Q[4]*Q[4]) - 1];
      annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
T = TransformationMatrices.<strong>from_Q</strong>(Q);
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns a
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.Orientation\">transformation matrix</a>&nbsp;T
computed from a <a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.Orientation\">quaternion object</a>&nbsp;Q
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.to_Q\">to_Q</a>.
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.from_Q\">Frames.from_Q</a>.
</p>
</html>"));
    end from_Q;

    function to_T "Return transformation matrix T from orientation object R"
      extends Modelica.Icons.Function;
      input TransformationMatrices.Orientation R
        "Orientation object to rotate frame 1 into frame 2";
      output Real T[3, 3]
        "Transformation matrix to transform vector from frame 1 to frame 2 (v2=T*v1)";
    algorithm
      T := R;
      annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
T = TransformationMatrices.<strong>to_T</strong>(R);
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns a real matrix&nbsp;T which is equal to a
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Orientation\">transformation matrix</a>&nbsp;R.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.from_T\">from_T</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.to_T_inv\">to_T_inv</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.to_T\">Frames.to_T</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.to_T\">Quaternions.to_T</a>.
</p>
</html>"));
    end to_T;

    function to_T_inv
      "Return inverse transformation matrix T_inv from orientation object R"

      extends Modelica.Icons.Function;
      input TransformationMatrices.Orientation R
        "Orientation object to rotate frame 1 into frame 2";
      output Real T_inv[3, 3]
        "Inverse transformation matrix to transform vector from frame 2 into frame 1 (v1=T_inv*v2)";
    algorithm
      T_inv := transpose(R);
      annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
T_inv = TransformationMatrices.<strong>to_T_inv</strong>(R);
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns a real matrix&nbsp;T_inv
which is inverse to a
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.Orientation\">transformation matrix</a>&nbsp;R.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.from_T_inv\">from_T_inv</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.to_T\">to_T</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.to_T_inv\">Frames.to_T_inv</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.to_T_inv\">Quaternions.to_T_inv</a>.
</p>
</html>"));
    end to_T_inv;

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

    function to_vector "Map rotation object into vector"
      extends Modelica.Icons.Function;
      input TransformationMatrices.Orientation T
        "Orientation object to rotate frame 1 into frame 2";
      output Real vec[9] "Elements of T in one vector";
    algorithm
      vec := {T[1, 1],T[2, 1],T[3, 1],T[1, 2],T[2, 2],T[3, 2],T[1, 3],T[2, 3],T[
        3, 3]};
      annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
vec = TransformationMatrices.<strong>to_vector</strong>(T);
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns a vector vec which contains elements of a
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.Orientation\">transformation matrix</a>&nbsp;T.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.to_T\">to_T</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.to_vector\">Frames.to_vector</a>.
</p>
</html>"));
    end to_vector;

    function to_exy
      "Map rotation object into e_x and e_y vectors of frame 2, resolved in frame 1"

      extends Modelica.Icons.Function;
      input TransformationMatrices.Orientation T
        "Orientation object to rotate frame 1 into frame 2";
      output Real exy[3, 2]
        "= [e_x, e_y] where e_x and e_y are axes unit vectors of frame 2, resolved in frame 1";
    algorithm
      exy := [T[1, :], T[2, :]];
      annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
exy = TransformationMatrices.<strong>to_exy</strong>(T);
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns unit vectors e_x and e_y which define axes of frame&nbsp;2 resolved in frame&nbsp;1,
provided&nbsp;T is a <a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.Orientation\">transformation matrix</a>
to rotate frame&nbsp;1 into &nbsp;2.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.from_nxy\">from_nxy</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.from_nxz\">from_nxz</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.to_exy\">Frames.to_exy</a>.
</p>
</html>"));
    end to_exy;
    annotation (Documentation(info="<html>
<p>
Package <strong>Frames.TransformationMatrices</strong> contains type definitions and
functions to transform rotational frame quantities using
transformation matrices.
</p>
<h4>Content</h4>
<p>In the table below an example is given for every function definition.
The used variables have the following declaration:
</p>
<pre>
   Orientation T, T1, T2, T_rel, T_inv;
   Real[3]     v1, v2, w1, w2, n_x, n_y, n_z, e, e_x, res_ori, phi;
   Real[6]     res_equal;
   Real        L, angle;
</pre>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><th><strong><em>Function/type</em></strong></th><th><strong><em>Description</em></strong></th></tr>
  <tr><td><strong>Orientation T;</strong></td>
      <td>New type defining an orientation object that describes<br>
          the rotation of frame 1 into frame 2.
      </td>
  </tr>
  <tr><td><strong>der_Orientation</strong> der_T;</td>
      <td>New type defining the first time derivative
         of Frames.Orientation.
      </td>
  </tr>
  <tr><td>res_ori = <strong>orientationConstraint</strong>(T);</td>
      <td>Return the constraints between the variables of an orientation object<br>
      (shall be zero).</td>
  </tr>
  <tr><td>w1 = <strong>angularVelocity1</strong>(T, der_T);</td>
      <td>Return angular velocity resolved in frame 1 from
          orientation object T<br> and its derivative der_T.
     </td>
  </tr>
  <tr><td>w2 = <strong>angularVelocity2</strong>(T, der_T);</td>
      <td>Return angular velocity resolved in frame 2 from
          orientation object T<br> and its derivative der_T.
     </td>
  </tr>
  <tr><td>v1 = <strong>resolve1</strong>(T,v2);</td>
      <td>Transform vector v2 from frame 2 to frame 1.
      </td>
  </tr>
  <tr><td>v2 = <strong>resolve2</strong>(T,v1);</td>
      <td>Transform vector v1 from frame 1 to frame 2.
     </td>
  </tr>
  <tr><td>[v1,w1] = <strong>multipleResolve1</strong>(T, [v2,w2]);</td>
      <td>Transform several vectors from frame 2 to frame 1.
      </td>
  </tr>
  <tr><td>[v2,w2] = <strong>multipleResolve2</strong>(T, [v1,w1]);</td>
      <td>Transform several vectors from frame 1 to frame 2.
      </td>
  </tr>
  <tr><td>D1 = <strong>resolveDyade1</strong>(T,D2);</td>
      <td>Transform second order tensor D2 from frame 2 to frame 1.
      </td>
  </tr>
  <tr><td>D2 = <strong>resolveDyade2</strong>(T,D1);</td>
      <td>Transform second order tensor D1 from frame 1 to frame 2.
     </td>
  </tr>
  <tr><td>T= <strong>nullRotation</strong>()</td>
      <td>Return orientation object T that does not rotate a frame.
     </td>
  </tr>
  <tr><td>T_inv = <strong>inverseRotation</strong>(T);</td>
      <td>Return inverse orientation object.
      </td>
  </tr>
  <tr><td>T_rel = <strong>relativeRotation</strong>(T1,T2);</td>
      <td>Return relative orientation object from two absolute
          orientation objects.
      </td>
  </tr>
  <tr><td>T2 = <strong>absoluteRotation</strong>(T1,T_rel);</td>
      <td>Return absolute orientation object from another
          absolute<br> and a relative orientation object.
      </td>
  </tr>
  <tr><td>T = <strong>planarRotation</strong>(e, angle);</td>
      <td>Return orientation object of a planar rotation.
      </td>
  </tr>
  <tr><td>angle = <strong>planarRotationAngle</strong>(e, v1, v2);</td>
      <td>Return angle of a planar rotation, given the rotation axis<br>
        and the representations of a vector in frame 1 and frame 2.
      </td>
  </tr>
  <tr><td>T = <strong>axisRotation</strong>(i, angle);</td>
      <td>Return orientation object T for rotation around axis i of frame 1.
      </td>
  </tr>
  <tr><td>T = <strong>axesRotations</strong>(sequence, angles);</td>
      <td>Return rotation object to rotate in sequence around 3 axes. Example:<br>
          T = axesRotations({1,2,3},{90,45,-90});
      </td>
  </tr>
  <tr><td>angles = <strong>axesRotationsAngles</strong>(T, sequence);</td>
      <td>Return the 3 angles to rotate in sequence around 3 axes to<br>
          construct the given orientation object.
      </td>
  </tr>
  <tr><td>phi = <strong>smallRotation</strong>(T);</td>
      <td>Return rotation angles phi valid for a small rotation.
      </td>
  </tr>
  <tr><td>T = <strong>from_nxy</strong>(n_x, n_y);</td>
      <td>Return orientation object from n_x and n_y vectors.
      </td>
  </tr>
  <tr><td>T = <strong>from_nxz</strong>(n_x, n_z);</td>
      <td>Return orientation object from n_x and n_z vectors.
      </td>
  </tr>
  <tr><td>R = <strong>from_T</strong>(T);</td>
      <td>Return orientation object R from transformation matrix T.
      </td>
  </tr>
  <tr><td>R = <strong>from_T_inv</strong>(T_inv);</td>
      <td>Return orientation object R from inverse transformation matrix T_inv.
      </td>
  </tr>
  <tr><td>T = <strong>from_Q</strong>(Q);</td>
      <td>Return orientation object T from quaternion orientation object Q.
      </td>
  </tr>
  <tr><td>T = <strong>to_T</strong>(R);</td>
      <td>Return transformation matrix T from orientation object R.
      </td>
  </tr>
  <tr><td>T_inv = <strong>to_T_inv</strong>(R);</td>
      <td>Return inverse transformation matrix T_inv from orientation object R.
      </td>
  </tr>
  <tr><td>Q = <strong>to_Q</strong>(T);</td>
      <td>Return quaternion orientation object Q from orientation object T.
      </td>
  </tr>
  <tr><td>exy = <strong>to_exy</strong>(T);</td>
      <td>Return [e_x, e_y] matrix of an orientation object T,<br>
          with e_x and e_y vectors of frame 2, resolved in frame 1.
      </td>
  </tr>
</table>
</html>"));
  end TransformationMatrices;

  package Internal
    "Internal definitions that may be removed or changed (do not use)"
    extends Modelica.Icons.InternalPackage;

    type TransformationMatrix = Real[3, 3];
    type QuaternionBase = Real[4];

    function maxWithoutEvent
      "Maximum of the input arguments, without event and function can be differentiated"
      extends Modelica.Icons.Function;
      input Real u1;
      input Real u2;
      output Real y;
    algorithm
      y := if u1 > u2 then u1 else u2;
      annotation (
        Inline=false,
        derivative=maxWithoutEvent_d,
        Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
y = Internal.<strong>maxWithoutEvent</strong>(u1, u2)
</pre></blockquote>

<h4>Description</h4>
<p>
Function <strong>maxWithoutEvent</strong> returns the maximum of its two
input arguments. This functions is used instead of the Modelica
built-in function \"max\" or an if-statement with \"noEvent(..)\",
in order that the function can be differentiated by providing
the first and second derivatives with additional functions.
Note, from a strict mathematical point of view the derivatives
will be wrong, since Dirac impulses would occur in the
derivatives. For the special cases as used in the MultiBody
library, this is irrelevant and therefore the usage of the function is correct.
</p>
</html>"));
    end maxWithoutEvent;

    function maxWithoutEvent_d
      "First derivative of function maxWithoutEvent(..)"
      extends Modelica.Icons.Function;

      input Real u1;
      input Real u2;
      input Real u1_d;
      input Real u2_d;
      output Real y_d;
    algorithm
      y_d := if u1 > u2 then u1_d else u2_d;
      annotation (
        Inline=false,
        derivative(order=2) = maxWithoutEvent_dd,
        Documentation(info="<html>
<p>
This is a derivative of function
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Internal.maxWithoutEvent\">maxWithoutEvent</a>.
</p>
</html>"));
    end maxWithoutEvent_d;

    function maxWithoutEvent_dd
      "First derivative of function maxWithoutEvent_d(..)"
      extends Modelica.Icons.Function;

      input Real u1;
      input Real u2;
      input Real u1_d;
      input Real u2_d;
      input Real u1_dd;
      input Real u2_dd;
      output Real y_dd;
    algorithm
      y_dd := if u1 > u2 then u1_dd else u2_dd;
      annotation (
        Inline=true, Documentation(info="<html>
<p>
This is a derivative of function
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Internal.maxWithoutEvent_d\">maxWithoutEvent_d</a>,
i.e. a second derivative of function
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Internal.maxWithoutEvent\">maxWithoutEvent</a>.
</p>
</html>"));
    end maxWithoutEvent_dd;

    function resolve1_der "Derivative of function Frames.resolve1(..)"
      import Modelica.Mechanics.MultiBody.Frames;
      extends Modelica.Icons.Function;
      input Orientation R "Orientation object to rotate frame 1 into frame 2";
      input Real v2[3] "Vector resolved in frame 2";
      input Real v2_der[3] "= der(v2)";
      output Real v1_der[3] "Derivative of vector v resolved in frame 1";
    algorithm
      v1_der := Frames.resolve1(R, v2_der + cross(R.w, v2));
      annotation(Inline=true, Documentation(info="<html>
<p>
This is a derivative of function
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.resolve1\">resolve1</a>.
</p>
</html>"));
    end resolve1_der;

    function resolve2_der "Derivative of function Frames.resolve2(..)"
      import Modelica.Mechanics.MultiBody.Frames;
      extends Modelica.Icons.Function;
      input Orientation R "Orientation object to rotate frame 1 into frame 2";
      input Real v1[3] "Vector resolved in frame 1";
      input Real v1_der[3] "= der(v1)";
      output Real v2_der[3] "Derivative of vector v resolved in frame 2";
    algorithm
      v2_der := Frames.resolve2(R, v1_der) - cross(R.w, Frames.resolve2(R, v1));
      annotation(Inline=true, Documentation(info="<html>
<p>
This is a derivative of function
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.resolve2\">resolve2</a>.
</p>
</html>"));
    end resolve2_der;

    function resolveRelative_der
      "Derivative of function Frames.resolveRelative(..)"
      import Modelica.Mechanics.MultiBody.Frames;
      extends Modelica.Icons.Function;
      input Real v1[3] "Vector in frame 1";
      input Orientation R1 "Orientation object to rotate frame 0 into frame 1";
      input Orientation R2 "Orientation object to rotate frame 0 into frame 2";
      input Real v1_der[3] "= der(v1)";
      output Real v2_der[3] "Derivative of vector v resolved in frame 2";
    algorithm
      v2_der := Frames.resolveRelative(v1_der+cross(R1.w,v1), R1, R2)
                - cross(R2.w, Frames.resolveRelative(v1, R1, R2));

      /* skew(w) = T*der(T'), -skew(w) = der(T)*T'

     v2 = T2*(T1'*v1)
     der(v2) = der(T2)*T1'*v1 + T2*der(T1')*v1 + T2*T1'*der(v1)
             = der(T2)*T2'*T2*T1'*v1 + T2*T1'*T1*der(T1')*v1 + T2*T1'*der(v1)
             = -w2 x (T2*T1'*v1) + T2*T1'*(w1 x v1) + T2*T1'*der(v1)
             = T2*T1'*(der(v1) + w1 x v1) - w2 x (T2*T1'*v1)
  */
      annotation(Inline=true, Documentation(info="<html>
<p>
This is a derivative of function
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.resolveRelative\">resolveRelative</a>.
</p>
</html>"));
    end resolveRelative_der;
    annotation (Documentation(info="<html>
<p>
Package with classes that are used within package Frames.
The classes in this package should not be directly used by a user.
</p>
</html>"));
  end Internal;

  annotation (Documentation(info="<html>
<p>
Package <strong>Frames</strong> contains type definitions and
functions to transform rotational frame quantities. The basic idea is to
hide the actual definition of an <strong>orientation</strong> in this package
by providing essentially type <strong>Orientation</strong> together with
<strong>functions</strong> operating on instances of this type.
</p>
<h4>Content</h4>
<p>In the table below an example is given for every function definition.
The used variables have the following declaration:
</p>
<pre>
   Frames.Orientation R, R1, R2, R_rel, R_inv;
   Real[3,3]   T, T_inv;
   Real[3]     v1, v2, w1, w2, n_x, n_y, n_z, e, e_x, res_ori, phi;
   Real[6]     res_equal;
   Real        L, angle;
</pre>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><th><strong><em>Function/type</em></strong></th><th><strong><em>Description</em></strong></th></tr>
  <tr><td><strong>Orientation R;</strong></td>
      <td>New type defining an orientation object that describes<br>
          the rotation of frame 1 into frame 2.
      </td>
  </tr>
  <tr><td>res_ori = <strong>orientationConstraint</strong>(R);</td>
      <td>Return the constraints between the variables of an orientation object<br>
      (shall be zero).</td>
  </tr>
  <tr><td>w1 = <strong>angularVelocity1</strong>(R);</td>
      <td>Return angular velocity resolved in frame 1 from
          orientation object R.
     </td>
  </tr>
  <tr><td>w2 = <strong>angularVelocity2</strong>(R);</td>
      <td>Return angular velocity resolved in frame 2 from
          orientation object R.
     </td>
  </tr>
  <tr><td>v1 = <strong>resolve1</strong>(R,v2);</td>
      <td>Transform vector v2 from frame 2 to frame 1.
      </td>
  </tr>
  <tr><td>v2 = <strong>resolve2</strong>(R,v1);</td>
      <td>Transform vector v1 from frame 1 to frame 2.
     </td>
  </tr>
  <tr><td>v2 = <strong>resolveRelative</strong>(v1,R1,R2);</td>
      <td>Transform vector v1 from frame 1 to frame 2
          using absolute orientation objects R1 of frame 1 and R2 of frame 2.
      </td>
  </tr>
  <tr><td>D1 = <strong>resolveDyade1</strong>(R,D2);</td>
      <td>Transform second order tensor D2 from frame 2 to frame 1.
      </td>
  </tr>
  <tr><td>D2 = <strong>resolveDyade2</strong>(R,D1);</td>
      <td>Transform second order tensor D1 from frame 1 to frame 2.
     </td>
  </tr>
  <tr><td>R = <strong>nullRotation</strong>()</td>
      <td>Return orientation object R that does not rotate a frame.
     </td>
  </tr>
  <tr><td>R_inv = <strong>inverseRotation</strong>(R);</td>
      <td>Return inverse orientation object.
      </td>
  </tr>
  <tr><td>R_rel = <strong>relativeRotation</strong>(R1,R2);</td>
      <td>Return relative orientation object from two absolute
          orientation objects.
      </td>
  </tr>
  <tr><td>R2 = <strong>absoluteRotation</strong>(R1,R_rel);</td>
      <td>Return absolute orientation object from another
          absolute<br> and a relative orientation object.
      </td>
  </tr>
  <tr><td>R = <strong>planarRotation</strong>(e, angle, der_angle);</td>
      <td>Return orientation object of a planar rotation.
      </td>
  </tr>
  <tr><td>angle = <strong>planarRotationAngle</strong>(e, v1, v2);</td>
      <td>Return angle of a planar rotation, given the rotation axis<br>
        and the representations of a vector in frame 1 and frame 2.
      </td>
  </tr>
  <tr><td>R = <strong>axisRotation</strong>(axis, angle, der_angle);</td>
      <td>Return orientation object R to rotate around angle along axis of frame 1.
      </td>
  </tr>
  <tr><td>R = <strong>axesRotations</strong>(sequence, angles, der_angles);</td>
      <td>Return rotation object to rotate in sequence around 3 axes. Example:<br>
          R = axesRotations({1,2,3},{pi/2,pi/4,-pi}, zeros(3));
      </td>
  </tr>
  <tr><td>angles = <strong>axesRotationsAngles</strong>(R, sequence);</td>
      <td>Return the 3 angles to rotate in sequence around 3 axes to<br>
          construct the given orientation object.
      </td>
  </tr>
  <tr><td>phi = <strong>smallRotation</strong>(R);</td>
      <td>Return rotation angles phi valid for a small rotation R.
      </td>
  </tr>
  <tr><td>R = <strong>from_nxy</strong>(n_x, n_y);</td>
      <td>Return orientation object from n_x and n_y vectors.
      </td>
  </tr>
  <tr><td>R = <strong>from_nxz</strong>(n_x, n_z);</td>
      <td>Return orientation object from n_x and n_z vectors.
      </td>
  </tr>
  <tr><td>R = <strong>from_T</strong>(T,w);</td>
      <td>Return orientation object R from transformation matrix T and
          its angular velocity w.
      </td>
  </tr>
  <tr><td>R = <strong>from_T2</strong>(T,der(T));</td>
      <td>Return orientation object R from transformation matrix T and
          its derivative der(T).
      </td>
  </tr>
  <tr><td>R = <strong>from_T_inv</strong>(T_inv,w);</td>
      <td>Return orientation object R from inverse transformation matrix T_inv and
          its angular velocity w.
      </td>
  </tr>
  <tr><td>R = <strong>from_Q</strong>(Q,w);</td>
      <td>Return orientation object R from quaternion orientation object Q
          and its angular velocity w.
      </td>
  </tr>
  <tr><td>T = <strong>to_T</strong>(R);</td>
      <td>Return transformation matrix T from orientation object R.
      </td>
  </tr>
  <tr><td>T_inv = <strong>to_T_inv</strong>(R);</td>
      <td>Return inverse transformation matrix T_inv from orientation object R.
      </td>
  </tr>
  <tr><td>Q = <strong>to_Q</strong>(R);</td>
      <td>Return quaternion orientation object Q from orientation object R.
      </td>
  </tr>
  <tr><td>exy = <strong>to_exy</strong>(R);</td>
      <td>Return [e_x, e_y] matrix of an orientation object R,<br>
          with e_x and e_y vectors of frame 2, resolved in frame 1.
      </td>
  </tr>
  <tr><td>L = <strong>length</strong>(n_x);</td>
      <td>Return length L of a vector n_x.
      </td>
  </tr>
  <tr><td>e_x = <strong>normalize</strong>(n_x);</td>
      <td>Return normalized vector e_x of n_x such that length of e_x is one.
      </td>
  </tr>
  <tr><td>e = <strong>axis</strong>(i);</td>
      <td>Return unit vector e directed along axis i
      </td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions\">Quaternions</a></td>
      <td><strong>Package</strong> with functions to transform rotational frame quantities based
          on quaternions (also called Euler parameters).
      </td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices\">TransformationMatrices</a></td>
      <td><strong>Package</strong> with functions to transform rotational frame quantities based
          on transformation matrices.
      </td>
  </tr>
</table>
</html>"), Icon(graphics={
        Line(points={{-2,-18},{80,-60}}, color={95,95,95}),
        Line(points={{-2,-18},{-2,80}}, color={95,95,95}),
        Line(points={{-78,-56},{-2,-18}}, color={95,95,95})}));
end Frames;
