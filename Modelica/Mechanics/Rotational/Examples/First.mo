within Modelica.Mechanics.Rotational.Examples;
model First "First example: simple drive train"
  extends Modelica.Icons.Example;
  parameter SI.Torque amplitude=10
    "Amplitude of driving torque";
  parameter SI.Frequency f=5 "Frequency of driving torque";
  parameter SI.Inertia Jmotor(min=0) = 0.1 "Motor inertia";
  parameter SI.Inertia Jload(min=0) = 2 "Load inertia";
  parameter Real ratio=10 "Gear ratio";
  parameter Real damping=10 "Damping in bearing of gear";

  Rotational.Components.Fixed fixed annotation (Placement(transformation(
          extent={{38,-48},{54,-32}})));
  Rotational.Sources.Torque torque(useSupport=true) annotation (Placement(
        transformation(extent={{-68,-8},{-52,8}})));
  Rotational.Components.Inertia inertia1(J=Jmotor) annotation (Placement(
        transformation(extent={{-38,-8},{-22,8}})));
  Rotational.Components.IdealGear idealGear(ratio=ratio, useSupport=true)
    annotation (Placement(transformation(extent={{-8,-8},{8,8}})));
  Rotational.Components.Inertia inertia2(
    J=2,
    phi(fixed=true, start=0),
    w(fixed=true, start=0)) annotation (Placement(transformation(extent={{
            22,-8},{38,8}})));
  Rotational.Components.Spring spring(c=1.e4, phi_rel(fixed=true))
    annotation (Placement(transformation(extent={{52,-8},{68,8}})));
  Rotational.Components.Inertia inertia3(J=Jload, w(fixed=true, start=0))
    annotation (Placement(transformation(extent={{82,-8},{98,8}})));
  Rotational.Components.Damper damper(d=damping) annotation (Placement(
        transformation(
        origin={46,-22},
        extent={{-8,-8},{8,8}},
        rotation=270)));
  Modelica.Blocks.Sources.Sine sine(amplitude=amplitude, f=f)
    annotation (Placement(transformation(extent={{-98,-8},{-82,8}})));
equation
  connect(inertia1.flange_b, idealGear.flange_a)
    annotation (Line(points={{-22,0},{-8,0}}));
  connect(idealGear.flange_b, inertia2.flange_a)
    annotation (Line(points={{8,0},{22,0}}));
  connect(inertia2.flange_b, spring.flange_a)
    annotation (Line(points={{38,0},{52,0}}));
  connect(spring.flange_b, inertia3.flange_a)
    annotation (Line(points={{68,0},{82,0}}));
  connect(damper.flange_a, inertia2.flange_b)
    annotation (Line(points={{46,-14},{46,0},{38,0}}));
  connect(damper.flange_b, fixed.flange)
    annotation (Line(points={{46,-30},{46,-40}}));
  connect(sine.y, torque.tau)
    annotation (Line(points={{-81.2,0},{-69.6,0}}, color={0,0,127}));
  connect(torque.support, fixed.flange)
    annotation (Line(points={{-60,-8},{-60,-40},{46,-40}}));
  connect(idealGear.support, fixed.flange)
    annotation (Line(points={{0,-8},{0,-40},{46,-40}}));
  connect(torque.flange, inertia1.flange_a) annotation (Line(
      points={{-52,0},{-38,0}}));
  annotation (
    Documentation(info="<html>
<p>The drive train consists of a motor inertia which is driven by
a sine-wave motor torque. Via a gearbox the rotational energy is
transmitted to a load inertia. Elasticity in the gearbox is modeled
by a spring element. A linear damper is used to model the
damping in the gearbox bearing.</p>
<p>Note, that a force component (like the damper of this example)
which is acting between a shaft and the housing has to be fixed
in the housing on one side via component Fixed.</p>
<p>Simulate for 1 second and plot the following variables:<br>
   angular velocities of inertias inertia2 and 3: inertia2.w, inertia3.w</p>

</html>"),
    experiment(StopTime=1.0, Interval=0.001));
end First;
