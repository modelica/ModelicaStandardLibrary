within Modelica.Mechanics.Rotational.Sources;
model TorqueStep "Constant torque, not dependent on speed"
  extends Modelica.Mechanics.Rotational.Interfaces.PartialTorque;
  parameter SI.Torque stepTorque(start=1)
    "Height of torque step (if negative, torque is acting as load)";
  parameter SI.Torque offsetTorque(start=0)
    "Offset of torque";
  parameter SI.Time startTime=0
    "Torque = offset for time < startTime";
  SI.Torque tau
    "Accelerating torque acting at flange (= -flange.tau)";

equation
  tau = -flange.tau;
  tau = offsetTorque + (if time < startTime then 0 else stepTorque);
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
          Line(points={{-75,0},{75,0}}, color={192,192,192}),
          Line(points={{-75,-30},{0,-30},{0,45},{65,45}}, color={0,0,127}),
          Text(
          extent={{0,-40},{100,-10}},
          textColor={128,128,128},
          textString="time")}),
    Documentation(info="<html>
<p>
Model of a torque step at time startTime.
Positive torque accelerates in positive direction of <code>flange</code> rotation.
</p>
</html>"));
end TorqueStep;
