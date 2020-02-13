within Modelica.Electrical.Analog.Interfaces;
partial model IdealSwitch "Ideal electrical switch"
  extends Modelica.Electrical.Analog.Interfaces.OnePort;
  parameter SI.Resistance Ron(final min=0) = 1e-5
    "Closed switch resistance";
  parameter SI.Conductance Goff(final min=0) = 1e-5
    "Opened switch conductance";
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(final T=293.15);
protected
  Boolean off "Indicates off-state";
  Real s(final unit="1") "Auxiliary variable";
  constant SI.Voltage unitVoltage=1 annotation (HideResult=true);
  constant SI.Current unitCurrent=1 annotation (HideResult=true);
equation
  v = (s*unitCurrent)*(if off then 1 else Ron);
  i = (s*unitVoltage)*(if off then Goff else 1);
  LossPower = v*i;
  annotation (
    Documentation(info="<html>
<p>
The ideal switch has a positive pin p and a negative pin n.
The switching behaviour is controlled by the boolean signal off.
If off is true, pin p is not connected with negative pin n.
Otherwise, pin p is connected with negative pin n.<br><br>
In order to prevent singularities during switching, the opened
switch has a (very low) conductance Goff
and the closed switch has a (very low) resistance Ron.
The limiting case is also allowed, i.e., the resistance Ron of the
closed switch could be exactly zero and the conductance Goff of the
open switch could be also exactly zero. Note, there are circuits,
where a description with zero Ron or zero Goff is not possible.
<br><br>
<strong>Please note:</strong>
In case of useHeatPort=true the temperature dependence of the electrical
behavior is <strong>not</strong> modelled. The parameters are not temperature dependent.
</p>
</html>",
        revisions="<html>
<ul>
<li><em> March 11, 2009   </em>
       by Christoph Clauss<br> conditional heat port added<br>
       </li>
<li><em> 1998   </em>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>"),
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={
        Ellipse(extent={{-44,4},{-36,-4}}, lineColor={0,0,255}),
        Line(points={{-90,0},{-44,0}}, color={0,0,255}),
        Line(points={{-37,2},{40,40}}, color={0,0,255}),
        Line(points={{40,0},{90,0}}, color={0,0,255}),
        Line(
          visible=useHeatPort,
          points={{0,-100},{0,25}},
          color={127,0,0},
          pattern=LinePattern.Dot),
        Text(
          extent={{-150,90},{150,50}},
          textString="%name",
          textColor={0,0,255})}));
end IdealSwitch;
