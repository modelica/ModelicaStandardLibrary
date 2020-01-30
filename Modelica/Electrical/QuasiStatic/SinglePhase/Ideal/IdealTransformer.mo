within Modelica.Electrical.QuasiStatic.SinglePhase.Ideal;
model IdealTransformer "Ideal transformer"
  parameter Real n=1 "Ratio of primary to secondary voltage";
  SI.ComplexVoltage v1=pin_p1.v - pin_n1.v "Voltage drop of side 1";
  SI.ComplexCurrent i1=pin_p1.i "Current into side 1";
  SI.ComplexVoltage v2=pin_p2.v - pin_n2.v "Voltage drop of side 2";
  SI.ComplexCurrent i2=pin_p2.i "Current into side 2";

  SI.Voltage abs_v1=Modelica.ComplexMath.abs(v1) "Magnitude of complex voltage v1";
  SI.Angle arg_v1=Modelica.ComplexMath.arg(v1) "Argument of complex voltage v1";
  SI.Current abs_i1=Modelica.ComplexMath.abs(i1) "Magnitude of complex current i1";
  SI.Angle arg_i1=Modelica.ComplexMath.arg(i1) "Argument of complex current i1";
  SI.ActivePower P1=Modelica.ComplexMath.real(v1*
      Modelica.ComplexMath.conj(i1)) "Active power, side 1";
  SI.ReactivePower Q1=Modelica.ComplexMath.imag(v1*
      Modelica.ComplexMath.conj(i1)) "Reactive power, side 1";
  SI.ApparentPower S1=Modelica.ComplexMath.abs(v1*
      Modelica.ComplexMath.conj(i1)) "Magnitude of complex apparent power, side 1";
  Real pf1=cos(Modelica.ComplexMath.arg(Complex(P1, Q1))) "Power factor, side 1";

  SI.Voltage abs_v2=Modelica.ComplexMath.abs(v2) "Magnitude of complex voltage v2";
  SI.Angle arg_v2=Modelica.ComplexMath.arg(v2) "Argument of complex voltage v2";
  SI.Current abs_i2=Modelica.ComplexMath.abs(i2) "Magnitude of complex current i2";
  SI.Angle arg_i2=Modelica.ComplexMath.arg(i2) "Argument of complex current i2";
  SI.ActivePower P2=Modelica.ComplexMath.real(v2*
      Modelica.ComplexMath.conj(i2)) "Active power, side 2";
  SI.ReactivePower Q2=Modelica.ComplexMath.imag(v2*
      Modelica.ComplexMath.conj(i2)) "Reactive power, side 2";
  SI.ApparentPower S2=Modelica.ComplexMath.abs(v2*
      Modelica.ComplexMath.conj(i2)) "Magnitude of complex apparent power, side 2";
  Real pf2=cos(Modelica.ComplexMath.arg(Complex(P2, Q2))) "Power factor, side 2";

  QuasiStatic.SinglePhase.Interfaces.PositivePin pin_p1 "Primary positive pin"
    annotation (Placement(transformation(extent={{-110,90},{-90,110}}),
        iconTransformation(extent={{-110,90},{-90,110}})));
  QuasiStatic.SinglePhase.Interfaces.PositivePin pin_p2
    "Secondary positive pin" annotation (Placement(transformation(extent={{90,
            90},{110,110}}), iconTransformation(extent={{90,90},{110,110}})));
  QuasiStatic.SinglePhase.Interfaces.NegativePin pin_n1 "Primary negative pin"
    annotation (Placement(transformation(extent={{-110,-110},{-90,-90}}),
        iconTransformation(extent={{-110,-110},{-90,-90}})));
  QuasiStatic.SinglePhase.Interfaces.NegativePin pin_n2
    "Secondary negative pin" annotation (Placement(transformation(extent={{90,-108},
            {110,-88}}), iconTransformation(extent={{90,-108},{110,-88}})));
