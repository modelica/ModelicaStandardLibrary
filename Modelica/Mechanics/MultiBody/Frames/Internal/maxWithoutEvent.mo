within Modelica.Mechanics.MultiBody.Frames.Internal;
function maxWithoutEvent
  "Maximum of the input arguments, without event and function can be differentiated"
  extends Modelica.Icons.Function;
  input Real u1;
  input Real u2;
  output Real y;
algorithm
  y := if u1 > u2 then u1 else u2;
  annotation (
    Inline=false,
    derivative=maxWithoutEvent_d,
    Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
y = Internal.<strong>maxWithoutEvent</strong>(u1, u2)
</pre></blockquote>

<h4>Description</h4>
<p>
Function <strong>maxWithoutEvent</strong> returns the maximum of its two
input arguments. This functions is used instead of the Modelica
built-in function \"max\" or an if-statement with \"noEvent(&hellip;)\",
in order that the function can be differentiated by providing
the first and second derivatives with additional functions.
Note, from a strict mathematical point of view the derivatives
will be wrong, since Dirac impulses would occur in the
derivatives. For the special cases as used in the MultiBody
library, this is irrelevant and therefore the usage of the function is correct.
</p>
</html>"));
end maxWithoutEvent;
