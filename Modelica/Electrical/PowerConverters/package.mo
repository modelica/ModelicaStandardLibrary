within Modelica.Electrical;
package PowerConverters "Rectifiers, Inverters, DC/DC and AC/AC converters"
  extends Modelica.Icons.Package;
  annotation (
    preferredView="info",
    Documentation(info="<html>
<p>
This library provides power converters for DC and AC single-phase and polyphase electrical systems. The PowerConverters library contains four types of converters.
</p>

<ul>
  <li>AC/DC converters (rectifiers)</li>
  <li>DC/AC converters (inverters)</li>
  <li>DC/DC converters</li>
  <li>AC/AC converters</li>
</ul>

<p>
Copyright &copy; 2013-2020, Modelica Association and contributors
</p>
</html>"),
    Icon(graphics={
        Line(
          points={{-78,0},{80,0}},
          color={95,95,95}),
        Line(
          points={{36,50},{36,-52}},
          color={95,95,95}),
        Polygon(points={{36,0},{-34,50},{-34,-50},{36,0}}, lineColor={95,95,95})}));
end PowerConverters;
