within Modelica.Mechanics.Rotational.Sources;
model QuadraticSpeedDependentTorque
  "Quadratic dependency of torque versus speed"
  extends Modelica.Mechanics.Rotational.Interfaces.PartialTorque;
  parameter SI.Torque tau_nominal
    "Nominal torque (if negative, torque is acting as load in positive direction of rotation)";
  parameter Boolean TorqueDirection=true
    "Same direction of torque in both directions of rotation";
  parameter SI.AngularVelocity w_nominal(min=Modelica.Constants.eps)
    "Nominal speed";
  SI.AngularVelocity w
    "Angular velocity of flange with respect to support (= der(phi))";
  SI.Torque tau
    "Accelerating torque acting at flange (= -flange.tau)";
equation
  w = der(phi);
  tau = -flange.tau;
  if TorqueDirection then
    tau = tau_nominal*(w/w_nominal)^2;
  else
    tau = tau_nominal*smooth(1, if w >= 0 then (w/w_nominal)^2 else -(w/w_nominal)^2);
  end if;
  annotation (
    Icon(
      coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100.0,-100.0},{100.0,100.0}}),
      graphics={
          Line(points={{-60,40},{-60,-50}}, color={192,192,192}),
          Line(points={{-75,-40},{75,-40}}, color={192,192,192}),
        Line(
          points={{-60,-40},{-40,-38},{-20,-32},{0,-20},{20,-4},{40,16},{58,42}},
          color={0,0,127},
          smooth=Smooth.Bezier)}),
    Documentation(info="<html>
<p>
Model of torque, quadratic dependent on angular velocity of flange.<br>
Parameter TorqueDirection chooses whether direction of torque is the same in both directions of rotation or not.
</p>
</html>"));
end QuadraticSpeedDependentTorque;
