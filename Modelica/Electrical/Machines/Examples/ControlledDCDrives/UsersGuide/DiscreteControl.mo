within Modelica.Electrical.Machines.Examples.ControlledDCDrives.UsersGuide;
class DiscreteControl "Concept of quasi-continuous discrete control"
  extends Modelica.Icons.Information;
  annotation (DocumentationClass=true, Documentation(info="<html>
<p>
According to <a href=\"modelica://Modelica.Electrical.Machines.UsersGuide.References\">[Latzel1995]</a> we can state: 
Provided the sampling frequency of the I/O between controller and drive is much higher than the eigenvalues of the drive, 
and the sum of small time constants due to the delays in setting the desired voltage and mesuring the actual current into account,
the controller can be designed as a time-continuous controller. 
These delays have to be investigated acoording to the used implementation. 
In these examples, timing is used according to Fig. 1. 
Here a triangle is used as the reference signal of the intersective pwm. 
Therefore sampling at the middle of the switching interval hits the average of the current with high accuracy. 
</p>
<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption align=\"bottom\"><strong>Fig. 1:</strong> Timing of voltage setting and current measurement</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Electrical/Machines/ControlledDCDrives/Timing.png\">
    </td>
  </tr>
</table>
<p>
There are two choices for the DC-DC inverter that can be compared:
</p>
<ul>
<li>Switching inverter: Reference voltage and actual current are sampled once during the switching interval, thus defining the delays (see Fig. 1).</li>
<li>Averaging inverter: The delays are approximated using first order blocks.</li>
</ul>
<p>
Investigating the correct parameterization of the controller or the energy consumption, the averaging inverter is sufficient and shows much higher performance. 
Investigating the current ripple, the averaging inverter has to be used in critical points of operation for rather short time spans. 
Of course, some differences between the trajectories of the switching and the averaging inverter remain, which are mainly caused by the non-constant battery voltage. 
</p>
</html>"));
end DiscreteControl;
