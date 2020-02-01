within Modelica.Mechanics.Rotational.Sources;
model LinearSpeedDependentTorque "Linear dependency of torque versus speed"
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
    tau = tau_nominal*abs(w/w_nominal);
  else
    tau = tau_nominal*(w/w_nominal);
  end if;
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
          Line(points={{0,60},{0,-50}}, color={192,192,192}),
          Line(points={{-75,0},{75,0}}, color={192,192,192}),
          Line(points={{-60,-45},{60,45}}, color={0,0,127})}),
    Documentation(info="<html>
<p>
Model of torque, linearly dependent on angular velocity of flange.<br>
Parameter TorqueDirection chooses whether direction of torque is the same in both directions of rotation or not.
</p>
</html>"));
end LinearSpeedDependentTorque;
