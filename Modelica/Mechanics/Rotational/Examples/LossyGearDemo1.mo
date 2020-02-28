within Modelica.Mechanics.Rotational.Examples;
model LossyGearDemo1
  "Example to show that gear efficiency may lead to stuck motion"
  extends Modelica.Icons.Example;
  SI.Power PowerLoss=gear.flange_a.tau*der(gear.flange_a.phi) + gear.flange_b.tau
      *der(gear.flange_b.phi) "Power lost in the gear";
  Rotational.Components.LossyGear gear(
    ratio=2,
    lossTable=[0, 0.5, 0.5, 0, 0],
    useSupport=true) annotation (Placement(transformation(extent={{-10,0},{
            10,20}})));
  Rotational.Components.Inertia Inertia1(J=1) annotation (Placement(
        transformation(extent={{-40,0},{-20,20}})));
  Rotational.Components.Inertia Inertia2(
    J=1.5,
    phi(fixed=true, start=0, nominal=0.001),
    w(fixed=true, start=0, nominal=0.01)) annotation (Placement(transformation(extent={{
            20,0},{40,20}})));
  Rotational.Sources.Torque torque1(useSupport=true) annotation (Placement(
        transformation(extent={{-70,0},{-50,20}})));
  Rotational.Sources.Torque torque2(useSupport=true) annotation (Placement(
        transformation(extent={{70,0},{50,20}})));
  Modelica.Blocks.Sources.Sine DriveSine(amplitude=10, f=1)
    annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
  Modelica.Blocks.Sources.Ramp load(
    height=5,
    duration=2,
    offset=-10) annotation (Placement(transformation(extent={{100,0},{80,20}})));
  Rotational.Components.Fixed fixed annotation (Placement(transformation(
          extent={{-10,-30},{10,-10}})));
equation
  connect(Inertia1.flange_b, gear.flange_a)
    annotation (Line(points={{-20,10},{-10,10}}));
  connect(gear.flange_b, Inertia2.flange_a)
    annotation (Line(points={{10,10},{20,10}}));
  connect(torque1.flange, Inertia1.flange_a)
    annotation (Line(points={{-50,10},{-40,10}}));
  connect(torque2.flange, Inertia2.flange_b)
    annotation (Line(points={{50,10},{40,10}}));
  connect(DriveSine.y, torque1.tau)
    annotation (Line(points={{-79,10},{-72,10}}, color={0,0,127}));
  connect(load.y, torque2.tau)
    annotation (Line(points={{79,10},{72,10}}, color={0,0,127}));
  connect(fixed.flange, gear.support)
    annotation (Line(points={{0,-20},{0,0}}));
  connect(fixed.flange, torque1.support)
    annotation (Line(points={{0,-20},{-60,-20},{-60,0}}));
  connect(fixed.flange, torque2.support)
    annotation (Line(points={{0,-20},{60,-20},{60,0}}));
  annotation (Documentation(info="<html>
<p>
This model contains two inertias which are connected by an ideal
gear where the friction between the teeth of the gear is modeled in
a physical meaningful way (friction may lead to stuck mode which
locks the motion of the gear). The friction is defined by an
efficiency factor (= 0.5) for forward and backward driving condition leading
to a torque dependent friction loss. Simulate for about 0.5 seconds.
The friction in the gear will take all modes
(forward and backward rolling, as well as stuck).
</p>
<p>
You may plot:
</p>
<blockquote><pre>
Inertia1.w,
Inertia2.w : angular velocities of inertias
powerLoss  : power lost in the gear
gear.mode  :  1 = forward rolling
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
</html>"),
       experiment(StopTime=0.5, Interval=0.001));
end LossyGearDemo1;
