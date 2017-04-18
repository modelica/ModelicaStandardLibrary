within Modelica.Math;
function isPowerOf2 "Determine if the integer input is a power of 2"
  extends Modelica.Icons.Function;
  input Integer i(min=1) "Integer scalar";
  output Boolean result "= true, if integer scalar is a power of 2";
algorithm
  assert(i>=1, "Integer input to isPowerOf2 has to be >= 1");
  result := i == 2^integer(log(i)/log(2)+0.5);
  annotation (Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Math.<strong>isPowerOf2</strong>(i);
</pre></blockquote>
<h4>Description</h4>
<p>
The function call \"<code>Math.isPowerOf2(i)</code>\" returns <strong>true</strong>,
if the Integer input i is a power of 2. Otherwise the function
returns <strong>false</strong>. The Integer input has to be &gt;=1.
</p>
<h4>Example</h4>
<blockquote><pre>
  Integer i1 = 1;
  Integer i2 = 4;
  Integer i3 = 9;
  Boolean result;
<strong>algorithm</strong>
  result := Math.isPowerOf2(i1);     // = <strong>true</strong> 2^0
  result := Math.isPowerOf2(i2);     // = <strong>true</strong> 2^2
  result := Math.isPowerOf2(i3);     // = <strong>false</strong>
</pre></blockquote>
</html>"));
end isPowerOf2;
