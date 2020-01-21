within Modelica.Electrical.QuasiStatic.Polyphase.Sources;
model VariableVoltageSource "Variable polyphase AC voltage"
  extends Interfaces.Source;
  Modelica.Blocks.Interfaces.RealInput f(unit="Hz") annotation (Placement(
        transformation(
        origin={60,120},
        extent={{-20,-20},{20,20}},
        rotation=270)));
  Modelica.ComplexBlocks.Interfaces.ComplexInput V[m] annotation (Placement(
        transformation(
        origin={-60,120},
        extent={{-20,-20},{20,20}},
        rotation=270)));
equation
  omega = 2*Modelica.Constants.pi*f;
  v = V;
  annotation (defaultComponentName="voltageSource",
    Icon(graphics={
        Line(points={{-50,0},{50,0}}, color={85,170,255}),
        Line(points={{-70,30},{-70,10}}, color={85,170,255}),
        Line(points={{-80,20},{-60,20}}, color={85,170,255}),
        Line(points={{60,20},{80,20}}, color={85,170,255})}),
                                 Documentation(info="<html>

<p>
This model describes <em>m</em> variable voltage sources, with <em>m</em> complex signal inputs,
specifying the complex voltages by the complex RMS voltage components.
Additionally, the frequency of the voltage source is defined by a real signal input.
<em>m</em> <a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sources.VariableVoltageSource\">single-phase VariableVoltageSources</a> are used.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sources.VoltageSource\">SinglePhase.VoltageSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sources.VoltageSource\">VoltageSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sources.CurrentSource\">CurrentSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sources.VariableCurrentSource\">VariableCurrentSource</a>
</p>
</html>"));
end VariableVoltageSource;
