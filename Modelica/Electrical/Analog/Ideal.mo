within Modelica.Electrical.Analog;
package Ideal
  "Ideal electrical elements such as switches, diode, transformer, operational amplifier"

  extends Modelica.Icons.Package;

  model IdealDiode "Ideal diode"
    extends Modelica.Electrical.Analog.Interfaces.IdealSemiconductor;
  equation
    off = s < 0;
    annotation (defaultComponentName="diode",
      Documentation(info="<html>
<p>
This is an ideal diode, for details see partial model <a href=\"modelica://Modelica.Electrical.Analog.Interfaces.IdealSemiconductor\">IdealSemiconductor</a><br>
The diode is conducting if voltage &gt; Vknee.<br>
The diode is locking if current &lt; Vknee/Goff.
</p>
</html>", revisions="<html>
<ul>
<li><em>February 7, 2016   </em>
       by Anton Haumer<br> extending from partial IdealSemiconductor<br>
       </li>
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
</html>"));
  end IdealDiode;

  model IdealThyristor "Ideal thyristor"
    extends Modelica.Electrical.Analog.Interfaces.IdealSemiconductor;
    Modelica.Blocks.Interfaces.BooleanInput fire annotation (Placement(
          transformation(
          origin={100,120},
          extent={{-20,-20},{20,20}},
          rotation=270), iconTransformation(
          extent={{-20,-20},{20,20}},
          rotation=270,
          origin={100,120})));
  equation
    off = s < 0 or pre(off) and not fire;
    annotation (defaultComponentName="thyristor",
      Documentation(info="<html>
<p>
This is an ideal thyristor, for details see partial model <a href=\"modelica://Modelica.Electrical.Analog.Interfaces.IdealSemiconductor\">IdealSemiconductor</a><br>
The thyristor is conducting if voltage &gt; Vknee AND fire = true.<br>
If fire gets false, the current has to fall below Vknee*Goff, then the thyristor gets locking.</p>
</html>", revisions="<html>
<ul>
<li><em>February 7, 2016   </em>
       by Anton Haumer<br> extending from partial IdealSemiconductor<br>
       </li>
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
          Line(points={{40,50},{60,30}}, color={0,0,255}),
          Line(
            visible=useHeatPort,
            points={{0,-100},{0,-20}},
            color={127,0,0},
            pattern=LinePattern.Dot),
          Line(points={{30,20},{58,48}}, color={0,0,255}),
          Line(points={{100,90},{100,100}}, color={0,0,255})}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics={
                                   Line(
              points={{20,10},{70,40}},
              thickness=0.5)}));
  end IdealThyristor;

  model IdealGTOThyristor "Ideal GTO thyristor"
    extends Modelica.Electrical.Analog.Interfaces.IdealSemiconductor;
    Modelica.Blocks.Interfaces.BooleanInput fire annotation (Placement(
          transformation(
          origin={100,120},
          extent={{-20,-20},{20,20}},
          rotation=270), iconTransformation(
          extent={{-20,-20},{20,20}},
          rotation=270,
          origin={100,120})));
  equation
    off = s < 0 or not fire;
    annotation (defaultComponentName="gto",
      Documentation(info="<html>
<p>
This is an ideal GTO thyristor or switching transistor, for details see partial model <a href=\"modelica://Modelica.Electrical.Analog.Interfaces.IdealSemiconductor\">IdealSemiconductor</a><br>
The GTO thyristor is conducting if voltage &gt; Vknee AND fire = true.<br>
Otherwise, the GTO thyristor is locking.
</p>
</html>", revisions="<html>
<ul>
<li><em>February 7, 2016   </em>
       by Anton Haumer<br> extending from partial IdealSemiconductor<br>
       </li>
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
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
              100}}), graphics={
          Line(points={{48,52},{68,32}}, color={0,0,255}),
          Line(
            visible=useHeatPort,
            points={{0,-100},{0,-20}},
            color={127,0,0},
            pattern=LinePattern.Dot),
          Polygon(
            points={{44,43},{44,36},{51,36},{44,43}},
            lineColor={0,0,255},
            fillPattern=FillPattern.Solid,
            fillColor={0,0,255}),
          Polygon(
            points={{46,33},{53,33},{53,26},{46,33}},
            lineColor={0,0,255},
            fillPattern=FillPattern.Solid,
            fillColor={0,0,255}),
          Line(points={{30,10},{68,48}}, color={0,0,255}),
          Line(points={{100,90},{100,100}}, color={0,0,255}),
          Line(points={{30,22},{56,48}}, color={0,0,255})}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics={
                                   Line(
              points={{20,10},{70,40}},
              thickness=0.5)}));
  end IdealGTOThyristor;

  model IdealCommutingSwitch "Ideal commuting switch"
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
The commuting switch has a positive pin p and two negative pins n1 and n2.
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
</html>", revisions="<html>
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
            lineColor={0,0,255})}));
  end IdealCommutingSwitch;

  model IdealIntermediateSwitch "Ideal intermediate switch"
    parameter SI.Resistance Ron(final min=0) = 1e-5 "Closed switch resistance";
    parameter SI.Conductance Goff(final min=0) = 1e-5
      "Opened switch conductance";
    extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(final T=
          293.15);
    Interfaces.PositivePin p1 annotation (Placement(transformation(extent={{-110,30},{-90,50}}), iconTransformation(extent={{-110,30},{-90,50}})));
    Interfaces.PositivePin p2 annotation (Placement(transformation(extent={{-110,-10},{-90,10}}), iconTransformation(extent={{-110,-10},{-90,10}})));
    Interfaces.NegativePin n1 annotation (Placement(transformation(extent={{90,30},{110,50}}), iconTransformation(extent={{90,30},{110,50}})));
    Interfaces.NegativePin n2 annotation (Placement(transformation(extent={{90,-10},{110,10}}), iconTransformation(extent={{90,-10},{110,10}})));
    Modelica.Blocks.Interfaces.BooleanInput control
      "true => p1--n2, p2--n1 connected, otherwise p1--n1, p2--n2  connected"
      annotation (Placement(transformation(
          origin={0,120},
          extent={{-20,-20},{20,20}},
          rotation=270), iconTransformation(
          extent={{-20,-20},{20,20}},
          rotation=270,
          origin={0,120})));
  protected
    Real s1(final unit="1");
    Real s2(final unit="1");
    Real s3(final unit="1");
    Real s4(final unit="1") "Auxiliary variables";
    constant SI.Voltage unitVoltage=1 annotation (HideResult=true);
    constant SI.Current unitCurrent=1 annotation (HideResult=true);
  equation
    p1.v - n1.v = (s1*unitCurrent)*(if (control) then 1 else Ron);
    p2.v - n2.v = (s2*unitCurrent)*(if (control) then 1 else Ron);
    p1.v - n2.v = (s3*unitCurrent)*(if (control) then Ron else 1);
    p2.v - n1.v = (s4*unitCurrent)*(if (control) then Ron else 1);

    p1.i = if control then s1*unitVoltage*Goff + s3*unitCurrent else s1*
      unitCurrent + s3*unitVoltage*Goff;
    p2.i = if control then s2*unitVoltage*Goff + s4*unitCurrent else s2*
      unitCurrent + s4*unitVoltage*Goff;
    n1.i = if control then -s1*unitVoltage*Goff - s4*unitCurrent else -s1*
      unitCurrent - s4*unitVoltage*Goff;
    n2.i = if control then -s2*unitVoltage*Goff - s3*unitCurrent else -s2*
      unitCurrent - s3*unitVoltage*Goff;

    LossPower = p1.i*p1.v + p2.i*p2.v + n1.i*n1.v + n2.i*n2.v;
    annotation (defaultComponentName="switch",
      Documentation(info="<html>
<p>The intermediate switch has four switching contact pins p1, p2, n1, and n2. The switching behaviour is controlled by the input signal control. If control is true, the pin p1 is connected to the pin n2, and the pin p2 is connected to the pin n1. Otherwise,if control is false, the pin p1 is connected to n1, and the pin p2 is connected to n2.</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Electrical/Analog/IdealIntermediateSwitch1.png\"
     alt=\"IdealIntermediateSwitch1.png\">
</p>

<p>In order to prevent singularities during switching, the opened switch has a (very low) conductance Goff and the closed switch has a (very low) resistance Ron.</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Electrical/Analog/IdealIntermediateSwitch2.png\"
     alt=\"IdealIntermediateSwitch2.png\">
</p>

<p>The limiting case is also allowed, i.e., the resistance Ron of the closed switch could be exactly zero and the conductance Goff of the open switch could be also exactly zero. Note, there are circuits, where a description with zero Ron or zero Goff is not possible.</p>
<p><strong>Please note:</strong> In case of useHeatPort=true the temperature dependence of the electrical behavior is <strong>not </strong>modelled. The parameters are not temperature dependent.</p>
</html>", revisions="<html>
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
          Text(
            extent={{-150,90},{150,50}},
            textString="%name",
            lineColor={0,0,255}),   Ellipse(extent={{-4,24},{4,16}}, lineColor=
            {0,0,255}),Line(points={{-96,0},{-40,0}}, color={0,0,255}),Line(
            points={{-96,40},{-40,40}}, color={0,0,255}),Line(points={{-40,0},{40,40}},
                     color={0,0,255}),Line(points={{-40,40},{40,0}}, color={0,0,255}),
            Line(points={{40,40},{96,40}}, color={0,0,255}),
                                             Line(points={{40,0},{96,0}}, color=
             {0,0,255})}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}})));
  end IdealIntermediateSwitch;

  model ControlledIdealCommutingSwitch "Controlled ideal commuting switch"
    parameter SI.Voltage level=0.5 "Switch level";
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
    Interfaces.Pin control
      "Control pin: if control.v > level p--n2 connected, otherwise p--n1 connected"
      annotation (Placement(transformation(
          origin={0,100},
          extent={{-10,-10},{10,10}},
          rotation=90)));
  protected
    Real s1(final unit="1");
    Real s2(final unit="1") "Auxiliary variables";
    constant SI.Voltage unitVoltage=1 annotation (HideResult=true);
    constant SI.Current unitCurrent=1 annotation (HideResult=true);
  equation
    control.i = 0;
    0 = p.i + n2.i + n1.i;

    p.v - n1.v = (s1*unitCurrent)*(if (control.v > level) then 1 else Ron);
    n1.i = -(s1*unitVoltage)*(if (control.v > level) then Goff else 1);
    p.v - n2.v = (s2*unitCurrent)*(if (control.v > level) then Ron else 1);
    n2.i = -(s2*unitVoltage)*(if (control.v > level) then 1 else Goff);
    LossPower = p.i*p.v + n1.i*n1.v + n2.i*n2.v;
    annotation (defaultComponentName="switch",
      Documentation(info="<html>
<p>
The commuting switch has a positive pin p and two negative pins n1 and n2.
The switching behaviour is controlled
by the control pin. If its voltage exceeds the value of the parameter level,
the pin p is connected with the negative pin n2. Otherwise, the pin p is
connected the negative pin n1.
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
</html>", revisions="<html>
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
            points={{0,-99},{0,25}},
            color={127,0,0},
            pattern=LinePattern.Dot),
          Text(
            extent={{-150,90},{150,50}},
            textString="%name",
            lineColor={0,0,255})}));
  end ControlledIdealCommutingSwitch;

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
         otherwise p1--n1, p2--n2  connected" annotation (Placement(
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

