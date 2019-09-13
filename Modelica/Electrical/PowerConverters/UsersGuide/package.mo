within Modelica.Electrical.PowerConverters;
package UsersGuide "User's Guide"
  extends Modelica.Icons.Information;
  annotation (DocumentationClass=true, Documentation(info="<html>
<p>
This library provides power converters for DC and AC single-phase and polyphase electrical systems. The PowerConverters library contains three types of converters.
</p>

<ul>
  <li>AC/DC converters (rectifiers)</li>
  <li>DC/AC converters (inverters)</li>
  <li>DC/DC converters</li>
  <li>AC/AC converters</li>
</ul>

<p>
AC/AC converters currently only provide dimmer and soft starter with triacs.
</p>

<h4>Converter characteristics</h4>

<ul>
  <li>All converter models rely on existing diode, thyristor and switch models provided in the
      <a href=\"modelica://Modelica.Electrical.Analog.Ideal\">Analog.Ideal</a> and the
      <a href=\"modelica://Modelica.Electrical.Polyphase.Ideal\">Polyphase.Ideal</a>
      package of the Modelica Standard Library.</li>
  <li>Switching losses and recovery effects are not considered</li>
  <li>Only conduction losses are taken into account</li>
  <li>The parameters of the semiconductors include
  <ul>
    <li>The on state resistance <code>Ron</code></li>
    <li>The off state conductance <code>Goff</code></li>
    <li>The knee voltage <code>Vknee</code></li>
  </ul></li>
  <li>Each converter is equipped with an optional heat port which can be enabled by the parameter
      <code>useHeatPort</code>; the heat ports of all semiconductors are connected,
      so all temperatures of all semiconductors are equal and the heat flow of the converter heat port
      is determined by the sum of all semiconductor heat flows</li>
  <li>Each converter contains boolean firing inputs provides variables <code>offStart...</code>
      to specify the initial conditions of the off state of each semiconductor</li>
  <li>The boolean firing signals are enabled either by means of the a parameter <code>constantEnable</code> or by a conditional signal input, enabled by <code>useConstantEnable = false</code></li>
  <li>The number of phases of polyphase converters is not restricted to three</li>
</ul>

<h4>Literature</h4>

<p>
General background knowledge on power converters and power electronics can be found in
<a href=\"modelica://Modelica.Electrical.PowerConverters.UsersGuide.References\">[Skvarenina01]</a> and
<a href=\"modelica://Modelica.Electrical.PowerConverters.UsersGuide.References\">[Luo05]</a>.
A freely available book is available in
<a href=\"modelica://Modelica.Electrical.PowerConverters.UsersGuide.References\">[Williams2006]</a>.
</p>
</html>"));
end UsersGuide;
