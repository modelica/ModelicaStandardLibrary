within Modelica.Mechanics.Translational.Sources;
model ConstantForce "Constant force, not dependent on speed"
  extends Modelica.Mechanics.Translational.Interfaces.PartialForce;
  parameter SI.Force f_constant
    "Nominal force (if negative, force is acting as load in positive direction of motion)";
equation
  f = -f_constant;
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={
          Line(points={{-75,10},{75,10}},
                                        color={192,192,192}),
          Line(points={{0,60},{0,0}}, color={192,192,192}),
          Line(points={{-75,30},{75,30}}, color={0,0,127}),
          Text(extent={{-120,-40},{120,-10}},
          textString="%f_constant")}),            Documentation(info="<html>
<p>Model of constant force, not dependent on velocity of flange.</p>
<p>Please note:<br>
Positive force accelerates in positive direction of movement, but brakes in reverse direction of movement.<br>
Negative force brakes in positive direction of movement, but accelerates in reverse direction of movement.</p>
</html>"));
end ConstantForce;