<p>
<img src=\"modelica://Modelica/Resources/Images/Electrical/Analog/ControlledIdealIntermediateSwitch1.png\"
     alt=\"ControlledIdealIntermediateSwitch1.png\">
</p>

<p>
In order to prevent singularities during switching, the opened switch has a (very low) conductance Goff and the closed switch has a (very low) resistance Ron.
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Electrical/Analog/ControlledIdealIntermediateSwitch2.png\"
     alt=\"ControlledIdealIntermediateSwitch2.png\">
</p>

<p>
The limiting case is also allowed, i.e., the resistance Ron of the closed switch could be exactly zero and the conductance Goff of the open switch could be also exactly zero. Note, there are circuits, where a description with zero Ron or zero Goff is not possible.</p>
<p><br><strong>Please note:</strong> In case of useHeatPort=true the temperature dependence of the electrical behavior is <strong>not </strong>modelled. The parameters are not temperature dependent.</p>
</html>", revisions="<html>
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
            lineColor={0,0,255})}));
  end ControlledIdealIntermediateSwitch;

  model IdealOpAmp "Ideal operational amplifier (norator-nullator pair)"
    SI.Voltage v1 "Voltage drop over the left port";
    SI.Voltage v2 "Voltage drop over the right port";
    SI.Current i1 "Current flowing from pos. to neg. pin of the left port";
    SI.Current i2 "Current flowing from pos. to neg. pin of the right port";
    Interfaces.PositivePin p1 "Positive pin of the left port" annotation (
        Placement(transformation(extent={{-110,-70},{-90,-50}}), iconTransformation(extent={{-110,-70},{-90,-50}})));
    Interfaces.NegativePin n1 "Negative pin of the left port" annotation (
        Placement(transformation(extent={{-110,50},{-90,70}}), iconTransformation(extent={{-110,50},{-90,70}})));
    Interfaces.PositivePin p2 "Positive pin of the right port" annotation (
        Placement(transformation(extent={{90,-10},{110,10}})));
    Interfaces.NegativePin n2 "Negative pin of the right port" annotation (
        Placement(transformation(
          origin={0,-100},
          extent={{10,-10},{-10,10}},
          rotation=270)));
  equation
    v1 = p1.v - n1.v;
    v2 = p2.v - n2.v;
    0 = p1.i + n1.i;
    0 = p2.i + n2.i;
    i1 = p1.i;
    i2 = p2.i;
    v1 = 0;
    i1 = 0;
    annotation (defaultComponentName="opAmp",
      Documentation(info="<html>
<p>
The ideal OpAmp is a two-port. The left port is fixed to <em>v1=0</em> and <em>i1=0</em>
(nullator). At the right port both any voltage <em>v2</em> and any current <em>i2</em>
are possible (norator).
</p>
</html>", revisions="<html>
<ul>
<li><em> 1998   </em>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>"),
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={
          Line(points={{60,0},{90,0}}, color={0,0,255}),
          Text(
            extent={{-150,130},{150,90}},
            textString="%name",
            lineColor={0,0,255}),
          Polygon(
            points={{70,0},{-70,80},{-70,-80},{70,0}},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255}),
          Line(points={{0,-40},{0,-100}}, color={0,0,255}),
          Line(points={{-100,60},{-70,60}}, color={0,0,255}),
          Line(points={{-100,-60},{-70,-60}}, color={0,0,255}),
          Line(points={{70,0},{100,0}}, color={0,0,255}),
          Line(points={{-60,50},{-40,50}}, color={0,0,255}),
          Line(points={{-60,-50},{-40,-50}}, color={0,0,255}),
          Line(points={{-50,-40},{-50,-60}}, color={0,0,255})}));
  end IdealOpAmp;

  model IdealOpAmp3Pin
    "Ideal operational amplifier (norator-nullator pair), but 3 pins"
    Interfaces.PositivePin in_p "Positive pin of the input port" annotation (
        Placement(transformation(extent={{-110,-70},{-90,-50}}), iconTransformation(extent={{-110,-70},{-90,-50}})));
    Interfaces.NegativePin in_n "Negative pin of the input port" annotation (
        Placement(transformation(extent={{-110,50},{-90,70}}), iconTransformation(extent={{-110,50},{-90,70}})));
    Interfaces.PositivePin out "Output pin" annotation (Placement(
          transformation(extent={{90,-10},{110,10}}), iconTransformation(extent={{90,-10},{110,10}})));
  equation
    in_p.v = in_n.v;
    in_p.i = 0;
    in_n.i = 0;
    annotation (defaultComponentName="opAmp",
      Documentation(info="<html>
<p>
The ideal OpAmp with three pins is of exactly the same behaviour as the ideal
OpAmp with four pins. Only the negative output pin is left out.
Both the input voltage and current are fixed to zero (nullator).
At the output pin both any voltage <em>v2</em> and any current <em>i2</em>
are possible.
</p>
</html>", revisions="<html>
<ul>
<li><em> 2002   </em>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>"),
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={
          Line(points={{60,0},{90,0}}, color={0,0,255}),
          Text(
            extent={{-150,130},{150,90}},
            textString="%name",
            lineColor={0,0,255}),
          Polygon(
            points={{70,0},{-70,80},{-70,-80},{70,0}},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255}),
          Line(points={{-100,60},{-70,60}}, color={0,0,255}),
          Line(points={{-100,-60},{-70,-60}}, color={0,0,255}),
          Line(points={{70,0},{100,0}}, color={0,0,255}),
          Line(points={{-60,50},{-40,50}}, color={0,0,255}),
          Line(points={{-60,-50},{-40,-50}}, color={0,0,255}),
          Line(points={{-50,-40},{-50,-60}}, color={0,0,255})}));
  end IdealOpAmp3Pin;

  model IdealOpAmpLimited "Ideal operational amplifier with limitation"
    Interfaces.PositivePin in_p "Positive pin of the input port" annotation (
        Placement(transformation(extent={{-110,-70},{-90,-50}}), iconTransformation(extent={{-110,-70},{-90,-50}})));
    Interfaces.NegativePin in_n "Negative pin of the input port" annotation (
        Placement(transformation(extent={{-110,50},{-90,70}}), iconTransformation(extent={{-110,50},{-90,70}})));
    Interfaces.PositivePin out "Output pin" annotation (Placement(
          transformation(extent={{90,-10},{110,10}})));
    Interfaces.PositivePin VMax "Positive output voltage limitation"
      annotation (Placement(transformation(extent={{-10,90},{10,110}}), iconTransformation(extent={{-10,90},{10,110}})));
    Interfaces.NegativePin VMin "Negative output voltage limitation"
      annotation (Placement(transformation(extent={{-10,-110},{10,-90}}), iconTransformation(extent={{-10,-110},{10,-90}})));
    SI.Voltage vin "input voltage";
  protected
    Real s(start=0, final unit="1") "Auxiliary variable";
    constant SI.Voltage unitVoltage=1 annotation (HideResult=true);

  equation
    in_p.i = 0;
    in_n.i = 0;
    VMax.i = 0;
    VMin.i = 0;
    vin = in_p.v - in_n.v;
    in_p.v - in_n.v = unitVoltage*smooth(0, (if s < -1 then s + 1 else if s > 1
       then s - 1 else 0));
    out.v = smooth(0, if s < -1 then VMin.v else if s > 1 then VMax.v else (
      VMax.v - VMin.v)*s/2 + (VMax.v + VMin.v)/2);
    annotation (defaultComponentName="opAmp",
      Documentation(info="<html>
<p>
The ideal OpAmp with limitation behaves like an ideal OpAmp without limitation,
if the output voltage is within the limits VMin and VMax. In this case
the input voltage vin = in_p.v - in_n.v is zero.
If the input voltage vin less than 0, the output voltage is out.v = VMin.
If the input voltage is vin larger than 0, the output voltage is out.v = VMax.
</p>
</html>", revisions="<html>
<ul>
<li><em> 1998   </em>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>"),
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={
          Line(points={{60,0},{90,0}}, color={0,0,255}),
          Polygon(
            points={{70,0},{-70,80},{-70,-80},{70,0}},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255}),
          Line(points={{-100,60},{-70,60}}, color={0,0,255}),
          Line(points={{-100,-60},{-70,-60}}, color={0,0,255}),
          Line(points={{-60,50},{-40,50}}, color={0,0,255}),
          Line(points={{-50,-40},{-50,-60}}, color={0,0,255}),
          Line(points={{-60,-50},{-40,-50}}, color={0,0,255}),
          Line(points={{70,0},{100,0}}, color={0,0,255}),
          Line(points={{-45,-10},{-10,-10},{-10,10},{20,10}}, color={0,0,255}),
          Text(
            extent={{-150,150},{150,110}},
            textString="%name",
            lineColor={0,0,255}),
          Line(points={{0,40},{0,100}}, color={0,0,255}),
          Line(points={{0,-100},{0,-40}}, color={0,0,255})}));
  end IdealOpAmpLimited;

  model IdealizedOpAmpLimted "Idealized operational amplifier with limitation"
    parameter Real V0=15000.0 "No-load amplification";
    parameter Boolean useSupply=false
      "Use supply pins (otherwise constant supply)" annotation (Evaluate=true);
    parameter SI.Voltage Vps=+15 "Positive supply voltage"
      annotation (Dialog(enable=not useSupply));
    parameter SI.Voltage Vns=-15 "Negative supply voltage"
      annotation (Dialog(enable=not useSupply));
    parameter Boolean strict=true "= true, if strict limits with noEvent(..)"
      annotation (Evaluate=true, choices(checkBox=true), Dialog(tab="Advanced"));
    parameter Modelica.Blocks.Types.LimiterHomotopy homotopyType = Modelica.Blocks.Types.LimiterHomotopy.Linear "Simplified model for homotopy-based initialization"
      annotation (Evaluate=true, Dialog(group="Initialization"));
    SI.Voltage vps "Positive supply voltage";
    SI.Voltage vns "Negative supply voltage";
    SI.Voltage v_in=in_p.v - in_n.v "Input voltage difference";
    SI.Voltage v_out=out.v "Output voltage to ground";
    SI.Power p_in=in_p.v*in_p.i + in_n.v*in_n.i "Input power";
    SI.Power p_out=out.v*out.i "Output power";
    SI.Power p_s=-(p_in + p_out) "Supply power";
    SI.Current i_s=p_s/(vps - vns) "Supply current";
    Modelica.Electrical.Analog.Interfaces.PositivePin in_p
      "Positive pin of the input port" annotation (Placement(transformation(
            extent={{-90,-70},{-110,-50}})));
    Modelica.Electrical.Analog.Interfaces.NegativePin in_n
      "Negative pin of the input port" annotation (Placement(transformation(
            extent={{-110,50},{-90,70}})));
    Modelica.Electrical.Analog.Interfaces.PositivePin out
      "Pin of the output port" annotation (Placement(transformation(extent={{
              110,-10},{90,10}}), iconTransformation(extent={{110,-10},
              {90,10}})));
    //optional supply pins
    Modelica.Electrical.Analog.Interfaces.PositivePin s_p(final i=+i_s, final v=
         vps) if useSupply "Optional positive supply pin" annotation (Placement(
          transformation(extent={{10,90},{-10,110}})));
    Modelica.Electrical.Analog.Interfaces.NegativePin s_n(final i=-i_s, final v=
         vns) if useSupply "Optional negative supply pin" annotation (Placement(
          transformation(extent={{-10,-110},{10,-90}})));
  protected
    SI.Voltage simplifiedExpr "Simplified expression for homotopy-based initialization";
  equation
    if not useSupply then
      vps = Vps;
      vns = Vns;
    end if;
    in_p.i = 0;
    in_n.i = 0;
    simplifiedExpr = (if homotopyType == Modelica.Blocks.Types.LimiterHomotopy.Linear then V0*v_in
                      else if homotopyType == Modelica.Blocks.Types.LimiterHomotopy.UpperLimit then vps
                      else if homotopyType == Modelica.Blocks.Types.LimiterHomotopy.LowerLimit then vns
                      else 0);
    if strict then
      if homotopyType == Modelica.Blocks.Types.LimiterHomotopy.NoHomotopy then
        v_out = smooth(0, noEvent(if V0*v_in>vps then vps else if V0*v_in<vns then vns else V0*v_in));
      else
        v_out = homotopy(actual = smooth(0, noEvent(if V0*v_in>vps then vps else if V0*v_in<vns then vns else V0*v_in)),
                         simplified=simplifiedExpr);
      end if;
    else
      if homotopyType == Modelica.Blocks.Types.LimiterHomotopy.NoHomotopy then
        v_out = smooth(0, if V0*v_in>vps then vps else if V0*v_in<vns then vns else V0*v_in);
      else
        v_out = homotopy(actual = smooth(0, if V0*v_in>vps then vps else if V0*v_in<vns then vns else V0*v_in),
                         simplified=simplifiedExpr);
      end if;
    end if;
    annotation (defaultComponentName="opAmp",
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
              100}}), graphics={
          Line(points={{60,0},{90,0}}, color={0,0,255}),
          Text(
            extent={{-150,150},{150,110}},
            textString="%name",
            lineColor={0,0,255}),
          Line(points={{60,0},{90,0}}, color={0,0,255}),
          Polygon(
            points={{70,0},{-70,80},{-70,-80},{70,0}},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255}),
          Line(points={{-100,60},{-70,60}}, color={0,0,255}),
          Line(points={{-100,-60},{-70,-60}}, color={0,0,255}),
          Line(points={{-60,50},{-40,50}}, color={0,0,255}),
          Line(points={{-50,-40},{-50,-60}}, color={0,0,255}),
          Line(points={{-60,-50},{-40,-50}}, color={0,0,255}),
          Line(points={{0,40},{0,100}}, color={0,0,255}, visible=useSupply),
          Line(points={{0,-100},{0,-40}}, color={0,0,255}, visible=useSupply)}),
      Documentation(info="<html>
<p>Idealized operational amplifier with saturation:</p>
<ul>
<li>Input currents are zero.</li>
<li>No-load amplification is high (but not infinite).</li>
<li>Output voltage is limited between positive and negative supply.</li>
</ul>
<p>Supply voltage is either defined by parameter Vps and Vns or by (optional) pins s_p and s_n.</p>
<p>In the first case the necessary power is drawn from an implicit internal supply, in the second case from the external supply.</p>
</html>"));
  end IdealizedOpAmpLimted;

  model IdealTransformer "Ideal transformer core with or without magnetization"
    extends Modelica.Electrical.Analog.Interfaces.TwoPort;
    parameter Real n(start=1) "Turns ratio primary:secondary voltage";
    parameter Boolean considerMagnetization=false
      "Choice of considering magnetization";
    parameter SI.Inductance Lm1(start=1)
      "Magnetization inductance w.r.t. primary side"
      annotation (Dialog(enable=considerMagnetization));
  protected
    SI.Current im1 "Magnetization current w.r.t. primary side";
    SI.MagneticFlux psim1 "Magnetic flux w.r.t. primary side";
  equation
    im1 = i1 + i2/n;
    if considerMagnetization then
      psim1 = Lm1*im1;
      v1 = der(psim1);
    else
      psim1 = 0;
      im1 = 0;
    end if;
    v1 = n*v2;
    annotation (defaultComponentName="transformer",
      Documentation(info="<html>
<p>
The ideal transformer is a two-port circuit element;
in case of Boolean parameter <code>considerMagnetization = false</code> it is characterized by the following equations:
</p>
<pre> i2 = -i1*n;
 v2 =  v1/n;
</pre>
<p>
where <code>n</code> is a real number called the turns ratio.
Due to this equations, also DC voltages and currents are transformed - which is not the case for technical transformers.
</p>
<p>
In case of Boolean parameter <code>considerMagnetization = true</code> it is characterized by the following equations:
</p>
<pre>
 im1  = i1 + i2/n \"Magnetizing current w.r.t. primary side\";
 psim1= Lm1*im1   \"Magnetic flux w.r.t. primary side\";
 v1 = der(psim1)  \"Primary voltage\";
 v2 = v1/n        \"Secondary voltage\";
</pre>
<p>
where <code>Lm</code> denotes the magnetizing inductance.
Due to this equations, the DC offset of secondary voltages and currents decrement according to the time constant defined by the connected circuit.
</p>
<p>
Taking primary <code>L1sigma</code> and secondary <code>L2ssigma</code> leakage inductances into account,
compared with the <a href=\"modelica://Modelica.Electrical.Analog.Basic.Transformer\">basic transformer</a>
the following parameter conversion can be applied (which leads to identical results):
</p>
<pre>
 L1 = L1sigma + M*n \"Primary inductance at secondary no-load\";
 L2 = L2sigma + M/n \"Secondary inductance at primary no-load\";
  M  = Lm1/n         \"Mutual inductance\";
</pre>
<p>
For the backward conversion, one has to decide about the partitioning of the leakage to primary and secondary side.
</p>
</html>", revisions="<html>
<ul>
<li><em>June 3, 2009   </em>
       magnetisation current added by Anton Haumer<br>
       </li>
<li><em>1998   </em>
       initially implemented by Christoph Clauss<br>
       </li>
</ul>
</html>"),
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
              100}}), graphics={
          Text(extent={{-150,-110},{150,-150}},textString="n=%n"),
          Text(
            extent={{-100,20},{-60,-20}},
            lineColor={0,0,255},
            textString="1"),
          Text(
            extent={{60,20},{100,-20}},
            lineColor={0,0,255},
            textString="2"),
          Text(
            extent={{-150,150},{150,110}},
            textString="%name",
            lineColor={0,0,255}),
          Line(points={{-40,60},{-40,100},{-90,100}}, color={0,0,255}),
          Line(points={{40,60},{40,100},{90,100}}, color={0,0,255}),
          Line(points={{-40,-60},{-40,-100},{-90,-100}}, color={0,0,255}),
          Line(points={{40,-60},{40,-100},{90,-100}}, color={0,0,255}),
          Line(
            points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}},
            color={0,0,255},
            smooth=Smooth.Bezier,
            origin={-33,45},
            rotation=270),
          Line(
            points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}},
            color={0,0,255},
            smooth=Smooth.Bezier,
            origin={-33,15},
            rotation=270),
          Line(
            points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}},
            color={0,0,255},
            smooth=Smooth.Bezier,
            origin={-33,-15},
            rotation=270),
          Line(
            points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}},
            color={0,0,255},
            smooth=Smooth.Bezier,
            origin={-33,-45},
            rotation=270),
          Line(
            points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}},
            color={0,0,255},
            smooth=Smooth.Bezier,
            origin={33,45},
            rotation=90),
          Line(
            points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}},
            color={0,0,255},
            smooth=Smooth.Bezier,
            origin={33,15},
            rotation=90),
          Line(
            points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}},
            color={0,0,255},
            smooth=Smooth.Bezier,
            origin={33,-15},
            rotation=90),
          Line(
            points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}},
            color={0,0,255},
            smooth=Smooth.Bezier,
            origin={33,-45},
            rotation=90)}));
  end IdealTransformer;

  model IdealGyrator "Ideal gyrator"
    extends Interfaces.TwoPort;
    parameter SI.Conductance G(start=1) "Gyration conductance";

  equation
    i1 = G*v2;
    i2 = -G*v1;
    annotation (defaultComponentName="gyrator",
      Documentation(info="<html>
<p>
A gyrator is an ideal two-port element defined by the following equations:
<br><br>
<code>
    i1 =  G * v2<br>
    i2 = -G * v1<br>
</code>
<br>
where the constant <em>G</em> is called the gyration conductance.
</p>
</html>", revisions="<html>
<ul>
<li><em> 1998   </em>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>"),
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}},
          grid={2,2}),graphics={
          Line(points={{-90,100},{-40,100},{-40,-100},{-90,-100}},
                                                               color={0,0,255}),
          Line(points={{-30,60},{20,60}}, color={0,0,255}),
          Polygon(
            points={{20,63},{30,60},{20,57},{20,63}},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255}),
          Line(points={{90,100},{40,100},{40,-100},{90,-100}},
                                                           color={0,0,255}),
          Text(
            extent={{-150,150},{150,110}},
            textString="%name",
            lineColor={0,0,255}),
          Line(
            points={{-40,30},{-25,28},{-10,12},{-10,-12},{-26,-28},{-40,-30}},
            color={0,0,255},
            smooth=Smooth.Bezier),
          Line(
            points={{-14,30},{1,28},{16,12},{16,-12},{0,-28},{-14,-30}},
            color={0,0,255},
            smooth=Smooth.Bezier,
            origin={26,0},
            rotation=180),
          Rectangle(extent={{-80,80},{80,-80}}, lineColor={0,0,255})}));
  end IdealGyrator;

  model Idle "Idle branch"
    extends Interfaces.OnePort;
  equation
    i = 0;
    annotation (
      Documentation(info="<html>
<p>The model Idle is a simple idle running branch. That means between both pins no current is running. This ideal device is of no influence on the circuit. Therefore, it can be neglected in each case. For purposes of completeness this component is part of the MSL, as an opposite of the short cut.</p>
</html>", revisions="<html>
<ul>
<li><em> 1998   </em>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>"),
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={
          Rectangle(
            extent={{-80,80},{80,-80}},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255}),
          Line(points={{-90,0},{-41,0}}, color={0,0,255}),
          Line(points={{91,0},{40,0}}, color={0,0,255}),
          Text(
            extent={{-150,130},{150,90}},
            textString="%name",
            lineColor={0,0,255})}));
  end Idle;

  model Short "Short cut branch"
    extends Interfaces.OnePort;
  equation
    v = 0;
    annotation (
      Documentation(info="<html>
<p>The model Short is a simple short cut branch. That means the voltage drop between both pins is zero. This device could be neglected if both pins are combined to one node. Besides connecting the nodes of both pins this device has no further function.</p>
</html>", revisions="<html>
<ul>
<li><em> 1998   </em>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>"),
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={
          Rectangle(
            extent={{-80,80},{80,-80}},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255}),
          Line(points={{91,0},{-90,0}}, color={0,0,255}),
          Text(
            extent={{-150,130},{150,90}},
            textString="%name",
            lineColor={0,0,255})}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics={
            Text(
              extent={{-100,100},{100,70}},
              textString="Short",
              lineColor={0,0,255})}));
  end Short;

  model IdealOpeningSwitch "Ideal electrical opener"
    extends Modelica.Electrical.Analog.Interfaces.IdealSwitch;
    Modelica.Blocks.Interfaces.BooleanInput control
      "true => switch open, false => p--n connected" annotation (Placement(
          transformation(
          origin={0,120},
          extent={{-20,-20},{20,20}},
          rotation=270), iconTransformation(
          extent={{-20,-20},{20,20}},
          rotation=270,
          origin={0,120})));
  equation
    off = control;
    annotation (defaultComponentName="switch",
      Documentation(info="<html>
<p>
The switching behaviour of the ideal opening switch is controlled by the input signal control: off = control.<br>
For further details, see partial model <a href=\"modelica://Modelica.Electrical.Analog.Interfaces.IdealSwitch\">IdealSwitch</a>.
</p>
</html>", revisions="<html>
<ul>
<li><em>February 7, 2016   </em>
       by Anton Haumer<br> extending from partial IdealSwitch<br>
       </li>
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
          Line(points={{40,20},{40,0}}, color={0,0,255}),
          Line(
            visible=useHeatPort,
            points={{0,-100},{0,25}},
            color={127,0,0},
            pattern=LinePattern.Dot)}));
  end IdealOpeningSwitch;

  model IdealClosingSwitch "Ideal electrical closer"
    extends Modelica.Electrical.Analog.Interfaces.IdealSwitch;
    Modelica.Blocks.Interfaces.BooleanInput control
      "true => p--n connected, false => switch open" annotation (Placement(
          transformation(
          origin={0,120},
          extent={{-20,-20},{20,20}},
          rotation=270)));
  equation
    off = not control;
    annotation (defaultComponentName="switch",
      Documentation(info="<html>
<p>
The switching behaviour of the ideal closing switch is controlled by the input signal control: off = not control.<br>
For further details, see partial model <a href=\"modelica://Modelica.Electrical.Analog.Interfaces.IdealSwitch\">IdealSwitch</a>.
</p>
</html>", revisions="<html>
<ul>
<li><em>February 7, 2016   </em>
       by Anton Haumer<br> extending from partial IdealSwitch<br>
       </li>
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
          Line(
            visible=useHeatPort,
            points={{0,-100},{0,25}},
            color={127,0,0},
            pattern=LinePattern.Dot)}));
  end IdealClosingSwitch;

  model ControlledIdealOpeningSwitch "Controlled ideal electrical opener"
    parameter SI.Voltage level=0.5 "Switch level";
    extends Modelica.Electrical.Analog.Interfaces.IdealSwitch;
    Modelica.Electrical.Analog.Interfaces.Pin control
      "Control pin: control.v > level switch open, otherwise p--n connected"
      annotation (Placement(transformation(
          origin={0,100},
          extent={{-10,-10},{10,10}},
          rotation=90)));
  equation
    off = control.v > level;
    control.i = 0;
    annotation (defaultComponentName="switch",
      Documentation(info="<html>
<p>
The switching behaviour of the controlled  ideal opening switch is controlled by the control pin: off = control.v &gt; level<br>
For further details, see partial model <a href=\"modelica://Modelica.Electrical.Analog.Interfaces.IdealSwitch\">IdealSwitch</a>.
</p>
</html>", revisions="<html>
<ul>
<li><em>February 7, 2016   </em>
       by Anton Haumer<br> extending from partial IdealSwitch<br>
       </li>
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
          Line(points={{40,20},{40,0}}, color={0,0,255}),
          Line(
            visible=useHeatPort,
            points={{0,-100},{0,25}},
            color={127,0,0},
            pattern=LinePattern.Dot)}));
  end ControlledIdealOpeningSwitch;

  model ControlledIdealClosingSwitch "Controlled ideal electrical closer"
    parameter SI.Voltage level=0.5 "Switch level";
    extends Modelica.Electrical.Analog.Interfaces.IdealSwitch;
    Modelica.Electrical.Analog.Interfaces.Pin control
      "Control pin: control.v > level switch closed, otherwise switch open"
      annotation (Placement(transformation(
          origin={0,100},
          extent={{-10,-10},{10,10}},
          rotation=90)));
  equation
    off = control.v < level;
    control.i = 0;
    annotation (defaultComponentName="switch",
      Documentation(info="<html>
<p>
The switching behaviour of the controlled ideal closing switch is controlled by the control pin: off = control.v &lt; level<br>
For further details, see partial model <a href=\"modelica://Modelica.Electrical.Analog.Interfaces.IdealSwitch\">IdealSwitch</a>.
</p>

</html>", revisions="<html>
<ul>
<li><em>February 7, 2016   </em>
       by Anton Haumer<br> extending from partial IdealSwitch<br>
       </li>
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
          Line(
            visible=useHeatPort,
            points={{0,-100},{0,25}},
            color={127,0,0},
            pattern=LinePattern.Dot)}));
  end ControlledIdealClosingSwitch;

  model OpenerWithArc "Ideal opening switch with simple arc model"
    extends Modelica.Electrical.Analog.Interfaces.IdealSwitchWithArc;
    Modelica.Blocks.Interfaces.BooleanInput control
      "false => p--n connected, true => switch open" annotation (Placement(
          transformation(
          origin={0,110},
          extent={{-10,-10},{10,10}},
          rotation=270)));
  equation
    off = control;
    annotation (defaultComponentName="switch",
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={
          Line(points={{40,20},{40,0}}, color={0,0,255}),
          Line(points={{40,40},{32,30},{48,26},{40,20}}, color={255,0,0})}),
      Documentation(info="<html>
<p>
This model is an extension to the <a href=\"modelica://Modelica.Electrical.Analog.Ideal.IdealOpeningSwitch\">IdealOpeningSwitch</a>.
</p>
<p>
For details of the arc effect, see partial model <a href=\"modelica://Modelica.Electrical.Analog.Interfaces.IdealSwitchWithArc\">IdealSwitchWithArc</a>.
</p>
</html>", revisions="<html>
<ul>
<li><em>February 7, 2016   </em>
       by Anton Haumer<br> extending from partial IdealSwitchWithArc<br>
       </li>
<li><em>June, 2009   </em>
       by Christoph Clauss<br> adapted to OpenerWithArc<br>
       </li>
<li><em>May, 2009   </em>
       by Anton Haumer<br> CloserWithArc initially implemented<br>
       </li>
</ul>
</html>"));
  end OpenerWithArc;

  model CloserWithArc "Ideal closing switch with simple arc model"
    extends Modelica.Electrical.Analog.Interfaces.IdealSwitchWithArc;
    Modelica.Blocks.Interfaces.BooleanInput control
      "true => p--n connected, false => switch open" annotation (Placement(
          transformation(
          origin={0,110},
          extent={{-10,-10},{10,10}},
          rotation=270)));
  equation
    off = not control;
    annotation (defaultComponentName="switch",
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
              100}}), graphics={
          Line(points={{40,40},{32,14},{48,22},{40,0}}, color={255,0,0})}),
      Documentation(info="<html>
<p>
This model is an extension to the <a href=\"modelica://Modelica.Electrical.Analog.Ideal.IdealClosingSwitch\">IdealClosingSwitch</a>.
</p>
<p>
For details of the arc effect, see partial model <a href=\"modelica://Modelica.Electrical.Analog.Interfaces.IdealSwitchWithArc\">IdealSwitchWithArc</a>.
</p>
</html>", revisions="<html>
<ul>
<li><em>February 7, 2016   </em>
       by Anton Haumer<br> extending from partial IdealSwitchWithArc<br>
       </li>
<li><em>May, 2009   </em>
       by Anton Haumer<br> initially implemented<br>
       </li>
</ul>
</html>"));
  end CloserWithArc;

  model ControlledOpenerWithArc
    "Controlled ideal electrical opener with simple arc model"
    parameter SI.Voltage level=0.5 "Switch level";
    extends Modelica.Electrical.Analog.Interfaces.IdealSwitchWithArc;
    Modelica.Electrical.Analog.Interfaces.Pin control
      "Control pin: control.v > level switch open, otherwise p--n connected"
      annotation (Placement(transformation(
          origin={0,100},
          extent={{-10,-10},{10,10}},
          rotation=90)));
  equation
    off = control.v > level;
    control.i = 0;
    annotation (defaultComponentName="switch",
      Documentation(info="<html>
<p>
This model is an extension to the <a href=\"modelica://Modelica.Electrical.Analog.Ideal.ControlledIdealOpeningSwitch\">ControlledIdealOpeningSwitch</a>.
</p>
<p>
For details of the arc effect, see partial model <a href=\"modelica://Modelica.Electrical.Analog.Interfaces.IdealSwitchWithArc\">IdealSwitchWithArc</a>.
</p>
</html>", revisions="<html>
<ul>
<li><em>February 7, 2016   </em>
       by Anton Haumer<br> extending from partial IdealSwitchWithArc<br>
       </li>
<li><em>May, 2009   </em>
       by Anton Haumer<br> initially implemented<br>
       </li>
</ul>
</html>"),
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={
          Line(points={{40,20},{40,0}}, color={0,0,255}),
          Line(points={{40,40},{32,30},{48,28},{40,20}}, color={255,0,0})}));
  end ControlledOpenerWithArc;

  model ControlledCloserWithArc
    "Controlled ideal electrical closer with simple arc model"
    parameter SI.Voltage level=0.5 "Switch level";
    extends Modelica.Electrical.Analog.Interfaces.IdealSwitchWithArc;
    Modelica.Electrical.Analog.Interfaces.Pin control
      "Control pin: control.v > level switch closed, otherwise switch open"
      annotation (Placement(transformation(
          origin={0,100},
          extent={{-10,-10},{10,10}},
          rotation=90)));
  equation
    off = control.v < level;
    control.i = 0;
    annotation (defaultComponentName="switch",
      Documentation(info="<html>
<p>
This model is an extension to the <a href=\"modelica://Modelica.Electrical.Analog.Ideal.ControlledIdealClosingSwitch\">ControlledIdealClosingSwitch</a>.
</p>
<p>
For details of the arc effect, see partial model <a href=\"modelica://Modelica.Electrical.Analog.Interfaces.IdealSwitchWithArc\">IdealSwitchWithArc</a>.
</p>
</html>", revisions="<html>
<ul>
<li><em>February 7, 2016   </em>
       by Anton Haumer<br> extending from partial IdealSwitchWithArc<br>
       </li>
<li><em>May, 2009   </em>
       by Anton Haumer<br> initially implemented<br>
       </li>
</ul>
</html>"),
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={
          Line(points={{40,40},{34,16},{48,24},{40,0}}, color={255,0,0})}));
  end ControlledCloserWithArc;

  model IdealTriac "Ideal triac, based on ideal thyristors"

    parameter SI.Resistance Ron(final min=0) = 1e-5 "Closed triac resistance";
    parameter SI.Conductance Goff(final min=0) = 1e-5
      "Opened triac conductance";
    parameter SI.Voltage Vknee(
      final min=0,
      start=0) = 0.8 "Threshold voltage for positive and negative phase";

    parameter SI.Resistance Rdis=100 "Resistance of disturbance elimination";
    parameter SI.Capacitance Cdis=0.005 "Capacity of disturbance elimination";

    Modelica.Electrical.Analog.Ideal.IdealThyristor idealThyristor(
      Ron=Ron,
      Goff=Goff,
      Vknee=Vknee) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          origin={-10,32})));
    Modelica.Electrical.Analog.Ideal.IdealThyristor idealThyristor1(
      Ron=Ron,
      Goff=Goff,
      Vknee=Vknee) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={-10,-32})));
    Modelica.Electrical.Analog.Basic.Resistor resistor(R=Rdis)
      annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
    Modelica.Electrical.Analog.Basic.Capacitor capacitor(C=Cdis)
      annotation (Placement(transformation(extent={{20,-10},{40,10}})));
    Modelica.Blocks.Interfaces.BooleanInput fire1 "Gate"
      annotation (Placement(transformation(extent={{-14,-14},{14,14}},
          rotation=90,
          origin={-100,-114}), iconTransformation(
          extent={{-14,-14},{14,14}},
          rotation=90,
          origin={-100,-114})));
    Modelica.Electrical.Analog.Interfaces.NegativePin n "Cathode"
      annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
    Modelica.Electrical.Analog.Interfaces.PositivePin p "Anode"
      annotation (Placement(transformation(extent={{94,-10},{114,10}})));
  equation

    connect(idealThyristor.n, capacitor.n) annotation (Line(
        points={{0,32},{40,32},{40,0}}, color={0,0,255}));
    connect(capacitor.n, idealThyristor1.p) annotation (Line(
        points={{40,0},{40,-32},{0,-32}}, color={0,0,255}));
    connect(idealThyristor1.n, resistor.p) annotation (Line(
        points={{-20,-32},{-60,-32},{-60,0}}, color={0,0,255}));
    connect(resistor.p, idealThyristor.p) annotation (Line(
        points={{-60,0},{-60,32},{-20,32}}, color={0,0,255}));
    connect(resistor.n, capacitor.p) annotation (Line(
        points={{-40,0},{20,0}}, color={0,0,255}));
    connect(idealThyristor1.fire, fire1) annotation (Line(
        points={{-20,-44},{-20,-100},{-100,-100},{-100,-114},{-100,-114}}, color={255,0,255}));
    connect(idealThyristor.fire, fire1) annotation (Line(
        points={{0,44},{0,60},{-80,60},{-80,-100},{-100,-100},{-100,-114},{-100,-114}}, color={255,0,255}));
    connect(n, idealThyristor.p) annotation (Line(
        points={{-100,0},{-90,0},{-90,40},{-20,40},{-20,32}}, color={0,0,255}));
    connect(idealThyristor1.p, p) annotation (Line(
        points={{0,-32},{0,-40},{80,-40},{80,0},{104,0}}, color={0,0,255}));
    annotation (defaultComponentName="triac",
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
              {100,100}}), graphics={
          Polygon(
            points={{-30,0},{-30,-100},{70,-50},{-30,0}},
            lineColor={0,0,255}),
          Polygon(
            points={{70,100},{70,0},{-30,50},{70,100}},
            lineColor={0,0,255}),
          Line(
            points={{70,0},{70,-100}}, color={0,0,255}),
          Line(
            points={{-30,0},{-30,100}}, color={0,0,255}),
          Line(
            points={{-30,0},{-90,0}}, color={0,0,255}),
          Line(
            points={{70,0},{110,0}}, color={0,0,255}),
          Line(
            points={{-100,-80},{-80,-80},{-30,-50}}, color={0,0,255}),
          Text(
            extent={{-150,150},{150,110}},
            textString="%name",
            lineColor={0,0,255}),
          Line(points={{-100,-100},{-100,-80}}, color={0,0,255})}),
                                    Documentation(info="<html>
<p>This is an ideal triac model based on an ideal thyristor model.</p>

<p>Two ideal thyristors (Modelica.Electrical.Analog.Ideal.IdealThyristor) are contrarily connected in parallel and additionally eliminated interference with a resistor (Rdis=100) and a capacitor (Cdis=0.005), which are connected in series.</p>

<p>The electrical component triac (TRIode Alternating Current switch) is, due to whose complex structure, a multifunctional applicable construction unit. The application area of this element is the manipulation of alternating current signals in frequency, voltage and/or current and also general blocking or filtering. However, compared to a thyristor the triac is only applied for substantial lesser currents, what is justified by whose sensitive structure. Generally one is limited to maximal voltages from 800 volt and currents from 40 ampere. For comparison maximal voltages of a thyristor are 8.000 volt and currents 5.000 ampere.</p>

<p>Structure and functionality:</p>

<p>Functionality of a triac is in principle the same like functionality of a thyristor, even connecting through of current starting from a certain voltage (knee voltage), but only if the current at anode and cathode is caused by a impulse current in the gate electrode. In case of the triac this process is also possible with reverse polarity, wherefore it is possible to control both half-waves of alternating currents. By means of gate electrodes, which are connected in a triac and why only one gate electrode is necessary, the point of time can be determined, at which the triac lets the alternating current signal pass. Thereby it is possible to affect the phase, at which the alternating current signal is cut. One speaks also of phase-angle control. Also depending on doping and specific structure knee voltage and maximal current carrying are alterable.</p>

<p>Characteristics:</p>
<ul>
<li>high switching times between on-state and off state up to activation of the reverse current phase</li>
<li>gate electrode are activated with (positive) impulse (called thyristor/triac firing), after firing thyristor path holds itself in state of low resistance or conductive state up to holding voltage is fallen below, it follows change to off state and next thyristor path can fire</li>
<li>in particular by switching of inductive components triacs generate harmonic waves, whose frequency ranges into broadcast sector and could there cause transmission disturbances; therefore triacs have to eliminate interference by inductors and capacitors</li>
</ul>
<p>Applications:</p>
<ul>
<li>any stepless exposure (dimmer)</li>
<li>engine speed adjustment of electric motors</li>
<li>further applications of phase-angle control (power electronics)</li>
<li>power packs</li>
</ul>
<p>As an additional information: this model is based on the Modelica.Electrical.Analog.Ideal.IdealThyristor.</p>
</html>", revisions="<html>
<ul>
<li><em>November 25, 2009   </em><br>

       by Susann Wolf<br><br>
       </li>
</ul>
</html>"));
  end IdealTriac;

  model AD_Converter "Simple n-bit analog to digital converter"
    import L = Modelica.Electrical.Digital.Interfaces.Logic;
    Modelica.Electrical.Analog.Interfaces.PositivePin p
      "Positive electrical pin (input)" annotation (Placement(transformation(
            extent={{-110,90},{-90,110}}),
                                         iconTransformation(extent={{-110,90},{-90,110}})));
    Modelica.Electrical.Analog.Interfaces.NegativePin n
      "Negative electrical pin (input)" annotation (Placement(transformation(
            extent={{-110,-110},{-90,-90}}),
                                           iconTransformation(
            extent={{-110,-110},{-90,-90}})));
    Modelica.Electrical.Digital.Interfaces.DigitalOutput y[N] "Digital output"
      annotation (Placement(transformation(extent={{100,-10},{120,10}}),
                                                                       iconTransformation(extent={{100,-10},{120,10}})));
    Modelica.Electrical.Digital.Interfaces.DigitalInput trig "Trigger input"
      annotation (Placement(transformation(extent={{-8,90},{12,110}}),
          iconTransformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={0,100})));
    parameter Integer N(final min=1, start=8)
      "Resolution in bits - output signal width";
    parameter SI.Voltage VRefHigh(start=10) "High reference voltage";
    parameter SI.Voltage VRefLow(final max=VRefHigh, start=0)
      "Low reference voltage";
    parameter SI.Resistance Rin(start=10^6) "Input resistance";
    Integer z(start=0, fixed=true);
    Real u;

  initial algorithm
    for i in 1:N loop
      y[i] := L.'X';
    end for;

  algorithm
    when (trig == L.'1' or trig == L.'H') then
      z := if u > VRefLow then integer((u - VRefLow)/(VRefHigh - VRefLow)*(2^N
         - 1) + 0.5) else 0;
      for i in 1:N loop
        y[i] := if mod(z, 2) > 0 then L.'1' else L.'0';
        z := div(z, 2);
      end for;
    end when;
  equation
    p.v - n.v = u;
    p.i*Rin = u;
    p.i + n.i = 0;
    annotation (defaultComponentName="converter", Documentation(info="<html>
<p>
Simple analog to digital converter with a variable resolution of n bits.
It converts the input voltage <code>ppin.v-npin.v</code> to an n-vector of type Logic
(9-valued logic according to IEEE 1164 STD_ULOGIC). The input resistance between positive and negative pin is determined by <code>Rin</code>.
Further effects (like input capacities) have to be modeled outside the converter, since this should be a general model.</p>

<p>
The input signal range (VRefLo,VRefHi) is divided into 2^n-1 equally spaced stages of length Vlsb:=(VRefHi-VRefLo)/(2^n-1).
The output signal is the binary code of <code> k </code> as long as the input voltage takes values in the k-th stage, namely in the range from
<code>Vlsb*(k-0.5)</code> to <code>m*(k+0.5)</code>. This is called mid-tread operation. Additionally the output can only change
its value if the trigger signal <code>trig</code> of type Logic changes to '1' (forced or weak).
</p>

<p>
The output vector is a 'little-endian'. i.e., that the first bit y[1] is the least significant one (LSB).
</p>

<p>
This is an abstract model of an ADC. Therefore, it can not cover the dynamic behaviour of the converter.
Hence the output will change instantaneously when the trigger signal rises.
</p>

</html>", revisions="<html>
<ul>
<li><em> October 13, 2009   </em>
       by Matthias Franke
       </li>
</ul>
</html>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
              {100,100}}), graphics={
          Rectangle(extent={{-100,100},{100,-100}},
                                                lineColor={0,0,255}),
          Polygon(
            points={{-98,-100},{100,98},{100,-100},{-98,-100}},
            lineColor={0,0,255},
            fillColor={127,0,127},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-60,50},{60,10}},
            lineColor={0,0,255},
            textString="%n-bit"),
          Text(
            extent={{-60,-10},{60,-50}},
            lineColor={0,0,255},
            textString="ADC")}));
  end AD_Converter;

  model DA_Converter "Simple digital to analog converter"
    import L = Modelica.Electrical.Digital.Interfaces.Logic;
    Modelica.Electrical.Digital.Interfaces.DigitalInput trig "Trigger input"
      annotation (Placement(transformation(extent={{-10,92},{10,112}}),
          iconTransformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={0,100})));
    Modelica.Electrical.Digital.Interfaces.DigitalInput x[N] "Digital input"
      annotation (Placement(transformation(extent={{-110,-10},{-90,10}}), iconTransformation(extent={{-110,-10},{-90,10}})));
    Modelica.Electrical.Analog.Interfaces.PositivePin p
      "Positive electrical pin (output)" annotation (Placement(transformation(
            extent={{90,90},{110,110}}),
                                       iconTransformation(extent={{90,90},{110,110}})));
    Modelica.Electrical.Analog.Interfaces.NegativePin n
      "Negative electrical pin (output)" annotation (Placement(transformation(
            extent={{90,-110},{110,-90}}),
                                         iconTransformation(extent={{90,-110},{110,-90}})));

    SI.Voltage vout(start=0, fixed=true);
    Real y(start=0, fixed=true);
    parameter Integer N(final min=1, start=8) "Resolution - input signal width";
    parameter SI.Voltage Vref(start=10) "Reference voltage";

  algorithm
    when trig == L.'1' or trig == L.'H' then
      y := 0;
      for i in 1:N loop
        y := if (x[i] == L.'1' or x[i] == L.'H') then y + 2^(i - 1) else y;
      end for;
      vout := y*Vref/(2^N - 1);
    end when;

  equation
    p.v - n.v = vout;
    p.i + n.i = 0;

    annotation (defaultComponentName="converter", Documentation(info="<html>
<p>Simple digital to analog converter with a variable input signal width of N bits. The input signal is an N-vector of type Logic (9-valued logic according to IEEE 1164 STD_ULOGIC). The output voltage of value <code>y</code> is generated by an ideal voltage source. The output can only change if the trigger signal <code>trig</code> of type Logic changes to &#39;1&#39; (forced or weak). In this case, the output voltage is calculated in the following way:
</p>
<pre>       N
  y = SUM ( x[i]*2^(i-1) )*Vref/(2^N-1),
      i=1
</pre>
<p>where x[i], i=1,...,N is 1 or 0. and Vref is the reference value. Therefore, the first bit in the input vector x[1] is the least significant one (LSB) and x[N] is the most significant bit (MSB).</p>
<p>This is an abstract model of a DAC. Hence, it can not cover the dynamic behaviour of the converter. Therefore the output will change instantaneously when the trigger signal rises.</p>
</html>", revisions="<html>
<ul>
<li><em> October 13, 2009   </em>
       by Matthias Franke
       </li>
</ul>
</html>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
              {100,100}}), graphics={
          Rectangle(extent={{-100,100},{100,-100}},
                                                lineColor={0,0,255}),
          Polygon(
            points={{-100,-100},{100,100},{-100,100},{-100,-100}},
            lineColor={0,0,255},
            fillColor={127,0,127},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-60,50},{60,10}},
            lineColor={0,0,255},
            textString="%n-bit"),
          Text(
            extent={{-60,-10},{60,-50}},
            lineColor={0,0,255},
            textString="DAC")}));
  end DA_Converter;
  annotation (Documentation(info="<html>
<p>This package contains electrical components with idealized behaviour. To enable more realistic applications than it is possible with pure realistic behavior some components are improved by additional features. E.g. the switches have resistances for the open or close case which can be parametrized.</p>
</html>", revisions="<html>
<dl>
<dt>
<strong>Main Authors:</strong>
</dt>
<dd>
Christoph Clau&szlig;
    &lt;<a href=\"mailto:christoph@clauss-it.com\">christoph@clauss-it.com</a>&gt;<br>
    Andr&eacute; Schneider
    &lt;<a href=\"mailto:Andre.Schneider@eas.iis.fraunhofer.de\">Andre.Schneider@eas.iis.fraunhofer.de</a>&gt;<br>
    Fraunhofer Institute for Integrated Circuits<br>
    Design Automation Department<br>
    Zeunerstra&szlig;e 38<br>
    D-01069 Dresden
</dd>
<dt>
<strong>Copyright:</strong>
</dt>
<dd>
Copyright &copy; 1998-2018, Modelica Association and Fraunhofer-Gesellschaft.<br>
<em>The Modelica package is <strong>free</strong> software; it can be redistributed and/or modified
under the terms of the <strong>Modelica license</strong>, see the license conditions
and the accompanying <strong>disclaimer</strong> in the documentation of package
Modelica in file \"Modelica/package.mo\".</em>
</dd>
</dl>
</html>"), Icon(graphics={
        Line(points={{-90,0},{-40,0}}),
        Line(points={{-40,0},{32,60}}),
        Line(points={{40,0},{90,0}})}));
end Ideal;
