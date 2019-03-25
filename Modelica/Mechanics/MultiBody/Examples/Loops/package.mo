within Modelica.Mechanics.MultiBody.Examples;
package Loops "Examples with kinematic loops"
extends Modelica.Icons.ExamplesPackage;


annotation (Documentation(info="<html>
<p>
This package contains different examples to show how
mechanical systems with kinematic loops can be modeled.
</p>
<h4>Content</h4>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><th><strong><em>Model</em></strong></th><th><strong><em>Description</em></strong></th></tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Loops.Engine1a\">Engine1a</a><br>
             <a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Loops.Engine1b\">Engine1b</a><br>
             <a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Loops.Engine1b_analytic\">Engine1b_analytic</a></td>
      <td> Model of one cylinder engine (Engine1a: simple, without combustion; Engine1b: with combustion;
           Engine1b_analytic: same as Engine1b but analytic loop handling)<br>
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Loops/Engine.png\">
      </td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Loops.EngineV6\">EngineV6</a><br>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Loops.EngineV6_analytic\">EngineV6_analytic</a></td>
      <td> V6 engine with 6 cylinders, 6 planar loops and 1 degree-of-freedom.
           Second version with analytic handling of kinematic loops and CAD data
           animation.<br>
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Loops/EngineV6_small.png\">
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Loops/EngineV6_CAD_smaller.png\">
      </td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Loops.Fourbar1\">Fourbar1</a></td>
      <td> One kinematic loop with four bars (with only revolute joints;
           5 non-linear equations)<br>
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Loops/Fourbar1_small.png\">
      </td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Loops.Fourbar2\">Fourbar2</a></td>
      <td> One kinematic loop with four bars (with UniversalSpherical
           joint; 1 non-linear equation)<br>
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Loops/Fourbar2_small.png\">
      </td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Loops.Fourbar_analytic\">Fourbar_analytic</a></td>
      <td> One kinematic loop with four bars (with JointSSP joint;
           analytic solution of non-linear algebraic loop)<br>
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Loops/Fourbar_analytic_small.png\">
      </td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Loops.PlanarFourbar\">PlanarFourbar</a></td>
      <td> Planar four bars  with one kinematic loop (with RevolutePlanarLoopConstraint joint)<br>
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Loops/PlanarFourbar_small.png\">
      </td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Loops.PlanarLoops_analytic\">PlanarLoops_analytic</a></td>
      <td> Mechanism with three planar kinematic loops and one
           degree-of-freedom with analytic loop handling
           (with JointRRR joints)<br>
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Loops/PlanarLoops_small.png\">
      </td>
  </tr>
</table>
</html>"));
end Loops;
