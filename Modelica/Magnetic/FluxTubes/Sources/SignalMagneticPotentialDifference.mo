within Modelica.Magnetic.FluxTubes.Sources;
model SignalMagneticPotentialDifference
  "Signal-controlled magnetomotive force"

  extends Interfaces.TwoPortElementary;
  Modelica.Blocks.Interfaces.RealInput V_m(unit="A")
    "Magnetic potential difference"
    annotation (Placement(transformation(
        origin={0,110},
        extent={{10,-10},{-10,10}},
        rotation=90), iconTransformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={0,110})));
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
      Line(points={{-100,0},{-50,0}}, color={255,127,0}),
      Line(points={{50,0},{100,0}}, color={255,127,0}),
      Text(
        extent={{-150,50},{150,90}},
        textString="%name",
        textColor={0,0,255}),
      Ellipse(
        extent={{-50,-50},{50,50}},
        lineColor={255,127,0},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
      Line(points={{-50,0},{50,0}}, color={255,127,0}),
        Line(points={{-70,30},{-70,10}}, color={255,128,0}),
        Line(points={{-80,20},{-60,20}}, color={255,128,0}),
        Line(points={{60,20},{80,20}}, color={255,128,0})}),
    Documentation(info="<html>
<p>
In electromagnetic devices, a change of a coil's magnetic flux linkage &Psi; reacts on the electrical subsystem in that a voltage v is induced due to <em>Faraday</em>'s law:
</p>
<blockquote><pre>
v = - d&Psi;/dt
</pre></blockquote>
<p>This reaction can possibly be neglected for</p>
<ul>
<li>modelling of electromagnetic actuators under quasi-static conditions (slow current change, slow armature motion),</li>
<li>modelling of current-controlled electromagnetic actuators (ideal current source) and</li>
<li>for system simulation where the system dynamics is not governed by an electromagnetic actuator, but by the surrounding subsystems.</li>
</ul>
<p>
In these cases, the magnetic potential difference or magnetomotive force imposed by a coil can easily be modelled with a signal-controlled source. Except for the neglected dynamics, steady-state actuator forces will be calculated properly in actuator models based on these sources.
</p>
</html>"));
end SignalMagneticPotentialDifference;
