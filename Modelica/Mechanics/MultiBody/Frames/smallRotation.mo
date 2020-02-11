within Modelica.Mechanics.MultiBody.Frames;
function smallRotation
  "Return rotation angles valid for a small rotation and optionally residues that should be zero"

  extends Modelica.Icons.Function;
  input Orientation R "Orientation object to rotate frame 1 into frame 2";
  input Boolean withResidues=false
    "= false/true, if 'angles'/'angles and residues' are returned in phi";
  output SI.Angle phi[if withResidues then 6 else 3]
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
