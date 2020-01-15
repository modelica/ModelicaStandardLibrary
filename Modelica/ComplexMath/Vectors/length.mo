within Modelica.ComplexMath.Vectors;
function length "Return length of a complex vector"
  extends Modelica.Icons.Function;
  input Complex v[:] "Vector";
  output Real result "Length of vector v";

algorithm
  result := sqrt(sum({v[i].re^2 + v[i].im^2 for i in 1:size(v,1)}));
  annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Vectors.<strong>length</strong>(v);
</pre></blockquote>

<h4>Description</h4>

<p>
The function call \"<code>Vectors.<strong>length</strong>(v)</code>\" returns the
<strong>Euclidean length</strong> \"<code>sqrt(v*v)</code>\" of vector v.
The function call is equivalent to Vectors.norm(v). The advantage of
length(v) over norm(v)\"is that function length(..) is implemented
in one statement and therefore the function is usually automatically
inlined. Further symbolic processing is therefore possible, which is
not the case with function norm(..).
</p>

<h4>Example</h4>
<blockquote><pre>
v = {2, -4, -2, -1};
<strong>length</strong>(v);  // = 5
</pre></blockquote>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Math.Vectors.norm\">Vectors.norm</a>
</p>
</html>"));
end length;
