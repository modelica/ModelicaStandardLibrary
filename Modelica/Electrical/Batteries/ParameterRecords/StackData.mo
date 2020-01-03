within Modelica.Electrical.Batteries.ParameterRecords;
record StackData "Parameters for stacks including degradation"
  extends Modelica.Electrical.Batteries.BaseClasses.BaseStackData(
    redeclare Modelica.Electrical.Batteries.ParameterRecords.CellData cellDataOriginal,
    redeclare Modelica.Electrical.Batteries.ParameterRecords.CellData cellDataDegraded,
    redeclare Modelica.Electrical.Batteries.ParameterRecords.CellData cellData);
  annotation(defaultComponentPrefixes="parameter");
end StackData;
