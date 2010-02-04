within Modelica.Electrical.QuasiStationary.MultiPhase.Sources;
model CurrentSource
  extends Interfaces.Source;
  parameter Modelica.SIunits.Frequency f(start=1) "frequency of the source";
  parameter Modelica.SIunits.Current I[m](start=fill(1,m))
    "RMS current of the source";
  parameter Modelica.SIunits.Angle phi[m]={0 - (j-1)*2*pi/m for j in 1:m}
    "phase shift of the source";
  SinglePhase.Sources.CurrentSource currentSource[m](
    each final f=f,
    final phi=phi,
    final I=I)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=0)));
equation
  connect(plugToPins_p.pin_p,currentSource. pin_p)
    annotation (Line(points={{-68,0},{-10,0}}, color={85,170,255}));
  connect(currentSource.pin_n, plugToPins_n.pin_n) annotation (Line(points={{10,0},{
          39,0},{39,2.44929e-016},{68,2.44929e-016}},     color={85,170,255}));
  annotation (Icon(graphics={
        Line(points={{-60,60},{60,60}}, color={0,0,255}),
        Polygon(
          points={{60,60},{30,70},{30,50},{60,60}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Line(points={{0,-50},{0,50}}, color={0,0,0})}),              Diagram(graphics),
  Documentation(info="<html>

<p>
This model describes <i>m</i> constant current sources, specifying the complex currents by the RMS currents and the phase shifts.
<i>m</i> <a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sources.CurrentSource\">single phase CurrentSources</a> are used.
</p>

<h4>See also</h4>

<p>
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sources.CurrentSource\">SinglePhase.CurrentSource</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sources.VoltageSource\">VoltageSource</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sources.VariableVoltageSource\">VariableVoltageSource</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sources.VariableCurrentSource\">VariableCurrentSource</a>
</p>
</html>"));
end CurrentSource;
