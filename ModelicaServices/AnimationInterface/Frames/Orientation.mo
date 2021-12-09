within ModelicaServices.AnimationInterface.Frames;
record Orientation
  "Orientation object defining rotation from a frame 1 into a frame 2"

  extends Icons.Record;
  Real T[3, 3] "Transformation matrix from world frame to local frame";
  Types.AngularVelocity w[3]
    "Absolute angular velocity of local frame, resolved in local frame";

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
