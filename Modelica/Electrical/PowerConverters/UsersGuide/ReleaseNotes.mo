within Modelica.Electrical.PowerConverters.UsersGuide;
class ReleaseNotes "Release Notes"
  extends Modelica.Icons.ReleaseNotes;
  annotation (Documentation(info="<html>
<h5>Version 3.2.3, 2019-01-23</h5>
<ul>
<li>Added instantaneous power calculations of DC and AC interface partial models, see <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2198\">#2198</a></li>
<li>Replaced Modelica_Electrical_PowerConverters by Modelica.Electrical.PowerConverter, see <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2196\">#2196</a></li>
<li>Unified location of PowerConverter connectors in diagram layer, see <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2185\">#2185</a></li>
<li>Fixed broken hyper links</li>
<li>Replaced pin declaration by <code>extends</code> according to <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2065\">#2065</a></li>
</ul>

<h5>Version 1.2.0, 2014-04-06</h5>
<ul>
<li>Moved enabling signals from control to inverter models due to consistency reasons</li>
<li>Added partial models for enabling firing signals</li>
</ul>

<h5>Version 1.1.0, 2014-03-24</h5>
<ul>
<li>Removed StepUp converter due to consistency reasons</li>
</ul>

<h5>Version 1.0.0, 2014-03-24</h5>
<ul>
<li>First tagged version</li>
</ul>

</html>"));
end ReleaseNotes;
