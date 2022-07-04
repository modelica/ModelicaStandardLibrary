within Modelica.Mechanics.Rotational.Examples;
model DemoFreeWheel "Demonstrate freewheel"
  extends Modelica.Icons.Example;
  Modelica.Mechanics.Rotational.Components.FreeWheel
                                      freeWheel
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  Modelica.Mechanics.Rotational.Components.Inertia inertia2(J=1,
    phi(start=0, fixed=true),
    w(start=0, fixed=true))
    annotation (Placement(transformation(extent={{30,-10},{50,10}})));
  Modelica.Mechanics.Rotational.Sources.LinearSpeedDependentTorque
    linearSpeedDependentTorque(
    tau_nominal=-5,
    TorqueDirection=false,
    w_nominal=1)
    annotation (Placement(transformation(extent={{80,-10},{60,10}})));
  Modelica.Mechanics.Rotational.Sources.Speed speed(exact=true)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Mechanics.Rotational.Components.Inertia inertia1(J=1)
    annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
  Modelica.Blocks.Sources.Sine sine(amplitude=5,
                                    f=5)
    annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
equation
  connect(freeWheel.flange_b, inertia2.flange_a)
    annotation (Line(points={{20,0},{30,0}}, color={0,0,0}));
  connect(linearSpeedDependentTorque.flange, inertia2.flange_b)
    annotation (Line(points={{60,0},{50,0}}, color={0,0,0}));
  connect(inertia1.flange_a, speed.flange)
    annotation (Line(points={{-30,0},{-40,0}}, color={0,0,0}));
  connect(inertia1.flange_b, freeWheel.flange_a)
    annotation (Line(points={{-10,0},{0,0}},                   color={0,0,0}));
  connect(sine.y, speed.w_ref)
    annotation (Line(points={{-69,0},{-62,0}}, color={0,0,127}));
  annotation (experiment(
      Interval=0.001,
      Tolerance=1e-06,
      StopTime=1),
    Documentation(info="<html>
<p>
Demonstration of an ideal freewhel: 
Inertia1 is driven with prescribed speed with sinusoidal trajectory, inertia2 is coupled with an ideal freewheel.
Inertia2 is accelerated as long as flange_a drives, when freewheeling occurs it is decelerated by a speed dependent torque. 
</p>
</html>"));
end DemoFreeWheel;
