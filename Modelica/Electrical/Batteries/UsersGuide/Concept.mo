within Modelica.Electrical.Batteries.UsersGuide;
class Concept "Concept of battery models"
  extends Modelica.Icons.Information;
  annotation (DocumentationClass=true, Documentation(info="<html>
<p>
The core of the battery models is a <a href=\"modelica://Modelica.Electrical.Analog.Sources.SignalVoltage\">signal voltage</a>
controlled by a look-up table OCV (open circuit voltage) dependent on SOC (state of charge). <br>
However, other dependencies (e.g. on temperature) are not implemented yet.
</p>
<p>
Current flowing to or from the battery is measured and integrated, thus calculating the charge contained in the battery.
The charge contained in the battery with respect to nominal charge <code>Qnom</code> gives SOC.<br>
The look-up table is parameterized for one cell, therefore input has to be scaled by <code>1/(Np*Qnom)</code>,
and the output has to be scaled by <code>Ns*OCVmax</code>.
</p>
<p>
To model self-discharge, a conductor in parallel to the signal voltage and the current sensor is implemented.
If self-discharge is specified as zero, the conductor is omitted.
</p>
<p>
A resistor <code>r0</code> is connected in series to the signal voltage, representing the inner resistance of the battery.
The resistance can be specified as linearly dependent on temperature.
</p>
<p>
If <a href=\"modelica://Modelica.Electrical.Batteries.BatteryStacks.CellRCStack\">CellRCStack</a> instead of
<a href=\"modelica://Modelica.Electrical.Batteries.BatteryStacks.CellStack\">CellStack</a> is chosen,
RC-elements are connected in series to model the transient behaviour of the battery.<br>
Both models can be used for a single cell <code>Ns = Np = 1</code> as well as a stack built from identical cells.<br>
Note that the total inner resistance <code>Ri</code> is the sum of the resistance of resistor <code>r0</code> and the sum of the resistances of the resistors of the RC-elements.
</p>
<p>
For details of parameterization, see <a href=\"modelica://Modelica.Electrical.Batteries.UsersGuide.Parameterization\">UsersGuide.Parameterization</a>.
</p>
</html>"));
end Concept;
