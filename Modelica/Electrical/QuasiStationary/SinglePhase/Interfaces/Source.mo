within Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces;
partial model Source "Partial voltage / current source"
  extends OnePort;
equation
  Connections.root(pin_p.reference);
  annotation (Icon(graphics={
        Ellipse(
          extent={{-50,50},{50,-50}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(extent={{100,-100},{-100,-60}}, textString=
                                               "%name"),
        Line(points={{-90,0},{-50,0}}, color={0,0,0}),
        Line(points={{50,0},{90,0}}, color={0,0,0})}),               Diagram(graphics),
  Documentation(info="<html>
<p>
The source partial model relies on the 
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.OnePort\">OnePort</a> and contains a proper icon. 
</p>

<h4>See also</h4>

<p>
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VoltageSource\">VoltageSource</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VariableVoltageSource\">VariableVoltageSource</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sources.CurrentSource\">CurrentSource</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VariableCurrentSource\">VariableCurrentSource</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.Source\">MultiPhase.Interfaces.Source</a>.
</p>
</html>"));
end Source;
