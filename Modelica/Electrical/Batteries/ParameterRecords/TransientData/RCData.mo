within Modelica.Electrical.Batteries.ParameterRecords.TransientData;
record RCData "Parameters of RC-elements"
  extends Modelica.Icons.Record;
  parameter Modelica.SIunits.Resistance R "Resistance of RC-element";
  parameter Modelica.SIunits.Capacitance C "Capacitance of RC-element (=T/R)";
  annotation(defaultComponentPrefixes="parameter", defaultComponentName="rcData",
  Documentation(info="<html>
<p>Parameters for RC-elements of battery models</p>
<h4>Note</h4>
<p>Capacitance C can be calculated from time constant T by C = T/R.</p>
</html>"),
    Icon(graphics={
        Line(
          points={{-40,-26},{-32,-26}},
          color={238,46,47},
          thickness=0.5),
        Line(
          points={{-6,-16},{-32,-16},{-32,-40},{-20,-40}},
          color={238,46,47},
          thickness=0.5),
        Line(
          points={{-6,-26},{-6,-6}},
          color={238,46,47},
          thickness=0.5),
        Line(
          points={{6,-26},{6,-6}},
          color={238,46,47},
          thickness=0.5),
        Line(
          points={{6,-16},{32,-16},{32,-40},{20,-40}},
          color={238,46,47},
          thickness=0.5),
        Line(
          points={{32,-26},{40,-26}},
          color={238,46,47},
          thickness=0.5),
        Rectangle(
          extent={{-20,-46},{20,-32}},
          lineColor={238,46,47},
          lineThickness=0.5)}));
end RCData;
