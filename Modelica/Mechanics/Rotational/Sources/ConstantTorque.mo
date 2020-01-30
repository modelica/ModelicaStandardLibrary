within Modelica.Mechanics.Rotational.Sources;
model ConstantTorque "Constant torque, not dependent on speed"
  extends Rotational.Interfaces.PartialTorque;
  parameter SI.Torque tau_constant
    "Constant torque (if negative, torque is acting as load in positive direction of rotation)";
  SI.AngularVelocity w
    "Angular velocity of flange with respect to support (= der(phi))";
  SI.Torque tau
    "Accelerating torque acting at flange (= -flange.tau)";
equation
  w = der(phi);
  tau = -flange.tau;
  tau = tau_constant;
  annotation (
    Icon(
      coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}),
        graphics={
          Line(points={{-75,10},{75,10}},
                                        color={192,192,192}),
          Line(points={{0,60},{0,0}}, color={192,192,192}),
          Line(points={{-75,30},{75,30}}, color={0,0,127}),
          Text(extent={{-120,-40},{120,-10}}, textString="%tau_constant")}),
    Documentation(info="<html>
<p>Model of constant torque, not dependent on angular velocity of flange.</p>
<p>Please note:<br>
Positive torque accelerates in positive direction of rotation, but brakes in reverse direction of rotation.<br>
Negative torque brakes in positive direction of rotation, but accelerates in reverse direction of rotation.</p>
</html>"));
end ConstantTorque;
