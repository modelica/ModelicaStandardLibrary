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
    Text(extent={{-150,-40},{150,-80}},
      textString="%name",
      textColor={0,0,255}),
    Polygon(points={{-78,24},{-69,17},{-89,0},{-78,24}},
      lineThickness=0.5,
      fillPattern=FillPattern.Solid),
    Line(points={{-74,20},{-70,23},{-65,26},{-60,28},{-56,29},{-50,30},{-41,30},{-35,29},{-31,28},{-26,26},{-21,23},{-17,20},{-13,15},{-10,9}},
      thickness=0.5, smooth=Smooth.Bezier),
    Line(points={{74,20},{70,23},{65,26},{60,28},{56,29},{50,30},{41,30},{35,29},{31,28},{26,26},{21,23},{17,20},{13,15},{10,9}},
      thickness=0.5, smooth=Smooth.Bezier),
    Polygon(points={{89,0},{78,24},{69,17},{89,0}},
      fillPattern=FillPattern.Solid)}));
end Torque2;
