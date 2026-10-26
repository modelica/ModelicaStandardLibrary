within Modelica.Mechanics.MultiBody.Interfaces;
partial model PartialAbsoluteSensor
  "Base model to measure an absolute frame variable"
  extends Modelica.Icons.RoundSensor;
  extends PartialTwoFramesResolve(
    break frame_b);

  parameter Integer n_out = 1 "Number of output signals";

  Modelica.Blocks.Interfaces.RealOutput y[n_out]
    "Measured data as signal vector"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));

  annotation (
    Documentation(info="<html>
<p>
This is the base class of a 3-dim. mechanics component with one frame and one
output port in order to measure an absolute quantity in the frame connector
and to provide the measured signal as output for further processing
with the blocks of package Modelica.Blocks.
</p>
</html>"),
         Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Line(points={{-70,0},{-100,0}}),
        Line(points={{70,0},{100,0}}, color={0,0,127}),
        Text(
          extent={{-150,120},{150,80}},
          textString="%name",
          textColor={0,0,255}),
        Line(points={{0,-100},{0,-70}}, pattern=LinePattern.Dot)}));
end PartialAbsoluteSensor;
