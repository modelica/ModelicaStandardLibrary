within Modelica.Mechanics.Rotational.Sources;
model ConstantSpeed "Constant speed, not dependent on torque"
  extends Modelica.Mechanics.Rotational.Interfaces.PartialTorque;
  Modelica.SIunits.AngularVelocity w
    "Angular velocity of flange with respect to support (= der(phi))";
  parameter Modelica.SIunits.AngularVelocity w_fixed "Fixed speed";
equation
  w = der(phi);
  w = w_fixed;
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
          Line(points={{-60,60},{-60,-10}}, color={192,192,192}),
          Line(points={{-75,0},{75,0}}, color={192,192,192}),
          Line(points={{10,-15},{10,70}}, color={0,0,127}),
          Text(extent={{-120,-50},{120,-20}}, textString="%w_fixed")}),
    Documentation(info="<html>
<p>
Model of <strong>fixed</strong> angular velocity of flange, not dependent on torque.
</p>
</html>"));
end ConstantSpeed;
