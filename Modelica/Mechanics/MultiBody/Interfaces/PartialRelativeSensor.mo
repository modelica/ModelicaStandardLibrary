within Modelica.Mechanics.MultiBody.Interfaces;
partial model PartialRelativeSensor
  "Base model to measure a relative variable between two frames"
  extends Modelica.Icons.RoundSensor;
  parameter Integer n_out = 1 "Number of output signals";
  Interfaces.Frame_a frame_a "Coordinate system a" annotation (Placement(transformation(extent={{-116,-16},{-84,16}})));
  Interfaces.Frame_b frame_b "Coordinate system b" annotation (Placement(transformation(extent={{84,-16},{116,16}})));

  Modelica.Blocks.Interfaces.RealOutput y[n_out]
    "Measured data as signal vector"
    annotation (Placement(transformation(
        origin={0,-110},
        extent={{10,-10},{-10,10}},
        rotation=90)));
protected
  outer Modelica.Mechanics.MultiBody.World world;

equation
  assert(cardinality(frame_a) > 0,
    "Connector frame_a of relative sensor object is not connected");
  assert(cardinality(frame_b) > 0,
    "Connector frame_b of relative sensor object is not connected");

  annotation (
    Documentation(info="<html>
<p>
This is a base class for 3-dim. mechanical components with two frames
and one output port in order to measure relative quantities
between the two frames or the cut-forces/torques in the frame and
to provide the measured signals as output for further processing
with the blocks of package Modelica.Blocks.
</p>
</html>"),
         Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Line(points={{-70,0},{-101,0}}),
        Line(points={{70,0},{100,0}}),
        Line(points={{0,-100},{0,-70}}, color={0,0,127}),
        Text(
          extent={{-132,76},{129,124}},
          textString="%name",
          textColor={0,0,255}),
        Text(
          extent={{-118,52},{-82,27}},
          textColor={128,128,128},
          textString="a"),
        Text(
          extent={{85,53},{121,28}},
          textColor={128,128,128},
          textString="b")}));
end PartialRelativeSensor;
