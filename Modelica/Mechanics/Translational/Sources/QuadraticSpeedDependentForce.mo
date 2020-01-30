within Modelica.Mechanics.Translational.Sources;
model QuadraticSpeedDependentForce
  "Quadratic dependency of force versus speed"
  extends Modelica.Mechanics.Translational.Interfaces.PartialForce;
  parameter SI.Force f_nominal
    "Nominal force (if negative, force is acting as load in positive direction of motion)";
  parameter Boolean ForceDirection=true
    "Same direction of force in both directions of motion";
  parameter SI.Velocity v_nominal(min=Modelica.Constants.eps)
    "Nominal speed";
  SI.Velocity v
    "Velocity of flange with respect to support (= der(s))";
equation
  v = der(s);
  if ForceDirection then
    f = -f_nominal*(v/v_nominal)^2;
  else
    f = -f_nominal*smooth(1, if v >= 0 then (v/v_nominal)^2 else -(v/v_nominal)^2);
  end if;
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={
          Line(points={{-60,50},{-60,-40}}, color={192,192,192}),
          Line(points={{-75,-30},{75,-30}}, color={192,192,192}),
        Line(
          points={{-60,-30},{-40,-28},{-20,-22},{0,-10},{20,6},{40,26},{58,52}},
          color={0,0,127},
          smooth=Smooth.Bezier)}),     Documentation(info="<html>
<p>
Model of force, quadratic dependent on velocity of flange.<br>
Parameter ForceDirection chooses whether direction of force is the same in both directions of movement or not.
</p>
</html>"));
end QuadraticSpeedDependentForce;
