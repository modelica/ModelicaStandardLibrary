within Modelica.Electrical.QuasiStatic.Polyphase.Sources;
model VariableCurrentSource "Variable polyphase AC current"
  extends Interfaces.Source;
  Modelica.Blocks.Interfaces.RealInput f(unit="Hz") annotation (Placement(
        transformation(
        origin={40,100},
        extent={{-20,-20},{20,20}},
        rotation=270), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={60,120})));
  Modelica.ComplexBlocks.Interfaces.ComplexInput I[m] annotation (Placement(
        transformation(
        origin={-40,100},
        extent={{-20,-20},{20,20}},
        rotation=270), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-60,120})));
equation
  omega = 2*Modelica.Constants.pi*f;
  i = I;
  annotation (defaultComponentName="currentSource",
    Icon(graphics={Line(points={{0,-50},{0,50}}, color={85,170,255}),
        Polygon(
          points={{90,0},{60,10},{60,-10},{90,0}},
          lineColor={85,170,255},
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid)}), Documentation(info="<html>

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
</html>"));
end VariableCurrentSource;
