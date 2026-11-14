within Modelica.Mechanics.Rotational.Examples;
model DemoFreeWheel "Demonstrate freewheel"
  extends Modelica.Icons.Example;
  Modelica.Mechanics.Rotational.Components.FreeWheel freeWheel
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  Modelica.Mechanics.Rotational.Components.Inertia inertia1(J=1)
    annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
  Modelica.Mechanics.Rotational.Components.Inertia inertia2(J=1,
    phi(start=0, fixed=true),
    w(start=0, fixed=true))
    annotation (Placement(transformation(extent={{30,-10},{50,10}})));
  Modelica.Mechanics.Rotational.Sources.LinearSpeedDependentTorque torqueLoad(
    tau_nominal=-5,
    TorqueDirection=false,
    w_nominal=1) annotation (Placement(transformation(extent={{80,-10},{60,10}})));
  Modelica.Mechanics.Rotational.Sources.Speed speed(exact=true)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Blocks.Sources.Sine signalSpeed(amplitude=5, f=5) annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
equation
  connect(freeWheel.flange_b, inertia2.flange_a)
    annotation (Line(points={{20,0},{30,0}}, color={0,0,0}));
  connect(torqueLoad.flange, inertia2.flange_b) annotation (Line(points={{60,0},{50,0}}, color={0,0,0}));
  connect(inertia1.flange_a, speed.flange)
    annotation (Line(points={{-30,0},{-40,0}}, color={0,0,0}));
  connect(inertia1.flange_b, freeWheel.flange_a)
    annotation (Line(points={{-10,0},{0,0}}, color={0,0,0}));
  connect(signalSpeed.y, speed.w_ref) annotation (Line(points={{-69,0},{-62,0}}, color={0,0,127}));
  annotation (experiment(
      Interval=0.001,
      Tolerance=1e-06,
      StopTime=1),
    Documentation(info="<html>
<p>
Demonstration of an ideal freewheel: 
The inertia <code>inertia1</code> is driven with a&nbsp;prescribed sinusoidal velocity.
Load inertia <code>inertia2</code> is coupled to <code>inertia1</code> by an ideal
freewheel. <code>inertia2</code> is accelerated as long as its <code>flange_a</code>
is driven. When freewheeling occurs, i.e.
<code>inertia2.w</code>&nbsp;&ge; <code>inertia1.w</code>, a&nbsp;velocity dependent
load torque decelerates <code>inertia2.w</code>.
</p>
</html>"));
end DemoFreeWheel;
