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
</html>"));
end DCACConcept;
