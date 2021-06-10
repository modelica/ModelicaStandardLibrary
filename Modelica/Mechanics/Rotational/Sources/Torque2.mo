within Modelica.Mechanics.Rotational.Sources;
model Torque2 "Input signal acting as torque on two flanges"
  extends Rotational.Interfaces.PartialTwoFlanges;

  Modelica.Blocks.Interfaces.RealInput tau(unit="N.m")
    "Torque driving the two flanges (a positive value accelerates the flange)"
    annotation (Placement(transformation(
        origin={0,40},
        extent={{-20,-20},{20,20}},
        rotation=270)));

equation
  flange_a.tau = tau;
  flange_b.tau = -tau;
  annotation (defaultComponentName="torque",
    Documentation(info="<html>
<p>
The input signal <strong>tau</strong> defines an external
torque in [Nm] which acts at both flange connectors,
i.e., the components connected to these flanges are driven by torque <strong>tau</strong>.</p>
<p>The input signal can be provided from one of the signal generator
blocks of Modelica.Blocks.Sources.
</p>
</html>"),
    Icon(
      coordinateSystem(preserveAspectRatio=true,
      extent={{-100,-100},{100,100}}),
      graphics={
        Ellipse(
          extent={{-50,-50},{50,50}},
          lineColor={0,0,0},
          startAngle=40,
          endAngle=140,
          closure=EllipseClosure.None,
          origin={50,-20}),
        Ellipse(
          extent={{-50,-50},{50,50}},
          lineColor={0,0,0},
          startAngle=40,
          endAngle=140,
          closure=EllipseClosure.None,
          origin={-50,-20}),
        Text(
          extent={{-150,-40},{150,-80}},
          textString="%name",
          textColor={0,0,255}),
        Polygon(
          points={{-80,28},{-72,18},{-92,8},{-80,28}},
          lineThickness=0.5,
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{80,28},{72,18},{92,8},{80,28}},
          fillPattern=FillPattern.Solid)}));
end Torque2;
