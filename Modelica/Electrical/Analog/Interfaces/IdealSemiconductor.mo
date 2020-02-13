within Modelica.Electrical.Analog.Interfaces;
partial model IdealSemiconductor "Ideal semiconductor"
  extends Modelica.Electrical.Analog.Interfaces.OnePort;
  parameter SI.Resistance Ron(final min=0) = 1e-5
    "Forward state-on differential resistance (closed resistance)";
  parameter SI.Conductance Goff(final min=0) = 1e-5
    "Backward state-off conductance (opened conductance)";
  parameter SI.Voltage Vknee(final min=0) = 0
    "Forward threshold voltage";
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort;
  Boolean off(start=true) "Switching state";
protected
  Real s(start=0, final unit="1")
    "Auxiliary variable for actual position on the ideal diode characteristic";
  /* s = 0: knee point
     s < 0: below knee point, blocking
     s > 0: above knee point, conducting */
  constant SI.Voltage unitVoltage=1 annotation (HideResult=true);
  constant SI.Current unitCurrent=1 annotation (HideResult=true);
equation
  v = (s*unitCurrent)*(if off then 1 else Ron) + Vknee;
  i = (s*unitVoltage)*(if off then Goff else 1) + Goff*Vknee;
  LossPower = v*i;
  annotation (
    Documentation(info="<html>
<p>
This is an ideal semiconductor which is<br><br>
<strong>open </strong>(off), if it is reversed biased (voltage drop less than 0)<br>
<strong>closed</strong> (on), if it is conducting (current > 0).<br>
<br>
This is the behaviour if all parameters are exactly zero.<br><br>
Note, there are circuits, where this ideal description
with zero resistance and zero conductance is not possible.
In order to prevent singularities during switching, the opened
semiconductor has a small conductance <em>Gon</em>
and the closed semiconductor has a low resistance <em>Roff</em> which is default.
</p>
<p>
The parameter <em>Vknee</em> which is the forward threshold voltage, allows to displace
the knee point<br> along  the <em>Gon</em>-characteristic until <em>v = Vknee</em>.
<br><br>
<strong>Please note:</strong>
In case of useHeatPort=true the temperature dependence of the electrical
behavior is <strong>not</strong> modelled.
</p>
</html>",
        revisions="<html>
<ul>
<li><em> March 11, 2009   </em>
       by Christoph Clauss<br> conditional heat port added<br>
       </li>
<li><em>Mai 7, 2004   </em>
       by Christoph Clauss and Anton Haumer<br> Vknee added<br>
       </li>
<li><em>some years ago   </em>
       by Christoph Clauss<br> realized<br>
       </li>
</ul>
</html>"),
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={
        Polygon(
          points={{30,0},{-30,40},{-30,-40},{30,0}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-90,0},{40,0}}, color={0,0,255}),
        Line(points={{40,0},{90,0}}, color={0,0,255}),
        Line(points={{30,40},{30,-40}}, color={0,0,255}),
        Line(
          visible=useHeatPort,
          points={{0,-100},{0,-20}},
          color={127,0,0},
          pattern=LinePattern.Dot),
        Text(
          extent={{-150,90},{150,50}},
          textString="%name",
          textColor={0,0,255})}),
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={Line(points={{-80,0},{80,0}}, color={128,128,128}),
          Polygon(
            points={{70,4},{80,0},{70,-4},{70,4}},
            lineColor={128,128,128},
            fillColor={128,128,128},
            fillPattern=FillPattern.Solid),Line(points={{0,80},{0,-80}},
          color={128,128,128}),Polygon(
            points={{-4,70},{0,80},{4,70},{-4,70}},
            lineColor={128,128,128},
            fillColor={128,128,128},
            fillPattern=FillPattern.Solid),Text(
            extent={{10,80},{20,70}},
            textColor={128,128,128},
            textString="i"),Text(
            extent={{70,-10},{80,-20}},
            textColor={128,128,128},
            textString="v"),Line(
            points={{-80,-40},{-20,-10},{20,10},{40,70}},
            thickness=0.5),Line(
            points={{20,9},{20,0}},
            color={128,128,128},
            pattern=LinePattern.Dot),Text(
            extent={{20,0},{40,-10}},
            textColor={128,128,128},
            textString="Vknee"),Text(
            extent={{20,70},{40,60}},
            textColor={128,128,128},
            textString="Ron"),Text(
            extent={{-20,10},{0,0}},
            textColor={128,128,128},
            textString="Goff"),Ellipse(
            extent={{18,12},{22,8}},
            pattern=LinePattern.Dot,
            lineColor={0,0,255})}));
end IdealSemiconductor;
