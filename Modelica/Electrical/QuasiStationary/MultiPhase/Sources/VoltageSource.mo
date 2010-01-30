within Modelica.Electrical.QuasiStationary.MultiPhase.Sources;
model VoltageSource
  extends Interfaces.Source;
  parameter Modelica.SIunits.Frequency f(start=1) "frequency of the source";
  parameter Modelica.SIunits.Voltage V[m](start=fill(1,m))
    "RMS voltage of the source";
  parameter Modelica.SIunits.Angle phi[m]={0 - (j-1)*2*pi/m for j in 1:m}
    "phase shift of the source";
  SinglePhase.Sources.VoltageSource voltageSource[m](
    each final f=f,
    final V=V,
    final phi=phi) 
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=0)));
equation
  connect(plugToPins_p.pin_p, voltageSource.pin_p) 
    annotation (Line(points={{-68,6.10623e-016},{-53.5,6.10623e-016},{-53.5,
          1.22125e-015},{-39,1.22125e-015},{-39,0},{-10,0}}, color={85,170,255}));
  connect(voltageSource.pin_n, plugToPins_n.pin_n) annotation (Line(points={{10,
          6.10623e-016},{39,6.10623e-016},{39,7.44522e-016},{68,7.44522e-016}},
        color={85,170,255}));
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
This model describes <i>m</i> constant voltage sources, specifying the complex voltages by the RMS voltages and the phase shifts. 
<i>m</i> <a href=\"Modelica://Modelica_QuasiStationary.SinglePhase.Sources.VoltageSource\">single phase VoltageSources</a> are used.
</p>

<h4>See also</h4>

<p>
<a href=\"Modelica://Modelica_QuasiStationary.SinglePhase.Sources.VoltageSource\">SinglePhase.VoltageSource</a>,
<a href=\"Modelica://Modelica_QuasiStationary.MultiPhase.Sources.VariableVoltageSource\">VariableVoltageSource</a>, 
<a href=\"Modelica://Modelica_QuasiStationary.MultiPhase.Sources.CurrentSource\">CurrentSource</a>,
<a href=\"Modelica://Modelica_QuasiStationary.MultiPhase.Sources.VariableCurrentSource\">VariableCurrentSource</a>
</p>
</html>"));
end VoltageSource;
