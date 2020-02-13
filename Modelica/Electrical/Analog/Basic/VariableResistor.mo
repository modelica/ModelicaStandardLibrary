within Modelica.Electrical.Analog.Basic;
model VariableResistor
  "Ideal linear electrical resistor with variable resistance"
  parameter SI.Temperature T_ref=300.15 "Reference temperature";
  parameter SI.LinearTemperatureCoefficient alpha=0
    "Temperature coefficient of resistance (R_actual = R*(1 + alpha*(T_heatPort - T_ref))";
  extends Modelica.Electrical.Analog.Interfaces.OnePort;
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(T=T_ref);
  SI.Resistance R_actual
    "Actual resistance = R*(1 + alpha*(T_heatPort - T_ref))";
  Modelica.Blocks.Interfaces.RealInput R(unit="Ohm") annotation (Placement(
        transformation(
        origin={0,120},
        extent={{-20,-20},{20,20}},
        rotation=270), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,120})));
equation
  assert((1 + alpha*(T_heatPort - T_ref)) >= Modelica.Constants.eps,
    "Temperature outside scope of model!");
  R_actual = R*(1 + alpha*(T_heatPort - T_ref));
  v = R_actual*i;
  LossPower = v*i;
  annotation (defaultComponentName="resistor",
    Documentation(info="<html>
<p>The linear resistor connects the branch voltage <em>v</em> with the branch current <em>i</em> by
<br><em><strong>i*R = v</strong></em>
<br>The Resistance <em>R</em> is given as input signal.
<br><br><strong>Attention!!!</strong><br>It is recommended that the R signal should not cross the zero value. Otherwise depending on the surrounding circuit the probability of singularities is high.</p>
</html>",
        revisions="<html>
<ul>
<li><em> August 07, 2009   </em>
       by Anton Haumer<br> temperature dependency of resistance added<br>
       </li>
<li><em> March 11, 2009   </em>
       by Christoph Clauss<br> conditional heat port added<br>
       </li>
<li><em>June 7, 2004   </em>
       by Christoph Clauss<br>changed, docu added<br>
       </li>
<li><em>April 30, 2004</em>
       by Anton Haumer<br>implemented.
       </li>
</ul>
</html>"),
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={
        Line(points={{-90,0},{-70,0}}, color={0,0,255}),
        Rectangle(
          extent={{-70,30},{70,-30}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{70,0},{90,0}}, color={0,0,255}),
        Text(
          extent={{-150,90},{150,50}},
          textString="%name",
          textColor={0,0,255})}));
end VariableResistor;
