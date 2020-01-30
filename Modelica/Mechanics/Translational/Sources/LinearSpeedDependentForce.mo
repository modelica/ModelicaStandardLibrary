within Modelica.Mechanics.Translational.Sources;
model LinearSpeedDependentForce "Linear dependency of force versus speed"
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
    f = -f_nominal*abs(v/v_nominal);
  else
    f = -f_nominal*(v/v_nominal);
  end if;
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={
          Line(points={{-75,0},{75,0}}, color={192,192,192}),
          Line(points={{0,60},{0,-50}}, color={192,192,192}),
                                  Line(points={{-60,-45},{60,45}}, color={0,0,127})}),
                              Documentation(info="<html>
<p>
Model of force, linearly dependent on velocity of flange.<br>
Parameter ForceDirection chooses whether direction of force is the same in both directions of movement or not.
</p>
</html>"));
end LinearSpeedDependentForce;
