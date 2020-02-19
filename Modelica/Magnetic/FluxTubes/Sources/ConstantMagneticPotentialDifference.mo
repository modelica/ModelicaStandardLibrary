within Modelica.Magnetic.FluxTubes.Sources;
model ConstantMagneticPotentialDifference "Constant magnetomotive force"

  extends Interfaces.TwoPortElementary;
  parameter SI.MagneticPotentialDifference V_m
    "Magnetic potential difference";
  SI.MagneticFlux Phi "Magnetic flux from port_p to port_n";

equation
  V_m = port_p.V_m - port_n.V_m;
  Phi = port_p.Phi;
  0 = port_p.Phi + port_n.Phi;

  annotation (
    defaultComponentName="magVoltageSource",
    Icon(coordinateSystem(
      preserveAspectRatio=false,
      extent={{-100,-100},{100,100}}), graphics={
      Ellipse(
        extent={{-50,-50},{50,50}},
        lineColor={255,127,0},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
      Line(points={{100,0},{50,0}}, color={255,127,0}),
      Line(points={{-50,0},{-100,0}}, color={255,127,0}),
      Text(
        extent={{-150,60},{150,100}},
        textString="%name",
        textColor={0,0,255}),
      Line(points={{-50,0},{50,0}}, color={255,127,0}),
        Line(points={{-70,30},{-70,10}}, color={255,128,0}),
        Line(points={{-80,20},{-60,20}}, color={255,128,0}),
        Line(points={{60,20},{80,20}}, color={255,128,0})}),
    Documentation(info="<html>
<p>
Magnetic circuits under steady-state conditions, i.e., with stationary magnetic fields (change of magnetic flux  d&Phi;/dt = 0) can be described with constant sources of a magnetic potential difference or magnetomotive force (mmf). Constant magnetic potential differences are imposed by
</p>
<ul>
<li>coils with stationary current (di / dt = 0) and</li>
<li>permanent magnets modelled with <em>Th&eacute;venin</em>'s equivalent magnetic circuit.</li>
</ul>
<p>
For modelling of reluctance actuators with this source component it is assumed that the armature is fixed so that no motion-induced flux change d&Phi;/dt can occur.
</p>
</html>"));
end ConstantMagneticPotentialDifference;
