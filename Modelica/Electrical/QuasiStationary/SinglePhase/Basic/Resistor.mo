within Modelica.Electrical.QuasiStationary.SinglePhase.Basic;
model Resistor "Singlephase linear resistor"
  extends Interfaces.OnePort;
  import Modelica.ComplexMath.real;
  import Modelica.ComplexMath.conj;
  parameter Modelica.SIunits.Resistance R_ref(start=1);
  parameter Modelica.SIunits.Temperature T_ref=293.15 "Reference temperature";
  parameter Modelica.SIunits.LinearTemperatureCoefficient alpha_ref=0
    "Temperature coefficient of resistance (R_actual = R_ref*(1 + alpha_ref*(heatPort.T - T_ref))";
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(T = T_ref);
  Modelica.SIunits.Resistance R_actual
    "Resistance = R_ref*(1 + alpha_ref*(heatPort.T - T_ref))";
equation
  assert((1 + alpha_ref*(T_heatPort - T_ref)) >= Modelica.Constants.eps, "Temperature outside scope of model!");
  R_actual = R_ref*(1 + alpha_ref*(T_heatPort - T_ref));
  v = R_actual*i;
  LossPower = real(v*conj(i));
  annotation (Icon(graphics={
        Text(extent={{100,60},{-100,100}}, textString=
                                               "%name"),
        Line(points={{60,0},{90,0}}),
        Line(points={{-90,0},{-60,0}}),
        Rectangle(
          extent={{-70,30},{70,-30}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(extent={{100,-80},{-100,-40}}, textString=
                                              "R=%R_ref")}),
      Diagram(graphics),
    Documentation(info="<html>
<p>
The linear resistor connects the complex voltage <i><u>v</u></i> with the complex
current <i><u>i</u></i> by <i><u>i</u>*R = <u>v</u></i>.
The resistance <i>R</i> is allowed to be positive, zero, or negative.
</p>

<p>
The resistor model also has an optional 
<a href=\"Modelica://Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort\">conditional heat port</a>. 
A linear temperature dependency of the resistance for an enabled heat port is also taken into account.
</p>

<h4>See also</h4>
<p>
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Conductor>Conductor</a>, 
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Capacitor>Capacitor</a>, 
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Inductor>Inductor</a>, 
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableResistor>Variable resistor</a>, 
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableConductor>Variable conductor</a>, 
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableCapacitor>Variable capacitor</a>, 
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableInductor>Variable inductor</a>
</p>
</html>"));
end Resistor;
