within Modelica.Electrical.Batteries.ParameterRecords;
package TransientData "Parameter records for transient battery models"
  extends Icons.RecordsPackage;


  annotation (                  Documentation(info="<html>
<p>
Parameter records for transient battery models
</p>
<h4>Note:</h4>
<p>
The user can easily build up a collection of different battery types by creating individual parameter records extending from the base record <code>CellData</code>.
Do not forget to add the <code>annotation(defaultComponentPrefixes=\"parameter\");</code> in each individual parameter record.
</p>
<p>
Record <a href=\"modelica://Modelica.Electrical.Batteries.ParameterRecords.TransientData.RCData\">RCData</a> is used in record <a href=\"modelica://Modelica.Electrical.Batteries.ParameterRecords.TransientData.CellData\">CellData</a>.
</p>
</html>"), Icon(graphics={
        Line(
          points={{-60,-6},{-50,-6}},
          color={238,46,47}),
        Line(
          points={{-6,24},{-50,24},{-50,-26},{-24,-26}},
          color={238,46,47}),
        Line(
          points={{-6,14},{-6,34}},
          color={238,46,47}),
        Line(
          points={{6,14},{6,34}},
          color={238,46,47}),
        Line(
          points={{6,24},{50,24},{50,-26},{24,-26}},
          color={238,46,47}),
        Line(
          points={{50,-6},{60,-6}},
          color={238,46,47}),
        Rectangle(
          extent={{-24,-36},{24,-16}},
          lineColor={238,46,47})}));
end TransientData;
