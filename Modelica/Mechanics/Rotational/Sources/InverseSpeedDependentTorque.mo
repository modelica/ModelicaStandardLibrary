within Modelica.Mechanics.Rotational.Sources;
model InverseSpeedDependentTorque
  "Torque reciprocal dependent on speed"
  extends Rotational.Interfaces.PartialTorque;
  import Modelica.Constants.pi;
  parameter SI.Torque tau_nominal
    "Nominal torque (if negative, torque is acting as load in positive direction of rotation)";
  parameter Boolean TorqueDirection=true
    "Same direction of torque in both directions of rotation";
  parameter SI.AngularVelocity w_nominal(min=Modelica.Constants.eps)
    "Nominal speed";
  parameter SI.AngularVelocity w0(final min=Modelica.Constants.eps, start=0.1)
    "Regularization below w0" annotation(Dialog(enable=not TorqueDirection));
  SI.AngularVelocity w
    "Angular velocity of flange with respect to support (= der(phi))";
  SI.Torque tau
    "Accelerating torque acting at flange (= -flange.tau)";
equation
  w = der(phi);
  tau = -flange.tau;
  if TorqueDirection then
    tau = if abs(w)<w0 then tau_nominal*w_nominal/w0 else tau_nominal*w_nominal/abs(w);
  else
    tau = if abs(w)<w0 then tau_nominal*w/w0 else tau_nominal*w_nominal/w;
  end if;
  annotation (
    Icon(
      coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
          Line(points={{-60,40},{-60,-50}}, color={192,192,192}),
          Line(points={{-75,-40},{75,-40}}, color={192,192,192}),
          Line(points={{60,-20},{30,-19.1},{0,-17.4},{-10,-16.3},{-20,-14.8},{-30,
              -12.2},{-40,-7},{-45,-1.7},{-50,8.7},{-52,16.5},{-53,22.1},{-54,29.6},
              {-55,40}},color={0,0,127},
          smooth=Smooth.Bezier)}),
    Documentation(info="<html>
<p>
Model of inverse speed dependent torque.
</p>
<p>
Parameter TorqueDirection chooses whether direction of torque is
the same in both directions of rotation or not.
If TorqueDirection =&nbsp;false, regularization near zero speed
avoids numerical problems.
</p>
</html>"));
end InverseSpeedDependentTorque;
