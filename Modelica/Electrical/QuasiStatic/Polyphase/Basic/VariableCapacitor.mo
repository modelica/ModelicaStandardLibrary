within Modelica.Electrical.QuasiStatic.Polyphase.Basic;
model VariableCapacitor "Polyphase variable capacitor"
  extends Interfaces.TwoPlug;
  Modelica.Blocks.Interfaces.RealInput C[m](each unit="F")
    "Variable capacitance" annotation (Placement(transformation(
        origin={0,120},
        extent={{-20,-20},{20,20}},
        rotation=270), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,120})));
  QuasiStatic.SinglePhase.Basic.VariableCapacitor variableCapacitor[m]
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  connect(variableCapacitor.pin_p, plugToPins_p.pin_p) annotation (Line(
        points={{-10,0},{-24.5,0},{-24.5,0},{-39,0},{-39,0},{-68,0}}, color={85,170,255}));
  connect(variableCapacitor.pin_n, plugToPins_n.pin_n) annotation (Line(
        points={{10,0},{39,0},{39,0},{68,0}}, color={85,170,255}));
  connect(C, variableCapacitor.C) annotation (Line(
      points={{0,120},{0,12}}, color={0,0,127}));
  annotation (defaultComponentName="capacitor",
    Icon(graphics={Line(points={{-90,0},{-6,0}}, color={85,170,255}),
          Line(points={{6,0},{90,0}}, color={85,170,255}),
        Line(
          points={{-6,28},{-6,-28}},
          color={85,170,255}),
        Line(
          points={{6,28},{6,-28}},
          color={85,170,255}),
        Text(
          extent={{-150,90},{150,50}},
              textString="%name",
          textColor={0,0,255}),
                Text(
              extent={{150,-80},{-150,-40}},
              textString="m=%m")}),
    Documentation(info="<html>
<p>
The linear capacitors connect the complex currents <code><u>i</u></code> with the complex
voltages <code><u>v</u></code> by <code><u>v</u>*j*&omega;*C = <u>i</u></code>,
using <code>m</code> <a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.VariableCapacitor\">single-phase variable Capacitors</a>.
The capacitances <code>C</code> are given as <code>m</code> input signals.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.VariableCapacitor\">VariableCapacitor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.Resistor\">Resistor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.Conductor\">Conductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.Capacitor\">Capacitor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.Inductor\">Inductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.Impedance\">Impedance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.Admittance\">Admittance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.VariableResistor\">Variable resistor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.VariableConductor\">Variable conductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.VariableInductor\">Variable inductor</a>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.VariableImpedance\">Variable impedance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.VariableAdmittance\">Variable admittance</a>
</p>
</html>"));
end VariableCapacitor;
