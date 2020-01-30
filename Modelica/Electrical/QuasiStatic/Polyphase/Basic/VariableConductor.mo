within Modelica.Electrical.QuasiStatic.Polyphase.Basic;
model VariableConductor "Polyphase variable conductor"
  extends Interfaces.TwoPlug;
  parameter SI.Temperature T_ref[m]=fill(293.15, m)
    "Reference temperatures";
  parameter SI.LinearTemperatureCoefficient alpha_ref[m]=
      zeros(m)
    "Temperature coefficient of resistance (G_actual = G_ref/(1 + alpha_ref*(heatPort.T - T_ref))";
  extends Modelica.Electrical.Polyphase.Interfaces.ConditionalHeatPort(
      final mh=m, T=T_ref);
  Modelica.Blocks.Interfaces.RealInput G_ref[m](each unit="S")
    "Variable conductance" annotation (Placement(transformation(
        origin={0,120},
        extent={{-20,-20},{20,20}},
        rotation=270), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,120})));
  QuasiStatic.SinglePhase.Basic.VariableConductor variableConductor[m](
    final T_ref=T_ref,
    final alpha_ref=alpha_ref,
    each final useHeatPort=useHeatPort,
    final T=T)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  connect(variableConductor.pin_p, plugToPins_p.pin_p) annotation (Line(
        points={{-10,0},{-24.5,0},{-24.5,0},{-39,0},{-39,0},{-68,0}}, color={85,170,255}));
  connect(variableConductor.pin_n, plugToPins_n.pin_n) annotation (Line(
        points={{10,0},{39,0},{39,0},{68,0}}, color={85,170,255}));
  connect(variableConductor.heatPort, heatPort) annotation (Line(points={{0,
          -10},{0,-32.5},{0,-32.5},{0,-55},{0,-55},{0,-100}}, color={191,0,0}));
  connect(G_ref, variableConductor.G_ref) annotation (Line(points={{0,120},{0,120},{0,12},{0,12}}, color={0,0,127}));
  annotation (defaultComponentName="conductor",
    Icon(graphics={Line(points={{60,0},{90,0}}, color={85,170,255}),
          Line(points={{-90,0},{-60,0}}, color={85,170,255}),
          Rectangle(
              extent={{-70,30},{70,-30}},
              lineColor={85,170,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
        Text(
          extent={{-150,90},{150,50}},
          textString="%name",
          textColor={0,0,255}),
                Text(
              extent={{150,-80},{-150,-40}},
              textString="m=%m")}),
    Documentation(info="<html>
<p>
The linear resistors connect the complex currents <code><u>i</u></code> with the complex
voltages <code><u>v</u></code> by <code><u>v</u>*G = <u>i</u></code>,
using <code>m</code> <a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.VariableConductor\">single-phase variable Conductors</a>.
The conductances <code>G</code> are given as <code>m</code> input signals.
</p>

<p>
The conductor model also has <code>m</code> optional
<a href=\"modelica://Modelica.Electrical.Polyphase.Interfaces.ConditionalHeatPort\">conditional heat ports</a>.
A linear temperature dependency of the conductances is also taken into account.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.VariableConductor\">VariableConductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.Resistor\">Resistor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.Conductor\">Conductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.Capacitor\">Capacitor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.Inductor\">Inductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.Impedance\">Impedance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.Admittance\">Admittance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.VariableResistor\">Variable resistor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.VariableCapacitor\">Variable capacitor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.VariableInductor\">Variable inductor</a>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.VariableImpedance\">Variable impedance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.VariableAdmittance\">Variable admittance</a>
</p>
</html>"));
end VariableConductor;
