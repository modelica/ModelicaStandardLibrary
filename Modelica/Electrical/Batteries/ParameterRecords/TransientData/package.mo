within Modelica.Electrical.Batteries.ParameterRecords;
package TransientData "Parameter records for transient battery models"
  extends Icons.RecordsPackage;


  annotation (Icon(graphics={
        Line(
          points={{-40,-20},{-32,-20}},
          color={238,46,47},
          thickness=0.5),
        Line(
          points={{-6,-10},{-32,-10},{-32,-34},{-20,-34}},
          color={238,46,47},
          thickness=0.5),
        Line(
          points={{-6,-20},{-6,0}},
          color={238,46,47},
          thickness=0.5),
        Line(
          points={{6,-20},{6,0}},
          color={238,46,47},
          thickness=0.5),
        Line(
          points={{6,-10},{32,-10},{32,-34},{20,-34}},
          color={238,46,47},
          thickness=0.5),
        Line(
          points={{32,-20},{40,-20}},
          color={238,46,47},
          thickness=0.5),
        Rectangle(
          extent={{-20,-40},{20,-26}},
          lineColor={238,46,47},
          lineThickness=0.5)}), Documentation(info="<html>
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
</html>"));
end TransientData;
