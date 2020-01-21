within Modelica.Mechanics.Rotational.Sources;
model Torque "Input signal acting as external torque on a flange"
  extends Modelica.Mechanics.Rotational.Interfaces.PartialElementaryOneFlangeAndSupport2;
  Modelica.Blocks.Interfaces.RealInput tau(unit="N.m")
    "Accelerating torque acting at flange (= -flange.tau)" annotation (
      Placement(transformation(extent={{-140,-20},{-100,20}})));

equation
  flange.tau = -tau;
  annotation (
    Documentation(info="<html>
<p>
The input signal <strong>tau</strong> defines an external
torque in [Nm] which acts (with negative sign) at
a flange connector, i.e., the component connected to this
flange is driven by torque <strong>tau</strong>.</p>
<p>
The input signal can be provided from one of the signal generator
blocks of Modelica.Blocks.Sources.
</p>
</html>"),
    Icon(
    coordinateSystem(preserveAspectRatio=true,
      extent={{-100,-100},{100,100}}),
      graphics={
    Text(extent={{-150,110},{150,70}},
      textString="%name",
      textColor={0,0,255}),
    Text(extent={{-62,-29},{-141,-70}},
      textString="tau"),
    Polygon(points={{86,0},{66,58},{37,27},{86,0}},
      fillPattern=FillPattern.Solid),
    Line(points={{0,-10},{0,-101}}),
    Polygon(points={{-53,-54},{-36,-30},{-50,-24},{-53,-54}},
      fillPattern=FillPattern.Solid),
    Line(
      points={{-84,0},{-78,18},{-56,46},{-20,60},{20,60},{60,40},{82,8}},
      smooth=Smooth.Bezier,
      thickness=0.5),
    Line(
      points={{-50,-40},{-38,-24},{-18,-12},{0,-10},{18,-12},{38,-24},{50,-40}},
      smooth=Smooth.Bezier)}));
end Torque;
