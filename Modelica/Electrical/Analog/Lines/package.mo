within Modelica.Electrical.Analog;
package Lines "Lossy and lossless segmented transmission lines, and LC distributed line models"
  extends Modelica.Icons.Package;

  annotation (Documentation(info="<html>
<p>This package contains lossy and lossless segmented transmission lines, and LC distributed line models. The line models do not yet possess a conditional heating port.</p>
</html>", revisions="<html>
<dl>
<dt>
<strong>Main Authors:</strong>
</dt>
<dd>
Christoph Clau&szlig;
    &lt;<a href=\"mailto:christoph@clauss-it.com\">christoph@clauss-it.com</a>&gt;<br>
    Joachim Haase;
    &lt;<a href=\"mailto:haase@eas.iis.fhg.de\">haase@eas.iis.fhg.de</a>&gt;<br>
    Andr&eacute; Schneider
    &lt;<a href=\"mailto:Andre.Schneider@eas.iis.fraunhofer.de\">Andre.Schneider@eas.iis.fraunhofer.de</a>&gt;<br>
    Fraunhofer Institute for Integrated Circuits<br>
    Design Automation Department<br>
    Zeunerstra&szlig;e 38<br>
    D-01069 Dresden
</dd>
</dl>

<p>
Copyright &copy; 1998-2020, Modelica Association and contributors
</p>
</html>"), Icon(graphics={
        Line(points={{-60,50},{-90,50}}),
        Rectangle(
          extent={{-60,60},{60,-60}}),
        Line(points={{-60,-50},{-90,-50}}),
        Line(points={{36,20},{-36,20}}),
        Line(points={{-36,40},{-36,0}}),
        Line(points={{36,40},{36,0}}),
        Line(points={{60,50},{90,50}}),
        Line(points={{60,-50},{90,-50}})}));
end Lines;
