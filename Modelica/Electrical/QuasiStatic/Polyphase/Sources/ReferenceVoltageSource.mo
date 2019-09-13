within Modelica.Electrical.QuasiStatic.Polyphase.Sources;
model ReferenceVoltageSource
  "Variable polyphase AC voltage with reference angle input"
  extends Interfaces.ReferenceSource;
  import Modelica.Constants.pi;
  Modelica.Blocks.Interfaces.RealInput gamma
    "Reference angle of voltage source" annotation (Placement(
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
  plug_p.reference.gamma = gamma;
  v = V;
  annotation (
    defaultComponentName="voltageSource", Documentation(info="<html>

<p>
This model describes <em>m</em> variable current sources, with <em>m</em> complex signal inputs,
specifying the complex current by the complex RMS voltage components.
Additionally, the frequency of the current source is defined by a real signal input.
<em>m</em> <a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sources.VariableCurrentSource\">single-phase VariableCurrentSources</a> are used.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sources.VoltageSource\">SinglePhase.VoltageSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sources.VoltageSource\">VoltageSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sources.VariableVoltageSource\">VariableVoltageSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sources.CurrentSource\">CurrentSource</a>.
</p>
</html>"),
       Icon(graphics={
        Line(points={{-70,30},{-70,10}}, color={85,170,255}),
        Line(points={{-80,20},{-60,20}}, color={85,170,255}),
        Line(points={{60,20},{80,20}}, color={85,170,255}),
        Line(points={{-50,0},{50,0}},  color={85,170,255})}));
end ReferenceVoltageSource;
