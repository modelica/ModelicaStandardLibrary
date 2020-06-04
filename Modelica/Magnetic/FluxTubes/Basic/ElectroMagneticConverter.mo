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
              points={{-136,103},{-126,100},{-136,97},{-136,103}},
              lineColor={160,160,164},
              fillColor={160,160,164},
              fillPattern=FillPattern.Solid),Line(points={{-152,100},{-127,100}},
                color={160,160,164}),Polygon(
              points={{143,-97},{153,-100},{143,-103},{143,-97}},
              lineColor={160,160,164},
              fillColor={160,160,164},
              fillPattern=FillPattern.Solid),Line(points={{127,-100},{152,-100}},
          color={160,160,164}),Text(
              extent={{130,-96},{146,-81}},
              textColor={160,160,164},
              textString="Phi"),Text(
              extent={{130,102},{147,117}},
          textString="Phi",
          textColor={160,160,164}),
                                Line(points={{-152,-100},{-127,-100}}, color={160,160,164}),
                         Polygon(
          points={{-142,-97},{-152,-100},{-142,-103},{-142,-97}},
          lineColor={160,160,164},
          fillColor={160,160,164},
          fillPattern=FillPattern.Solid),    Text(
              extent={{-143,-96},{-126,-81}},
              textColor={160,160,164},
              textString="i"),Text(
              extent={{-152,103},{-135,118}},
              textColor={160,160,164},
              textString="i"),Line(points={{126,100},{151,100}}, color={160,160,164}),
          Polygon(
          points={{136,103},{126,100},{136,97},{136,103}},
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
V<sub>m</sub> = N * i
N * d&Phi;/dt = -v
</pre></blockquote>

<div>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Basic/converter_signs.png\" alt=\"converter signs\">
</div>

<p>
V<sub>m</sub> is the magnetic potential difference applied to the magnetic circuit due to the current i through the coil (Ampere's law).
There exists a left-hand assignment between the current i (Put your hand around the coil, fingers pointing in the direction of current flow.)
and the magnetic potential difference V<sub>m</sub> (thumb).<br>
<strong>Note:</strong> There exists a right-hand assignment between the current through the coil i (fingers) and the magnetomotive force mmf.
The mmf has the opposite direction compared with V<sub>m</sub>, it is not used in Modelica.
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
<strong>Note:</strong> The image shows a coil wound counter-clockwise (positive mathematical direction).
If a coil wound clockwise has to be modeled instead, the parameter N (Number of turns) can be set to a negative value.
</p>

<p>
The flux linkage &Psi; and the static inductance L_stat = |&Psi;/i| are calculated for information only. Note that L_stat is set to |&Psi;/eps| if |i| &lt; eps
(= 100*Modelica.Constants.eps).
</p>
</html>"));
end ElectroMagneticConverter;
