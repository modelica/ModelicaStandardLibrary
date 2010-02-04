within Modelica.Electrical.QuasiStationary.SinglePhase.Basic;
model VariableConductor "Singlephase variable conductor"
  extends Interfaces.OnePort;
  import Modelica.ComplexMath.real;
  import Modelica.ComplexMath.conj;
  parameter Modelica.SIunits.Temperature T_ref=293.15 "Reference temperature";
  parameter Modelica.SIunits.LinearTemperatureCoefficient alpha_ref=0
    "Temperature coefficient of conductance (G_actual = G_ref/(1 + alpha_ref*(heatPort.T - T_ref))";
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(T = T_ref);
  Modelica.SIunits.Conductance G_actual
    "Conductance = G_ref/(1 + alpha_ref*(heatPort.T - T_ref))";
  Modelica.Blocks.Interfaces.RealInput G_ref
    annotation (Placement(transformation(
        origin={0,110},
        extent={{-20,-20},{20,20}},
        rotation=270)));
equation
  assert((1 + alpha_ref*(T_heatPort - T_ref)) >= Modelica.Constants.eps, "Temperature outside scope of model!");
  G_actual = G_ref/(1 + alpha_ref*(T_heatPort - T_ref));
  i = G_actual*v;
  LossPower = real(v*conj(i));
  annotation (Icon(graphics={
        Text(extent={{100,-80},{-100,-40}}, textString=
                                               "%name"),
        Line(points={{60,0},{90,0}}),
        Line(points={{-90,0},{-60,0}}),
        Rectangle(
          extent={{-70,30},{70,-30}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{0,90},{0,30}},
          color={0,0,255},
          smooth=Smooth.None)}),
                       Diagram(graphics),
    Documentation(info="<html>

<p>
The linear conductor connects the voltage <i><u>v</u></i> with the
current <i><u>i</u></i> by <i><u>i</u> = G*<u>v</u></i>.
The conductance <i>G</i> is given as input signal.
</p>

<p>
The variable conductor model also has an optional
<a href=\"Modelica://Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort\">conditional heat port</a>.
A linear temperature dependency of the resistance for an enabled heat port is also taken into account.
</p>

<h4>See also</h4>
<p>
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Resistor>Resistor</a>,
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Conductor>Conductor</a>,
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Capacitor>Capacitor</a>,
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Inductor>Inductor</a>,
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableResistor>Variable resistor</a>,
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableCapacitor>Variable capacitor</a>,
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableInductor>Variable inductor</a>
</p>
</html>"));
end VariableConductor;
