within Modelica.Electrical.QuasiStatic.SinglePhase.Basic;
model Admittance "Single-phase linear admittance"
  extends Interfaces.OnePort;
  import Modelica.ComplexMath.j;
  import Modelica.ComplexMath.real;
  import Modelica.ComplexMath.imag;
  import Modelica.ComplexMath.conj;
  parameter SI.ComplexAdmittance Y_ref(re(start=1),im(start=0)) "Complex admittance G_ref + j*B_ref";
  parameter SI.Temperature T_ref=293.15 "Reference temperature";
  parameter SI.LinearTemperatureCoefficient alpha_ref=0 "Temperature coefficient of resistance (R_actual = R_ref*(1 + alpha_ref*(heatPort.T - T_ref))";
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(T=T_ref);
  parameter Boolean frequencyDependent = false "Consider frequency dependency, if true"
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter SI.Frequency f_ref = 1 "Reference frequency, if frequency dependency is considered"
    annotation(Dialog(enable=frequencyDependent));
  SI.Conductance G_actual "Resistance = R_ref*(1 + alpha_ref*(heatPort.T - T_ref))";
  SI.Susceptance B_actual "Susceptance considering possible frequency dependency";
  final parameter SI.Conductance G_ref=real(Y_ref) "Resistive component of conductance";
  final parameter SI.Susceptance B_ref=imag(Y_ref) "Reactive component of susceptance";
equation
  assert((1 + alpha_ref*(T_heatPort - T_ref)) >= Modelica.Constants.eps,
    "Temperature outside scope of model!");
  G_actual = G_ref/(1 + alpha_ref*(T_heatPort - T_ref));
  B_actual = B_ref * (if not frequencyDependent then 1 else
    (if B_ref>=0 then omega/(2*Modelica.Constants.pi*f_ref) else 2*Modelica.Constants.pi*f_ref/omega));
  i = Complex(G_actual, B_actual) * v;
  LossPower = real(v*conj(i));
  annotation (Icon(graphics={
        Line(points={{60,0},{90,0}}, color={85,170,255}),
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
          textColor={0,0,255})}),
      Documentation(info="<html>

<p>The admittance model represents a <strong>parallel</strong> connection of a conductor and either a capacitor or inductor.<br>
<img src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStatic/SinglePhase/Basic/GB_admittance.png\"></p>

<p>
The linear admittance connects the voltage <code><u>v</u></code> with the
current <code><u>i</u></code> by  <code><u>i</u> = <u>Y</u>*<u>v</u></code>. The resistive
component is modeled temperature dependent, so the real part <code>G_actual = real(<u>Y</u>)</code> is determined from
the actual operating temperature and the reference input conductance <code>real(Y_ref)</code>.
A <a href=\"modelica://Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort\">conditional heat port</a> is considered.
The reactive component <code>B_actual = imag(<u>Y</u>)</code>
is equal to <code>imag(Y_ref)</code> if <code>frequencyDependent = false</code>.
Frequency dependency is considered by <code>frequencyDependent = true</code>, distinguishing two cases:
</p>

<dl>
<dt>(a) <code>imag(Y_ref) &gt; 0</code>: capacitive case</dt>
<dd>The actual susceptance <code>B_actual</code> is proportional to <code>f/f_ref</code></dd>
<dt>(b) <code>imag(Y_ref) &lt; 0</code>: inductive case</dt>
<dd>The actual susceptance <code>B_actual</code> is proportional to <code>f_ref/f</code></dd>
</dl>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Resistor\">Resistor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Conductor\">Conductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Capacitor\">Capacitor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Impedance\">Impedance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.VariableResistor\">Variable resistor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.VariableConductor\">Variable conductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.VariableCapacitor\">Variable capacitor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.VariableInductor\">Variable inductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.VariableImpedance\">Variable impedance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.VariableAdmittance\">Variable admittance</a>
</p>
</html>"));
end Admittance;
