within Modelica.Electrical.QuasiStatic.Polyphase.Basic;
model Capacitor "Polyphase linear capacitor"
  extends Interfaces.TwoPlug;
  parameter SI.Capacitance C[m](start=fill(1, m))
    "Capacitances";
  QuasiStatic.SinglePhase.Basic.Capacitor capacitor[m](final C=C)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  connect(plugToPins_p.pin_p, capacitor.pin_p) annotation (Line(points={{-68,
          0},{-53.5,0},{-53.5,0},{-39,0},{-39,0},{-10,0}}, color={85,170,
          255}));
  connect(capacitor.pin_n, plugToPins_n.pin_n) annotation (Line(points={{10,
          0},{39,0},{39,0},{68,0}}, color={85,170,255}));
  annotation (Icon(graphics={Text(
              extent={{150,-80},{-150,-40}},
              textString="m=%m"),
        Text(
          extent={{-150,90},{150,50}},
              textString="%name",
          textColor={0,0,255}),
        Line(
          points={{-6,28},{-6,-28}},
          color={85,170,255}),
        Line(
          points={{6,28},{6,-28}},
          color={85,170,255}),
                             Line(points={{-90,0},{-6,0}}, color={85,170,255}),
          Line(points={{6,0},{90,0}}, color={85,170,255})}), Documentation(info="<html>
<p>
The linear capacitor connects the complex currents <code><u>i</u></code> with the complex
voltages <code><u>v</u></code> by <code><u>v</u>*j*&omega;*C = <u>i</u></code>,
using <code>m</code> <a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Capacitor\">single-phase Capacitors</a>.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Capacitor\">Capacitor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.Resistor\">Resistor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.Conductor\">Conductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.Inductor\">Inductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.Impedance\">Impedance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.Admittance\">Admittance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.VariableResistor\">Variable resistor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.VariableConductor\">Variable conductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.VariableCapacitor\">Variable capacitor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.VariableInductor\">Variable inductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.VariableImpedance\">Variable impedance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.VariableAdmittance\">Variable admittance</a>
</p>
</html>"));
end Capacitor;
