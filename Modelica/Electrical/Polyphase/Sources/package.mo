within Modelica.Electrical.Polyphase;
package Sources "Polyphase voltage and current sources"
  extends Modelica.Icons.SourcesPackage;

  annotation (Documentation(info="<html>
<p>
This package contains time-dependent and controlled polyphase voltage and current sources:
</p>
<ul>
<li>SignalVoltage: fed by Modelica.Blocks.Sources arbitrary waveforms of voltages are possible</li>
<li>ConstantVoltage: constant polyphase voltages</li>
<li>SineVoltage : phase shift between consecutive voltages by default given by
<a href=\"modelica://Modelica.Electrical.Polyphase.Functions.symmetricOrientation\">symmetricOrientation</a></li>
<li>CosineVoltage : phase shift between consecutive voltages by default given by
<a href=\"modelica://Modelica.Electrical.Polyphase.Functions.symmetricOrientation\">symmetricOrientation</a></li>
<li>SignalCurrent: fed by Modelica.Blocks.Sources arbitrary waveforms of currents are possible</li>
<li>ConstantCurrent: constant polyphase currents</li>
<li>SineCurrent : phase shift between consecutive currents by default given by
<a href=\"modelica://Modelica.Electrical.Polyphase.Functions.symmetricOrientation\">symmetricOrientation</a></li>
<li>CosineCurrent : phase shift between consecutive currents by default given by
<a href=\"modelica://Modelica.Electrical.Polyphase.Functions.symmetricOrientation\">symmetricOrientation</a></li>
</ul>
</html>",
        revisions="<html>
<dl>
  <dt><strong>Main Authors:</strong></dt>
  <dd>
  <a href=\"https://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting &amp; Electrical Engineering<br>
  D-93049 Regensburg<br>Germany<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
  <dt><strong>Release Notes:</strong></dt>
  <dd>
  <ul>
  <li> v1.0 2004/10/01 Anton Haumer</li>
  </ul>
  </dd>
</dl>
</html>"));
end Sources;
