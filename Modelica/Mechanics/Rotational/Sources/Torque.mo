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
        Ellipse(
          extent={{-100,-100},{100,100}},
          lineColor={0,0,0},
          startAngle=40,
          endAngle=150,
          closure=EllipseClosure.None,
          origin={0,-40}),
        Ellipse(
          extent={{-60,-60},{60,60}},
          lineColor={0,0,0},
          startAngle=40,
          endAngle=140,
          closure=EllipseClosure.None,
          origin={0,-80}),
        Text(
          extent={{-62,-29},{-141,-70}},
          textString="tau"),
        Polygon(
          points={{90,10},{66,60},{40,34},{90,10}},
          fillPattern=FillPattern.Solid),
        Line(
          points={{0,-20},{0,-101}}),
        Polygon(
          points={{-54,-54},{-30,-38},{-44,-26},{-54,-54}},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-150,110},{150,70}},
          textString="%name",
          textColor={0,0,255})}));
end Torque;
