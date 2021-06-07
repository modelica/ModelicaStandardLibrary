within Modelica.Electrical.Analog.Lines;
model TLine3
  "Lossless transmission line with characteristic impedance Z0 and frequency F"
  extends Modelica.Electrical.Analog.Interfaces.TwoPort;
  extends Modelica.Icons.ObsoleteModel;
  parameter SI.Resistance Z0(start=1) "Natural impedance";
  parameter SI.Frequency F(start=1) "Frequency";
  SI.Voltage es(start=0) "Voltage source of forward travelling wave";
  SI.Voltage er(start=0) "Voltage source of reflected wave";
protected
  parameter SI.Time TD=1/F/4;
equation
  assert(Z0 > 0, "Z0 has to be positive");
  assert(F > 0, "F has to be positive");
  i1 = (v1 - es)/Z0;
  i2 = (v2 - er)/Z0;
  es = 2*delay(v2, TD) - delay(er, TD);
  er = 2*delay(v1, TD) - delay(es, TD);
  annotation (defaultComponentName="line",
    Documentation(info="<html>
<p>Lossless transmission line with characteristic impedance Z0 and frequency F The lossless transmission line TLine3 is a two Port. Both port branches consist of a resistor with value of the characteristic impedance Z0 and a controlled voltage source that takes into consideration the transmission delay. For further details see [<a href=\"modelica://Modelica.Electrical.Analog.UsersGuide.References\">Branin1967</a>]. Resistance R&#39; and conductance C&#39; per meter are assumed to be zero. The characteristic impedance Z0 can be derived from inductance and capacitance per length (L&#39; resp. C&#39;), i. e. Z0 = sqrt(L&#39;/C&#39;). The length of the line is equal to a quarter of the wavelength corresponding to the frequency F, i. e. the transmission delay is the quotient of 4 and F. In this case, the characteristic impedance is called natural impedance.</p>
<p><strong>References:</strong>
   [<a href=\"modelica://Modelica.Electrical.Analog.UsersGuide.References\">Branin1967</a>],
   [<a href=\"modelica://Modelica.Electrical.Analog.UsersGuide.References\">Hoefer1985</a>]</p>
<h4>Note:</h4>
<p>This model is replaced by <a href=\"modelica://Modelica.Electrical.Analog.Lines.TLine\">TLine</a> with appropriate parameterization.</p>
</html>",    revisions="<html>
<ul>
<li><em> 1998   </em>
       by Joachim Haase<br> initially implemented<br>
       </li>
</ul>
</html>"),
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{-80,80},{80,-80}},
          lineColor={0,0,255},
          fillPattern=FillPattern.Solid,
          fillColor={255,255,255}),
        Line(points={{60,-100},{90,-100}}, color={0,0,255}),
        Line(points={{60,100},{90,100}}, color={0,0,255}),
        Line(points={{-60,100},{-90,100}}, color={0,0,255}),
        Line(points={{-60,-100},{-90,-100}}, color={0,0,255}),
        Text(
          extent={{-70,-10},{70,-50}},
          textString="TLine3"),
        Text(
          extent={{-150,150},{150,110}},
          textString="%name",
          textColor={0,0,255}),
        Line(points={{-40,40},{-40,20}}),
        Line(points={{40,30},{-40,30}}),
        Line(points={{40,40},{40,20}}),
        Line(points={{-60,100},{-60,80}}, color={0,0,255}),
        Line(points={{60,100},{60,80}}, color={0,0,255}),
        Line(points={{60,-80},{60,-100}}, color={0,0,255}),
        Line(points={{-60,-80},{-60,-100}}, color={0,0,255})}));
end TLine3;
