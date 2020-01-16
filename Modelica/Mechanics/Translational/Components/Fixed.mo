within Modelica.Mechanics.Translational.Components;
model Fixed "Fixed flange"
  parameter SI.Position s0=0 "Fixed offset position of housing";

  Interfaces.Flange_b flange annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180)));
equation
  flange.s = s0;
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={
        Line(points={{-80,-40},{80,-40}}, color={0,127,0}),
        Line(points={{80,-40},{40,-80}}, color={0,127,0}),
        Line(points={{40,-40},{0,-80}}, color={0,127,0}),
        Line(points={{0,-40},{-40,-80}}, color={0,127,0}),
        Line(points={{-40,-40},{-80,-80}}, color={0,127,0}),
        Line(points={{0,-40},{0,-10}}, color={0,127,0}),
        Text(
          extent={{-150,-90},{150,-130}},
          textString="%name",
          textColor={0,0,255})}), Documentation(info="<html>
<p>
The <em>flange</em> of a 1D translational mechanical system <em>fixed</em>
at an position s0 in the <em>housing</em>. May be used:
</p>
<ul>
<li> to connect a compliant element, such as a spring or a damper,
     between a sliding mass and the housing.</li>
<li> to fix a rigid element, such as a sliding mass, at a specific
     position.</li>
</ul>

</html>"));
end Fixed;
