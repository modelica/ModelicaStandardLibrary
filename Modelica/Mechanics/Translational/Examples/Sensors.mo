within Modelica.Mechanics.Translational.Examples;
model Sensors "Sensors for translational systems"
  extends Modelica.Icons.Example;

  Translational.Sensors.ForceSensor forceSensor annotation (Placement(
        transformation(extent={{-40,10},{-20,30}})));
  Modelica.Mechanics.Translational.Sensors.MultiSensor multiSensor
    annotation (Placement(transformation(extent={{-10,10},{10,30}})));
  Translational.Sensors.SpeedSensor speedSensor1 annotation (Placement(
        transformation(extent={{60,-50},{80,-30}})));
  Translational.Sensors.PositionSensor positionSensor1 annotation (
      Placement(transformation(extent={{60,-20},{80,0}})));
  Translational.Sensors.AccSensor accSensor1 annotation (Placement(
        transformation(extent={{60,-80},{80,-60}})));
  Translational.Sensors.PositionSensor positionSensor2 annotation (
      Placement(transformation(extent={{60,10},{80,30}})));
  Translational.Components.Mass mass(
    L=1,
    s(fixed=true),
    v(fixed=true),
    m=1) annotation (Placement(transformation(extent={{30,10},{50,30}})));
  Translational.Sources.Force force annotation (Placement(transformation(
          extent={{-70,10},{-50,30}})));
  Modelica.Blocks.Sources.Sine sineForce(amplitude=10, f=4)
    annotation (Placement(transformation(extent={{-100,10},{-80,30}})));
equation
  connect(sineForce.y, force.f)
    annotation (Line(points={{-79,20},{-72,20}}, color={0,0,127}));
  connect(forceSensor.flange_a, force.flange) annotation (Line(
      points={{-40,20},{-50,20}}, color={0,127,0}));
  connect(mass.flange_a, positionSensor1.flange) annotation (Line(
      points={{30,20},{20,20},{20,-10},{60,-10}},
                                        color={0,127,0}));
  connect(mass.flange_a, speedSensor1.flange) annotation (Line(
      points={{30,20},{20,20},{20,-40},{60,-40}},
                                          color={0,127,0}));
  connect(mass.flange_a, accSensor1.flange) annotation (Line(
      points={{30,20},{20,20},{20,-70},{60,-70}},
                                          color={0,127,0}));
  connect(mass.flange_b, positionSensor2.flange) annotation (Line(
      points={{50,20},{60,20}}, color={0,127,0}));
  connect(forceSensor.flange_b, multiSensor.flange_a) annotation (Line(
      points={{-20,20},{-10,20}},color={0,127,0}));
  connect(multiSensor.flange_b, mass.flange_a) annotation (Line(
      points={{10,20},{30,20}}, color={0,127,0}));
  annotation (Documentation(info="<html>
<p>
These sensors measure
</p>

<blockquote><pre>
force f in N
position s in m
velocity v in m/s
acceleration a in m/s2
</pre></blockquote>

<p>
In this example, the measured velocity and acceleration is independent of
the flange the sensor is connected to. In contrast, the measured position
depends on the flange (flange_a or flange_b) and the
length&nbsp;<var>L</var> of the component.
Plot <code>positionSensor1.s</code>, <code>positionSensor2.s</code> and <code>mass.s</code>
to see the difference.
</p>
</html>"),
       experiment(StopTime=1.0, Interval=0.001));
end Sensors;
