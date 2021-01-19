within Modelica.Mechanics.MultiBody.Frames.Quaternions;
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
  Real t;
algorithm
  /*
   This is an optimized version of the quaternion conversion based on
   this paper: https://d3cw3dd2w32x2b.cloudfront.net/wp-content/uploads/2015/01/matrix-to-quat.pdf
*/
  if T[3, 3] < 0 then
    if T[1, 1] > T[2, 2] then
      t := 1 + T[1, 1] - T[2, 2] - T[3, 3];
      Q := {t, T[1, 2] + T[2, 1], T[3, 1] + T[1, 3], T[2, 3] - T[3, 2]};
    else
      t := 1 - T[1, 1] + T[2, 2] - T[3, 3];
      Q := {T[1, 2] + T[2, 1], t, T[2, 3] + T[3, 2], T[3, 1] - T[1, 3]};
    end if;
  else
    if T[1, 1] < -T[2, 2] then
      t := 1 - T[1, 1] - T[2, 2] + T[3, 3];
      Q := {T[3, 1] + T[1, 3], T[2, 3] + T[3, 2], t, T[1, 2] - T[2, 1]};
    else
      t := 1 + T[1, 1] + T[2, 2] + T[3, 3];
      Q := {T[2, 3] - T[3, 2], T[3, 1] - T[1, 3], T[1, 2] - T[2, 1], t};
    end if;
  end if;
  Q := Q*0.5/sqrt(t);

  /*
   Note:
   There is an ambiguity for quaternions, since Q and -Q
   lead to the same transformation matrix. The ambiguity
   is resolved here by selecting the Q that is closer to
   the input argument Q_guess.
*/
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
</html>", revisions="<html>
<ul>
  <li>January 2021 by Jakub Tobolar<br>
       reimplemented for more efficient and numerically stable algorithm according to
       <a href=\"https://d3cw3dd2w32x2b.cloudfront.net/wp-content/uploads/2015/01/matrix-to-quat.pdf\">https://d3cw3dd2w32x2b.cloudfront.net/wp-content/uploads/2015/01/matrix-to-quat.pdf</a>.
       It compares only one particular diagonal element with another to
       select one of the four code parts. Then, the selected code delivers
       four components which are close to the desired quaternion,
       so that it has only be scaled by an appropriate factor.<br>
       We appreciate the effort of Mike Day, the author of the abovementioned document.
       Credit also goes to Matthias Hellerer (DLR) for making inquiries
       and the first Modelica implementation.
  </li>
</ul>
</html>"));
end from_T;
