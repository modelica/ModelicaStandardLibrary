within Modelica.Magnetic.QuasiStatic.FluxTubes.Basic;
model ElectroMagneticConverter "Electromagnetic energy conversion"

  constant Complex j=Complex(0, 1);
  FluxTubes.Interfaces.PositiveMagneticPort port_p "Positive magnetic port" annotation (Placement(transformation(extent={{90,90},{110,110}}), iconTransformation(extent={{90,90},{110,110}})));
  FluxTubes.Interfaces.NegativeMagneticPort port_n "Negative magnetic port" annotation (Placement(transformation(extent={{110,-110},{90,-90}}), iconTransformation(extent={{110,-110},{90,-90}})));
  Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.PositivePin pin_p
  "Positive electric pin" annotation (Placement(transformation(extent={{-90,90},{-110,110}}), iconTransformation(extent={{-90,90},{-110,110}})));
  Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.NegativePin pin_n
  "Negative electric pin"   annotation (Placement(transformation(extent={{-110,-110},{-90,-90}}), iconTransformation(extent={{-110,-110},{-90,-90}})));
  SI.ComplexVoltage v "Voltage";
  SI.ComplexCurrent i(re(start=0, stateSelect=StateSelect.prefer),
                                    im(start=0, stateSelect=StateSelect.prefer))
  "Current";
  SI.ComplexMagneticPotentialDifference V_m
  "Magnetic potential difference";
  SI.ComplexMagneticFlux Phi
  "Magnetic flux coupled into magnetic circuit";
  SI.AngularVelocity omega;

  parameter Real N=1 "Number of turns";

  //for information only:
  SI.ComplexMagneticFlux Psi
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
    Icon(coordinateSystem(
      preserveAspectRatio=false,
      extent={{-100,-100},{100,100}}), graphics={
      Line(points={{-30,100},{-30,60}},color={85,170,255}),
      Line(points={{-30,-60},{-30,-100}},color={85,170,255}),
      Line(points={{-30,100},{-90,100}},
                                       color={85,170,255}),
      Line(points={{-30,-100},{-88,-100}},
                                         color={85,170,255}),
      Ellipse(extent={{-4,-34},{64,34}}, lineColor={255,170,85}),
      Line(points={{30,-100},{30,0}},  color={255,170,85}),
      Line(points={{30,0},{30,100}}, color={255,170,85}),
      Line(points={{30,100},{90,100}},color={255,170,85}),
      Line(points={{30,-100},{90,-100}},
                                       color={255,170,85}),
      Text(
        extent={{-150,150},{150,110}},
        textString="%name",
          pattern=LinePattern.None,
          textColor={0,0,255}),
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
The electromagnetic energy conversion is given by <em>Ampere</em>'s law and <em>Faraday</em>'s law respectively:
</p>

<pre>
    V<sub>m</sub> = N * i
    N * d&Phi;/dt = -v
</pre>

<div>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Basic/converter_signs.png\" alt=\"converter signs\">
</div>

<p>
V<sub>m</sub> is the magnetic potential difference applied to the magnetic circuit due to the current i through the coil (Ampere's law).
There exists a left-hand assignment between the current i (fingers) and the magnetic potential difference V<sub>m</sub> (thumb).<br>
<strong>Note:</strong> There exists a right-hand assignment between the current through the coil i (fingers) and the magnetomotive force mmf.
The mmf has the opposite direction compared with V<sub>m</sub>. It is not used in Modelica.
</p>

<p>
For the complete magnetic circuit the sum of all magnetic potential differences counted with the correct sign in a reference direction is equal to zero: sum(V<sub>m</sub>) = 0.<br>
The magnetic flux &Phi; in each passive component is related to the magnetic potential difference V<sub>m</sub> by the equivalent of Ohms' law: V<sub>m</sub> = R<sub>m</sub> * &Phi;<br>
<strong>Note:</strong> The magnetic resistance R<sub>m</sub> depends on geometry and material properties. For ferromagnetic materials R<sub>m</sub> is not constant due to saturation.
</p>

<p>
Therefore the sign (actual direction) of &Phi; (magnetic flux through the converter) depends on the associated branch of the magnetic circuit.<br>
v is the induced voltage in the coil due to the derivative of magnetic flux &Phi; (Faraday's law).<br>
<strong>Note:</strong> The negative sign of the induced voltage v is due to <em>Lenz</em>'s law.
</p>

<p>
<strong>Note:</strong> The image shows a right-handed coil.
If a left-handed coil has to be modeled instead of a right-handed coil, the parameter N (Number of turns) can be set to a negative value.
</p>

<p>
The flux linkage &Psi; and the static inductance L_stat = |&Psi;/i| are calculated for information only. Note that L_stat is set to |&Psi;/eps| if |i| &lt; eps
(= 100*Modelica.Constants.eps).
</p>
</html>"));
end ElectroMagneticConverter;
