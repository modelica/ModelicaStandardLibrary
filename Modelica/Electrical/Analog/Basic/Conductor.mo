within Modelica.Electrical.Analog.Basic;
model Conductor "Ideal linear electrical conductor"
  parameter SI.Conductance G(start=1)
    "Conductance at temperature T_ref";
  parameter SI.Temperature T_ref=300.15 "Reference temperature";
  parameter SI.LinearTemperatureCoefficient alpha=0
    "Temperature coefficient of conductance (G_actual = G_ref/(1 + alpha*(T_heatPort - T_ref))";
  extends Modelica.Electrical.Analog.Interfaces.OnePort;
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(T=T_ref);
  SI.Conductance G_actual
    "Actual conductance = G_ref/(1 + alpha*(T_heatPort - T_ref))";

equation
  assert((1 + alpha*(T_heatPort - T_ref)) >= Modelica.Constants.eps,
    "Temperature outside scope of model!");
  G_actual = G/(1 + alpha*(T_heatPort - T_ref));
  i = G_actual*v;
  LossPower = v*i;
  annotation (
    Documentation(info="<html>
<p>The linear conductor connects the branch voltage <em>v</em> with the branch current <em>i</em> by <em>i = v*G</em>. The Conductance <em>G</em> is allowed to be positive, zero, or negative.</p>
</html>",
        revisions="<html>
<ul>
<li><em> August 07, 2009   </em>
       by Anton Haumer<br> temperature dependency of conductance added<br>
       </li>
<li><em> March 11, 2009   </em>
       by Christoph Clauss<br> conditional heat port added<br>
       </li>
<li><em> 1998   </em>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>"),
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={
        Rectangle(
          extent={{-70,30},{70,-30}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,255}),
        Rectangle(extent={{-70,30},{70,-30}}, lineColor={0,0,255}),
        Line(points={{-90,0},{-70,0}}, color={0,0,255}),
        Line(points={{70,0},{90,0}}, color={0,0,255}),
        Line(
          visible=useHeatPort,
          points={{0,-100},{0,-30}},
          color={127,0,0},
          pattern=LinePattern.Dot),
        Text(
          extent={{-150,-40},{150,-80}},
          textString="G=%G"),
        Text(
          extent={{-150,90},{150,50}},
          textString="%name",
          textColor={0,0,255})}));
end Conductor;
