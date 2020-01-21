within Modelica.Electrical.Batteries.BatteryStacksWithSensors;
model CellRC "Cell with measurement"
  extends Modelica.Electrical.Batteries.BaseClasses.BaseCellWithSensors(
    redeclare Modelica.Electrical.Batteries.ParameterRecords.TransientData.CellData cellData,
    redeclare Modelica.Electrical.Batteries.BatteryStacks.CellRCStack cell(
      cellData=cellData,
      SOC(start=SOC0, fixed=true),
      SOCtolerance=SOCtolerance,
      useHeatPort=true,
      T=T));
  extends Modelica.Electrical.Batteries.Icons.TransientModel;
  annotation (Documentation(info="<html>
<p>
This is a single transient <a href=\"modelica://Modelica.Electrical.Batteries.BatteryStacks.CellRCStack\">cellRC[Np=1, Ns=1]</a> (with RC-elements) with measurement.
</p>
</html>"));
end CellRC;
