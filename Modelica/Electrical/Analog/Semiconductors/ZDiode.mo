within Modelica.Electrical.Analog.Semiconductors;
model ZDiode "Zener diode with 3 working areas"
  extends Modelica.Electrical.Analog.Interfaces.OnePort;
  parameter SI.Current Ids=1e-6 "Saturation current";
  parameter SI.Voltage Vt=0.04 "Voltage equivalent of temperature (kT/qn)";
  parameter Real Maxexp(final min=Modelica.Constants.small) = 30
    "Max. exponent for linear continuation";
  parameter SI.Resistance R=1e8 "Parallel ohmic resistance";
  parameter SI.Voltage Bv=5.1 "Breakthrough voltage = Zener- or Z-voltage";
  parameter SI.Current Ibv=0.7 "Breakthrough knee current";
  parameter Real Nbv=0.74 "Breakthrough emission coefficient";
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(T=293.15);
equation
  i = smooth(1, if (v>Maxexp*Vt) then
            Ids*( exp(Maxexp)*(1 + v/Vt - Maxexp)-1) + v/R else
         if ( (v+Bv)<-Maxexp*(Nbv*Vt)) then
            -Ids -Ibv* exp(Maxexp)*(1 - (v+Bv)/(Nbv*Vt) - Maxexp) +v/R else
            Ids*(exp(v/Vt)-1) - Ibv*exp(-(v+Bv)/(Nbv*Vt)) + v/R);
  LossPower = v*i;
        annotation (defaultComponentName="diode",
          Documentation(info="<html>
<p>The simple Zener diode is a one port. It consists of the diode itself and an parallel ohmic resistance <em>R</em>. The diode formula is:</p>
<blockquote><pre>
              v/Vt                -(v+Bv)/(Nbv*Vt)
i  =  Ids ( e      - 1) - Ibv ( e                  ).
</pre></blockquote>
<p>If the exponent in one of the two branches reaches the limit <em>Maxexp</em>, the diode characteristic is linearly continued to avoid overflow.</p>
<p><br>The Zener diode model permits (in contrast to the simple diode model) current in reverse direction if the breakdown voltage Bv (also known Zener knee voltage) is exceeded.</p>
<p>The thermal power is calculated by <em>i*v</em>.</p><p><strong>Please note:</strong> In case of useHeatPort=true the temperature dependence of the electrical behavior is <strong>not</strong> modelled yet. The parameters are not temperature dependent.</p>
</html>",revisions="<html>
<ul>
<li><em> March 11, 2009   </em>
       by Christoph Clauss<br> conditional heat port added<br>
       </li>
<li><em>April 5, 2004   </em>
       by Christoph Clauss<br> implemented<br>
       </li>
</ul>
</html>"),
         Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Polygon(
          points={{30,0},{-30,40},{-30,-40},{30,0}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-90,0},{40,0}}, color={0,0,255}),
        Line(points={{40,0},{90,0}}, color={0,0,255}),
        Line(points={{30,40},{30,-40}}, color={0,0,255}),
        Text(
          extent={{-150,90},{150,50}},
          textString="%name",
          textColor={0,0,255}),
        Line(
          visible=useHeatPort,
          points={{0,-101},{0,-20}},
          color={127,0,0},
          pattern=LinePattern.Dot),
        Line(points={{30,-40},{20,-40}}, color={28,108,200})}));
end ZDiode;
