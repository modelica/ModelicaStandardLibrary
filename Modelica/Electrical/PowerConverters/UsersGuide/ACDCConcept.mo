within Modelica.Electrical.PowerConverters.UsersGuide;
class ACDCConcept "AC/DC converter concept"
  extends Modelica.Icons.Information;
  annotation (DocumentationClass=true, Documentation(info="<html>

<p>AC/DC converters are also called rectifiers</p>

<h4>Component classification</h4>

<p>Conventional AC/DC converters contain diodes and thyristors. If thyristors are used, the output voltage of the rectifier can be controlled. If only diodes are used, the output voltages is solely dependent on the input voltage and the characteristic of applied diodes.</p>
<ul>
  <li>Diode rectifiers</li>
  <li>Thyristor rectifiers</li>
  <li>Half controlled rectifiers; half of the semiconductors are diodes and the others are thyristors, respectively</li>
</ul>

<h4>Topology classification</h4>

<p>The PowerConverters library provides bridge and center tap rectifiers for single and polyphase supply, see
<a href=\"modelica://Modelica.Electrical.PowerConverters.ACDC\">AC/DC converters</a>.</p>

<h4>Control</h4>

<p>For each of the provided rectifiers a
<a href=\"modelica://Modelica.Electrical.PowerConverters.ACDC.Control\">control model</a> is available.
These control models have electrical connectors to be connected with the AC supply.
The firing angle of thyristor rectifiers can either be set by a parameter or a signal input.
</p>

<h4>Examples</h4>

<p>A variety of examples is provided at
<a href=\"modelica://Modelica.Electrical.PowerConverters.Examples.ACDC\">Examples.ACDC</a>.
These examples include different kinds of DC loads. Even the control characteristics
of the rectifiers can be obtained experimentally; the names of these models
contain <code>_Characteristic</code>.
</p>
</html>"));
end ACDCConcept;
