within Modelica.Electrical.Batteries.BatteryStacks;
model CellStack
  "Battery with open-circuit voltage dependent on state of charge, self-discharge and inner resistance"
  extends Modelica.Electrical.Batteries.BaseClasses.BaseCellStack(r0(final R=Ns*cellData.Ri/Np),
    redeclare Modelica.Electrical.Batteries.ParameterRecords.CellData cellData);
equation
  connect(r0.n, n)
    annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
  annotation (Documentation(info="<html>
<p>
The battery is modeled by open-circuit voltage (OCV) dependent on state of charge (SOC), self-discharge and inner resistance,
as implemented in partial <a href=\"modelica://Modelica.Electrical.Batteries.BaseClasses.BaseCellStack\">BaseCellStack</a>.
</p>
<p>
This model can be used for a single cell <code>Ns = Np = 1</code> as well as a stack built from identical cells.
</p>
<p>
For details, see <a href=\"modelica://Modelica.Electrical.Batteries.UsersGuide.Concept\">concept</a> and <a href=\"modelica://Modelica.Electrical.Batteries.UsersGuide.Parameterization\">parameterization</a>.
</p>
<h4>Note</h4>
<p>
Parameter record array <a href=\"modelica://Modelica.Electrical.Batteries.ParameterRecords.TransientData.RCData\">rcData</a> contained in
parameter record <a href=\"modelica://Modelica.Electrical.Batteries.ParameterRecords.CellData\">cellData</a> is neglected.
</p>
</html>"));
end CellStack;
