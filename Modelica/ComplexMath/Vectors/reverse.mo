within Modelica.ComplexMath.Vectors;
function reverse "Reverse vector elements (e.g., v[1] becomes last element)"
extends Modelica.Icons.Function;

  input Complex v[:] "Vector";
  output Complex result[size(v, 1)] "Elements of vector v in reversed order";

algorithm
  result := {v[end-i+1] for i in 1:size(v,1)};
annotation (Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Vectors.<strong>reverse</strong>(v);
</pre></blockquote>
<h4>Description</h4>
The function call &quot;<code>Vectors.<strong>reverse</strong>(v)</code>&quot; returns the complex vector elements in reverse order.

<h4>Example</h4>
<blockquote><pre>
<strong>reverse</strong>({1,2,3,4});  // = {4,3,2,1}
</pre></blockquote>
</html>"));
end reverse;
