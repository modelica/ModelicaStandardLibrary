package Loops "Examples with kinematic loops"
extends Modelica.Icons.Library;


annotation (preferedView="info", Documentation(info="<html>
<p>
This package contains different examples to show how
mechanical systems with kinematic loops can be modeled.
</p>
<h4>Content</h4>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><th><b><i>Model</i></b></th><th><b><i>Description</i></b></th></tr>
  <tr><td><b><a href=\"Modelica://Modelica.Mechanics.MultiBody.Examples.Loops.Engine\">Engine</a></b></td>
      <td> Model of one cylinder engine<br> 
      <img src=\"../Images/MultiBody/Examples/Loops/Engine.png\">
      </td>
  </tr>
  <tr><td><b><a href=\"Modelica://Modelica.Mechanics.MultiBody.Examples.Loops.EngineV6\">EngineV6</a><br>
<a href=\"Modelica://Modelica.Mechanics.MultiBody.Examples.Loops.EngineV6_analytic\">EngineV6_analytic</a></b></td>
      <td> V6 engine with 6 cylinders, 6 planar loops and 1 degree-of-freedom.
           Second version with analytic handling of kinematic loops and CAD data
           animation.<br>
      <img src=\"../Images/MultiBody/Examples/Loops/EngineV6_small.png\">
      <img src=\"../Images/MultiBody/Examples/Loops/EngineV6_CAD_smaller.png\">
      </td>
  </tr>
  <tr><td><b><a href=\"Modelica://Modelica.Mechanics.MultiBody.Examples.Loops.Fourbar1\">Fourbar1</a></b></td>
      <td> One kinematic loop with four bars (with only revolute joints; 
           5 non-linear equations)<br> 
      <img src=\"../Images/MultiBody/Examples/Loops/Fourbar1_small.png\">
      </td>
  </tr>
  <tr><td><b><a href=\"Modelica://Modelica.Mechanics.MultiBody.Examples.Loops.Fourbar2\">Fourbar2</a></b></td>
      <td> One kinematic loop with four bars (with UniversalSpherical 
           joint; 1 non-linear equation) <br> 
      <img src=\"../Images/MultiBody/Examples/Loops/Fourbar2_small.png\">
      </td>
  </tr>
  <tr><td><b><a href=\"Modelica://Modelica.Mechanics.MultiBody.Examples.Loops.Fourbar_analytic\">Fourbar_analytic</a></b></td>
      <td> One kinematic loop with four bars (with JointSSP joint; 
           analytic solution of non-linear algebraic loop)  <br> 
      <img src=\"../Images/MultiBody/Examples/Loops/Fourbar_analytic_small.png\">
      </td>
  </tr>
  <tr><td><b><a href=\"Modelica://Modelica.Mechanics.MultiBody.Examples.Loops.PlanarLoops_analytic\">PlanarLoops_analytic</a></b></td>
      <td> Mechanism with three planar kinematic loops and one 
           degree-of-freedom with analytic loop handling 
           (with JointRRR joints) <br> 
      <img src=\"../Images/MultiBody/Examples/Loops/PlanarLoops_small.png\">
      </td>
  </tr>
</table>
</html>"));
end Loops;
