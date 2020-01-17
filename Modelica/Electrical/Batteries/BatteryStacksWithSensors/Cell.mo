within Modelica.Electrical.Batteries.BatteryStacksWithSensors;
model Cell "Cell with measurement"
  extends Modelica.Electrical.Batteries.BaseClasses.BaseCellWithSensors(
    redeclare Modelica.Electrical.Batteries.ParameterRecords.CellData cellData,
    redeclare Modelica.Electrical.Batteries.BatteryStacks.CellStack cell(
      cellData=cellData,
      SOC(start=SOC0, fixed=true),
      SOCtolerance=SOCtolerance,
      useHeatPort=true,
      T=T));
 annotation (Documentation(info="<html>
<p>
This is a single <a href=\"modelica://Modelica.Electrical.Batteries.BatteryStacks.CellStack\">cell[Np=1, Ns=1]</a> with measurement.
</p>
</html>"));
end Cell;