equation
  // Current balance
  pin_p1.i + pin_n1.i = Complex(0, 0);
  pin_p2.i + pin_n2.i = Complex(0, 0);
  // Transformation ratios
  v1 = Complex(+n, 0)*v2;
  i2 = Complex(-n, 0)*i1;
  Connections.branch(pin_p1.reference, pin_n1.reference);
  pin_p1.reference.gamma = pin_n1.reference.gamma;
  Connections.branch(pin_n1.reference, pin_n2.reference);
  pin_p2.reference.gamma = pin_n2.reference.gamma;
  Connections.branch(pin_p1.reference, pin_p2.reference);
  pin_p1.reference.gamma = pin_p2.reference.gamma;
  annotation (defaultComponentName="transformer",
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={
        Text(
          extent={{-100,10},{0,-10}},
          textColor={0,0,255},
          textString="1=primary"),
        Text(
          extent={{0,10},{100,-10}},
          textColor={0,0,255},
          textString="2=secondary"),
        Polygon(
          points={{-120,53},{-110,50},{-120,47},{-120,53}},
          lineColor={160,160,164},
          fillColor={160,160,164},
          fillPattern=FillPattern.Solid),
        Line(points={{-136,50},{-111,50}}, color={160,160,164}),
        Text(
          extent={{-136,53},{-119,68}},
          textColor={160,160,164},
          textString="i1"),
        Line(points={{-136,-49},{-111,-49}}, color={160,160,164}),
        Polygon(
          points={{-126,-46},{-136,-49},{-126,-52},{-126,-46}},
          lineColor={160,160,164},
          fillColor={160,160,164},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-127,-46},{-110,-31}},
          textColor={160,160,164},
          textString="i1"),
        Polygon(
          points={{127,-47},{137,-50},{127,-53},{127,-47}},
          lineColor={160,160,164},
          fillColor={160,160,164},
          fillPattern=FillPattern.Solid),
        Line(points={{111,-50},{136,-50}}, color={160,160,164}),
        Text(
          extent={{112,-44},{128,-29}},
          textColor={160,160,164},
          textString="i2"),
        Text(
          extent={{118,52},{135,67}},
          textString="i2"),
        Polygon(
          points={{120,53},{110,50},{120,47},{120,53}},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={160,160,164}),
        Line(points={{111,50},{136,50}})}),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics={
        Text(
          extent={{-100,20},{-60,-20}},
          textColor={85,170,255},
          textString="1"),
        Text(
          extent={{60,20},{100,-20}},
          textColor={85,170,255},
          textString="2"),
        Line(points={{-40,60},{-40,100},{-90,100}}, color={85,170,255}),
        Line(points={{40,60},{40,100},{90,100}}, color={85,170,255}),
        Line(points={{-40,-60},{-40,-100},{-90,-100}}, color={85,170,255}),
        Line(points={{40,-60},{40,-100},{90,-100}}, color={85,170,255}),
        Line(
          points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}},
          color={85,170,255},
          smooth=Smooth.Bezier,
          origin={-33,45},
          rotation=270),
        Line(
          points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}},
          color={85,170,255},
          smooth=Smooth.Bezier,
          origin={-33,15},
          rotation=270),
        Line(
          points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}},
          color={85,170,255},
          smooth=Smooth.Bezier,
          origin={-33,-15},
          rotation=270),
        Line(
          points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}},
          color={85,170,255},
          smooth=Smooth.Bezier,
          origin={-33,-45},
          rotation=270),
        Line(
          points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}},
          color={85,170,255},
          smooth=Smooth.Bezier,
          origin={33,45},
          rotation=90),
        Line(
          points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}},
          color={85,170,255},
          smooth=Smooth.Bezier,
          origin={33,15},
          rotation=90),
        Line(
          points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}},
          color={85,170,255},
          smooth=Smooth.Bezier,
          origin={33,-15},
          rotation=90),
        Line(
          points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}},
          color={85,170,255},
          smooth=Smooth.Bezier,
          origin={33,-45},
          rotation=90),
        Text(
          extent={{-150,149},{150,109}},
          textString="%name",
          textColor={0,0,255})}),
    Documentation(info="<html>
<p>
The ideal transformer is a two-port circuit element without magnetization. Voltages and currents are ideally transformed:
</p>
<blockquote><pre>
v1 =  v2*n;
i2 = -i1*n;
</pre></blockquote>
<p>
where <code>n</code> is a real number called the turns ratio.</p>
</html>",
      revisions="<html>
<h5>2014-01-02, Christian Kral</h5>
<ul>
<li>Initial implementation of ideal transformer model</li>
</ul>

</html>"));
end IdealTransformer;
