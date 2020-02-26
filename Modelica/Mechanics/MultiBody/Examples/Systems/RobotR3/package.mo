within Modelica.Mechanics.MultiBody.Examples.Systems;
package RobotR3 "Library to demonstrate robot system models based on the Manutec r3 robot"
  extends Modelica.Icons.ExamplesPackage;

  annotation (
    Documentation(info="<html>
<p>
This package contains models of the robot r3 of the company Manutec.
These models are used to demonstrate in which way complex
robot models might be built up by testing first the component
models individually before composing them together.
Furthermore, it is shown how CAD data can be used
for animation.
</p>

<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Systems/RobotR3/robot_kr15.png\"
alt=\"model Examples.Systems.RobotR3\">

<p>
The following models are available:
</p>
<blockquote><pre>
<strong>OneAxis</strong>   Test one axis (controller, motor, gearbox).
<strong>FullRobot</strong> Test complete robot model.
</pre></blockquote>
<p>
The r3 robot is no longer manufactured. In fact the company
Manutec does no longer exist.
The parameters of this robot have been determined by measurements
in the laboratory of DLR. The measurement procedure is described in:
</p>
<blockquote><pre>
Tuerk S. (1990): Zur Modellierung der Dynamik von Robotern mit
    rotatorischen Gelenken. Fortschrittberichte VDI, Reihe 8, Nr. 211,
    VDI-Verlag 1990.
</pre></blockquote>
<p>
The robot model is described in detail in
</p>
<blockquote><pre>
Otter M. (1995): Objektorientierte Modellierung mechatronischer
    Systeme am Beispiel geregelter Roboter. Dissertation,
    Fortschrittberichte VDI, Reihe 20, Nr. 147, VDI-Verlag 1995.
    This report can be downloaded as compressed postscript file
    from: <a href=\"http://www.robotic.dlr.de/Martin.Otter\">http://www.robotic.dlr.de/Martin.Otter</a>.
</pre></blockquote>
<p>
The path planning is performed in a simple way by using essentially
the Modelica.Mechanics.Rotational.KinematicPTP block. A user defines
a path by start and end angle of every axis. A path is planned such
that all axes are moving as fast as possible under the given
restrictions of maximum joint speeds and maximum joint accelerations.
The actual r3 robot from Manutec had a different path planning strategy.
Today's path planning algorithms from robot companies are much
more involved.
</p>
<p>
In order to get a nice animation, CAD data from a KUKA robot
is used, since CAD data of the original r3 robot was not available.
The KUKA CAD data was derived from public data of
<a href=\"http://www.kuka-robotics.com/\">
KUKA</a>.
Since dimensions of the corresponding KUKA robot are similar but not
identical to the r3 robot, the data of the r3 robot (such as arm lengths) have been modified, such that it matches the CAD data.
</p>
<p>
In this model, a simplified P-PI cascade controller for every
axes is used. The parameters have been manually adjusted by
simulations. The original r3 controllers are more complicated.
The reason to use simplified controllers is to have a simpler demo.
</p>
</html>"));

end RobotR3;
