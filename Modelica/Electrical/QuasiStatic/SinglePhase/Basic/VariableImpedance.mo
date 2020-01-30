within Modelica.Electrical.QuasiStatic.SinglePhase.Basic;
model VariableImpedance "Single-phase variable impedance"
  extends Interfaces.OnePort;
  import Modelica.ComplexMath.real;
  import Modelica.ComplexMath.imag;
  import Modelica.ComplexMath.conj;
  parameter SI.Temperature T_ref=293.15 "Reference temperature";
  parameter SI.LinearTemperatureCoefficient alpha_ref=0 "Temperature coefficient of resistance (R_actual = R_ref*(1 + alpha_ref*(heatPort.T - T_ref))";
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(T=T_ref);
  Modelica.ComplexBlocks.Interfaces.ComplexInput Z_ref "Variable complex impedance"
    annotation (Placement(transformation(
        origin={0,120},
        extent={{-20,-20},{20,20}},
        rotation=270), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,120})));
  parameter Boolean frequencyDependent = false "Consider frequency dependency, if true"
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter SI.Frequency f_ref = 1 "Reference frequency, if frequency dependency is considered"
    annotation(Dialog(enable=frequencyDependent));
  SI.Resistance R_actual "Resistance = R_ref*(1 + alpha_ref*(heatPort.T - T_ref))";
  SI.Reactance X_actual "Reactance considering possible frequency dependency";
  SI.Resistance R_ref=real(Z_ref) "Resistive component of impedance, resistance";
  SI.Reactance X_ref=imag(Z_ref) "Reactive component of impedance, reactance";
equation
  assert((1 + alpha_ref*(T_heatPort - T_ref)) >= Modelica.Constants.eps,
    "Temperature outside scope of model!");
  R_actual = R_ref*(1 + alpha_ref*(T_heatPort - T_ref));
  X_actual = X_ref * (if not frequencyDependent then 1 else
    (if X_ref>=0 then omega/(2*Modelica.Constants.pi*f_ref) else 2*Modelica.Constants.pi*f_ref/omega));
  v = Complex(R_actual, X_actual) * i;
  LossPower = real(v*conj(i));
  annotation (defaultComponentName="impedance",
    Icon(graphics={
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

<p>The impedance model represents a <strong>series</strong> connection of a resistor and either an inductor or capacitor.<br>
<img src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStatic/SinglePhase/Basic/RX_impedance.png\"></p>

<p>
The linear impedance connects the complex voltage <code><u>v</u></code> with the
complex current <code><u>i</u></code> by <code><u>i</u>*<u>Z</u> = <u>v</u></code>.
The impedance <code>Z_ref = R_ref + j*X_ref</code> is given as complex input signal, representing the
resistive and reactive component of the input impedance. The resistive
component is modeled temperature dependent, so the real part <code>R_actual = real(<u>Z</u>)</code> is determined from
the actual operating temperature and the reference input resistance <code>real(Z_ref)</code>.
The reactive component <code>X_actual = imag(<u>Z</u>)</code>
is equal to <code>imag(Z_ref)</code> if <code>frequencyDependent = false</code>.
Frequency dependency is considered by <code>frequencyDependent = true</code>, distinguishing two cases:
</p>

<dl>
<dt>(a) <code>imag(Z_ref) &gt; 0</code>: inductive case</dt>
<dd>The actual reactance <code>X_actual</code> is proportional to <code>f/f_ref</code></dd>
<dt>(b) <code>imag(Z_ref) &lt; 0</code>: capacitive case</dt>
<dd>The actual reactance <code>X_actual</code> is proportional to <code>f_ref/f</code></dd>
</dl>

<h4>Note</h4>
<p>
A zero crossing of the real or imaginary part of the impedance signal <code>Z_ref</code> could cause
singularities due to the actual structure of the connected network.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Resistor\">Resistor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Conductor\">Conductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Capacitor\">Capacitor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Inductor\">Inductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Impedance\">Impedance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Admittance\">Admittance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.VariableResistor\">Variable resistor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.VariableConductor\">Variable conductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.VariableCapacitor\">Variable capacitor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.VariableInductor\">Variable inductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.VariableAdmittance\">Variable admittance</a>
</p>
</html>"));
end VariableImpedance;
