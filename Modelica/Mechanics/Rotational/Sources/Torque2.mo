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
      fillPattern=FillPattern.Solid)}),
    Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{15,-71},{83,-84}},
          textColor={128,128,128},
          textString="rotation axis"),
        Polygon(
          points={{11,-77},{-9,-72},{-9,-82},{11,-77}},
          lineColor={128,128,128},
          fillColor={128,128,128},
          fillPattern=FillPattern.Solid),
        Line(points={{-79,-77},{-8,-77}}, color={128,128,128}),
        Line(
          points={{-75,20},{-71,23},{-66,26},{-61,28},{-57,29},{-51,30},{-42,
              30},{-36,29},{-32,28},{-27,26},{-22,23},{-18,20},{-14,15},{-11,
              9}},
          thickness=0.5, smooth=Smooth.Bezier),
        Polygon(
          points={{-79,24},{-70,17},{-90,0},{-79,24}},
          lineThickness=0.5,
          fillPattern=FillPattern.Solid),
        Line(
          points={{73,20},{69,23},{64,26},{59,28},{55,29},{49,30},{40,30},{
              34,29},{30,28},{25,26},{20,23},{16,20},{12,15},{9,9}},
          thickness=0.5, smooth=Smooth.Bezier),
        Polygon(
          points={{88,0},{77,24},{68,17},{88,0}},
          fillPattern=FillPattern.Solid)}));
end Torque2;
