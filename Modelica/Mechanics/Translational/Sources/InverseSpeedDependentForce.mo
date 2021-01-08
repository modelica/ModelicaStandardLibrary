within Modelica.Mechanics.Translational.Sources;
model InverseSpeedDependentForce
  "Force reciprocal dependent on speed"
  extends Translational.Interfaces.PartialForce;
  parameter SI.Force f_nominal
    "Nominal force (if negative, torque is acting as load in positive direction of motion)";
  parameter Boolean ForceDirection=true
    "Same direction of force in both directions of motion";
  parameter SI.Velocity v_nominal(min=Modelica.Constants.eps)
    "Nominal speed";
  parameter SI.Velocity v0(final min=Modelica.Constants.eps, start=0.1)
    "Regularization below v0" annotation(Dialog(enable=not ForceDirection));
  SI.Velocity v
    "Velocity of flange with respect to support (= der(s))";
equation
  v = der(s);
  if ForceDirection then
    f = if abs(v)<v0 then -f_nominal*v_nominal/v0 else -f_nominal*v_nominal/abs(v);
  else
    f = if abs(v)<v0 then -f_nominal*v/v0 else -f_nominal*v_nominal/v;
  end if;
  annotation (
    Icon(
      coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
          Line(points={{-60,50},{-60,-40}}, color={192,192,192}),
          Line(points={{-75,-30},{75,-30}}, color={192,192,192}),
          Line(points={{60,-10},{30,-9.1},{0,-7.4},{-10,-6.3},{-20,-4.8},{-30,-2.2},{-40,3},{-45,8.3},{-50,18.7},{-52,26.5},{-53,32.1},{-54,39.6},{-55,50}},
                        color={0,0,127},
          smooth=Smooth.Bezier)}),
    Documentation(info="<html>
<p>
Model of inverse speed dependent force.
</p>
<p>
Parameter ForceDirection chooses whether direction of force is
the same in both directions of movement or not.
If ForceDirection =&nbsp;false, regularization near zero speed
avoids numerical problems.
</p>
</html>"));
end InverseSpeedDependentForce;
