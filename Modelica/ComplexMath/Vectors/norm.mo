within Modelica.ComplexMath.Vectors;
function norm "Returns the p-norm of a complex vector"
  extends Modelica.Icons.Function;
  input Complex v[:] "Vector";
  input Real p(min=1) = 2
        "Type of p-norm (often used: 1, 2, or Modelica.Constants.inf)";
  output Real result "p-norm of vector v";

algorithm
  if p == 2 then
    result:= sqrt(sum(v[i].re^2 + v[i].im^2 for i in 1:size(v,1)));
  elseif p == Modelica.Constants.inf then
    result := ComplexMath.'abs'(ComplexMath.'max'(v));
  elseif p == 1 then
    result := sum(ComplexMath.'abs'(v[i]) for i in 1:size(v, 1));
  else
    result := (sum(ComplexMath.'abs'(v[i])^p for i in 1:size(v, 1)))^(1/p);
  end if;

  annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Vectors.<strong>norm</strong>(v);
Vectors.<strong>norm</strong>(v,p=2);   // 1 &le; p &le; &#8734;
</pre></blockquote>

<h4>Description</h4>
<p>
The function call \"<code>Vectors.<strong>norm</strong>(v)</code>\" returns the
<strong>Euclidean norm</strong> \"<code>sqrt(v*v)</code>\" of vector v.
With the optional
second argument \"p\", any other p-norm can be computed:
</p>
<center>
<img src=\"modelica://Modelica/Resources/Images/Math/Vectors/vectorNorm.png\" alt=\"function Vectors.norm\">
</center>
<p>
Besides the Euclidean norm (p=2), also the 1-norm and the
infinity-norm are sometimes used:
</p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><td><strong>1-norm</strong></td>
      <td>= sum(abs(v))</td>
      <td><strong>norm</strong>(v,1)</td>
  </tr>
  <tr><td><strong>2-norm</strong></td>
      <td>= sqrt(v*v)</td>
      <td><strong>norm</strong>(v) or <strong>norm</strong>(v,2)</td>
  </tr>
  <tr><td><strong>infinity-norm</strong></td>
      <td>= max(abs(v))</td>
      <td><strong>norm</strong>(v,Modelica.Constants.<strong>inf</strong>)</td>
  </tr>
</table>
<p>
Note, for any vector norm the following inequality holds:
</p>
<blockquote><pre>
<strong>norm</strong>(v1+v2,p) &le; <strong>norm</strong>(v1,p) + <strong>norm</strong>(v2,p)
</pre></blockquote>

<h4>Example</h4>
<blockquote><pre>
v = {2, -4, -2, -1};
<strong>norm</strong>(v,1);    // = 9
<strong>norm</strong>(v,2);    // = 5
<strong>norm</strong>(v);      // = 5
<strong>norm</strong>(v,10.5); // = 4.00052597412635
<strong>norm</strong>(v,Modelica.Constants.inf);  // = 4
</pre></blockquote>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Math.Matrices.norm\">Matrices.norm</a>
</p>
</html>"));
end norm;
