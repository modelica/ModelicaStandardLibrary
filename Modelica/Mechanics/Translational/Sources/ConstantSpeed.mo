within Modelica.Mechanics.Translational.Sources;
model ConstantSpeed "Constant speed, not dependent on force"
  extends Modelica.Mechanics.Translational.Interfaces.PartialForce;
  parameter SI.Velocity v_fixed
    "Fixed speed (if negative, force is acting as load)";
  SI.Velocity v
    "Velocity of flange with respect to support (= der(s))";
equation
  v = der(s);
  v = v_fixed;
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={
          Line(points={{-60,60},{-60,-10}}, color={192,192,192}),
          Line(points={{-75,0},{75,0}}, color={192,192,192}),
                                  Line(points={{10,-15},{10,70}}, color={0,0,127}),
      Text(extent={{-120,-50},{120,-20}},
          textString="%v_fixed")}),         Documentation(info="<html>
<p>
Model of <strong>fixed</strong> velocity of flange, not dependent on force.
</p>
</html>"));
end ConstantSpeed;
