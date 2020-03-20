within Modelica.Electrical.Batteries.BatteryStacksWithSensors;
model StackRC "Stack with sensors"
  extends Modelica.Electrical.Batteries.BaseClasses.BaseStackWithSensors(
      redeclare Modelica.Electrical.Batteries.ParameterRecords.TransientData.StackData stackData,
      redeclare Modelica.Electrical.Batteries.BatteryStacksWithSensors.CellRC cell(
        cellData=stackData.cellData,
        SOC0=SOC0,
        each SOCtolerance=SOCtolerance,
        each useHeatPort=useHeatPort,
        each T=T));
  extends Modelica.Electrical.Batteries.Icons.TransientModel;
  annotation (Documentation(info="<html>
<p>
This is a stack of <code>Ns</code> x <code>Np</code> transient <a href=\"modelica://Modelica.Electrical.Batteries.BatteryStacksWithSensors.CellRC\">cellRC[Np=1, Ns=1]</a> (with RC-elements) with measurement, arranged in a matrix.
</p>
</html>"));
end StackRC;
