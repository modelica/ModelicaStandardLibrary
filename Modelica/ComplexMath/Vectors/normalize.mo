within Modelica.ComplexMath.Vectors;
function normalize
      "Return normalized complex vector such that length = 1 and prevent zero-division for zero vector"
  extends Modelica.Icons.Function;
  input Complex v[:] "Vector";
  input Real eps = 100*Modelica.Constants.eps "if |v| < eps then result = v";
  output Complex result[size(v, 1)] "Input vector v normalized to length=1";

protected
  Real length_v = length(v);
algorithm
  if length_v >= eps then
     for i in 1:size(v,1) loop
         result[i] :=v[i].re/length_v + (v[i].im/length_v)*j;
     end for;
  else
     result :=v;
  end if;

  annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Vectors.<strong>normalize</strong>(v);
Vectors.<strong>normalize</strong>(v,eps=100*Modelica.Constants.eps);
</pre></blockquote>

<h4>Description</h4>
<p>
The function call \"<code>Vectors.<strong>normalize</strong>(v)</code>\" returns the
<strong>unit vector</strong> \"<code>v/length(v)</code>\" of vector v.
If length(v) is close to zero (more precisely, if length(v) &lt; eps),
v is returned in order to avoid
a division by zero. For many applications this is useful, because
often the unit vector <strong>e</strong> = <strong>v</strong>/length(<strong>v</strong>) is used to compute
a vector x*<strong>e</strong>, where the scalar x is in the order of length(<strong>v</strong>),
i.e., x*<strong>e</strong> is small, when length(<strong>v</strong>) is small and then
it is fine to replace <strong>e</strong> by <strong>v</strong> to avoid a division by zero.
</p>
<p>
Since the function is implemented in one statement,
it is usually inlined and therefore symbolic processing is
possible.
</p>

<h4>Example</h4>
<blockquote><pre>
<strong>normalize</strong>({1,2,3});  // = {0.267, 0.534, 0.802}
<strong>normalize</strong>({0,0,0});  // = {0,0,0}
</pre></blockquote>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Math.Vectors.length\">Vectors.length</a>
</p>
</html>"));
end normalize;
