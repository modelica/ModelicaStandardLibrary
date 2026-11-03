within Modelica.Mechanics.MultiBody.Interfaces;
partial model PartialRelativeSensor
  "Base model to measure a relative variable between two frames"
  extends Modelica.Icons.RoundSensor;
  extends PartialTwoFramesResolve;

  parameter Integer n_out = 1 "Number of output signals";

  Modelica.Blocks.Interfaces.RealOutput y[n_out]
    "Measured data as signal vector"
    annotation (Placement(transformation(
        origin={-80,-110},
        extent={{10,-10},{-10,10}},
        rotation=90)));

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
        Text(
          extent={{-150,120},{150,80}},
          textString="%name",
          textColor={0,0,255}),
        Line(points={{-50,-50},{-80,-80},{-80,-100}}, color={0,0,127}),
        Line(points={{0,-100},{0,-70}}, pattern=LinePattern.Dot)}));
end PartialRelativeSensor;
