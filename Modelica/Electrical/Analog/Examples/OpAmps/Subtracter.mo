within Modelica.Electrical.Analog.Examples.OpAmps;
model Subtracter "Inverting subtracter"
  extends Modelica.Icons.Example;
  parameter SI.Voltage Vin=5 "Amplitude of input voltage";
  parameter SI.Frequency f=10 "Frequency of input voltage";
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
  Sources.SineVoltage vIn1(V=Vin, f=f) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-60,0})));
  Sources.ConstantVoltage vIn2(V=Vin) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-40,-10})));
  Modelica.Electrical.Analog.Sensors.VoltageSensor vOut annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=270,
        origin={40,0})));
  OpAmpCircuits.Feedback feedback(p1_2(i(start=0)))
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  connect(feedback.n1, ground.p)
    annotation (Line(points={{-10,-10},{-10,-20}}, color={0,0,255}));
  connect(vIn1.p, feedback.p1)
    annotation (Line(points={{-60,10},{-10,10}}, color={0,0,255}));
  connect(vIn2.p, feedback.p1_2)
    annotation (Line(points={{-40,0},{-10,0}}, color={0,0,255}));
  connect(ground.p, vIn2.n)
    annotation (Line(points={{-10,-20},{-40,-20}}, color={0,0,255}));
  connect(ground.p, vIn1.n)
    annotation (Line(points={{-10,-20},{-60,-20},{-60,-10}}, color={0,0,255}));
  connect(feedback.p2, vOut.n)
    annotation (Line(points={{10,10},{40,10}}, color={0,0,255}));
  connect(feedback.n2, vOut.p)
    annotation (Line(points={{10,-10},{40,-10}}, color={0,0,255}));
  annotation (Documentation(info="<html>
<p>This is an inverting subtracter.</p>
<p>Note: <code>vOut</code> measure the negative output voltage.</p>
</html>"),
    experiment(
      StartTime=0,
      StopTime=1,
      Tolerance=1e-006,
      Interval=0.001));
end Subtracter;
