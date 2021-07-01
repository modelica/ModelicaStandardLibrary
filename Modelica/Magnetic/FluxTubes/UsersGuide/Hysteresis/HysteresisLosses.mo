within Modelica.Magnetic.FluxTubes.UsersGuide.Hysteresis;
class HysteresisLosses "Hysteresis losses"
  extends Modelica.Icons.Information;
  annotation (Documentation(info="<html>
<h4>Hysteresis power losses</h4>
<p>The total power loss (<code>LossPower</code>) of an hysteresis flux tube element is the sum of the power loss due to the static ferromagnetic hysteresis (<code>LossPowerStat</code>) and the power loss due to eddy currents (<code>LossPowerEddy</code>).</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/Hysteresis/HysteresisLosses/Eqn_LossPower01.png\">
    </td>
  </tr>
</table>

<p>
The two components <code>LossPowerStat</code> and <code>LossPowerEddy</code> can be calculated as follows.
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/Hysteresis/HysteresisLosses/Eqn_LossPower02.png\">
    </td>
  </tr>
</table>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/Hysteresis/HysteresisLosses/Eqn_LossPower03.png\">
    </td>
  </tr>
</table>

<p>
Where <code>&sigma;<sub>cl</sub></code> is the classical eddy current factor (see <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Hysteresis.DynamicHysteresis\">UsersGuide.Hysteresis.DynamicHysteresis</a>) and V the volume of the core material. The equations show that <code>LossPowerStat</code> acts as power sink and power source (magnetic energy storage) whereas <code>LossPowerEddy</code> is always positive (Power sink). By means of an simple example the following figures show the time course of the magnetic flux density,  the magnetic field strength and the hysteresis losses. The pulsating course of the power loss (see Fig. 3c) makes it difficult to estimate an average loss. For this reason, the hysteresis flux tube elements are capable of directly computing the moving average of the power losses. Therefore, <code>t_avg</code> of the \"LossesAndHeat\" tab of the elements parameter dialog may be adjusted to set an adequate time interval (see Fig. 3d).
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption><strong>Fig. 1:</strong> Diagram of a simple transformer with ferromagnetic core (model available at <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.Hysteresis.SinglePhaseTransformerWithHysteresis1\">Examples.Hysteresis.SinglePhaseTransformerWithHysteresis1</a>)</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/Hysteresis/HysteresisLosses/PowerLoss_Hysteresis01.png\">
    </td>
  </tr>
</table>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption><strong>Fig. 2:</strong> Simulated total dynamic hysteresis loop with its static and eddy current fractions</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/Hysteresis/HysteresisLosses/PowerLoss_Hysteresis02.png\">
    </td>
  </tr>
</table>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption><strong>Fig. 3:</strong> Simulated outputs of the <code>Core</code> component of Fig. 1</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/Hysteresis/HysteresisLosses/PowerLoss_Hysteresis03.png\">
    </td>
  </tr>
</table>

</html>"));
end HysteresisLosses;
