within Modelica.Mechanics.MultiBody.Sensors;
model RelativeAngles "Measure relative angles between two frame connectors"
  extends Internal.PartialRelativeSensor
    annotation(IconMap(primitivesVisible=false));
  extends Modelica.Icons.RoundSensor;

  Modelica.Blocks.Interfaces.RealOutput angles[3](
    each final quantity="Angle",
    each final unit="rad",
    each displayUnit="deg")
    "Angles to rotate frame_a into frame_b via 'sequence'"
    annotation (Placement(transformation(
        origin={0,-110},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  parameter MultiBody.Types.RotationSequence sequence(
    min={1,1,1},
    max={3,3,3})={1,2,3}
    "Angles are returned to rotate frame_a around axes sequence[1], sequence[2] and finally sequence[3] into frame_b"
    annotation (Evaluate=true);
  parameter SI.Angle guessAngle1=0
    "Select angles[1] such that abs(angles[1] - guessAngle1) is a minimum";
  Modelica.Mechanics.MultiBody.Frames.Orientation R_rel
    "Relative orientation object from frame_a to frame_b";

equation
  frame_a.f = zeros(3);
  frame_a.t = zeros(3);
  frame_b.f = zeros(3);
  frame_b.t = zeros(3);
  R_rel = Modelica.Mechanics.MultiBody.Frames.relativeRotation(frame_a.R, frame_b.R);
  angles = MultiBody.Frames.axesRotationsAngles(
    R_rel,
    sequence,
    guessAngle1);
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
      graphics={
        Line(
          points={{0,-70},{0,-100}},
          color={0,0,127}),
        Line(
          points={{-70,0},{-96,0},{-96,0}}),
        Line(
          points={{96,0},{70,0},{70,0}}),
        Text(
          extent={{-132,90},{129,138}},
          textString="%name",
          textColor={0,0,255}),
        Text(
          extent={{-50,-14},{50,-54}},
          textColor={64,64,64},
          textString="rad"),
        Text(
          extent={{-108,43},{-72,18}},
          textColor={128,128,128},
          textString="a"),
        Text(
          extent={{72,43},{108,18}},
          textColor={128,128,128},
          textString="b")}),
    Documentation(info="<html>
<p>
This model determines the 3 angles to rotate frame_a
into frame_b along the axes defined by parameter <strong>sequence</strong>.
For example, if sequence = {3,1,2} then frame_a is
rotated around angles[1] along the z-axis, afterwards it is rotated
around angles[2] along the x-axis, and finally it is rotated around
angles[3] along the y-axis and is then identical to frame_b.
The 3 angles are returned in the range
</p>
<blockquote><pre>
-&pi; &lt;= angles[i] &lt;= &pi;
</pre></blockquote>
<p>
There are <strong>two solutions</strong> for \"angles[1]\" in this range.
Via parameter <strong>guessAngle1</strong> (default = 0) the
returned solution is selected such that |angles[1] - guessAngle1| is
minimal. The relative transformation matrix between frame_a and
frame_b may be in a singular configuration with respect to \"sequence\", i.e.,
there is an infinite number of angle values leading to the same relative
transformation matrix. In this case, the returned solution is
selected by setting angles[1] = guessAngle1. Then angles[2]
and angles[3] can be uniquely determined in the above range.
</p>
<p>
The parameter <strong>sequence</strong> has the restriction that
only values 1,2,3 can be used and that sequence[1] &ne; sequence[2]
and sequence[2] &ne; sequence[3]. Often used values are:
</p>
<blockquote><pre>
sequence = <strong>{1,2,3}</strong>  // Cardan or Tait-Bryan angle sequence
         = <strong>{3,1,3}</strong>  // Euler angle sequence
         = <strong>{3,2,1}</strong>
</pre></blockquote>
</html>"));
end RelativeAngles;
