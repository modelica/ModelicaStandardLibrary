within Modelica.Thermal.HeatTransfer.Components;
model ConvectiveResistor
  "Lumped thermal element for heat convection (dT = Rc*Q_flow)"
  SI.HeatFlowRate Q_flow "Heat flow rate from solid -> fluid";
  SI.TemperatureDifference dT "= solid.T - fluid.T";
  Modelica.Blocks.Interfaces.RealInput Rc(unit="K/W")
    "Signal representing the convective thermal resistance in [K/W]"
    annotation (Placement(transformation(
        origin={0,100},
        extent={{-20,-20},{20,20}},
        rotation=270)));
  Interfaces.HeatPort_a solid annotation (Placement(transformation(extent={{
            -110,-10},{-90,10}})));
  Interfaces.HeatPort_b fluid annotation (Placement(transformation(extent={{
            90,-10},{110,10}})));
equation
  dT = solid.T - fluid.T;
  solid.Q_flow = Q_flow;
  fluid.Q_flow = -Q_flow;
  dT = Rc*Q_flow;
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Rectangle(
          extent={{-62,80},{98,-80}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-90,80},{-60,-80}},
          fillColor={192,192,192},
          fillPattern=FillPattern.Forward),
        Text(
          extent={{-150,-90},{150,-130}},
          textString="%name",
          textColor={0,0,255}),
        Line(points={{100,0},{100,0}}, color={0,127,255}),
        Line(points={{-60,20},{76,20}}, color={191,0,0}),
        Line(points={{-60,-20},{76,-20}}, color={191,0,0}),
        Line(points={{-34,80},{-34,-80}}, color={0,127,255}),
        Line(points={{6,80},{6,-80}}, color={0,127,255}),
        Line(points={{40,80},{40,-80}}, color={0,127,255}),
        Line(points={{76,80},{76,-80}}, color={0,127,255}),
        Line(points={{-34,-80},{-44,-60}}, color={0,127,255}),
        Line(points={{-34,-80},{-24,-60}}, color={0,127,255}),
        Line(points={{6,-80},{-4,-60}}, color={0,127,255}),
        Line(points={{6,-80},{16,-60}}, color={0,127,255}),
        Line(points={{40,-80},{30,-60}}, color={0,127,255}),
        Line(points={{40,-80},{50,-60}}, color={0,127,255}),
        Line(points={{76,-80},{66,-60}}, color={0,127,255}),
        Line(points={{76,-80},{86,-60}}, color={0,127,255}),
        Line(points={{56,-30},{76,-20}}, color={191,0,0}),
        Line(points={{56,-10},{76,-20}}, color={191,0,0}),
        Line(points={{56,10},{76,20}}, color={191,0,0}),
        Line(points={{56,30},{76,20}}, color={191,0,0}),
        Text(
          extent={{22,124},{92,98}},
          textString="Rc")}),
    Documentation(info="<html>
<p>
This is a model of linear heat convection, e.g., the heat transfer between a plate and the surrounding air; same as the
<a href=\"modelica://Modelica.Thermal.HeatTransfer.Components.Convection\">Convection</a> component
but using the convective resistance instead of the convective conductance as an input.
This is advantageous for series connections of ConvectiveResistors,
especially if it shall be allowed that a convective resistance is defined to be zero (i.e. no temperature difference).
</p>
</html>"),
       Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={
        Line(points={{100,0},{100,0}}, color={0,127,255}),
        Line(points={{100,0},{100,0}}, color={0,127,255}),
        Line(points={{100,0},{100,0}}, color={0,127,255})}));
end ConvectiveResistor;
