within Modelica.Electrical.QuasiStationary.SinglePhase.Sources;
model VariableCurrentSource "Variable AC current"
  extends QuasiStationary.SinglePhase.Interfaces.Source;
  Modelica.Blocks.Interfaces.RealInput f 
    annotation (Placement(transformation(
        origin={40,100},
        extent={{-20,-20},{20,20}},
        rotation=270)));
  Modelica.ComplexBlocks.Interfaces.ComplexInput I 
    annotation (Placement(transformation(
        origin={-40,100},
        extent={{-20,-20},{20,20}},
        rotation=270)));
equation
  omega = 2*Modelica.Constants.pi*f;
  i = I;
  annotation (Icon(graphics={
        Line(points={{0,-50},{0,50}}, color={0,0,0}),
        Line(points={{-60,60},{60,60}}, color={0,0,255}),
        Polygon(
          points={{60,60},{30,70},{30,50},{60,60}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid)}),
      Diagram(graphics),
  Documentation(info="<html>

<p>
This is a current source with a complex signal input, specifying the complex current by the complex RMS current components. 
Additionally, the frequency of the voltage source is defined by a real signal input.
</p>

<h4>See also</h4>

<p>
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VoltageSource\">VoltageSource</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VariableVoltageSource\">VariableVoltageSource</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sources.CurrentSource\">CurrentSource</a>,
</p>
</html>"));
end VariableCurrentSource;
