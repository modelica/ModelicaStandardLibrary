within Modelica.Electrical.QuasiStatic.SinglePhase.Basic;
model VariableCapacitor "Single-phase variable capacitor"
  extends Interfaces.OnePort;
  import Modelica.ComplexMath.j;
  Modelica.Blocks.Interfaces.RealInput C(unit="F") "Variable capacitances"
    annotation (Placement(transformation(
        origin={0,120},
        extent={{-20,-20},{20,20}},
        rotation=270), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,120})));
equation
  i = j*omega*C*v;
  annotation (defaultComponentName="capacitor",
    Icon(graphics={
        Line(points={{-90,0},{-6,0}}, color={85,170,255}),
        Line(points={{6,0},{90,0}}, color={85,170,255}),
        Text(
          extent={{-150,90},{150,50}},
          textString="%name",
          textColor={0,0,255}),
        Line(
          points={{-6,28},{-6,-28}},
          color={85,170,255}),
        Line(
          points={{6,28},{6,-28}},
          color={85,170,255})}),
    Documentation(info="<html>

<p>
The linear capacitor connects the voltage <code><u>v</u></code> with the
current <code><u>i</u></code> by <code><u>i</u> = j*&omega;*C*<u>v</u></code>.
The capacitance <code>C</code> is given as input signal.
</p>

<h4>Note</h4>
<p>
The abstraction of a variable capacitor at quasi-static operation assumes:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStatic/SinglePhase/Basic/dc_dt.png\"
     alt=\"dc_dt.png\">.
</div>

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
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.VariableInductor\">Variable inductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.VariableImpedance\">Variable impedance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.VariableAdmittance\">Variable admittance</a>
</p>
</html>"));
end VariableCapacitor;
