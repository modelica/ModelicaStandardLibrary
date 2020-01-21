within Modelica.Mechanics.Rotational.Components;
model Fixed "Flange fixed in housing at a given angle"
  parameter SI.Angle phi0=0 "Fixed offset angle of housing";

  Interfaces.Flange_b flange "(right) flange fixed in housing" annotation (
      Placement(transformation(extent={{10,-10},{-10,10}})));

equation
  flange.phi = phi0;
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{-150,-90},{150,-130}},
          textColor={0,0,255},
          textString="%name"),
        Line(points={{-80,-40},{80,-40}}),
        Line(points={{80,-40},{40,-80}}),
        Line(points={{40,-40},{0,-80}}),
        Line(points={{0,-40},{-40,-80}}),
        Line(points={{-40,-40},{-80,-80}}),
        Line(points={{0,-40},{0,-10}})}),
    Documentation(info="<html>
<p>
The <strong>flange</strong> of a 1D rotational mechanical system is <strong>fixed</strong>
at an angle phi0 in the <strong>housing</strong>. May be used:
</p>
<ul>
<li> to connect a compliant element, such as a spring or a damper,
     between an inertia or gearbox component and the housing.</li>
<li> to fix a rigid element, such as an inertia, with a specific
     angle to the housing.</li>
</ul>

</html>"));
end Fixed;
