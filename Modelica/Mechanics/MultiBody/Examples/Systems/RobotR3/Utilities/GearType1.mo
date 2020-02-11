within Modelica.Mechanics.MultiBody.Examples.Systems.RobotR3.Utilities;
model GearType1 "Motor inertia and gearbox model for r3 joints 1,2,3"
  extends Modelica.Mechanics.Rotational.Icons.Gearbox;
  extends Modelica.Mechanics.Rotational.Interfaces.PartialTwoFlanges;

  parameter Real i=-105 "Gear ratio";
  parameter SI.RotationalSpringConstant c = 43 "Spring constant";
  parameter SI.RotationalDampingConstant d = 0.005 "Damper constant";
  parameter SI.Torque Rv0=0.4 "Viscous friction torque at zero velocity";
  parameter Real Rv1(unit="N.m.s/rad") = (0.13/160)
    "Viscous friction coefficient (R=Rv0+Rv1*abs(qd))";
  parameter Real peak=1
    "Maximum static friction torque is peak*Rv0 (peak >= 1)";
  SI.AngularAcceleration a_rel=der(spring.w_rel)
    "Relative angular acceleration of spring";
  constant SI.AngularVelocity unitAngularVelocity = 1;
  constant SI.Torque unitTorque = 1;

  Modelica.Mechanics.Rotational.Components.IdealGear gear(
    ratio=i, useSupport=false)
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Modelica.Mechanics.Rotational.Components.SpringDamper spring(
    c=c, d=d)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Mechanics.Rotational.Components.BearingFriction bearingFriction(
    tau_pos=[0,
         Rv0/unitTorque; 1, (Rv0 + Rv1*unitAngularVelocity)/unitTorque],
      useSupport=false) annotation (Placement(
        transformation(extent={{-60,-10},{-40,10}})));
equation
  connect(spring.flange_b, gear.flange_a)
    annotation (Line(points={{10,0},{40,0}}));
  connect(bearingFriction.flange_b, spring.flange_a)
    annotation (Line(points={{-40,0},{-10,0}}));
  connect(gear.flange_b, flange_b)
    annotation (Line(points={{60,0},{100,0}}));
  connect(bearingFriction.flange_a, flange_a)
    annotation (Line(points={{-60,0},{-100,0}}));
initial equation
  spring.w_rel = 0;
  a_rel = 0;
  annotation (
    Documentation(info="<html>
<p>
Models the gearbox used in the first three joints with all its effects,
like elasticity and friction.
Coulomb friction is approximated by a friction element acting
at the \"motor\"-side. In reality, bearing friction should be
also incorporated at the driven side of the gearbox. However,
this would require considerable more effort for the measurement
of the friction parameters.
Default values for all parameters are given for joint 1.
Model relativeStates is used to define the relative angle
and relative angular velocity across the spring (=gear elasticity)
as state variables. The reason is, that a default initial
value of zero of these states makes always sense.
If the absolute angle and the absolute angular velocity of model
Jmotor would be used as states, and the load angle (= joint angle of
robot) is NOT zero, one has always to ensure that the initial values
of the motor angle and of the joint angle are modified correspondingly.
Otherwise, the spring has an unrealistic deflection at initial time.
Since relative quantities are used as state variables, this simplifies
the definition of initial values considerably.
</p>
</html>"),
       Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{-150,100},{150,60}},
          textString="%name",
          textColor={0,0,255}),
        Text(
          extent={{-30,-30},{30,-80}},
          textColor={255,255,255},
          textString="1"),
        Line(points={{-24,0},{-16,0},{-12,14},{-4,-14},{4,14},{12,-14},{16,0},{24,0}}, color={95,95,95})}),
    Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={Text(
          extent={{72,30},{130,22}},
          textString="flange of joint axis"), Text(
          extent={{-128,26},{-70,18}},
          textString="flange of motor axis")}));
end GearType1;
