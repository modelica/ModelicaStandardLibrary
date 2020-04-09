within Modelica.Math;
function nearestInteger "Convert real number to nearest integer value"
  extends Modelica.Icons.Function;

  input Real r "Real number to convert to integer";
  output Integer i "Integer value, which is closest to the given real number";

algorithm
  i :=if (r > 0) then integer(floor(r + 0.5)) else integer(ceil(r - 0.5));

  annotation (Documentation(info="<html>

<h4>Syntax</h4>
<blockquote><pre>
Math.<strong>nearestInteger</strong>(r);
</pre></blockquote>

<h4>Description</h4>
<p>
    The input value \"r\" of type Real is converted to the closest Integer value \"i\",
    using the <em>round half away from zero</em> rule with the equation:
</p>
<blockquote><pre>
i = <strong>integer</strong>( <strong>floor</strong>( r + 0.5 ) )  for  r &gt; 0;
i = <strong>integer</strong>(  <strong>ceil</strong>( r - 0.5 ) )  for  r &lt; 0;
</pre></blockquote>

<h4>Example</h4>
<blockquote><pre>
import Modelica.Math;
Math.nearestInteger(0.4);                     // = 0
Math.nearestInteger(0.5);                     // = 1
Math.nearestInteger(-0.4);                    // = 0
Math.nearestInteger(-0.5);                    // = -1
Math.nearestInteger(0.3999999999999999+0.1);  // = 0
Math.nearestInteger(1.39999999999999999+0.1); // = 1 (erroneous border case, see note below)
</pre></blockquote>

<h4>Note</h4>

<p>
    This function does the same conversion as the block
    <a href=\"modelica://Modelica.Blocks.Math.RealToInteger\">RealToInteger</a>.
</p>
<p>
    The underlying equation is simple, but not always correct. Due to floating point arithmetic some border cases
    are not converted correct, like shown in the example above.
</p>
</html>"));
end nearestInteger;
