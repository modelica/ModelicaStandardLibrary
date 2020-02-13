within Modelica.Electrical.Analog.Ideal;
model IdealTwoWaySwitch "Ideal two-way switch"
  parameter SI.Resistance Ron(final min=0) = 1e-5 "Closed switch resistance";
  parameter SI.Conductance Goff(final min=0) = 1e-5
    "Opened switch conductance";
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(final T=
        293.15);
  Interfaces.PositivePin p annotation (Placement(transformation(extent={{-110,
            -10},{-90,10}})));
  Interfaces.NegativePin n2 annotation (Placement(transformation(extent={{90,
            -10},{110,10}})));
  Interfaces.NegativePin n1 annotation (Placement(transformation(extent={{90,30},{110,50}}), iconTransformation(extent={{90,30},{110,50}})));
  Modelica.Blocks.Interfaces.BooleanInput control
    "true => p--n2 connected, false => p--n1 connected" annotation (Placement(
        transformation(
        origin={0,120},
        extent={{-20,-20},{20,20}},
        rotation=270), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,120})));
protected
  Real s1(final unit="1");
  Real s2(final unit="1") "Auxiliary variables";
  constant SI.Voltage unitVoltage=1 annotation (HideResult=true);
  constant SI.Current unitCurrent=1 annotation (HideResult=true);
equation
  0 = p.i + n2.i + n1.i;

  p.v - n1.v = (s1*unitCurrent)*(if (control) then 1 else Ron);
  n1.i = -(s1*unitVoltage)*(if (control) then Goff else 1);
  p.v - n2.v = (s2*unitCurrent)*(if (control) then Ron else 1);
  n2.i = -(s2*unitVoltage)*(if (control) then 1 else Goff);
  LossPower = p.i*p.v + n1.i*n1.v + n2.i*n2.v;
  annotation (defaultComponentName="switch",
    Documentation(info="<html>
<p>
The two-way switch has a positive pin p and two negative pins n1 and n2.
The switching behaviour is controlled
by the input signal control. If control is true, the pin p is connected
with the negative pin n2. Otherwise, the pin p is connected to the negative pin n1.
</p>
<p>
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
        Line(points={{40,40},{90,40}}, color={0,0,255}),
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
end IdealTwoWaySwitch;
