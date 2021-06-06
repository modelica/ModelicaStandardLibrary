within Modelica.Electrical.Analog.Lines;
model TLine
  "Lossless transmission line with characteristic impedance Z0 and transmission delay TD"
  extends Modelica.Electrical.Analog.Interfaces.TwoPort;
  parameter Modelica.Units.SI.Resistance Z0(start=1) "Characteristic impedance";
  parameter Modelica.Units.SI.Time TD=0
    "Transmission delay: specify > 0 if F and NL are not given";
  parameter Modelica.Units.SI.Frequency F=0
    "Frequency: specify > 0 if TD is not given";
  parameter Real NL=1/4 "Normalized length: specify if TD is not given";
  Modelica.Units.SI.Voltage es(start=0) "Voltage source of forward travelling wave";
  Modelica.Units.SI.Voltage er(start=0) "Voltage source of reflected wave";
protected
  parameter Modelica.Units.SI.Time TDi=if F > 0 then NL/F else TD
    "Internally used transmission delay";
equation
  assert(Z0 > 0, "Z0 has to be positive");
  assert((F > 0) or (TD > 0), "F or TD has to be positive");
  i1 = (v1 - es)/Z0;
  i2 = (v2 - er)/Z0;
  es = 2*delay(v2, TDi) - delay(er, TDi);
  er = 2*delay(v1, TDi) - delay(es, TDi);
  annotation (defaultComponentName="line",
    Documentation(info="<html>
<p>
Lossless transmission line with characteristic impedance Z0 and transmission delay TD. The lossless transmission line TLine is a two Port. 
Both port branches consist of a resistor with characteristic impedance Z0 and a controlled voltage source that takes into consideration the transmission delay TD. 
For further details see [<a href=\"modelica://Modelica.Electrical.Analog.UsersGuide.References\">Branin1967</a>]. 
The model parameters can be derived from inductance and capacitance per length (L&#39; resp. C&#39;), i. e. Z0 = sqrt(L&#39; / C&#39;).
</p>
<p>
There are three possibilities for specifying the transmission delay TD:
</p>
<ul>
<li>Calculate TD = sqrt(L&#39; * C&#39;)*length_of_line.</li>
<li>Specify the normalized length NL, i.e. the length of the line divided by the wavelength corresponding to the frequency F: TD = NL / F.</li>
<li>Specify NL = 1/4, i.e. the length of the line is assumed to be equal to a quarter of the wavelength corresponding to the frequency F: TD = 1/4 / F. 
    In that case, the characteristic impedance Z0 is called natural impedance.</li>
</ul>

<p>Resistance R&#39; and conductance G&#39; per meter are assumed to be zero.</p>

<p><strong>References:</strong>
   [<a href=\"modelica://Modelica.Electrical.Analog.UsersGuide.References\">Branin1967</a>],
   [<a href=\"modelica://Modelica.Electrical.Analog.UsersGuide.References\">Hoefer1985</a>]</p>
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
          textString="TLine",
          textColor={0,0,0}),
        Line(points={{-40,40},{-40,20}}),
        Line(points={{40,30},{-40,30}}),
        Line(points={{40,40},{40,20}}),
        Line(points={{-60,100},{-60,80}}, color={0,0,255}),
        Line(points={{60,100},{60,80}}, color={0,0,255}),
        Line(points={{60,-80},{60,-100}}, color={0,0,255}),
        Line(points={{-60,-80},{-60,-100}}, color={0,0,255})}));
end TLine;
