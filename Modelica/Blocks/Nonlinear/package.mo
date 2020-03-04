within Modelica.Blocks;
package Nonlinear "Library of discontinuous or non-differentiable algebraic control blocks"
  import Modelica.Blocks.Interfaces;

  extends Modelica.Icons.Package;

      annotation (
        Documentation(info="<html>
<p>
This package contains <strong>discontinuous</strong> and
<strong>non-differentiable, algebraic</strong> input/output blocks.
</p>
</html>", revisions="<html>
<ul>
<li><em>October 21, 2002</em>
       by Christian Schweiger:<br>
       New block VariableLimiter added.</li>
<li><em>August 22, 1999</em>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized, based on an existing Dymola library
       of Dieter Moormann and Hilding Elmqvist.
</li>
</ul>
</html>"), Icon(graphics={Line(points={{-80,-66},{-26,-66},{28,52},{88,52}},
            color={95,95,95})}));
end Nonlinear;
