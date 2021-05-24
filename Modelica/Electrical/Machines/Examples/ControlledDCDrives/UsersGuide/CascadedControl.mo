within Modelica.Electrical.Machines.Examples.ControlledDCDrives.UsersGuide;
class CascadedControl "Concept of cascaded control"
  extends Modelica.Icons.Information;
  annotation (DocumentationClass=true, Documentation(info="<html>
<p>The concept of cascaded control is shown in Fig. 1.</p>
<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption align=\"bottom\"><strong>Fig. 1:</strong> Structure of cascaded control</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Electrical/Machines/ControlledDCDrives/CascadedControl.png\">
    </td>
  </tr>
</table>
<p>
Fig. 2 shows the equations describing the drive, using for parameterizing the controllers. 
The behaviour of the actuator is a delay which can be approximated by a first order. 
Additionally, filtering or sampling the current defines an additional delay which can be approximated by a first order. 
Both delays define the sum of small time constants T<sub>&sigma;</sub>.
</p>
<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption align=\"bottom\"><strong>Fig. 2:</strong> Equations describing the drive</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Electrical/Machines/ControlledDCDrives/Formula1.png\">
    </td>
  </tr>
</table>
<p><br>
The innermost control loop consists of the current controller, which is parameterized according to the absolute optimum (Fig. 3)
which aims at optimal transfer function with respect to the reference current.
</p>
<ul>
<li>PI - controller</li>
<li>Compensation of induced voltage</li>
<li>Limitation of the output (reference voltage) to the actual possible voltage</li>
<li>Subsequently, an anti-windup method</li>
</ul>
<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption align=\"bottom\"><strong>Fig. 3:</strong> Parameterization of the current controller</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Electrical/Machines/ControlledDCDrives/Formula2.png\">
    </td>
  </tr>
</table>
<p><br>
The optional next loop comprises the speed controller, which is parameterized according to the symmetrical optimum (Fig. 4) 
which aims at optimal transfer function with respect to disturbance (load torque).
</p>
<ul>
<li>PI - controller</li>
<li>Limitation of the output (reference torque) to the possible torque (current)</li>
<li>Subsequently, an anti-windup method</li>
<li>If reference speed is not prescribed by a correctly parameterized position controller which is commanded by a kinematicPTP (optimal path planning), 
    reference has to be filtered or limited in slew rate</li>
</ul>
<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption align=\"bottom\"><strong>Fig. 4:</strong> Parameterization of the speed controller</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Electrical/Machines/ControlledDCDrives/Formula3.png\">
    </td>
  </tr>
</table>
<p><br>
The optional outmost loop comprises the position controller, which is parameterized such way to avoid an overshot in position.
</p>
<ul>
<li>P - controller</li>
<li>Limitation of the output (reference speed) to the possible speed</li>
</ul>
</html>"));
end CascadedControl;
