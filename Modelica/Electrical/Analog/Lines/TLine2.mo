within Modelica.Electrical.Analog.Lines;
model TLine2
  "Lossless transmission line with characteristic impedance Z0, frequency F and normalized length NL"
  extends Modelica.Electrical.Analog.Interfaces.TwoPort;
  extends Modelica.Icons.ObsoleteModel;
  parameter SI.Resistance Z0(start=1)
    "Characteristic impedance";
  parameter SI.Frequency F(start=1) "Frequency";
  parameter Real NL(start=1) "Normalized length";
  SI.Voltage es(start=0) "Voltage source of forward travelling wave";
  SI.Voltage er(start=0) "Voltage source of reflected wave";
protected
  parameter SI.Time TD=NL/F;
equation
  assert(Z0 > 0, "Z0 has to be positive");
  assert(NL > 0, "NL has to be positive");
  assert(F > 0, "F has to be positive");
  i1 = (v1 - es)/Z0;
  i2 = (v2 - er)/Z0;
  es = 2*delay(v2, TD) - delay(er, TD);
  er = 2*delay(v1, TD) - delay(es, TD);
  annotation (defaultComponentName="line",
    Documentation(info="<html>
<p>Lossless transmission line with characteristic impedance Z0, frequency F and normalized length NL The lossless transmission line TLine2 is a two Port. Both port branches consist of a resistor with the value of the characteristic impedance Z0 and a controlled voltage source that takes into consideration the transmission delay. For further details see [<a href=\"modelica://Modelica.Electrical.Analog.UsersGuide.References\">Branin1967</a>]. Resistance R&#39; and conductance C&#39; per meter are assumed to be zero. The characteristic impedance Z0 can be derived from inductance and capacitance per length (L&#39; resp. C&#39;), i. e. Z0 = sqrt(L&#39;/C&#39;). The normalized length NL is equal to the length of the line divided by the wavelength corresponding to the frequency F, i. e. the transmission delay TD is the quotient of NL and F.</p>
<p><strong>References:</strong>
   [<a href=\"modelica://Modelica.Electrical.Analog.UsersGuide.References\">Branin1967</a>],
   [<a href=\"modelica://Modelica.Electrical.Analog.UsersGuide.References\">Hoefer1985</a>]</p>
<h4>Note:</h4>
<p>This model is replaced by <a href=\"modelica://Modelica.Electrical.Analog.Lines.TLine\">TLine</a> with appropriate parameterization.</p>
</html>",    revisions="<html>
<dl>
<dt><em>1998</em></dt>
<dd>by Joachim Haase initially implemented</dd>
</dl>
</html>"),
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{-150,150},{150,110}},
          textString="%name",
          textColor={0,0,255}),
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
          textString="TLine2"),
        Line(points={{-40,40},{-40,20}}),
        Line(points={{40,30},{-40,30}}),
        Line(points={{40,40},{40,20}}),
        Line(points={{-60,100},{-60,80}}, color={0,0,255}),
        Line(points={{60,100},{60,80}}, color={0,0,255}),
        Line(points={{60,-80},{60,-100}}, color={0,0,255}),
        Line(points={{-60,-80},{-60,-100}}, color={0,0,255})}));
end TLine2;
