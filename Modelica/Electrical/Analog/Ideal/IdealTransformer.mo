within Modelica.Electrical.Analog.Ideal;
model IdealTransformer "Ideal transformer core with or without magnetization"
  extends Modelica.Electrical.Analog.Interfaces.TwoPort;
  parameter Real n(start=1) "Turns ratio primary:secondary voltage";
  parameter Boolean considerMagnetization=false
    "Choice of considering magnetization";
  parameter SI.Inductance Lm1(start=1)
    "Magnetization inductance w.r.t. primary side"
    annotation (Dialog(enable=considerMagnetization));
protected
  SI.Current im1 "Magnetization current w.r.t. primary side";
  SI.MagneticFlux psim1 "Magnetic flux w.r.t. primary side";
equation
  im1 = i1 + i2/n;
  if considerMagnetization then
    psim1 = Lm1*im1;
    v1 = der(psim1);
  else
    psim1 = 0;
    im1 = 0;
  end if;
  v1 = n*v2;
  annotation (defaultComponentName="transformer",
    Documentation(info="<html>
<p>
The ideal transformer is a two-port circuit element;
in case of Boolean parameter <code>considerMagnetization = false</code> it is characterized by the following equations:
</p>
<blockquote><pre>
i2 = -i1*n;
v2 =  v1/n;
</pre></blockquote>
<p>
where <code>n</code> is a real number called the turns ratio.
Due to this equations, also DC voltages and currents are transformed - which is not the case for technical transformers.
</p>
<p>
In case of Boolean parameter <code>considerMagnetization = true</code> it is characterized by the following equations:
</p>
<blockquote><pre>
im1  = i1 + i2/n \"Magnetizing current w.r.t. primary side\";
psim1= Lm1*im1   \"Magnetic flux w.r.t. primary side\";
v1 = der(psim1)  \"Primary voltage\";
v2 = v1/n        \"Secondary voltage\";
</pre></blockquote>
<p>
where <code>Lm</code> denotes the magnetizing inductance.
Due to this equations, the DC offset of secondary voltages and currents decrement according to the time constant defined by the connected circuit.
</p>
<p>
Taking primary <code>L1sigma</code> and secondary <code>L2ssigma</code> leakage inductances into account,
compared with the <a href=\"modelica://Modelica.Electrical.Analog.Basic.Transformer\">basic transformer</a>
the following parameter conversion can be applied (which leads to identical results):
</p>
<blockquote><pre>
L1 = L1sigma + M*n \"Primary inductance at secondary no-load\";
L2 = L2sigma + M/n \"Secondary inductance at primary no-load\";
M  = Lm1/n         \"Mutual inductance\";
</pre></blockquote>
<p>
For the backward conversion, one has to decide about the partitioning of the leakage to primary and secondary side.
</p>
</html>",
        revisions="<html>
<ul>
<li><em>June 3, 2009   </em>
       magnetisation current added by Anton Haumer<br>
       </li>
<li><em>1998   </em>
       initially implemented by Christoph Clauss<br>
       </li>
</ul>
</html>"),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics={
        Text(extent={{-150,-110},{150,-150}},textString="n=%n"),
        Text(
          extent={{-100,20},{-60,-20}},
          textColor={0,0,255},
          textString="1"),
        Text(
          extent={{60,20},{100,-20}},
          textColor={0,0,255},
          textString="2"),
        Text(
          extent={{-150,150},{150,110}},
          textString="%name",
          textColor={0,0,255}),
        Line(points={{-40,60},{-40,100},{-90,100}}, color={0,0,255}),
        Line(points={{40,60},{40,100},{90,100}}, color={0,0,255}),
        Line(points={{-40,-60},{-40,-100},{-90,-100}}, color={0,0,255}),
        Line(points={{40,-60},{40,-100},{90,-100}}, color={0,0,255}),
        Line(
          points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}},
          color={0,0,255},
          smooth=Smooth.Bezier,
          origin={-33,45},
          rotation=270),
        Line(
          points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}},
          color={0,0,255},
          smooth=Smooth.Bezier,
          origin={-33,15},
          rotation=270),
        Line(
          points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}},
          color={0,0,255},
          smooth=Smooth.Bezier,
          origin={-33,-15},
          rotation=270),
        Line(
          points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}},
          color={0,0,255},
          smooth=Smooth.Bezier,
          origin={-33,-45},
          rotation=270),
        Line(
          points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}},
          color={0,0,255},
          smooth=Smooth.Bezier,
          origin={33,45},
          rotation=90),
        Line(
          points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}},
          color={0,0,255},
          smooth=Smooth.Bezier,
          origin={33,15},
          rotation=90),
        Line(
          points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}},
          color={0,0,255},
          smooth=Smooth.Bezier,
          origin={33,-15},
          rotation=90),
        Line(
          points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}},
          color={0,0,255},
          smooth=Smooth.Bezier,
          origin={33,-45},
          rotation=90)}));
end IdealTransformer;
