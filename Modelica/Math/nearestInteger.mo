within Modelica.Math;
function nearestInteger "Convert real number to nearest integer value (by rounding away from zero)"
  extends Modelica.Icons.Function;

  input Real r "Real number to convert to integer";
  output Integer i "Integer value, which is nearest to the given real number (rounded away from zero)";

algorithm
  i :=if (r > 0) then integer(floor(r + 0.5)) else integer(ceil(r - 0.5));

  annotation (Documentation(info="<html>

<h4>Syntax</h4>
<blockquote><pre>
Math.<strong>nearestInteger</strong>(r);
</pre></blockquote>

<h4>Description</h4>
<p>
The input value <code>r</code> of type Real is converted to the nearest integer value <code>i</code> (by rounding away from zero):
</p>
<blockquote><pre>
i = <strong>integer</strong>( <strong>floor</strong>( r + 0.5 ) )  for  r &gt; 0;
i = <strong>integer</strong>( <strong>ceil </strong>( r - 0.5 ) )  for  r &lt; 0;
</pre></blockquote>

<h4>Example</h4>
<blockquote><pre>
import Modelica.Math;
Math.nearestInteger(0.4);                     // = 0
Math.nearestInteger(0.5);                     // = 1
Math.nearestInteger(-0.4);                    // = 0
Math.nearestInteger(-0.5);                    // = -1
</pre></blockquote>

<h4>Note</h4>

<p>
This function does the same conversion as the block
<a href=\"modelica://Modelica.Blocks.Math.RealToInteger\">RealToInteger</a>.
</p>
</html>"), GenerateEvents=true);
end nearestInteger;
