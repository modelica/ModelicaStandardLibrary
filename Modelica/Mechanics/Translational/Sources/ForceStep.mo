within Modelica.Mechanics.Translational.Sources;
model ForceStep "Constant force, not dependent on speed"
  extends Modelica.Mechanics.Translational.Interfaces.PartialForce;
  parameter SI.Force stepForce(start=1)
    "Height of force step (if negative, force is acting as load)";
  parameter SI.Force offsetForce(start=0) "Offset of force";
  parameter SI.Time startTime=0
    "Force = offset for time < startTime";
equation
  f = -offsetForce - (if time < startTime then 0 else stepForce);
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={
          Line(points={{-75,0},{75,0}}, color={192,192,192}),
                                  Line(points={{-75,-30},{0,-30},{0,45},{65,45}}, color={0,0,127}),
                                      Text(
          extent={{0,-40},{100,-10}},
          textColor={128,128,128},
          textString="time")}),     Documentation(info="<html>
<p>
Model of a force step at time startTime.
Positive force accelerates in positive direction of <code>flange</code> translation.
</p>
</html>"));
end ForceStep;
