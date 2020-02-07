within Modelica.Mechanics.MultiBody.Frames.TransformationMatrices;
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
  SI.Angle angles[3];
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
-&pi; &lt;= angles[i] &lt;= &pi;
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
