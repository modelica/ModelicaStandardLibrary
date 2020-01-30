within Modelica.Electrical.Batteries.UsersGuide;
class Concept "Concept of battery models"
  extends Modelica.Icons.Information;
  annotation (DocumentationClass=true, Documentation(info="<html>
<p>
The core of the cell models is a <a href=\"modelica://Modelica.Electrical.Analog.Sources.SignalVoltage\">signal voltage</a>
controlled by a look-up table OCV (open circuit voltage) dependent on SOC (state of charge). <br>
However, other dependencies (e.g., on temperature) are not implemented yet.
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
Additionally to these batteries that model a single cell scaled by the number of series connected cells <code>Ns</code> and the number of parallel connected cells <code>Np</code>,
single cell models and stacks are provided in <a href=\"modelica://Modelica.Electrical.Batteries.BatteryStacksWithSensors\">BatteryStacksWithSensors</a>.
The cells are equipped with sensors, the measured signals are provided in the <a href=\"modelica://Modelica.Electrical.Batteries.Interfaces.CellBus\">CellBus</a>.
The stack models contain a matrix of <code>Ns</code> x <code>Np</code> single cells which can be parameterized differently
to investigate the influence of a degraded cell on the behaviour of the whole stack, as well as to design battery management systems.
The stack provides the <a href=\"modelica://Modelica.Electrical.Batteries.Interfaces.StackBus\">StackBus</a> which contains <code>Ns</code> x <code>Np</code> cell buses of the cells.
Additionally, the signals of the whole stack - the same signals as of a single cell - are provided in the BatteryBus.
</p>
<p>
There are two options of series and parallel connections of cells in stacks:
</p>
<ul>
<li><code>useAllParallelConnections=true </code>: <code>Np</code> cells are connected in parallel, and these groups are connected in series.</li>
<li><code>useAllParallelConnections=false</code>: <code>Ns</code> cells are connected in series, and these groups are connected in parallel.</li>
</ul>
<p>
For convenience, a block <a href=\"modelica://Modelica.Electrical.Batteries.Utilities.BusTranscription\">BusTranscription</a> transfers the signals of all cell buses in the stack bus
to the <a href=\"modelica://Modelica.Electrical.Batteries.Interfaces.StackBusArrays\">StackBusArrays</a>, arranged as <code>Ns</code> x <code>Np</code> matrix per measurement signal.
</p>
<p>
For details of parameterization, see <a href=\"modelica://Modelica.Electrical.Batteries.UsersGuide.Parameterization\">UsersGuide.Parameterization</a>.
</p>
</html>"));
end Concept;
