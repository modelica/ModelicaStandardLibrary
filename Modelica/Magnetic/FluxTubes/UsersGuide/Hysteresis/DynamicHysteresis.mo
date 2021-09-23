within Modelica.Magnetic.FluxTubes.UsersGuide.Hysteresis;
class DynamicHysteresis "Dynamic Hysteresis (Eddy Currents)"
  extends Modelica.Icons.Information;
  annotation (Documentation(info="<html>

<h4>Dynamic Hysteresis (Eddy Currents)</h4>

<p>
Some of the hysteresis flux tubes elements of the package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets\">HysteresisAndMagnets</a> are capable of simulating eddy currents (dynamic hysteresis) additional to the static hysteresis behavior of the core material. The computation of eddy currents can be activated via the switch <code>includeEddyCurrents</code> in the \"LossesAndHeat\" tab of the corresponding elements parameter dialog. The total magnetic field strength <code>H</code> of the element is the sum of the ferromagnetic portion <code>Hstat</code> and the eddy current portion <code>Heddy:</code>
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/Hysteresis/DynamicHysteresis/Eqn_EddyCurrent_Ht.png\">
    </td>
  </tr>
</table>

<p>
The eddy current portion of the magnetic field strength is the product of the classical eddy current factor (<code>&sigma;<sub>cl</sub></code>) <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[BE01,Te98]</a> and the time derivative of the magnetic flux density B(t):
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/Hysteresis/DynamicHysteresis/Eqn_EddyCurrent_Heddy.png\">
    </td>
  </tr>
</table>

<p>
Where <code>&sigma;</code> is the electrical conductivity and <code>d</code> the thickness of the used electric steel sheets. Fig. 1 shows the decomposition of an exemplary dynamic hysteresis in its static and eddy current portion.
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
<caption><strong>Fig. 1:</strong> Static and dynamic portion of the hysteresis B(H)</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/Hysteresis/DynamicHysteresis/Eddy_BHBHstatBHeddy.png\">
    </td>
  </tr>
</table>

<p>
The following two figures show a comparison between measured and simulated dynamic hysteresis at several frequencies. The measurements were performed with a 25 cm Epstein frame  according to DIN EN 60404-2. The magnetic core was made up of four layers of M330-50A steel sheet. The primary Winding of the used Epstein frame had 720 turns. The primary voltage was adjusted so that the magnetic excitation was about Hmax = 400 A/m, but 72 V in maximum. The simulation results (see Fig. 3) were generated with a simple model of this setup using the <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets.GenericHystTellinenTable\">GenericHystTellinenTable</a> hysteresis flux tube element for modeling the magnetic core.
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
<caption><strong>Fig. 2:</strong> Dynamic hysteresis measurements with an 25 cm Epstein frame according to DIN EN 60404-2 (Material: M330-50A, 4 Sheets)</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/Hysteresis/DynamicHysteresis/EddyCurrent_Epstein_Meas.png\">
    </td>
  </tr>
</table>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
<caption><strong>Fig. 3:</strong> Simulation results of a 25 cm Epstein frame model according to the measurement setup of Fig. 1</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/Hysteresis/DynamicHysteresis/EddyCurrent_Epstein_Sim.png\">
    </td>
  </tr>
</table>

</html>"));
end DynamicHysteresis;
