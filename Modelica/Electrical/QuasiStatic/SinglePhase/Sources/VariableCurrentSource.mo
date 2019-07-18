within Modelica.Electrical.QuasiStatic.SinglePhase.Sources;
model VariableCurrentSource "Variable AC current"
  extends Interfaces.Source;
  Modelica.Blocks.Interfaces.RealInput f(unit="Hz") annotation (Placement(
        transformation(
        origin={60,120},
        extent={{-20,-20},{20,20}},
        rotation=270)));
  Modelica.ComplexBlocks.Interfaces.ComplexInput I annotation (Placement(
        transformation(
        origin={-60,120},
        extent={{-20,-20},{20,20}},
        rotation=270)));
equation
  omega = 2*Modelica.Constants.pi*f;
  i = I;
  annotation (defaultComponentName="currentSource",
    Icon(graphics={Line(points={{0,50},{0,-50}}, color={85,170,255}),
        Polygon(
          points={{90,0},{60,10},{60,-10},{90,0}},
          lineColor={85,170,255},
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid)}), Documentation(info="<html>

<p>
This is a current source with a complex signal input, specifying the complex current by the complex RMS current components.
Additionally, the frequency of the voltage source is defined by a real signal input.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sources.VoltageSource\">VoltageSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sources.VariableVoltageSource\">VariableVoltageSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sources.CurrentSource\">CurrentSource</a>,
</p>
</html>"));
end VariableCurrentSource;
