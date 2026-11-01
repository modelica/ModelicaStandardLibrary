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

<h4>Relations between voltages of a three-phase inverter drive</h4>

<table>
<tr><td>RMS of grid line-to-line voltage</td>
    <td> V<sub>LL</sub></td></tr>
<tr><td>Maximum of DC voltage</td>
    <td> V<sub>DC</sub>=&radic;2 &sdot; V<sub>LL</sub></td></tr>
<tr><td>Considering (fictious) Y-connection of the connected machine</td>
    <td> </td></tr>
<tr><td>Maximum length of space phasor</td>
    <td> |<u>V</u>|=2/3 &sdot; V<sub>DC</sub></td></tr>
<tr><td>Inradius of the hexagon (see Fig. 1)</td>
    <td> V<sub>max</sub>=|<u>V</u>| &sdot; cos(&pi;/6)=1/&radic;3 &sdot; V<sub>DC</sub></td></tr>
<tr><td>RMS of nominal phase voltage</td>
    <td> V<sub>nom</sub>=1/&radic;2  &sdot; V<sub>max</sub>=1/&radic;6  &sdot; V<sub>DC</sub>=1/&radic;3  &sdot; V<sub>LL</sub></td></tr>
</table>

<table border=\\\"0\\\" cellspacing=\\\"0\\\" cellpadding=\\\"2\\\">
  <caption><strong>Fig. 1:</strong> Possible voltage space phasors </caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Electrical/PowerConverters/PWM.png\">
    </td>
  </tr>
</table>

</html>"));
end DCACConcept;
