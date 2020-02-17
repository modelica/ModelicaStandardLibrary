within Modelica.Electrical.Batteries.BatteryStacksWithSensors;
model Stack "Stack with sensors"
  extends Modelica.Electrical.Batteries.BaseClasses.BaseStackWithSensors(
    redeclare Modelica.Electrical.Batteries.BaseClasses.BaseStackData stackData,
    redeclare Modelica.Electrical.Batteries.BatteryStacksWithSensors.Cell cell(
      cellData=stackData.cellData,
      SOC0=SOC0,
      each SOCtolerance=SOCtolerance,
      each useHeatPort=useHeatPort,
      each T=T));
  annotation (Documentation(info="<html>
<p>
This is a stack of <code>Ns</code> x <code>Np</code> <a href=\"modelica://Modelica.Electrical.Batteries.BatteryStacksWithSensors.Cell\">cell[Np=1, Ns=1]</a> with measurement, arranged in a matrix.
</p>
</html>"));
end Stack;
