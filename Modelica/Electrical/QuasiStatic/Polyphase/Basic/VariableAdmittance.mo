within Modelica.Electrical.QuasiStatic.Polyphase.Basic;
model VariableAdmittance "Polyphase variable admittance"
  extends Interfaces.TwoPlug;
  parameter SI.Temperature T_ref[m]=fill(293.15, m)
    "Reference temperatures";
  parameter SI.LinearTemperatureCoefficient alpha_ref[m]=zeros(m)
    "Temperature coefficient of resistance (R_actual = R_ref*(1 + alpha_ref*(heatPort.T - T_ref))";
  extends Modelica.Electrical.Polyphase.Interfaces.ConditionalHeatPort(final mh=m, T=T_ref);
  parameter Boolean frequencyDependent = false "Consider frequency dependency, if true"
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter SI.Frequency f_ref = 1 "Reference frequency, if frequency dependency is considered"
    annotation(Dialog(enable=frequencyDependent));
  Modelica.ComplexBlocks.Interfaces.ComplexInput Y_ref[m]
    "Variable complex admittances" annotation (Placement(transformation(
        origin={0,120},
        extent={{-20,-20},{20,20}},
        rotation=270), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,120})));
  SinglePhase.Basic.VariableAdmittance variableImpedance[m](
    final T_ref=T_ref,
    final alpha_ref=alpha_ref,
    each final useHeatPort=useHeatPort,
    final T=T,
    final frequencyDependent=fill(frequencyDependent, m),
    final f_ref=fill(f_ref, m))
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  connect(variableImpedance.pin_p, plugToPins_p.pin_p) annotation (Line(
        points={{-10,0},{-68,0}}, color={85,170,255}));
  connect(variableImpedance.pin_n, plugToPins_n.pin_n)
    annotation (Line(points={{10,0},{68,0}}, color={85,170,255}));
  connect(variableImpedance.heatPort, heatPort) annotation (Line(
      points={{0,-10},{0,-100}}, color={191,0,0}));
  connect(Y_ref, variableImpedance.Y_ref) annotation (Line(
      points={{0,120},{0,12}}, color={85,170,255}));
  annotation (defaultComponentName="admittance",
    Icon(graphics={Line(points={{60,0},{90,0}}, color={85,170,255}),
          Line(points={{-90,0},{-60,0}}, color={85,170,255}),
          Rectangle(
              extent={{-70,30},{70,-30}},
              lineColor={85,170,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid), Polygon(
              points={{-70,-30},{70,30},{70,-30},{-70,-30}},
              lineColor={85,170,255},
              fillColor={85,170,255},
              fillPattern=FillPattern.Solid),
        Text(
          extent={{-150,90},{150,50}},
          textString="%name",
          textColor={0,0,255}),
                Text(
              extent={{150,-80},{-150,-40}},
              textString="m=%m")}),
    Documentation(info="<html>
<p>The admittance model represents a <strong>parallel</strong> connection of a resistor and either a capacitor or inductor
in each phase.<br>
<img src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStatic/SinglePhase/Basic/GB_admittance.png\"></p>

<p>
The linear admittance connects the complex voltage <code><u>v</u></code> with the
complex current <code><u>i</u></code> by <code><u>v</u>*<u>Y</u> = <u>i</u></code> in each phase,
using <code>m</code>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.VariableAdmittance\">
variable single-phase admittances</a>.
The admittances <code>Y_ref = G_ref + j*B_ref</code> are given as complex input signals, representing the
resistive and reactive components of the input admittances. The resistive
components are modeled temperature dependent, so the real part <code>G_actual = real(<u>Y</u>)</code> are determined from
the actual operating temperatures and the reference input conductances <code>real(Y_ref)</code>.
<a href=\"modelica://Modelica.Electrical.Polyphase.Interfaces.ConditionalHeatPort\">Conditional heat ports</a> are considered.
The reactive components <code>B_actual = imag(<u>Y</u>)</code>
are equal to <code>imag(Y_ref)</code> if <code>frequencyDependent = false</code>.
Frequency dependency is considered by <code>frequencyDependent = true</code>, distinguishing two cases:
</p>

<dl>
<dt>(a) <code>imag(Y_ref) &gt; 0</code>: capacitive case</dt>
<dd>The actual susceptances <code>B_actual</code> are proportional to <code>f/f_ref</code></dd>
<dt>(b) <code>imag(Y_ref) &lt; 0</code>: inductive case</dt>
<dd>The actual susceptances <code>B_actual</code> are proportional to <code>f_ref/f</code></dd>
</dl>

<h4>Note</h4>
<p>
Zero crossings of the real or imaginary parts of the admittance signals <code>Y_ref</code> could cause
singularities due to the actual structure of the connected network.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.VariableResistor\">VariableResistor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.Resistor\">Resistor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.Conductor\">Conductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.Capacitor\">Capacitor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.Inductor\">Inductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.Impedance\">Impedance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.Admittance\">Admittance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.VariableConductor\">Variable conductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.VariableCapacitor\">Variable capacitor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.VariableInductor\">Variable inductor</a>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.VariableImpedance\">Variable impedance</a>,
</p>
</html>"));
end VariableAdmittance;
