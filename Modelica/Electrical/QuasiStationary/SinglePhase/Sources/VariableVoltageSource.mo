within Modelica.Electrical.QuasiStationary.SinglePhase.Sources;
model VariableVoltageSource "Variable AC voltage"
  extends QuasiStationary.SinglePhase.Interfaces.Source;
  Modelica.Blocks.Interfaces.RealInput f
    annotation (Placement(transformation(
        origin={40,100},
        extent={{-20,-20},{20,20}},
        rotation=270)));
  Modelica.ComplexBlocks.Interfaces.ComplexInput V
    annotation (Placement(transformation(
        origin={-40,100},
        extent={{-20,-20},{20,20}},
        rotation=270)));
equation
  omega = 2*Modelica.Constants.pi*f;
  v = V;
  annotation (Icon(graphics={
        Text(
          extent={{-120,50},{-20,0}},
          lineColor={0,0,255},
          textString=
                  "+"),
        Text(
          extent={{20,50},{120,0}},
          lineColor={0,0,255},
          textString=
                  "-"),
        Line(points={{50,0},{-50,0}}, color={0,0,0})}),
      Diagram(graphics),
    Documentation(info="<html>

<p>
This is a voltage source with a complex signal input, specifying the complex voltage by the complex RMS voltage components.
Additionally, the frequency of the voltage source is defined by a real signal input.
</p>

<h4>See also</h4>

<p>
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VoltageSource\">VoltageSource</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sources.CurrentSource\">CurrentSource</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VariableCurrentSource\">VariableCurrentSource</a>
</p>
</html>"));
end VariableVoltageSource;
