within Modelica.Electrical.PowerConverters.UsersGuide;
class ACACConcept "AC/AC converter concept"
  extends Modelica.Icons.Information;
  annotation (DocumentationClass=true, Documentation(info="<html>

<p>The following AC/AC converter topologies are currently included in the PowerConverters library.</p>

<ul>
<li>Single-phase dimmer with <a href=\"modelica://Modelica.Electrical.PowerConverters.ACAC.SinglePhaseTriac\">triac</a></li>
<li>Polyphase induction machine soft starter with <a href=\"modelica://Modelica.Electrical.PowerConverters.ACAC.PolyphaseTriac\">triac</a></li>
</ul>

<h4>Control</h4>

<p>To apply firing signals to the triac, the
<a href=\"modelica://Modelica.Electrical.PowerConverters.DCDC.Control.SignalPWM\">SignalPWM model</a> is provided.
</p>
<p>
The <a href=\"modelica://Modelica.Electrical.PowerConverters.ACAC.Control.VoltageToAngle\">Voltage2Angle block</a>
calculates phase angle from reference voltage.
</p>
<p>
To control the soft start of an induction machine,
the <a href=\"modelica://Modelica.Electrical.PowerConverters.ACAC.Control.SoftStartControl\">SoftStartControl block</a>
is provided. It applies a voltage ramp during start, setting the ramp on hold whenever the measured current exceeds the maximum current.
Furthermore, a ramp down can be applied for stopping the drive.
</p>

<h4>Examples</h4>

<p>Some examples are provided at
<a href=\"modelica://Modelica.Electrical.PowerConverters.Examples.ACAC\">Examples.ACAC</a>.
</p>
</html>"));
end ACACConcept;
