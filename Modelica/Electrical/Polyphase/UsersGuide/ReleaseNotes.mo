within Modelica.Electrical.Polyphase.UsersGuide;
class ReleaseNotes "Release Notes"
  extends Modelica.Icons.ReleaseNotes;
  annotation (preferredView="info",
    DocumentationClass=true, Documentation(info="<html>

<h5>Version 3.2.3, 2019-01-23 (Anton Haumer, Christian Kral)</h5>
<ul>
  <li>Shortened default component names, see
      <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2301\">#2301</a></li>
<li>Removed redundant (and not identical) parameter m from
    <a href=\"modelica://Modelica.Electrical.Polyphase.Basic.MutualInductor\">MutualInductor</a>,
    see <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2202\">#2202</a></li>
<li>Changed epsilon from constant to parameter in
    <a href=\"modelica://Modelica.Electrical.Polyphase.Basic.MutualInductor\">MutualInductor</a>,
    see <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2200\">#2200</a></li>
<li>Added User's Guide</li>
<li>Added blocks and functions for multiple base systems</li>
</ul>

<h5>Version 1.4.0, 2009-08-26 (Anton Haumer)</h5>
<ul>
<li>Added conditional HeatPorts as in Electrical.Analog</li>
<li>Added switches with arc as in Electrical.Analog</li>
</ul>

<h5>Version 1.3.2, 2007-08-24 (Anton Haumer)</h5>
<ul>
<li>Removed redeclare type SignalType</li>
</ul>

<h5>Version 1.3.1, 2007-08-12 (Anton Haumer)</h5>
<ul>
<li>Improved documentation</li>
</ul>

<h5>Version 1.3.0, 2007-01-23 (Anton Haumer)</h5>
<ul>
<li>Improved some icons</li>
</ul>

<h5>Version 1.2, 2006-07-05 (Anton Haumer)</h5>
<ul>
<li>Removed annotation from pin of Interfaces.Plug</li>
<li>Corrected usage of resistance/conductance</li>
</ul>

<h5>Version 1.1, 2006-01-12 (Anton Haumer)</h5>
<ul>
<li>Added Sensors.PowerSensor</li>
</ul>

<h5>Version 1.0, 2004-10-01 (Anton Haumer)</h5>
<ul>
  <li>Initial release version</li>
</ul></html>"));
end ReleaseNotes;
