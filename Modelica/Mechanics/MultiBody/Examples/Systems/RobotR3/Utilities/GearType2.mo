within Modelica.Mechanics.MultiBody.Examples.Systems.RobotR3.Utilities;
model GearType2 "Motor inertia and gearbox model for r3 joints 4,5,6"
  extends Modelica.Mechanics.Rotational.Icons.Gearbox;
  extends Modelica.Mechanics.Rotational.Interfaces.PartialTwoFlanges;

  parameter Real i=-99 "Gear ratio";
  parameter SI.Torque Rv0=21.8 "Viscous friction torque at zero velocity";
  parameter Real Rv1(unit="N.m.s/rad")=9.8
    "Viscous friction coefficient (R=Rv0+Rv1*abs(qd))";
  parameter Real peak=(26.7/21.8)
    "Maximum static friction torque is peak*Rv0 (peak >= 1)";

  constant SI.AngularVelocity unitAngularVelocity = 1;
  constant SI.Torque unitTorque = 1;
  Modelica.Mechanics.Rotational.Components.IdealGear gear(
    ratio=i, useSupport=false)
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Modelica.Mechanics.Rotational.Components.BearingFriction bearingFriction(
    tau_pos=[0,
         Rv0/unitTorque; 1, (Rv0 + Rv1*unitAngularVelocity)/unitTorque], peak=peak,
    useSupport=false)
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
equation
  connect(gear.flange_b, bearingFriction.flange_a)
    annotation (Line(points={{-20,0},{20,0}}));
  connect(bearingFriction.flange_b, flange_b)
    annotation (Line(points={{40,0},{100,0}}));
  connect(gear.flange_a, flange_a)
    annotation (Line(points={{-40,0},{-100,0}}));
  annotation (
    Documentation(info="<html>
<p>
The elasticity and damping in the gearboxes of the outermost
three joints of the robot is neglected.
Default values for all parameters are given for joint 4.
</p>
</html>"),
       Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{-150,100},{150,60}},
          textString="%name",
          textColor={0,0,255}),
        Text(
          extent={{-30,-30},{30,-80}},
          textString="2",
          textColor={255,255,255})}));
end GearType2;
