within Modelica.Electrical.Batteries;
package ParameterRecords "Parameter records for batteries"
  extends Modelica.Icons.RecordsPackage;

  annotation (Documentation(info="<html>
<p>
Parameter records for batteries
</p>
<h4>Note</h4>
<p>
The user can easily build up a collection of different battery types by creating individual parameter records extending from the base record <code>CellData</code>.
Do not forget to add the <code>annotation(defaultComponentPrefixes=\"parameter\");</code> in each individual parameter record.
</p>
</html>"));
end ParameterRecords;
