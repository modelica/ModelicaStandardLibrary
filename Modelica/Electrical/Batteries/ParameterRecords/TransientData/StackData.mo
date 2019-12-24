within Modelica.Electrical.Batteries.ParameterRecords.TransientData;
record StackData "Parameters for stacks"
  extends Modelica.Electrical.Batteries.BaseClasses.BaseStackData(
    redeclare Modelica.Electrical.Batteries.ParameterRecords.TransientData.CellData cellDataOriginal,
    redeclare Modelica.Electrical.Batteries.ParameterRecords.TransientData.CellData cellDataDegraded,
    redeclare Modelica.Electrical.Batteries.ParameterRecords.TransientData.CellData cellData);
  extends Modelica.Electrical.Batteries.Icons.TransientStackRecord;
  annotation(defaultComponentPrefixes="parameter");
end StackData;
