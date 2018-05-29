within Modelica.Mechanics.MultiBody.Examples;
package Elementary "Elementary examples to demonstrate various features of the MultiBody library"
extends Modelica.Icons.ExamplesPackage;


annotation (Documentation(info="<html>
<p>
This package contains elementary example models to demonstrate
the usage of the MultiBody library
</p>
<h4>Content</h4>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><th><strong><em>Model</em></strong></th><th><strong><em>Description</em></strong></th></tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Elementary.DoublePendulum\">DoublePendulum</a><br>
          <a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Elementary.DoublePendulumInitTip\">DoublePendulumInitTip</a></td>
      <td> Simple double pendulum with two revolute joints and two bodies. In DoublePendulumInitTip, the initial position of the pendulum tip is given
           instead of common initialization by pendulum angles.<br>
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Elementary/DoublePendulumSmall.png\">
      </td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Elementary.ForceAndTorque\">ForceAndTorque</a></td>
      <td> Demonstrates usage of Forces.ForceAndTorque element.<br>
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Elementary/ForceAndTorque_small.png\">
      </td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Elementary.FreeBody\">FreeBody</a></td>
      <td> Free flying body attached by two springs to environment.<br>
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Elementary/FreeBody_small.png\">
      </td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Elementary.InitSpringConstant\">InitSpringConstant</a></td>
      <td> Determine spring constant such that system is in steady state
           at given position.<br>
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Elementary/InitSpringConstant_small.png\">
      </td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Elementary.LineForceWithTwoMasses\">LineForceWithTwoMasses</a></td>
      <td> Demonstrates a line force with two point masses using a
           Joints.Assemblies.JointUPS and alternatively a
           Forces.LineForceWithTwoMasses component.<br>
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Elementary/LineForceWithTwoMasses_small.png\">
      </td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Elementary.Pendulum\">Pendulum</a></td>
      <td> Simple pendulum with one revolute joint and one body.<br>
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Elementary/Pendulum_small.png\">
      </td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Elementary.PendulumWithSpringDamper\">PendulumWithSpringDamper</a></td>
      <td> Simple spring/damper/mass system<br>
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Elementary/PendulumWithSpringDamper_small.png\">
      </td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Elementary.PointGravity\">PointGravity</a></td>
      <td> Two bodies in a point gravity field<br>
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Elementary/PointGravity_small.png\">
      </td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Elementary.PointGravityWithPointMasses\">PointGravityWithPointMasses</a></td>
      <td> Two point masses in a point gravity field (rotation of bodies is neglected)<br>
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Elementary/PointGravityWithPointMasses_small.png\">
      </td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Elementary.PointGravityWithPointMasses2\">PointGravityWithPointMasses2</a></td>
      <td> Rigidly connected point masses in a point gravity field<br>
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Elementary/PointGravityWithPointMasses2_small.png\">
      </td>
  </tr>

  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Elementary.RollingWheel\">RollingWheel</a></td>
      <td> Single wheel rolling on ground starting from an initial speed<br>
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Elementary/RollingWheel.png\">
      </td>
  </tr>

  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Elementary.RollingWheelSetDriving\">RollingWheelSetDriving</a></td>
      <td> Rolling wheel set that is driven by torques driving the wheels<br>
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Elementary/RollingWheelSetDriving.png\">
      </td>
  </tr>

  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Elementary.RollingWheelSetPulling\">RollingWheelSetPulling</a></td>
      <td> Rolling wheel set that is pulled by a force<br>
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Elementary/RollingWheelSetPulling.png\">
      </td>
  </tr>

  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Elementary.SpringDamperSystem\">SpringDamperSystem</a></td>
      <td> Spring/damper system with a prismatic joint and
           attached on free flying body<br>
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Elementary/SpringDamperSystem_small.png\">
      </td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Elementary.SpringMassSystem\">SpringMassSystem</a></td>
      <td> Mass attached via a prismatic joint and a spring to the world frame<br>
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Elementary/SpringMassSystem_small.png\">
      </td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Elementary.SpringWithMass\">SpringWithMass</a></td>
      <td> Point mass hanging on a spring<br>
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Elementary/SpringWithMass_small.png\">
      </td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Elementary.ThreeSprings\">ThreeSprings</a></td>
      <td> 3-dimensional springs in series and parallel connection<br>
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Elementary/ThreeSprings_small.png\">
      </td>
  </tr>

  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Elementary.HeatLosses\">HeatLosses</a></td>
      <td> Demonstrate the modeling of heat losses.  </td>
  </tr>

  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Elementary.UserDefinedGravityField\">UserDefinedGravityField </a></td>
      <td> Demonstrate the modeling of a user-defined gravity field.  </td>
  </tr>

  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Elementary.Surfaces\">Surfaces</a></td>
      <td> Demonstrate the visualization of a sine surface,
       as well as a torus and a wheel constructed from a surface<br>
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Elementary/Surfaces_small.png\">
      </td>
  </tr>

</table>
</html>"));
end Elementary;
