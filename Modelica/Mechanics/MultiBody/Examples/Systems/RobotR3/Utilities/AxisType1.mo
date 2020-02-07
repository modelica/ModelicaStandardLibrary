within Modelica.Mechanics.MultiBody.Examples.Systems.RobotR3.Utilities;
model AxisType1 "Axis model of the r3 joints 1,2,3"
  extends AxisType2(redeclare GearType1 gear(c=c, d=cd))
    annotation(IconMap(primitivesVisible=false));
  parameter SI.RotationalSpringConstant c = 43 "Spring constant"
    annotation (Dialog(group="Gear"));
  parameter SI.RotationalDampingConstant cd = 0.005 "Damper constant"
    annotation (Dialog(group="Gear"));
  annotation (
    Documentation(info="<html>
<p>
Model of axis 1, 2, 3 of the robot r3. An axis consists of a gearbox with modelled gear elasticity and bearing friction,
a model of the electrical motor and a continuous-time cascade controller.
</p>
</html>"),
    Icon(graphics={Line(points={{44,0},{52,0},{58,20},{68,-20},{74,0},{82,0}},color={95,95,95}),
        Rectangle(
          extent={{80,10},{100,-10}},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={192,192,192},
          lineColor={64,64,64}),
        Rectangle(
          extent={{28,10},{46,-10}},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={192,192,192},
          lineColor={64,64,64}),
        Rectangle(
          extent={{-100,50},{22,-50}},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={175,175,175},
          lineColor={0,0,0}),
        Text(
          extent={{-150,100},{150,60}},
          textString="%name",
          textColor={0,0,255}),
        Rectangle(
          extent={{-100,34},{22,-34}},
          fillPattern=FillPattern.Solid,
          fillColor={95,95,95},
          lineColor={0,0,0}),
        Rectangle(
          extent={{10,54},{30,-54}},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={160,160,164}),
        Rectangle(
          extent={{10,54},{30,-54}}, lineColor={0,0,0})}));
end AxisType1;
