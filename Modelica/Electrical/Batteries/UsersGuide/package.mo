within Modelica.Electrical.Batteries;
package UsersGuide "User's Guide"
  extends Modelica.Icons.Information;

  annotation (DocumentationClass=true, Documentation(info="<html>
<p>
This library provides battery models, based on the electrical behaviour at the terminals.
</p>
<h4>Battery characteristics</h4>
<p>
All battery models rely on existing components like voltage source, resistor and capacitor models provided in the
<a href=\"modelica://Modelica.Electrical.Analog\">Analog</a> package of the Modelica Standard Library.<br>
Explore the <a href=\"modelica://Modelica.Electrical.Batteries.UsersGuide.Concept\">concept</a> of the battery models as well as
<a href=\"modelica://Modelica.Electrical.Batteries.UsersGuide.Parameterization\">parameterization</a>.
Both are based on the <a href=\"modelica://Modelica.Electrical.Batteries.UsersGuide.References\">references</a>.
</p>
<p>
Each battery is equipped with an optional heat port which can be enabled by the parameter <code>useHeatPort</code>;
the heat flow of the battery heat port is determined by the sum of all heat flows of all resistive elements.<br>
This enables coupling with external thermal models to investigate thermal management issues.
However, thermal models are not included yet.
</p>
</html>"));
end UsersGuide;
