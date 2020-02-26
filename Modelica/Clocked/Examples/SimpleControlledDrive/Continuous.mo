within Modelica.Clocked.Examples.SimpleControlledDrive;
model Continuous "Simple controlled drive with continuous controller"
 extends Modelica.Icons.Example;

  Modelica.Mechanics.Rotational.Components.Inertia load(J=10,
    phi(fixed=true, start=0),
    w(fixed=true, start=0))
    annotation (Placement(transformation(extent={{80,0},{100,20}})));
  Modelica.Mechanics.Rotational.Sensors.SpeedSensor speed       annotation (
     Placement(transformation(
        extent={{-10,-10},{6,6}},
        rotation=-90,
        origin={110,-15})));
  Modelica.Blocks.Sources.Ramp ramp(duration=2)
    annotation (Placement(transformation(extent={{-111,0},{-91,20}})));

  Modelica.Blocks.Continuous.PI PI(
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0,
    T=0.1,
    k=110)
    annotation (Placement(transformation(extent={{-12,0},{8,20}})));
  Modelica.Blocks.Math.Feedback feedback
    annotation (Placement(transformation(extent={{-43,0},{-23,20}})));

  Modelica.Mechanics.Rotational.Sources.Torque torque
    annotation (Placement(transformation(extent={{53,0},{73,20}})));

equation
  connect(speed.flange, load.flange_b)       annotation (Line(
      points={{108,-5},{108,10},{100,10}}));
  connect(feedback.y, PI.u) annotation (Line(
      points={{-24,10},{-14,10}},
      color={0,0,127}));
  connect(torque.flange, load.flange_a) annotation (Line(
      points={{73,10},{80,10}}));
  connect(ramp.y, feedback.u1) annotation (Line(
      points={{-90,10},{-41,10}},
      color={0,0,127}));
  connect(PI.y, torque.tau) annotation (Line(
      points={{9,10},{51,10}},
      color={0,0,127}));
  connect(speed.w, feedback.u2) annotation (Line(
      points={{108,-21.8},{108,-26},{-33,-26},{-33,2}},
      color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-140,-100},
            {140,100}}), graphics={
        Text(
          extent={{-35,39},{15,33}},
          textColor={255,0,0},
          textString="feedback controller"),
        Text(
          extent={{54,39},{104,33}},
          textColor={255,0,0},
          textString="plant"),
        Rectangle(extent={{-120,40},{-70,-20}}, lineColor={255,0,0}),
        Text(
          extent={{-119,39},{-71,33}},
          textColor={255,0,0},
          textString="reference"),
        Rectangle(extent={{-46,40},{18,-34}}, lineColor={255,0,0}),
        Rectangle(extent={{40,40},{120,-34}}, lineColor={255,0,0})}),
    Documentation(info="<html>
<p>
Original simple controlled drive with a
<strong>continuous-time</strong> controller.
</p>
</html>"),
    experiment(
      StopTime=5));
end Continuous;
