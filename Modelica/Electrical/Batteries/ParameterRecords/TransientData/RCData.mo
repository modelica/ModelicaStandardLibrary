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
          points={{-60,-16},{-50,-16}},
          color={238,46,47}),
        Line(
          points={{-6,14},{-50,14},{-50,-36},{-24,-36}},
          color={238,46,47}),
        Line(
          points={{-6,4},{-6,24}},
          color={238,46,47}),
        Line(
          points={{6,4},{6,24}},
          color={238,46,47}),
        Line(
          points={{6,14},{50,14},{50,-36},{24,-36}},
          color={238,46,47}),
        Line(
          points={{50,-16},{60,-16}},
          color={238,46,47}),
        Rectangle(
          extent={{-24,-46},{24,-26}},
          lineColor={238,46,47})}));
end RCData;
