within Modelica.Electrical.QuasiStationary.MultiPhase.Sources;
model VariableCurrentSource
  extends Interfaces.Source;
  SinglePhase.Sources.VariableCurrentSource variableCurrentSource[
                          m]
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealInput f
    annotation (Placement(transformation(
        origin={40,100},
        extent={{-20,-20},{20,20}},
        rotation=270)));
  Modelica.ComplexBlocks.Interfaces.ComplexInput I[m]
    annotation (Placement(transformation(
        origin={-40,100},
        extent={{-20,-20},{20,20}},
        rotation=270)));
equation
  for j in 1:m loop
    connect(f, variableCurrentSource[j].f)
      annotation (Line(points={{40,100},{40,60},{4,60},{4,10}}, color={0,0,127}));
  end for;
  connect(plugToPins_p.pin_p, variableCurrentSource.pin_p)
    annotation (Line(points={{-68,0},{-53.5,0},{-53.5,1.22125e-015},{-39,1.22125e-015},
          {-39,0},{-10,0}},
        color={85,170,255}));
  connect(variableCurrentSource.pin_n, plugToPins_n.pin_n)
    annotation (Line(points={{10,0},{39,0},{39,2.44929e-016},{68,2.44929e-016}},
                                            color={85,170,255}));
  connect(I, variableCurrentSource.I) annotation (Line(points={{-40,100},{-40,
          60},{-4,60},{-4,10}}, color={85,170,255}));
  annotation (Icon(graphics={
        Line(points={{-60,60},{60,60}}, color={85,170,255}),
        Polygon(
          points={{60,60},{30,70},{30,50},{60,60}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Line(points={{0,-50},{0,50}}, color={0,0,0})}),
      Diagram(graphics),
  Documentation(info="<html>

<p>
This model describes <i>m</i> variable current sources, with <i>m</i> complex signal inputs,
specifying the complex current by the complex RMS voltage components.
Additionally, the frequency of the current source is defined by a real signal input.
<i>m</i> <a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VariableCurrentSource\">single phase VariableCurrentSources</a> are used.
</p>

<h4>See also</h4>

<p>
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VoltageSource\">SinglePhase.VoltageSource</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sources.VoltageSource\">VoltageSource</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sources.VariableVoltageSource\">VariableVoltageSource</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sources.CurrentSource\">CurrentSource</a>.
</p>
</html>"));
end VariableCurrentSource;
