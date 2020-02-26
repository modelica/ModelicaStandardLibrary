within Modelica.Clocked.Examples.CascadeControlledDrive;
model Continuous "Drive with continuous-time cascade controller"
 extends Modelica.Icons.Example;

  Modelica.Mechanics.Rotational.Components.Inertia load(J=10,
    phi(fixed=true, start=0),
    w(fixed=true, start=0))
    annotation (Placement(transformation(extent={{88,2},{104,18}})));
  Modelica.Mechanics.Rotational.Sensors.SpeedSensor speed       annotation (
     Placement(transformation(
        extent={{-7.5,-7.5},{4.5,4.5}},
        rotation=-90,
        origin={111.5,-11.5})));

  Modelica.Blocks.Continuous.PI PI(
    k=100,
    initType=Modelica.Blocks.Types.Init.InitialState,
    x_start=0,
    T=0.5)
    annotation (Placement(transformation(extent={{14,0},{34,20}})));
  Modelica.Blocks.Math.Feedback feedback2
    annotation (Placement(transformation(extent={{-12,2},{4,18}})));

  Modelica.Mechanics.Rotational.Sources.Torque torque
    annotation (Placement(transformation(extent={{64,2},{81,18}})));

  Modelica.Mechanics.Rotational.Sensors.AngleSensor angle annotation (
      Placement(transformation(
        extent={{6,-6},{-6,6}},
        rotation=90,
        origin={128,-10})));
  Modelica.Blocks.Sources.KinematicPTP2 kinematicPTP(
    q_end={Modelica.Constants.pi},
    qd_max={2},
    qdd_max={3})
    annotation (Placement(transformation(extent={{-134,0},{-114,20}})));
  Modelica.Blocks.Math.Feedback feedback1
    annotation (Placement(transformation(extent={{-82,2},{-66,18}})));
  Modelica.Blocks.Math.Gain gain(k=20)
    annotation (Placement(transformation(extent={{-56,0},{-36,20}})));
equation
  connect(speed.flange, load.flange_b)       annotation (Line(
      points={{110,-4},{110,10},{104,10}}));
  connect(feedback2.y, PI.u)
                            annotation (Line(
      points={{3.2,10},{12,10}},
      color={0,0,127}));
  connect(torque.flange, load.flange_a) annotation (Line(
      points={{81,10},{88,10}}));
  connect(angle.flange, load.flange_b) annotation (Line(
      points={{128,-4},{128,10},{104,10}}));
  connect(PI.y, torque.tau) annotation (Line(
      points={{35,10},{62.3,10}},
      color={0,0,127}));
  connect(speed.w, feedback2.u2) annotation (Line(
      points={{110,-16.6},{110,-30},{-4,-30},{-4,3.6}},
      color={0,0,127}));
  connect(angle.phi, feedback1.u2) annotation (Line(
      points={{128,-16.6},{128,-46},{-74,-46},{-74,3.6}},
      color={0,0,127}));
  connect(kinematicPTP.q[1], feedback1.u1) annotation (Line(
      points={{-113,18},{-100,18},{-100,10},{-80.4,10}},
      color={0,0,127}));
  connect(feedback1.y, gain.u) annotation (Line(
      points={{-66.8,10},{-58,10}},
      color={0,0,127}));
  connect(gain.y, feedback2.u1) annotation (Line(
      points={{-35,10},{-10.4,10}},
      color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-140,
            -100},{140,100}}),
    graphics={
        Text(
          extent={{-12,38},{38,32}},
          textColor={255,0,0},
          textString="fast controller"),
        Text(
          extent={{66,37},{116,31}},
          textColor={255,0,0},
          textString="plant"),
        Rectangle(extent={{-138,40},{-110,-20}},lineColor={255,0,0}),
        Text(
          extent={{-142,38},{-103,33}},
          textColor={255,0,0},
          textString="reference"),
        Rectangle(extent={{-92,40},{-28,-68}},lineColor={255,0,0}),
        Rectangle(extent={{-14,40},{38,-68}}, lineColor={255,0,0}),
        Rectangle(extent={{56,40},{134,-68}}, lineColor={255,0,0}),
        Text(
          extent={{-89,38},{-39,32}},
          textColor={255,0,0},
          textString="slow controller")}),
    Documentation(info="<html>
<p>
Original cascade controlled drive with a
<strong>continuous-time</strong> controller.
</p>
</html>"),
    experiment(StopTime=4));
end Continuous;
