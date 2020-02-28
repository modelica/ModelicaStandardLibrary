within Modelica.Mechanics.Rotational.Examples;
model LossyGearDemo2
  "Example to show combination of LossyGear and BearingFriction"
  extends Modelica.Icons.Example;
  SI.Power PowerLoss=gear.flange_a.tau*der(gear.flange_a.phi) + gear.flange_b.tau
      *der(gear.flange_b.phi) "Power lost in the gear";

  Rotational.Components.LossyGear gear(
    ratio=2,
    lossTable=[0, 0.5, 0.5, 0, 0],
    useSupport=true) annotation (Placement(transformation(extent={{-20,0},{
            0,20}})));
  Rotational.Components.Inertia Inertia1(J=1) annotation (Placement(
        transformation(extent={{-50,0},{-30,20}})));
  Rotational.Components.Inertia Inertia2(
    J=1.5,
    phi(fixed=true, start=0, nominal=1e-4),
    w(fixed=true, start=0, nominal=0.001)) annotation (Placement(transformation(extent={{
            10,0},{30,20}})));
  Rotational.Sources.Torque torque1(useSupport=true) annotation (Placement(
        transformation(extent={{-110,0},{-90,20}})));
  Rotational.Sources.Torque torque2(useSupport=true) annotation (Placement(
        transformation(extent={{60,0},{40,20}})));
  Modelica.Blocks.Sources.Sine DriveSine(amplitude=10, f=1)
    annotation (Placement(transformation(extent={{-140,0},{-120,20}})));
  Modelica.Blocks.Sources.Ramp load(
    height=5,
    duration=2,
    offset=-10) annotation (Placement(transformation(extent={{90,0},{70,20}})));
  Rotational.Components.BearingFriction bearingFriction(tau_pos=[0, 0.5; 1,
        1], useSupport=true) annotation (Placement(transformation(extent={{
            -80,0},{-60,20}})));
  Rotational.Components.Fixed fixed annotation (Placement(transformation(
          extent={{-20,-30},{0,-10}})));
equation
  connect(torque2.flange, Inertia2.flange_b)
    annotation (Line(points={{40,10},{30,10}}));
  connect(Inertia2.flange_a, gear.flange_b)
    annotation (Line(points={{10,10},{0,10}}));
  connect(gear.flange_a, Inertia1.flange_b)
    annotation (Line(points={{-20,10},{-30,10}}));
  connect(Inertia1.flange_a, bearingFriction.flange_b)
    annotation (Line(points={{-50,10},{-60,10}}));
  connect(bearingFriction.flange_a, torque1.flange)
    annotation (Line(points={{-80,10},{-80,10},{-90,10}}));
  connect(DriveSine.y, torque1.tau) annotation (Line(points={{-119,10},{-119,
          10},{-112,10}}, color={0,0,127}));
  connect(load.y, torque2.tau)
    annotation (Line(points={{69,10},{62,10}}, color={0,0,127}));
  connect(gear.support, fixed.flange)
    annotation (Line(points={{-10,0},{-10,-20}}));
  connect(fixed.flange, torque2.support)
    annotation (Line(points={{-10,-20},{50,-20},{50,0}}));
  connect(fixed.flange, bearingFriction.support)
    annotation (Line(points={{-10,-20},{-70,-20},{-70,0}}));
  connect(torque1.support, fixed.flange) annotation (Line(points={{-100,0},
          {-100,-20},{-10,-20}}));
  annotation (
    Diagram(coordinateSystem(extent={{-140,-100},{100,100}})),
    Documentation(info="<html>
<p>
This model contains bearing friction and gear friction (= efficiency).
If both friction models are stuck, there is no unique solution.
Still a reliable Modelica simulator should
be able to handle this situation.
</p>
<p>
Simulate for about 0.5 seconds. The friction elements are
in all modes (forward and backward rolling, as well as stuck).
</p>
<p>
You may plot:
</p>
<blockquote><pre>
Inertia1.w,
Inertia2.w          : angular velocities of inertias
powerLoss           : power lost in the gear
bearingFriction.mode:  1 = forward rolling
                       0 = stuck (w=0)
                      -1 = backward rolling
gear.mode           :  1 = forward rolling
                       0 = stuck (w=0)
                      -1 = backward rolling
</pre></blockquote>

<p>
Note, <code>powerLoss</code> (= sum of the power flows of the connectors) and
<code>gear.powerLoss</code> (= <code>gear.tau_loss</code>*<code>gear.w_a</code>,
where <code>gear.tau_loss</code> is determined in a non-trivial way
from the stuck/sliding situation of the bearing and teeth friction;
= equation (16) in [<a href=\"modelica://Modelica.Mechanics.Rotational.UsersGuide.References\">Pelchen2002</a>])
should be identical, or the difference should be close to zero, if model
<a href=\"modelica://Modelica.Mechanics.Rotational.Components.LossyGear\">LossyGear</a>
is correctly implemented.
</p>

<p>
Note: This combination of LossyGear and BearingFriction is not recommended to use,
as component LossyGear includes the functionality of component BearingFriction
(only <em>peak</em> not supported).
</p>
</html>"),
       experiment(StopTime=0.5, Interval=0.001));
end LossyGearDemo2;
