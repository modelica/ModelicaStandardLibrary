within Modelica.Electrical.QuasiStatic.Polyphase.Basic;
model Admittance "Polyphase linear admittance"
  extends Interfaces.TwoPlug;
  parameter SI.ComplexAdmittance Y_ref[m](re(start=fill(1,m)),im(start=fill(0,m)))
    "Complex admittances G_ref + j*B_ref";
  parameter SI.Temperature T_ref[m]=fill(293.15, m)
    "Reference temperatures";
  parameter SI.LinearTemperatureCoefficient alpha_ref[m]=zeros(m)
    "Temperature coefficient of resistance (R_actual = R_ref*(1 + alpha_ref*(heatPort.T - T_ref))";
  extends Modelica.Electrical.Polyphase.Interfaces.ConditionalHeatPort(final mh=m, T=T_ref);
  parameter Boolean frequencyDependent = false "Consider frequency dependency, if true"
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter SI.Frequency f_ref = 1 "Reference frequency, if frequency dependency is considered"
    annotation(Dialog(enable=frequencyDependent));
  QuasiStatic.SinglePhase.Basic.Admittance admittance[m](
    final Y_ref=Y_ref,
    final T_ref=T_ref,
    final alpha_ref=alpha_ref,
    final useHeatPort=fill(useHeatPort, m),
    final T=T,
    final frequencyDependent=fill(frequencyDependent, m),
    final f_ref=fill(f_ref, m))
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

equation
  connect(plugToPins_p.pin_p, admittance.pin_p) annotation (Line(points={{-68,0},{-53.5,0},{-39,0},{-10,0}}, color={85,170,255}));
  connect(admittance.pin_n, plugToPins_n.pin_n) annotation (Line(points={{10,0},{39,0},{68,0}}, color={85,170,255}));
  connect(admittance.heatPort, heatPort) annotation (Line(points={{0,-10},{0,-10},{0,-100}}, color={191,0,0}));
  annotation (Icon(graphics={
                Text(
              extent={{150,-80},{-150,-40}},
              textString="m=%m"), Line(points={{60,0},{90,0}}, color={85,170,255}),
          Line(points={{-90,0},{-60,0}}, color={85,170,255}),
          Rectangle(
              extent={{-70,30},{70,-30}},
              lineColor={85,170,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
                                 Polygon(
              points={{-70,-30},{70,30},{70,-30},{-70,-30}},
              lineColor={85,170,255},
              fillColor={85,170,255},
              fillPattern=FillPattern.Solid),
        Text(
          extent={{-150,90},{150,50}},
          textString="%name",
          textColor={0,0,255})}), Documentation(info="<html>

<p>The admittance model represents a <strong>parallel</strong> connection of a resistor and either a capacitor or inductor
in each phase.<br>
<img src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStatic/SinglePhase/Basic/GB_admittance.png\"></p>

<p>
The linear admittance connects the voltage <code><u>v</u></code> with the
current <code><u>i</u></code> by  <code><u>i</u> = <u>Y</u>*<u>v</u></code> in each phase, using <code>m</code>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Admittance\">single-phase admittances</a>.
The resistive
components are modeled temperature dependent, so the real parts <code>G_actual = real(<u>Y</u>)</code> are determined from
the actual operating temperatures and the reference input conductances <code>real(Y_ref)</code>.
<a href=\"modelica://Modelica.Electrical.Polyphase.Interfaces.ConditionalHeatPort\">Conditional heat ports</a> are considered.
The reactive components
<code>B_actual = imag(<u>Y</u>)</code>
are equal to <code>imag(Y_ref)</code> if <code>frequencyDependent = false</code>.
Frequency dependency is considered by <code>frequencyDependent = true</code>, distinguishing two cases:
</p>

<dl>
<dt>(a) <code>imag(Y_ref) &gt; 0</code>: capacitive case</dt>
<dd>The actual susceptances <code>B_actual</code> are proportional to <code>f/f_ref</code></dd>
<dt>(b) <code>imag(Y_ref) &lt; 0</code>: inductive case</dt>
<dd>The actual susceptances <code>B_actual</code> are proportional to <code>f_ref/f</code></dd>
</dl>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Admittance\">Admittance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.Resistor\">Resistor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.Conductor\">Conductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.Capacitor\">Capacitor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.Impedance\">Impedance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.VariableResistor\">Variable resistor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.VariableConductor\">Variable conductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.VariableCapacitor\">Variable capacitor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.VariableInductor\">Variable inductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.VariableImpedance\">Variable impedance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.VariableAdmittance\">Variable admittance</a>
</p>
</html>"));
end Admittance;
