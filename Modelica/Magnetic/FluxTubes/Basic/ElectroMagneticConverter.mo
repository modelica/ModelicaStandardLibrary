within Modelica.Magnetic.FluxTubes.Basic;
model ElectroMagneticConverter "Ideal electromagnetic energy conversion"

  FluxTubes.Interfaces.PositiveMagneticPort port_p "Positive magnetic port"
    annotation (Placement(transformation(extent={{90,90},{110,110}}), iconTransformation(extent={{90,90},{110,110}})));
  FluxTubes.Interfaces.NegativeMagneticPort port_n "Negative magnetic port"
    annotation (Placement(transformation(extent={{110,-110},{90,-90}}), iconTransformation(extent={{110,-110},{90,-90}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin p "Positive electrical pin"
    annotation (Placement(transformation(extent={{-90,90},{-110,110}}), iconTransformation(extent={{-90,90},{-110,110}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin n "Negative electrical pin"
    annotation (Placement(transformation(extent={{-110,-110},{-90,-90}}), iconTransformation(extent={{-110,-110},{-90,-90}})));
  SI.Voltage v "Voltage";
  SI.Current i(start=0, stateSelect=StateSelect.prefer) "Current";
  SI.MagneticPotentialDifference V_m "Magnetic potential difference";
  SI.MagneticFlux Phi "Magnetic flux coupled into magnetic circuit";

  parameter Real N=1 "Number of turns";

  // For information only:
  SI.MagneticFlux Psi "Flux linkage";
  SI.Inductance L_stat "Static inductance abs(Psi/i)";

protected
  Real eps=100*Modelica.Constants.eps;
equation
  v = p.v - n.v;
  0 = p.i + n.i;
  i = p.i;

  V_m = port_p.V_m - port_n.V_m;
  0 = port_p.Phi + port_n.Phi;
  Phi = port_p.Phi;

  // Converter equations
  V_m = i*N "Ampere's law";
  N*der(Phi) = -v "Faraday's law";

  // For information only
  Psi = N*Phi;
  // Use of abs() for positive results; due to Modelica sign conventions for flow into connectors
  L_stat = noEvent(if abs(i) > eps then abs(Psi/i) else abs(Psi/eps));

  annotation (
    defaultComponentName="converter",
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}}), graphics={Polygon(
              points={{-134,63},{-124,60},{-134,57},{-134,63}},
              lineColor={160,160,164},
              fillColor={160,160,164},
              fillPattern=FillPattern.Solid),Line(points={{-150,60},{-125,
          60}}, color={160,160,164}),Polygon(
              points={{141,-57},{151,-60},{141,-63},{141,-57}},
              lineColor={160,160,164},
              fillColor={160,160,164},
              fillPattern=FillPattern.Solid),Line(points={{125,-60},{150,-60}},
          color={160,160,164}),Text(
              extent={{128,-56},{144,-41}},
              textColor={160,160,164},
              textString="Phi"),Text(
              extent={{128,64},{145,79}},
              textString="Phi"),Line(points={{-150,-59},{-125,-59}}, color=
          {160,160,164}),Polygon(
              points={{-140,-56},{-150,-59},{-140,-62},{-140,-56}},
              lineColor={160,160,164},
              fillColor={160,160,164},
              fillPattern=FillPattern.Solid),Text(
              extent={{-141,-56},{-124,-41}},
              textColor={160,160,164},
              textString="i"),Text(
              extent={{-150,63},{-133,78}},
              textColor={160,160,164},
              textString="i"),Line(points={{124,61},{149,61}}, color={160,160,164}),
          Polygon(
              points={{134,64},{124,61},{134,58},{134,64}},
              lineColor={160,160,164},
              fillColor={160,160,164},
              fillPattern=FillPattern.Solid)}),
    Icon(coordinateSystem(
      preserveAspectRatio=false,
      extent={{-100,-100},{100,100}}), graphics={
      Text(
        extent={{-150,150},{150,110}},
        textColor={0,0,255},
        textString="%name"),
        Line(points={{-30,100},{-90,100}},
                                         color={0,0,255}),
        Line(points={{-30,-100},{-90,-100}},
                                           color={0,0,255}),
        Ellipse(extent={{-4,-34},{64,34}}, lineColor={255,127,0}),
        Line(points={{30,-100},{30,0}},  color={255,127,0}),
        Line(points={{30,0},{30,100}}, color={255,127,0}),
        Line(points={{30,100},{90,100}},color={255,127,0}),
        Line(points={{30,-100},{90,-100}},
                                         color={255,127,0}),
        Text(
          extent={{-150,150},{150,110}},
          textColor={0,0,255},
          textString="%name"),
        Line(
          points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}},
          color={0,0,255},
          smooth=Smooth.Bezier,
          origin={-23,45},
          rotation=270),
        Line(
          points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}},
          color={0,0,255},
          smooth=Smooth.Bezier,
          origin={-23,15},
          rotation=270),
        Line(
          points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}},
          color={0,0,255},
          smooth=Smooth.Bezier,
          origin={-23,-15},
          rotation=270),
        Line(
          points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}},
          color={0,0,255},
          smooth=Smooth.Bezier,
          origin={-23,-45},
          rotation=270),
        Line(points={{-30,60},{-30,100}}, color={28,108,200}),
        Line(points={{-30,-100},{-30,-60}}, color={28,108,200})}),
    Documentation(info="<html>
<p>
The electromagnetic energy conversion is given by <em>Ampere</em>'s law and <em>Faraday</em>'s law respectively:
</p>

<blockquote><pre>
V_m = i * N
N * d&Phi;/dt = -v
</pre></blockquote>

<p>
V_m is the magnetomotive force that is supplied to the connected magnetic circuit, &Phi; is the magnetic flux through the associated branch of this magnetic circuit. 
The negative sign of the induced voltage v is due to <em>Lenz</em>'s law.
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Basic/AmperesLaw.png\" alt=\"Ampere's Law\">
</p>

<p>
Ampere's law relates the terms <em>magnetomotive force</em> and <em>magnetic voltage</em>. 
This is a similar situation as with the relation of the electromotive force and the electric voltage in Kirchhoff's law. 
With these terms the two laws are:
</p>

<ul>
<li>Ampere's law: F = sum(V_m): 
The sum of all magnetomotive forces counted with the correct sign in a reference direction is equal to the sum of all magnetic voltages counted in the same reference direction</li>
<li>Kirchhoff's law: E = sum(v): 
The sum of all electromotive forces counted with the correct sign in a reference direction is equal to the sum of all electric voltages counted in the same reference direction</li>
</ul>

<p>
Modelica can neither treat magnetomotive nor electromotive forces directly in interconnected equivalent circuits. Instead the two laws are applied in a different way:
</p>

<ul>
<li>Ampere's law: sum(V_m) = 0: 
The sum of all magnetic voltages counted with the correct sign in a reference direction is equal to zero</li>
<li>Kirchhoff's law: sum(v) = 0: 
The sum of all electric voltages counted with the correct sign in a reference direction is equal to zero</li>
</ul>

<p>
Therefore each magnetomotive and electromotive is converted into an equivalent magnetic and electric voltage, respectively. 
In a magnetic circuit the electromotive force N * I is modeled as a magnetic voltage source V_mF oriented from plus to minus in the figure above.
Therefore, there exists a
</p>

<ul>
<li>right-hand assignment between the magnetomotive force F (thumb) and the current I (fingers) -- which is true but not implemented in Modelica --, but a</li>
<li>left-hand assignment between the magnetic voltage of the source, V_mF (thumb) and the current I (fingers) -- which is implemented in Modelica.</li>
</ul>

<p>
If a left-handed coil has to be modeled instead of a right-handed coil, the parameter N (Number of turns) can be set to a negative value.
</p>

<p>
The flux linkage &Psi; and the static inductance L_stat = |&Psi;/i| are calculated for information only. Note that L_stat is set to |&Psi;/eps| if |i| &lt; eps
(= 100*Modelica.Constants.eps).
</p>
</html>"));
end ElectroMagneticConverter;
