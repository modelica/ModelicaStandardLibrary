within Modelica.Magnetic.QuasiStatic.FluxTubes.Basic;
model ElectroMagneticConverter "Electromagnetic energy conversion"

  constant Complex j=Complex(0, 1);
  FluxTubes.Interfaces.PositiveMagneticPort port_p "Positive magnetic port" annotation (Placement(transformation(extent={{90,90},{110,110}}), iconTransformation(extent={{90,90},{110,110}})));
  FluxTubes.Interfaces.NegativeMagneticPort port_n "Negative magnetic port" annotation (Placement(transformation(extent={{110,-110},{90,-90}}), iconTransformation(extent={{110,-110},{90,-90}})));
  Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.PositivePin pin_p
  "Positive electric pin" annotation (Placement(transformation(extent={{-90,90},{-110,110}}), iconTransformation(extent={{-90,90},{-110,110}})));
  Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.NegativePin pin_n
  "Negative electric pin"   annotation (Placement(transformation(extent={{-110,-110},{-90,-90}}), iconTransformation(extent={{-110,-110},{-90,-90}})));
  Modelica.SIunits.ComplexVoltage v "Voltage";
  Modelica.SIunits.ComplexCurrent i(re(start=0, stateSelect=StateSelect.prefer),
                                    im(start=0, stateSelect=StateSelect.prefer))
  "Current";
  Modelica.SIunits.ComplexMagneticPotentialDifference V_m
  "Magnetic potential difference";
  Modelica.SIunits.ComplexMagneticFlux Phi
  "Magnetic flux coupled into magnetic circuit";
  Modelica.SIunits.AngularVelocity omega;

  parameter Real N=1 "Number of turns";

  //for information only:
  Modelica.SIunits.ComplexMagneticFlux Psi
  "Flux linkage for information only";
  SI.Inductance L_stat "Static inductance abs(Psi/i) for information only";

protected
  Real eps=100*Modelica.Constants.eps;
equation
  v = pin_p.v - pin_n.v;
  Complex(0) = pin_p.i + pin_n.i;
  i = pin_p.i;

  V_m = port_p.V_m - port_n.V_m;
  Complex(0) = port_p.Phi + port_n.Phi;
  Phi = port_p.Phi;

  // Induced voltages from complex magnetic flux, number of turns
  // and angles of orientation of winding
  v = -j*omega*N*Phi;
  // Amperes law
  V_m = N*i;
  // for information only:
  Psi = N*Phi;
  // Use of abs for positive results; due to Modelica sign conventions for flow into connectors:
  L_stat = noEvent(if Modelica.ComplexMath.abs(i) > eps then Modelica.ComplexMath.abs(Psi/i) else Modelica.ComplexMath.abs(Psi/eps));

  omega = der(port_p.reference.gamma);

  // Potential roots are not used; instead the reference angle is handled
  // by means of Connections.branch between electric pin_p and magnetic port_p
  Connections.branch(port_p.reference, port_n.reference);
  port_p.reference.gamma = port_n.reference.gamma;
  Connections.branch(pin_p.reference, pin_n.reference);
  pin_p.reference.gamma = pin_n.reference.gamma;
  Connections.branch(port_p.reference, pin_p.reference);
  port_p.reference.gamma = pin_p.reference.gamma;
  annotation (
    defaultComponentName="converter",
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}})),
    Icon(coordinateSystem(
      preserveAspectRatio=false,
      extent={{-100,-100},{100,100}}), graphics={
      Line(points={{-30,100},{-30,60}},color={85,170,255}),
      Line(points={{-30,-60},{-30,-100}},color={85,170,255}),
      Line(points={{-30,100},{-90,100}},
                                       color={85,170,255}),
      Line(points={{-30,-100},{-88,-100}},
                                         color={85,170,255}),
      Line(
        points={{0,80},{-100,80}},
        color={85,170,255},
        pattern=LinePattern.Dash),
      Line(
        points={{-100,80},{-100,-80}},
        color={85,170,255},
        pattern=LinePattern.Dash),
      Line(
        points={{0,-80},{-100,-80}},
        color={85,170,255},
        pattern=LinePattern.Dash),
      Line(
        points={{100,80},{0,80}},
        color={255,170,85},
        pattern=LinePattern.Dash),
      Line(
        points={{100,-80},{0,-80}},
        color={255,170,85},
        pattern=LinePattern.Dash),
      Line(
        points={{100,80},{100,-80}},
        color={255,170,85},
        pattern=LinePattern.Dash),
      Ellipse(extent={{-4,-34},{64,34}}, lineColor={255,170,85}),
      Line(points={{30,-100},{30,-34}},color={255,170,85}),
      Line(points={{18,0},{42,0}}, color={255,170,85}),
      Line(points={{42,10},{42,-12}}, color={255,170,85}),
      Line(points={{30,34},{30,100}},color={255,170,85}),
      Line(points={{30,100},{90,100}},color={255,170,85}),
      Line(points={{30,-100},{90,-100}},
                                       color={255,170,85}),
      Text(
        extent={{-150,150},{150,110}},
        textString="%name",
          pattern=LinePattern.None,
          textColor={0,0,255}),
      Line(points={{18,10},{18,-12}}, color={255,170,85}),
      Line(points={{-110,30},{-110,-30}},
                                        color={85,170,255}),
      Polygon(
        points={{-110,-30},{-104,-10},{-116,-10},{-110,-30}},
        lineColor={85,170,255},
        fillColor={85,170,255},
        fillPattern=FillPattern.Solid),
      Line(points={{110,30},{110,-30}},
                                      color={255,170,85}),
      Polygon(
          points={{110,-30},{116,-10},{104,-10},{110,-30}},
          lineColor={255,170,85},
          fillColor={255,170,85},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}},
          color={85,170,255},
          smooth=Smooth.Bezier,
          origin={-23,45},
          rotation=270),
        Line(
          points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}},
          color={85,170,255},
          smooth=Smooth.Bezier,
          origin={-23,15},
          rotation=270),
        Line(
          points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}},
          color={85,170,255},
          smooth=Smooth.Bezier,
          origin={-23,-15},
          rotation=270),
        Line(
          points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}},
          color={85,170,255},
          smooth=Smooth.Bezier,
          origin={-23,-45},
          rotation=270)}),
    Documentation(info="<html>
<p>
The electromagnetic energy conversion is given by <strong>Ampere</strong>'s law and <strong>Faraday</strong>'s law respectively:
</p>

<dl>
<dd>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/converter.png\">
</dd>
</dl>

<p>
In this equation
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/V_m.png\">
is the magnetomotive force that is supplied to the connected magnetic circuit,
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/Phi.png\">
is the magnetic flux through the associated branch of this magnetic circuit. The negative sign of the induced voltage
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/v.png\"> is due to <strong>Lenz</strong>'s law.
</p>

<p>
The static inductance is calculated from the flux linkage
</p>
<dl>
<dd>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/Psi-N-Phi.png\">
</dd>
</dl>
<p>and the current
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/i.png\">:
</p>
<dl>
<dd>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/L_stat-Psi-i.png\">
</dd>
</dl>
<p>
This quantity is calculated for information only.</p>

<h5>Note</h5>

<p><img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/L_stat.png\">
is set to</p>
<dl>
<dd>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/L_stat-Psi-eps.png\">
</dd>
</dl>
<p>
if
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/i-lt-eps.png\">.
</p></html>"));
end ElectroMagneticConverter;
