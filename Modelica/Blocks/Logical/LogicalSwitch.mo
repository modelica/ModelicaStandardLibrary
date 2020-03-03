within Modelica.Blocks.Logical;
block LogicalSwitch "Logical Switch"
  extends Blocks.Interfaces.partialBooleanSI3SO;

equation
  y = if u2 then u1 else u3;
  annotation (Documentation(info="<html>
<p>The LogicalSwitch switches, depending on the
Boolean u2 connector (the middle connector),
between the two possible input signals
u1 (upper connector) and u3 (lower connector).</p>
<p>If u2 is true, connector y is set equal to
u1, else it is set equal to u3.</p>
</html>"),
         Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}),
          graphics={
        Line(
          points={{12,0},{100,0}},
          color={255,0,255}),
        Line(
          points={{-100,0},{-40,0}},
          color={255,0,255}),
        Line(
          points={{-100,-80},{-40,-80},{-40,-80}},
          color={255,0,255}),
        Line(points={{-40,12},{-40,-10}}, color={255,0,255}),
        Line(points={{-100,80},{-40,80}}, color={255,0,255}),
        Line(
          points=DynamicSelect({{-40,80},{8,2}}, if u2 then {{-40,80},{8,2}} else {{-40,-80},{8,2}}),
          color={255,0,255},
          thickness=1),
        Ellipse(lineColor={0,0,127},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          extent={{2,-6},{18,8}})}));
end LogicalSwitch;
