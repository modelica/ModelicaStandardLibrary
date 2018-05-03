within Modelica.Mechanics.MultiBody.Examples;
package Systems "Examples of complete system models including 3-dimensional mechanics"
extends Modelica.Icons.ExamplesPackage;


annotation (Documentation(info="<html>
<p>
This package contains complete <strong>system models</strong> where components
from different domains are used, including 3-dimensional mechanics.
</p>
<h4>Content</h4>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><th><strong><em>Model</em></strong></th><th><strong><em>Description</em></strong></th></tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Systems.RobotR3\">RobotR3</a><br>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Systems.RobotR3.oneAxis\">RobotR3.oneAxis</a><br>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Systems.RobotR3.fullRobot\">RobotR3.fullRobot</a></td>
      <td> 6 degree of freedom robot with path planning,
           controllers, motors, brakes, gears and mechanics.
           \"oneAxis\" models only one drive train. \"fullRobot\" is
           the complete, detailed robot model.<br>
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Systems/r3_fullRobot_small.png\">
      </td>
  </tr>
</table>
</html>"));
end Systems;
