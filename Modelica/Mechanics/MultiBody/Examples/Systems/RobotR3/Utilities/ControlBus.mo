within Modelica.Mechanics.MultiBody.Examples.Systems.RobotR3.Utilities;
expandable connector ControlBus "Data bus for all axes of robot"
  extends Modelica.Icons.SignalBus;
  Modelica.Mechanics.MultiBody.Examples.Systems.RobotR3.Utilities.AxisControlBus axisControlBus1 "Bus of axis 1";
  Modelica.Mechanics.MultiBody.Examples.Systems.RobotR3.Utilities.AxisControlBus axisControlBus2 "Bus of axis 2";
  Modelica.Mechanics.MultiBody.Examples.Systems.RobotR3.Utilities.AxisControlBus axisControlBus3 "Bus of axis 3";
  Modelica.Mechanics.MultiBody.Examples.Systems.RobotR3.Utilities.AxisControlBus axisControlBus4 "Bus of axis 4";
  Modelica.Mechanics.MultiBody.Examples.Systems.RobotR3.Utilities.AxisControlBus axisControlBus5 "Bus of axis 5";
  Modelica.Mechanics.MultiBody.Examples.Systems.RobotR3.Utilities.AxisControlBus axisControlBus6 "Bus of axis 6";

  annotation (
    Documentation(info="<html>
<p>
Signal bus that is used to communicate <strong>all signals</strong> of the robot.
This is an expandable connector which has a \"default\" set of
signals. Note, the input/output causalities of the signals are
determined from the connections to this bus.
</p>
</html>"));
end ControlBus;
