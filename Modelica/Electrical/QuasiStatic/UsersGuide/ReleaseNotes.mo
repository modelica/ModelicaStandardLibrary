within Modelica.Electrical.QuasiStatic.UsersGuide;
class ReleaseNotes "Release notes"
  extends Modelica.Icons.ReleaseNotes;

  annotation (Documentation(info="<html>
<h5>Version 3.2.3, 2019-01-23</h5>
<ul>
    <li>Added frequency dependent behavior im impedance and admittance models, see
        <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2451\">#2451</a></li>
    <li>Added frequency sweep voltage and current sources, see
        <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2442\">#2442</a>
    <ul>
        <li>Single-phase <a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sources.FrequencySweepVoltageSource\">FrequencySweepVoltageSource</a></li>
        <li>Single-phase <a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sources.FrequencySweepCurrentSource\">FrequencySweepCurrentSource</a></li>
        <li>Polyphase <a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sources.FrequencySweepVoltageSource\">FrequencySweepVoltageSource</a></li>
        <li>Polyphase <a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sources.FrequencySweepCurrentSource\">FrequencySweepCurrentSource</a></li>
    </ul></li>
    <li>Shortened default component names, see
      <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2301\">#2301</a></li>
    <li>Fixed missing <code>final useConjugateInput = false</code>, see
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2251\">#2251</a>
    <ul>
      <li><a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Blocks.SymmetricalComponents\">Polyphase.Blocks.SymmetricalComponents</a></li>
      <li><a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Blocks.FromSymmetricalComponents\">Polyphase.Blocks.FromSymmetricalComponents</a></li>
      <li><a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Blocks.SingleToPolyphase\">Polyphase.Blocks.SingleToPolyphase</a></li>
    </ul></li>
<li>Updated icons of inductors and transformer models, see <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2210\">#2210</a></li>
<li>Added polar and power quantities in ideal quasi-static transformer model, see <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2173\">#2173</a></li>
<li>Removed redundant (and not identical) parameter m from
    <a href=\"modelica://Modelica.Electrical.Polyphase.Basic.MutualInductor\">MutualInductor</a>,
    see <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2202\">#2202</a></li>
<li>Added linear polyphase mutual inductor model, see <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2200\">#2200</a></li>
<li>Added complex impedance and admittance models of single-phase and polyphase package, see ticket
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/1870\">#1870</a></li>
<li>Added magnitude and argument of complex voltages and currents in interface and sensor models, see ticket
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/1405\">#1405</a></li>
<li>Added active, reactive and apparent power and power factor in interface models, see ticket
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/1405\">#1405</a></li>
<li>Added complex single-phase and polyphase impedance and admittance models (ticket
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/1367\">#1367</a>)</li>
<li>Updated documentation on temperature dependency of resistance and conductance models</li>
<li>Rewrote source models to simplify initialization (
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/commit/861851e3b9628fa483e958a943ab015c15fcb821\">r7031</a>)</li>
<li>Implementation of ideal transformer model</li>
</ul>

<h5>Version 1.0.0</h5>
<ul><li>First official release</li></ul>
</html>", revisions="<html>
</html>"));
end ReleaseNotes;
