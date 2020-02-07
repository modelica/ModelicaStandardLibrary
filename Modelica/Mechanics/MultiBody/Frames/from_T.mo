within Modelica.Mechanics.MultiBody.Frames;
function from_T "Return orientation object R from transformation matrix T"
  extends Modelica.Icons.Function;
  input Real T[3, 3]
    "Transformation matrix to transform vector from frame 1 to frame 2 (v2=T*v1)";
  input SI.AngularVelocity w[3]
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
