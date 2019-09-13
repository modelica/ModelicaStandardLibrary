within Modelica.Electrical.QuasiStatic.SinglePhase.Sources;
model VariableVoltageSource "Variable AC voltage"
  extends Interfaces.Source;
  Modelica.Blocks.Interfaces.RealInput f(unit="Hz") annotation (Placement(
        transformation(
        origin={60,120},
        extent={{-20,-20},{20,20}},
        rotation=270)));
  Modelica.ComplexBlocks.Interfaces.ComplexInput V annotation (Placement(
        transformation(
        origin={-60,120},
        extent={{-20,-20},{20,20}},
        rotation=270)));
equation
  omega = 2*Modelica.Constants.pi*f;
  v = V;
  annotation (defaultComponentName="voltageSource",
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={
        Line(points={{-50,0},{50,0}}, color={85,170,255}),
        Line(points={{-70,30},{-70,10}}, color={85,170,255}),
        Line(points={{-80,20},{-60,20}}, color={85,170,255}),
        Line(points={{60,20},{80,20}}, color={85,170,255})}),
                                         Documentation(info="<html>

<p>
This is a voltage source with a complex signal input, specifying the complex voltage by the complex RMS voltage components.
Additionally, the frequency of the voltage source is defined by a real signal input.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sources.VoltageSource\">VoltageSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sources.CurrentSource\">CurrentSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sources.VariableCurrentSource\">VariableCurrentSource</a>
</p>
</html>"));
end VariableVoltageSource;
