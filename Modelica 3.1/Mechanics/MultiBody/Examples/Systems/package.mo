within Modelica.Mechanics.MultiBody.Examples;
package Systems "Examples of complete system models including 3-dimensional mechanics"
extends Modelica.Icons.Library;


annotation ( Documentation(info="<html>
<p>
This package contains complete <b>system models</b> where components
from different domains are used, including 3-dimensional mechanics.
</p>
<h4>Content</h4>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><th><b><i>Model</i></b></th><th><b><i>Description</i></b></th></tr>
  <tr><td valign=\"top\"><a href=\"Modelica://Modelica.Mechanics.MultiBody.Examples.Systems.RobotR3\">RobotR3</a><br>
<a href=\"Modelica://Modelica.Mechanics.MultiBody.Examples.Systems.RobotR3.oneAxis\">RobotR3.oneAxis</a><br>
<a href=\"Modelica://Modelica.Mechanics.MultiBody.Examples.Systems.RobotR3.fullRobot\">RobotR3.fullRobot</a>
</b></td>
      <td valign=\"top\"> 6 degree of freedom robot with path planning,
           controllers, motors, brakes, gears and mechanics.
           \"oneAxis\" models only one drive train. \"fullRobot\" is
           the complete, detailed robot model.<br>
      <img src=\"../Images/MultiBody/Examples/Systems/r3_fullRobot_small.png\">
      </td>
  </tr>
</table>
</html>"));
end Systems;
