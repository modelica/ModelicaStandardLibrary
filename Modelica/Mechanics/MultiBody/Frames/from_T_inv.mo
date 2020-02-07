within Modelica.Mechanics.MultiBody.Frames;
function from_T_inv
  "Return orientation object R from inverse transformation matrix T_inv"

  extends Modelica.Icons.Function;
  input Real T_inv[3, 3]
    "Inverse transformation matrix to transform vector from frame 2 to frame 1 (v1=T_inv*v2)";
  input SI.AngularVelocity w[3]
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
