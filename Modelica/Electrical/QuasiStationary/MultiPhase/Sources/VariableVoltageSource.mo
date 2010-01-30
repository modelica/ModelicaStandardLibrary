within Modelica.Electrical.QuasiStationary.MultiPhase.Sources;
model VariableVoltageSource
  extends Interfaces.Source;
  SinglePhase.Sources.VariableVoltageSource variableVoltageSource[
                          m] 
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealInput f 
    annotation (Placement(transformation(
        origin={40,100},
        extent={{-20,-20},{20,20}},
        rotation=270)));
  Blocks.Interfaces.ComplexInput V[m] 
    annotation (Placement(transformation(
        origin={-40,100},
        extent={{-20,-20},{20,20}},
        rotation=270)));
equation
  for j in 1:m loop
    connect(f, variableVoltageSource[j].f) 
      annotation (Line(points={{40,100},{40,60},{4,60},{4,10}}, color={0,0,127}));
  end for;
  connect(plugToPins_p.pin_p, variableVoltageSource.pin_p) 
    annotation (Line(points={{-68,6.10623e-016},{-53.5,6.10623e-016},{-53.5,
          1.22125e-015},{-39,1.22125e-015},{-39,0},{-10,0}}, color={85,170,255}));
  connect(variableVoltageSource.pin_n, plugToPins_n.pin_n) 
    annotation (Line(points={{10,6.10623e-016},{39,6.10623e-016},{39,
          7.44522e-016},{68,7.44522e-016}}, color={85,170,255}));
  connect(V, variableVoltageSource.V) 
    annotation (Line(points={{-40,100},{-40,60},{-4,60},{-4,10}}, color={85,170,
          255}));
  annotation (Icon(graphics={
        Line(points={{50,0},{-50,0}}, color={0,0,0}),
        Text(
          extent={{-120,50},{-20,0}},
          lineColor={0,0,255},
          textString=
                  "+"),
        Text(
          extent={{20,50},{120,0}},
          lineColor={0,0,255},
          textString=
                  "-")}),                                            Diagram(graphics),
  Documentation(info="<html>

<p>
This model describes <i>m</i> variable voltage sources, with <i>m</i> complex signal inputs, 
specifying the complex voltages by the complex RMS voltage components. 
Additionally, the frequency of the voltage source is defined by a real signal input. 
<i>m</i> <a href=\"Modelica://Modelica_QuasiStationary.SinglePhase.Sources.VariableVoltageSource\">single phase VariableVoltageSources</a> are used.
</p>

<h4>See also</h4>

<p>
<a href=\"Modelica://Modelica_QuasiStationary.SinglePhase.Sources.VoltageSource\">SinglePhase.VoltageSource</a>,
<a href=\"Modelica://Modelica_QuasiStationary.MultiPhase.Sources.VoltageSource\">VoltageSource</a>, 
<a href=\"Modelica://Modelica_QuasiStationary.MultiPhase.Sources.CurrentSource\">CurrentSource</a>,
<a href=\"Modelica://Modelica_QuasiStationary.MultiPhase.Sources.VariableCurrentSource\">VariableCurrentSource</a>
</p>
</html>"));
end VariableVoltageSource;
