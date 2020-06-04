within Modelica.Electrical.Analog.Ideal;
model ControlledIdealIntermediateSwitch
  "Controlled ideal intermediate switch"
  parameter SI.Voltage level=0.5 "Switch level";
  parameter SI.Resistance Ron(final min=0) = 1e-5 "Closed switch resistance";
  parameter SI.Conductance Goff(final min=0) = 1e-5
    "Opened switch conductance";
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(final T=
        293.15);
  Interfaces.PositivePin p1 annotation (Placement(transformation(extent={{-110,30},{-90,50}}), iconTransformation(extent={{-110,30},{-90,50}})));
  Interfaces.PositivePin p2 annotation (Placement(transformation(extent={{-110,
            -10},{-90,10}})));
  Interfaces.NegativePin n1 annotation (Placement(transformation(extent={{90,30},{110,50}}), iconTransformation(extent={{90,30},{110,50}})));
  Interfaces.NegativePin n2 annotation (Placement(transformation(extent={{90,
            -10},{110,10}})));
  Interfaces.Pin control "Control pin: if control.v > level p1--n2, p2--n1 connected,
         otherwise p1--n1, p2--n2  connected"
                                            annotation (Placement(
        transformation(
        origin={0,100},
        extent={{-10,-10},{10,10}},
        rotation=90)));
protected
  Real s1(final unit="1");
  Real s2(final unit="1");
  Real s3(final unit="1");
  Real s4(final unit="1") "Auxiliary variables";
  constant SI.Voltage unitVoltage=1 annotation (HideResult=true);
  constant SI.Current unitCurrent=1 annotation (HideResult=true);
equation
  control.i = 0;

  p1.v - n1.v = (s1*unitCurrent)*(if (control.v > level) then 1 else Ron);
  p2.v - n2.v = (s2*unitCurrent)*(if (control.v > level) then 1 else Ron);
  p1.v - n2.v = (s3*unitCurrent)*(if (control.v > level) then Ron else 1);
  p2.v - n1.v = (s4*unitCurrent)*(if (control.v > level) then Ron else 1);

  p1.i = if control.v > level then s1*unitVoltage*Goff + s3*unitCurrent else
    s1*unitCurrent + s3*unitVoltage*Goff;
  p2.i = if control.v > level then s2*unitVoltage*Goff + s4*unitCurrent else
    s2*unitCurrent + s4*unitVoltage*Goff;
  n1.i = if control.v > level then -s1*unitVoltage*Goff - s4*unitCurrent
     else -s1*unitCurrent - s4*unitVoltage*Goff;
  n2.i = if control.v > level then -s2*unitVoltage*Goff - s3*unitCurrent
     else -s2*unitCurrent - s3*unitVoltage*Goff;

  LossPower = p1.i*p1.v + p2.i*p2.v + n1.i*n1.v + n2.i*n2.v;
  annotation (defaultComponentName="switch",
    Documentation(info="<html>
<p>The intermediate switch has four switching contact pins p1, p2, n1, and n2. The switching behaviour is controlled by the control pin. If its voltage exceeds the value of the parameter level, the pin p1 is connected to pin n2, and the pin p2 is connected to the pin n1. Otherwise, the pin p1 is connected to the pin n1, and the pin p2 is connected to the pin n2.
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Electrical/Analog/ControlledIdealIntermediateSwitch1.png\"
     alt=\"ControlledIdealIntermediateSwitch1.png\">
</div>

<p>
In order to prevent singularities during switching, the opened switch has a (very low) conductance Goff and the closed switch has a (very low) resistance Ron.
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Electrical/Analog/ControlledIdealIntermediateSwitch2.png\"
     alt=\"ControlledIdealIntermediateSwitch2.png\">
</div>

<p>
The limiting case is also allowed, i.e., the resistance Ron of the closed switch could be exactly zero and the conductance Goff of the open switch could be also exactly zero. Note, there are circuits, where a description with zero Ron or zero Goff is not possible.</p>
<p><br><strong>Please note:</strong> In case of useHeatPort=true the temperature dependence of the electrical behavior is <strong>not </strong>modelled. The parameters are not temperature dependent.</p>
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
        Ellipse(extent={{-4,24},{4,16}}, lineColor={0,0,255}),
        Line(points={{-90,0},{-40,0}}, color={0,0,255}),
        Line(points={{-90,40},{-40,40}}, color={0,0,255}),
        Line(points={{-40,0},{40,40}}, color={0,0,255}),
        Line(points={{-40,40},{40,0}}, color={0,0,255}),
        Line(points={{40,40},{90,40}}, color={0,0,255}),
        Line(points={{40,0},{90,0}}, color={0,0,255}),
        Line(
          visible=useHeatPort,
          points={{0,-100},{0,22}},
          color={127,0,0},
          pattern=LinePattern.Dot),
        Text(
          extent={{-150,90},{150,50}},
          textString="%name",
          textColor={0,0,255})}));
end ControlledIdealIntermediateSwitch;
