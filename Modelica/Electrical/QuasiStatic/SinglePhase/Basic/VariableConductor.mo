within Modelica.Electrical.QuasiStatic.SinglePhase.Basic;
model VariableConductor "Single-phase variable conductor"
  extends Interfaces.OnePort;
  import Modelica.ComplexMath.real;
  import Modelica.ComplexMath.conj;
  parameter SI.Temperature T_ref=293.15 "Reference temperature";
  parameter SI.LinearTemperatureCoefficient alpha_ref=0 "Temperature coefficient of conductance (G_actual = G_ref/(1 + alpha_ref*(heatPort.T - T_ref))";
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(T=T_ref);
  SI.Conductance G_actual "Conductance = G_ref/(1 + alpha_ref*(heatPort.T - T_ref))";
  Modelica.Blocks.Interfaces.RealInput G_ref(unit="S") "Variable conductance"
                           annotation (Placement(transformation(
        origin={0,120},
        extent={{-20,-20},{20,20}},
        rotation=270), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,120})));
equation
  assert((1 + alpha_ref*(T_heatPort - T_ref)) >= Modelica.Constants.eps,
    "Temperature outside scope of model!");
  G_actual = G_ref/(1 + alpha_ref*(T_heatPort - T_ref));
  i = G_actual*v;
  LossPower = real(v*conj(i));
  annotation (defaultComponentName="conductor",
    Icon(graphics={
        Line(points={{60,0},{90,0}}, color={85,170,255}),
        Line(points={{-90,0},{-60,0}}, color={85,170,255}),
        Rectangle(
          extent={{-70,30},{70,-30}},
          lineColor={85,170,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-150,90},{150,50}},
          textString="%name",
          textColor={0,0,255})}),
    Documentation(info="<html>

<p>
The linear conductor connects the voltage <code><u>v</u></code> with the
current <code><u>i</u></code> by <code><u>i</u> = G*<u>v</u></code>.
The conductance <code>G</code> is given as input signal.
</p>

<p>
The variable conductor model also has an optional
<a href=\"modelica://Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort\">conditional heat port</a>.
A linear temperature dependency of the conductance is also taken into account.
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
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.VariableCapacitor\">Variable capacitor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.VariableInductor\">Variable inductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.VariableImpedance\">Variable impedance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.VariableAdmittance\">Variable admittance</a>
</p>
</html>"));
end VariableConductor;
