within Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces;
partial model Source "Partial voltage / current source"
  extends TwoPlug;
  constant Modelica.SIunits.Angle pi=Modelica.Constants.pi;
  annotation (Icon(graphics={
        Ellipse(
          extent={{-50,50},{50,-50}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(extent={{100,-100},{-100,-60}}, textString=
                                               "%name"),
        Line(points={{-90,0},{-50,0}}, color={0,0,0}),
        Line(points={{50,0},{90,0}}, color={0,0,0}),
        Text(
          extent={{100,60},{-100,100}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString=
               "m=%m")}),          Diagram(graphics),
  Documentation(info="<html>
<p>
The source partial model relies on the
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.TwoPlug\">TwoPlug</a> and contains a proper icon.
</p>

<h4>See also</h4>

<p>
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sources.VoltageSource\">VoltageSource</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sources.VariableVoltageSource\">VariableVoltageSource</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sources.CurrentSource\">CurrentSource</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.MutliPhase.Sources.VariableCurrentSource\">VariableCurrentSource</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.Source\">SinglePhase.Interfaces.Source</a>.
</p>
</html>"));
end Source;
