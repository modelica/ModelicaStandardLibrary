within Modelica.Mechanics.MultiBody.Examples;
package Loops "Examples with kinematic loops"
extends Modelica.Icons.Library;


annotation ( Documentation(info="<html>
<p>
This package contains different examples to show how
mechanical systems with kinematic loops can be modeled.
</p>
<h4>Content</h4>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><th><b><i>Model</i></b></th><th><b><i>Description</i></b></th></tr>
  <tr><td valign=\"top\"><a href=\"Modelica://Modelica.Mechanics.MultiBody.Examples.Loops.Engine1a\">Engine1a</a><br>
             <a href=\"Modelica://Modelica.Mechanics.MultiBody.Examples.Loops.Engine1b\">Engine1b</a><br>
             <a href=\"Modelica://Modelica.Mechanics.MultiBody.Examples.Loops.Engine1b_analytic\">Engine1b_analytic</a></td>
      <td valign=\"top\"> Model of one cylinder engine (Engine1a: simple, without combustion; Engine1b: with combustion;
           Engine1b_analytic: same as Engine1b but analytic loop handling)<br>
      <img src=\"../Images/MultiBody/Examples/Loops/Engine.png\">
      </td>
  </tr>
  <tr><td valign=\"top\"><a href=\"Modelica://Modelica.Mechanics.MultiBody.Examples.Loops.EngineV6\">EngineV6</a><br>
<a href=\"Modelica://Modelica.Mechanics.MultiBody.Examples.Loops.EngineV6_analytic\">EngineV6_analytic</a></td>
      <td valign=\"top\"> V6 engine with 6 cylinders, 6 planar loops and 1 degree-of-freedom.
           Second version with analytic handling of kinematic loops and CAD data
           animation.<br>
      <img src=\"../Images/MultiBody/Examples/Loops/EngineV6_small.png\">
      <img src=\"../Images/MultiBody/Examples/Loops/EngineV6_CAD_smaller.png\">
      </td>
  </tr>
  <tr><td valign=\"top\"><a href=\"Modelica://Modelica.Mechanics.MultiBody.Examples.Loops.Fourbar1\">Fourbar1</a></td>
      <td valign=\"top\"> One kinematic loop with four bars (with only revolute joints;
           5 non-linear equations)<br>
      <img src=\"../Images/MultiBody/Examples/Loops/Fourbar1_small.png\">
      </td>
  </tr>
  <tr><td valign=\"top\"><a href=\"Modelica://Modelica.Mechanics.MultiBody.Examples.Loops.Fourbar2\">Fourbar2</a></td>
      <td valign=\"top\"> One kinematic loop with four bars (with UniversalSpherical
           joint; 1 non-linear equation) <br>
      <img src=\"../Images/MultiBody/Examples/Loops/Fourbar2_small.png\">
      </td>
  </tr>
  <tr><td valign=\"top\"><a href=\"Modelica://Modelica.Mechanics.MultiBody.Examples.Loops.Fourbar_analytic\">Fourbar_analytic</a></td>
      <td valign=\"top\"> One kinematic loop with four bars (with JointSSP joint;
           analytic solution of non-linear algebraic loop)  <br>
      <img src=\"../Images/MultiBody/Examples/Loops/Fourbar_analytic_small.png\">
      </td>
  </tr>
  <tr><td valign=\"top\"><a href=\"Modelica://Modelica.Mechanics.MultiBody.Examples.Loops.PlanarLoops_analytic\">PlanarLoops_analytic</a></td>
      <td valign=\"top\"> Mechanism with three planar kinematic loops and one
           degree-of-freedom with analytic loop handling
           (with JointRRR joints) <br>
      <img src=\"../Images/MultiBody/Examples/Loops/PlanarLoops_small.png\">
      </td>
  </tr>
</table>
</html>"));
end Loops;
