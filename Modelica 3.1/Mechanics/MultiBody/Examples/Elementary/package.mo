within Modelica.Mechanics.MultiBody.Examples;
package Elementary "Elementary examples to demonstrate various features of the MultiBody library"
extends Modelica.Icons.Library;


annotation ( Documentation(info="<HTML>
<p>
This package contains elementary example models to demonstrate
the usage of the MultiBody library
</p>
<h4>Content</h4>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><th><b><i>Model</i></b></th><th><b><i>Description</i></b></th></tr>
  <tr><td valign=\"top\"><a href=\"Modelica://Modelica.Mechanics.MultiBody.Examples.Elementary.DoublePendulum\">DoublePendulum</a></td>
      <td valign=\"top\"> Simple double pendulum with two revolute joints and two bodies.<br>
      <img src=\"../Images/MultiBody/Examples/Elementary/DoublePendulumSmall.png\">
      </td>
  </tr>
  <tr><td valign=\"top\"><a href=\"Modelica://Modelica.Mechanics.MultiBody.Examples.Elementary.ForceAndTorque\">ForceAndTorque</a></td>
      <td valign=\"top\"> Demonstrates usage of Forces.ForceAndTorque element.<br>
      <img src=\"../Images/MultiBody/Examples/Elementary/ForceAndTorque_small.png\">
      </td>
  </tr>
  <tr><td valign=\"top\"><a href=\"Modelica://Modelica.Mechanics.MultiBody.Examples.Elementary.FreeBody\">FreeBody</a></td>
      <td valign=\"top\"> Free flying body attached by two springs to environment.<br>
      <img src=\"../Images/MultiBody/Examples/Elementary/FreeBody_small.png\">
      </td>
  </tr>
  <tr><td valign=\"top\"><a href=\"Modelica://Modelica.Mechanics.MultiBody.Examples.Elementary.InitSpringConstant\">InitSpringConstant</a></td>
      <td valign=\"top\"> Determine spring constant such that system is in steady state
           at given position.<br>
      <img src=\"../Images/MultiBody/Examples/Elementary/InitSpringConstant_small.png\">
      </td>
  </tr>
  <tr><td valign=\"top\"><a href=\"Modelica://Modelica.Mechanics.MultiBody.Examples.Elementary.LineForceWithTwoMasses\">LineForceWithTwoMasses</a></td>
      <td valign=\"top\"> Demonstrates a line force with two point masses using a
           Joints.Assemblies.JointUPS and alternatively a
           Forces.LineForceWithTwoMasses component.<br>
      <img src=\"../Images/MultiBody/Examples/Elementary/LineForceWithTwoMasses_small.png\">
      </td>
  </tr>
  <tr><td valign=\"top\"><a href=\"Modelica://Modelica.Mechanics.MultiBody.Examples.Elementary.Pendulum\">Pendulum</a></td>
      <td valign=\"top\"> Simple pendulum with one revolute joint and one body. <br>
      <img src=\"../Images/MultiBody/Examples/Elementary/Pendulum_small.png\">
      </td>
  </tr>
  <tr><td valign=\"top\"><a href=\"Modelica://Modelica.Mechanics.MultiBody.Examples.Elementary.PendulumWithSpringDamper\">PendulumWithSpringDamper</a></td>
      <td valign=\"top\"> Simple spring/damper/mass system <br>
      <img src=\"../Images/MultiBody/Examples/Elementary/PendulumWithSpringDamper_small.png\">
      </td>
  </tr>
  <tr><td valign=\"top\"><a href=\"Modelica://Modelica.Mechanics.MultiBody.Examples.Elementary.PointGravity\">PointGravity</a></td>
      <td valign=\"top\"> Two bodies in a point gravity field <br>
      <img src=\"../Images/MultiBody/Examples/Elementary/PointGravity_small.png\">
      </td>
  </tr>
  <tr><td valign=\"top\"><a href=\"Modelica://Modelica.Mechanics.MultiBody.Examples.Elementary.PointGravityWithPointMasses\">PointGravityWithPointMasses</a></td>
      <td valign=\"top\"> Two point masses in a point gravity field (rotation of bodies is neglected) <br>
      <img src=\"../Images/MultiBody/Examples/Elementary/PointGravityWithPointMasses_small.png\">
      </td>
  </tr>
  <tr><td valign=\"top\"><a href=\"Modelica://Modelica.Mechanics.MultiBody.Examples.Elementary.PointGravityWithPointMasses2\">PointGravityWithPointMasses2</a></td>
      <td valign=\"top\"> Rigidly connected point masses in a point gravity field <br>
      <img src=\"../Images/MultiBody/Examples/Elementary/PointGravityWithPointMasses2_small.png\">
      </td>
  </tr>

  <tr><td valign=\"top\"><a href=\"Modelica://Modelica.Mechanics.MultiBody.Examples.Elementary.RollingWheel\">RollingWheel</a></td>
      <td valign=\"top\"> Single wheel rolling on ground starting from an initial speed <br>
      <img src=\"../Images/MultiBody/Examples/Elementary/RollingWheel.png\">
      </td>
  </tr>


  <tr><td valign=\"top\"><a href=\"Modelica://Modelica.Mechanics.MultiBody.Examples.Elementary.RollingWheelSetDriving\">RollingWheelSetDriving</a></td>
      <td valign=\"top\"> Rolling wheel set that is driven by torques driving the wheels <br>
      <img src=\"../Images/MultiBody/Examples/Elementary/RollingWheelSetDriving.png\">
      </td>
  </tr>


  <tr><td valign=\"top\"><a href=\"Modelica://Modelica.Mechanics.MultiBody.Examples.Elementary.RollingWheelSetPulling\">RollingWheelSetPulling</a></td>
      <td valign=\"top\"> Rolling wheel set that is pulled by a force <br>
      <img src=\"../Images/MultiBody/Examples/Elementary/RollingWheelSetPulling.png\">
      </td>
  </tr>


  <tr><td valign=\"top\"><a href=\"Modelica://Modelica.Mechanics.MultiBody.Examples.Elementary.SpringDamperSystem\">SpringDamperSystem</a></td>
      <td valign=\"top\"> Spring/damper system with a prismatic joint and
           attached on free flying body <br>
      <img src=\"../Images/MultiBody/Examples/Elementary/SpringDamperSystem_small.png\">
      </td>
  </tr>
  <tr><td valign=\"top\"><a href=\"Modelica://Modelica.Mechanics.MultiBody.Examples.Elementary.SpringMassSystem\">SpringMassSystem</a></td>
      <td valign=\"top\"> Mass attached via a prismatic joint and a spring to the world frame <br>
      <img src=\"../Images/MultiBody/Examples/Elementary/SpringMassSystem_small.png\">
      </td>
  </tr>
  <tr><td valign=\"top\"><a href=\"Modelica://Modelica.Mechanics.MultiBody.Examples.Elementary.SpringWithMass\">SpringWithMass</a></td>
      <td valign=\"top\"> Point mass hanging on a spring <br>
      <img src=\"../Images/MultiBody/Examples/Elementary/SpringWithMass_small.png\">
      </td>
  </tr>
  <tr><td valign=\"top\"><a href=\"Modelica://Modelica.Mechanics.MultiBody.Examples.Elementary.ThreeSprings\">ThreeSprings</a></td>
      <td valign=\"top\"> 3-dimensional springs in series and parallel connection<br>
      <img src=\"../Images/MultiBody/Examples/Elementary/ThreeSprings_small.png\">
      </td>
  </tr>
</table>
</HTML>"));
end Elementary;
