within Modelica.Electrical.Analog.Semiconductors;
model Diode "Simple diode with heating port"
  extends Modelica.Electrical.Analog.Interfaces.OnePort;
  parameter SI.Current Ids=1e-6 "Saturation current";
  parameter Boolean useTemperatureDependency = false "= true, if the diode current depends on temperature, otherwise utilizes the voltage equivalent of temperature" annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter SI.Voltage Vt=0.04 "Voltage equivalent of temperature (kT/qn)" annotation(Dialog(enable=not useTemperatureDependency));
  parameter Real Maxexp(final min=Modelica.Constants.small) = 15 "Max. exponent for linear continuation";
  parameter SI.Resistance R=1e8 "Parallel ohmic resistance";
  parameter Real EG=1.11 "Activation energy" annotation(Dialog(enable=useTemperatureDependency));
  parameter Real N=1 "Emission coefficient" annotation(Dialog(enable=useTemperatureDependency));
  parameter SI.Temperature TNOM=300.15 "Parameter measurement temperature" annotation(Dialog(enable=useTemperatureDependency));
  parameter Real XTI=3 "Temperature exponent of saturation current" annotation(Dialog(enable=useTemperatureDependency));
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(useHeatPort=useTemperatureDependency);

  SI.Voltage vt_t "Temperature voltage";
  SI.Current id "Diode current";
protected
  SI.Temperature htemp "Auxiliary temperature";
  Real aux;
  Real auxp;
equation
  assert(T_heatPort > 0,"Temperature must be positive");
  htemp = T_heatPort;
  vt_t = k*htemp/q;

  if useTemperatureDependency then
    id = Ids*(exlin(v/(N*vt_t), Maxexp) - 1);
    i = id*pow(htemp/TNOM, XTI/N)*auxp + v/R;
  else
    id = Ids*(exlin(v/Vt, Maxexp) - 1);
    i = smooth(1, id + v/R);
  end if;

  aux = (htemp/TNOM - 1)*EG/(N*vt_t);
  auxp = exp(aux);

  LossPower = i*v;
  annotation (defaultComponentName="diode",
    Documentation(info="<html>
<p>
The simple diode is an electrical one port, where a heat port is added, which is
defined in the Modelica.Thermal library. It consists of the diode itself and a parallel ohmic
resistance <em>R</em>. If <em>useTemperatureDependency</em> is set to <em>true</em>, the diode formula is:
</p>
<blockquote><pre>
           v/N/vt_t
i = Ids (e          - 1)
</pre></blockquote>
where <em>vt_t</em> depends on the temperature of the heat port:
<blockquote><pre>
vt_t = k*temp/q
</pre></blockquote>
<p>
If <em>useTemperatureDependency</em> is set to <em>false</em>, the diode formula utilizes the voltage equivalent of the temperature, i.e.,
</p>
<blockquote><pre>
           v/Vt
i = Ids (e      - 1).
</pre></blockquote>
<p>
If the exponent <em>v/N/vt_t</em> or <em>v/Vt</em>, respectively, reaches the limit <em>Maxexp</em>, the diode characteristic is linearly continued to avoid overflow.<br>
The thermal power is calculated by <em>i*v</em>.
</p>
</html>",
        revisions="<html>
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
          extent={{-150,-40},{150,-80}},
          textString="Vt=%Vt",
          visible=not useTemperatureDependency),
        Text(
          extent={{-150,90},{150,50}},
          textString="%name",
          textColor={0,0,255}),
        Line(
          visible=useHeatPort,
          points={{0,-100},{0,-20}},
          color={127,0,0},
          pattern=LinePattern.Dot)}));
end Diode;
