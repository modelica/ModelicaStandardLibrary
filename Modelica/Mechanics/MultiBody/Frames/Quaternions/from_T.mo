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
