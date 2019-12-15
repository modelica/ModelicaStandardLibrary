within Modelica.Electrical.Polyphase;
package UsersGuide "User's Guide"
  extends Modelica.Icons.Information;

  annotation (preferredView="info",
    DocumentationClass=true,
    Documentation(info="<html>
<p>
This library contains components for modelling of polyphase electrical circuits.
The number of phases m is not restricted to three.
The connector (named plug) contains an array of m single-phase <a href=\"modelica://Modelica.Electrical.Analog.Interfaces.Pin\">pins</a>.
Most of the components use an array of single-phase components from <a href=\"modelica://Modelica.Electrical.Analog\">Modelica.Electrical.Analog</a>.
</p>
<h4>Note</h4>
<p>
For the orientation of an arbitrary number of phases m &gt; 3, see the <a href=\"modelica://Modelica.Electrical.Polyphase.UsersGuide.PhaseOrientation\">phase orientation concept</a>.
</p>
</html>"));
end UsersGuide;
