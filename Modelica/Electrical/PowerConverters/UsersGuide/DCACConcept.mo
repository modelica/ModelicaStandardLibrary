within Modelica.Electrical.PowerConverters.UsersGuide;
class DCACConcept "DC/AC converter concept"
  extends Modelica.Icons.Information;
  annotation (DocumentationClass=true, Documentation(info="<html>

<p>There are a single-phase and polyphase DC/AC converter model provided by the PowerConverters library.</p>

<h4>Control</h4>

<p>Currently there are
<a href=\"modelica://Modelica.Electrical.PowerConverters.DCAC.Control.SVPWM\">space vector PWM</a> and
<a href=\"modelica://Modelica.Electrical.PowerConverters.DCAC.Control.IntersectivePWM\">intersective PWM</a> models provided.
However, for operating the single-phase inverter the PWM
<a href=\"modelica://Modelica.Electrical.PowerConverters.DCDC.Control.SignalPWM\">controller</a>
can be used.
</p>

<h4>Examples</h4>

<p>Some examples are provided at
<a href=\"modelica://Modelica.Electrical.PowerConverters.Examples.DCAC\">Examples.DCAC</a>.
</p>

<h4>Structure of a three-phase inverter drive</h4>

<p>
The machine-side inverter (see Fig. 1) consist of 6 switches (power transistors, MOSFETs or IGBTs) with anti-parallel freewheeling diodes. 
It can be seen that there are 8 allowed switch combinations that avoid a short-circuit of the DC capacitor. 
Two of them (no. 0 and 7) tie all three terminals either to the positive or to the negative terminal of the DC circuit, and therefore produce no voltage. 
The remaining 6 (no. 1 - 6) produce voltage space phasors of the same length but in 6 different positions (see Fig. 2). 
Which switch states (hi-side and lo-side) cause which space phasors is shown in Tab. 1. 
An overview about the relationships between the voltages is given in Tab. 2.
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption><strong>Fig. 1:</strong> Structure of a three-phase inverter drive </caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Electrical/PowerConverters/InverterDrive.png\">
    </td>
  </tr>
</table>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<caption><strong>Tab. 1:</strong> Space phasors and switch states </caption>
<tr><td>Voltage space phasor no.</td><td> 0 </td><td> 1 </td><td> 2 </td><td> 3 </td><td> 4 </td><td> 5 </td><td> 6 </td><td> 7 </td></tr>
<tr><td>Switch state hi-side    </td><td>000</td><td>100</td><td>110</td><td>010</td><td>011</td><td>001</td><td>101</td><td>111</td></tr>
<tr><td>Switch state lo-side    </td><td>111</td><td>011</td><td>001</td><td>101</td><td>100</td><td>110</td><td>010</td><td>000</td></tr>
</table>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption><strong>Fig. 2:</strong> Possible voltage space phasors </caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Electrical/PowerConverters/PWM.png\">
    </td>
  </tr>
</table>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
<caption><strong>Tab. 2:</strong> Relations between voltages of a three-phase inverter drive </caption>  
<tr><td>RMS of grid line-to-line voltage</td>
    <td> V<sub>LL</sub></td></tr>
<tr><td>Maximum of DC voltage</td>
    <td> V<sub>DC</sub>=&radic;2 &sdot; V<sub>LL</sub></td></tr>
<tr><td>Considering (fictious) Y-connection of the connected machine</td>
    <td> </td></tr>
<tr><td>Maximum length of space phasor</td>
    <td> |<u>V</u>|=2/3 &sdot; V<sub>DC</sub></td></tr>
<tr><td>Inradius of the hexagon (see Fig. 2)</td>
    <td> V<sub>max</sub>=|<u>V</u>| &sdot; cos(&pi;/6)=1/&radic;3 &sdot; V<sub>DC</sub></td></tr>
<tr><td>RMS of nominal phase voltage</td>
    <td> V<sub>nom</sub>=1/&radic;2  &sdot; V<sub>max</sub>=1/&radic;6  &sdot; V<sub>DC</sub>=1/&radic;3  &sdot; V<sub>LL</sub></td></tr>
</table>

<p>
There are 2 examples demonstrating that: 
<a href=\"modelica://Modelica.Electrical.PowerConverters.Examples.DCAC.PolyphaseTwoLevel.ThreephaseTwoLevel_PWM\">ThreephaseTwoLevel_PWM</a> and
<a href=\"modelica://Modelica.Electrical.Machines.Examples.InductionMachines.IMC_InverterDrive\">IMC_InverterDrive</a>.
</p>
</html>"));
end DCACConcept;
