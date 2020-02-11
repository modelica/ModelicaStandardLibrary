within Modelica.Mechanics.MultiBody.Sensors;
model Power "Measure power flowing from frame_a to frame_b"
  extends Modelica.Icons.RoundSensor;

  extends Modelica.Mechanics.MultiBody.Interfaces.PartialTwoFrames;
  Modelica.Blocks.Interfaces.RealOutput power(quantity="Power",unit="W")
    "Power at frame_a as output signal"
    annotation (Placement(transformation(
        origin={-80,-110},
        extent={{10,-10},{-10,10}},
        rotation=90)));

equation
  Connections.branch(frame_a.R, frame_b.R);
  frame_a.r_0 = frame_b.r_0;
  frame_a.R = frame_b.R;
  zeros(3) = frame_a.f + frame_b.f;
  zeros(3) = frame_a.t + frame_b.t;
  power = frame_a.f*Frames.resolve2(frame_a.R, der(frame_a.r_0))
     + frame_a.t*Frames.angularVelocity2(frame_a.R);
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={
        Line(points={{-70,0},{-101,0}}),
        Line(points={{70,0},{100,0}}),
        Line(points={{-80,0},{-80,-100}}, color={0,0,127}),
        Text(
          extent={{-128,126},{126,68}},
          textString="%name",
          textColor={0,0,255}),
        Text(
          extent={{-50,-14},{50,-54}},
          textColor={64,64,64},
          textString="W")}),
    Documentation(info="<html>
<p>
This component provides the power flowing from frame_a to frame_b
as output signal <strong>power</strong>.
</p>
</html>"));
end Power;
