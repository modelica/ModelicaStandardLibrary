within Modelica.Electrical.Analog;
package Interfaces
  "Connectors and partial models for Analog electrical components"
  extends Modelica.Icons.InterfacesPackage;

  connector Pin "Pin of an electrical component"
    Modelica.SIunits.Voltage v "Potential at the pin" annotation (
        unassignedMessage="An electrical potential cannot be uniquely calculated.
The reason could be that
- a ground object is missing (Modelica.Electrical.Analog.Basic.Ground)
  to define the zero potential of the electrical circuit, or
- a connector of an electrical component is not connected.");
    flow Modelica.SIunits.Current i "Current flowing into the pin" annotation (
        unassignedMessage="An electrical current cannot be uniquely calculated.
The reason could be that
- a ground object is missing (Modelica.Electrical.Analog.Basic.Ground)
  to define the zero potential of the electrical circuit, or
- a connector of an electrical component is not connected.");
    annotation (defaultComponentName="pin",
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,255},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid)}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics={Rectangle(
            extent={{-40,40},{40,-40}},
            lineColor={0,0,255},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid), Text(
            extent={{-160,110},{40,50}},
            lineColor={0,0,255},
            textString="%name")}),
      Documentation(revisions="<html>
<ul>
<li><i> 1998   </i>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>", info="<html>
<p>Pin is the basic electric connector. It includes the voltage which consists between the pin and the ground node. The ground node is the node of (any) ground device (Modelica.Electrical.Basic.Ground). Furthermore, the pin includes the current, which is considered to be <b>positive</b> if it is flowing at the pin<b> into the device</b>.</p>
</html>"));
  end Pin;

  connector PositivePin "Positive pin of an electric component"
    Modelica.SIunits.Voltage v "Potential at the pin" annotation (
        unassignedMessage="An electrical potential cannot be uniquely calculated.
The reason could be that
- a ground object is missing (Modelica.Electrical.Analog.Basic.Ground)
  to define the zero potential of the electrical circuit, or
- a connector of an electrical component is not connected.");
    flow Modelica.SIunits.Current i "Current flowing into the pin" annotation (
        unassignedMessage="An electrical current cannot be uniquely calculated.
The reason could be that
- a ground object is missing (Modelica.Electrical.Analog.Basic.Ground)
  to define the zero potential of the electrical circuit, or
- a connector of an electrical component is not connected.");
    annotation (defaultComponentName="pin_p",
      Documentation(info="<html>
<p>Connectors PositivePin and NegativePin are nearly identical. The only difference is that the icons are different in order to identify more easily the pins of a component. Usually, connector PositivePin is used for the positive and connector NegativePin for the negative pin of an electrical component.</p>
</html>",               revisions="<html>
<ul>
<li><i> 1998   </i>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>"),
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,255},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid)}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics={Rectangle(
            extent={{-40,40},{40,-40}},
            lineColor={0,0,255},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid), Text(
            extent={{-160,110},{40,50}},
            lineColor={0,0,255},
            textString="%name")}));
  end PositivePin;

  connector NegativePin "Negative pin of an electric component"
    Modelica.SIunits.Voltage v "Potential at the pin" annotation (
        unassignedMessage="An electrical potential cannot be uniquely calculated.
The reason could be that
- a ground object is missing (Modelica.Electrical.Analog.Basic.Ground)
  to define the zero potential of the electrical circuit, or
- a connector of an electrical component is not connected.");
    flow Modelica.SIunits.Current i "Current flowing into the pin" annotation (
        unassignedMessage="An electrical current cannot be uniquely calculated.
The reason could be that
- a ground object is missing (Modelica.Electrical.Analog.Basic.Ground)
  to define the zero potential of the electrical circuit, or
- a connector of an electrical component is not connected.");
    annotation (defaultComponentName="pin_n",
      Documentation(info="<html>
<p>Connectors PositivePin and NegativePin are nearly identical. The only difference is that the icons are different in order to identify more easily the pins of a component. Usually, connector PositivePin is used for the positive and connector NegativePin for the negative pin of an electrical component.</p>
</html>",               revisions="<html>
<li><i> 1998   </i>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>"),
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid)}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics={Rectangle(
            extent={{-40,40},{40,-40}},
            lineColor={0,0,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid), Text(
            extent={{-40,110},{160,50}},
            textString="%name",
            lineColor={0,0,255})}));
  end NegativePin;

  partial model TwoPin "Component with two electrical pins"
    SI.Voltage v "Voltage drop between the two pins (= p.v - n.v)";
    PositivePin p
      "Positive pin Positive pin (potential p.v > n.v for positive voltage drop v)"
                                                                                                annotation (Placement(
          transformation(extent={{-110,-10},{-90,10}}, rotation=0)));
    NegativePin n "Negative pin" annotation (Placement(transformation(extent={{
              90,-10},{110,10}}, rotation=0)));
  equation
    v = p.v - n.v;
    annotation (
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Polygon(
            points={{-120,3},{-110,0},{-120,-3},{-120,3}},
            lineColor={160,160,164},
            fillColor={160,160,164},
            fillPattern=FillPattern.Solid),
          Line(points={{-136,0},{-111,0}}, color={160,160,164}),
          Text(
            extent={{-134,5},{-117,20}},
            lineColor={160,160,164},
            textString="p.i"),
          Line(points={{110,0},{135,0}}, color={160,160,164}),
          Polygon(
            points={{120,3},{110,0},{120,-3},{120,3}},
            lineColor={160,160,164},
            fillColor={160,160,164},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{117,3},{134,18}},
            lineColor={160,160,164},
            textString="n.i")}),
      Documentation(revisions="<html>
<ul>
<li><i> 1998   </i>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>", info="<html>
<p>TwoPin is a partial model with two pins and one internal variable for the voltage over the two pins. Internal currents are not defined. It is intended to be used in cases where the model which inherits TwoPin is composed by combining other components graphically, not by equations.</p>
</html>"));
  end TwoPin;

  partial model OnePort
    "Component with two electrical pins p and n and current i from p to n"

    SI.Voltage v "Voltage drop between the two pins (= p.v - n.v)";
    SI.Current i "Current flowing from pin p to pin n";
    PositivePin p
      "Positive pin (potential p.v > n.v for positive voltage drop v)"             annotation (Placement(
          transformation(extent={{-110,-10},{-90,10}}, rotation=0)));
    NegativePin n "Negative pin" annotation (Placement(transformation(extent={{
              110,-10},{90,10}}, rotation=0)));
  equation
    v = p.v - n.v;
    0 = p.i + n.i;
    i = p.i;
    annotation (
      Documentation(info="<html>
<p>Superclass of elements which have <b>two</b> electrical pins: the positive pin connector <i>p</i>, and the negative pin connector <i>n</i>. It is assumed that the current flowing into pin p is identical to the current flowing out of pin n. This current is provided explicitly as current i.</p>
</html>",
   revisions="<html>
<ul>
<li><i> 1998   </i>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>"),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Line(points={{-110,20},{-85,20}}, color={160,160,164}),
          Polygon(
            points={{-95,23},{-85,20},{-95,17},{-95,23}},
            lineColor={160,160,164},
            fillColor={160,160,164},
            fillPattern=FillPattern.Solid),
          Line(points={{90,20},{115,20}}, color={160,160,164}),
          Line(points={{-125,0},{-115,0}}, color={160,160,164}),
          Line(points={{-120,-5},{-120,5}}, color={160,160,164}),
          Text(
            extent={{-110,25},{-90,45}},
            lineColor={160,160,164},
            textString="i"),
          Polygon(
            points={{105,23},{115,20},{105,17},{105,23}},
            lineColor={160,160,164},
            fillColor={160,160,164},
            fillPattern=FillPattern.Solid),
          Line(points={{115,0},{125,0}}, color={160,160,164}),
          Text(
            extent={{90,45},{110,25}},
            lineColor={160,160,164},
            textString="i")}));
  end OnePort;

  partial model TwoPort
    "Component with two electrical ports, including current"
    SI.Voltage v1 "Voltage drop over the left port";
    SI.Voltage v2 "Voltage drop over the right port";
    SI.Current i1 "Current flowing from pos. to neg. pin of the left port";
    SI.Current i2 "Current flowing from pos. to neg. pin of the right port";
    PositivePin p1
      "Positive pin of the left port (potential p1.v > n1.v for positive voltage drop v1)"
                                                                                                        annotation (Placement(
          transformation(extent={{-110,40},{-90,60}}, rotation=0)));
    NegativePin n1 "Negative pin of the left port" annotation (Placement(
          transformation(extent={{-90,-60},{-110,-40}}, rotation=0)));
    PositivePin p2
      "Positive pin of the right port (potential p2.v > n2.v for positive voltage drop v2)"
                                                                                                         annotation (Placement(
          transformation(extent={{110,40},{90,60}}, rotation=0)));
    NegativePin n2 "Negative pin of the right port" annotation (Placement(
          transformation(extent={{90,-60},{110,-40}}, rotation=0)));
  equation
    v1 = p1.v - n1.v;
    v2 = p2.v - n2.v;
    0 = p1.i + n1.i;
    0 = p2.i + n2.i;
    i1 = p1.i;
    i2 = p2.i;
    annotation (
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Polygon(
            points={{-120,53},{-110,50},{-120,47},{-120,53}},
            lineColor={160,160,164},
            fillColor={160,160,164},
            fillPattern=FillPattern.Solid),
          Line(points={{-136,50},{-111,50}}, color={160,160,164}),
          Polygon(
            points={{127,-47},{137,-50},{127,-53},{127,-47}},
            lineColor={160,160,164},
            fillColor={160,160,164},
            fillPattern=FillPattern.Solid),
          Line(points={{111,-50},{136,-50}}, color={160,160,164}),
          Text(
            extent={{112,-44},{128,-29}},
            lineColor={160,160,164},
            textString="i2"),
          Text(
            extent={{118,52},{135,67}},
            lineColor={0,0,0},
            textString="i2"),
          Polygon(
            points={{120,53},{110,50},{120,47},{120,53}},
            lineColor={0,0,0},
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={160,160,164}),
          Line(points={{111,50},{136,50}}, color={0,0,0}),
          Line(points={{-136,-49},{-111,-49}}, color={160,160,164}),
          Polygon(
            points={{-126,-46},{-136,-49},{-126,-52},{-126,-46}},
            lineColor={160,160,164},
            fillColor={160,160,164},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-127,-46},{-110,-31}},
            lineColor={160,160,164},
            textString="i1"),
          Text(
            extent={{-136,53},{-119,68}},
            lineColor={160,160,164},
            textString="i1")}),
      Documentation(revisions="<html>
<ul>
<li><i> 1998   </i>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>", info="<html>
<p>TwoPort is a partial model that consists of two ports. Like OnePort each port has two pins. It is assumed that the current flowing into the positive  pin   is identical to the current flowing out of pin n. This currents of each port are  provided explicitly as currents i1 and i2, the voltages respectively as v1 and v2.</p>
</html>"));
  end TwoPort;

  partial model ConditionalHeatPort
    "Partial model to include a conditional HeatPort in order to describe the power loss via a thermal network"

    parameter Boolean useHeatPort = false "=true, if HeatPort is enabled"
    annotation(Evaluate=true, HideResult=true, choices(__Dymola_checkBox=true));
    parameter Modelica.SIunits.Temperature T=293.15
      "Fixed device temperature if useHeatPort = false" annotation(Dialog(enable=not useHeatPort));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort(T(start=T)=T_heatPort, Q_flow=-LossPower) if useHeatPort
      annotation (Placement(transformation(extent={{-10,-110},{10,-90}}),
          iconTransformation(extent={{-10,-110},{10,-90}})));
    Modelica.SIunits.Power LossPower
      "Loss power leaving component via HeatPort";
    Modelica.SIunits.Temperature T_heatPort "Temperature of HeatPort";
  equation
    if not useHeatPort then
       T_heatPort = T;
    end if;

    annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
              -100},{100,100}}),                                                                 graphics),
      Documentation(revisions="<html>
<ul>
<li><i> February 17, 2009   </i>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>",   info="<html>
<p>
This partial model provides a conditional heating port for the connection to a thermal network.
</p>
<ul>
<li> If <b>useHeatPort</b> is set to <b>false</b> (default), no heat port is available, and the thermal
     loss power flows internally to the ground. In this case, the parameter <b>T</b> specifies
     the fixed device temperature (the default for T = 20<sup>o</sup>C)</li>.
<li> If <b>useHeatPort</b> is set to <b>true</b>, a heat port is available.</li>
</ul>

<p>
If this model is used, the loss power has to be provided by an equation in the model which inherits from
ConditionalHeatingPort model (<b>lossPower = ...</b>). As device temperature
<b>T_heatPort</b> can be used to describe the influence of the device temperature
on the model behaviour.
</p>
</html>"));
  end ConditionalHeatPort;

  partial model AbsoluteSensor
    "Base class to measure the absolute value of a pin variable"
    extends Modelica.Icons.RotationalSensor;

    Interfaces.PositivePin p "Pin to be measured" annotation (Placement(
          transformation(extent={{-110,-10},{-90,10}}, rotation=0)));
    Modelica.Blocks.Interfaces.RealOutput y
      "Measured quantity as Real output signal"                                       annotation (Placement(
          transformation(extent={{100,-10},{120,10}}, rotation=0)));
    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Line(points={{-70,0},{-90,0}}, color={0,0,0}),
          Line(points={{70,0},{100,0}}, color={0,0,255}),
          Text(
            extent={{-150,80},{150,120}},
            textString="%name",
            lineColor={0,0,255})}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={Line(points={{-70,0},{-96,0}}, color={0,0,0}),
            Line(points={{70,0},{100,0}}, color={0,0,255})}),
      Documentation(revisions="<html>
<ul>
<li><i> 1998   </i>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>", info="<html>
<p>The AbsoluteSensor is a partial model for converting values that can be calculated from one pin connector into a real valued signal. The special calculation has to be described in the model which inherits the AbsoluteSensor.  It is often used in sensor devices. To be a true sensor the modeller has to take care that the sensor model does not influence the electrical behavior to be measured.</p>
</html>"));

  end AbsoluteSensor;

  partial model RelativeSensor
    "Base class to measure a relative variable between two pins"
    extends Modelica.Icons.RotationalSensor;

    Interfaces.PositivePin p "Positive pin" annotation (Placement(
          transformation(extent={{-110,-10},{-90,10}}, rotation=0)));
    Interfaces.NegativePin n "Negative pin" annotation (Placement(
          transformation(extent={{90,-10},{110,10}}, rotation=0)));
    Modelica.Blocks.Interfaces.RealOutput y
      "Measured quantity as Real output signal"                                       annotation (Placement(
          transformation(
          origin={0,-100},
          extent={{10,-10},{-10,10}},
          rotation=90)));
    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Line(points={{-70,0},{-90,0}}, color={0,0,0}),
          Line(points={{70,0},{90,0}}, color={0,0,0}),
          Line(points={{0,-90},{0,-70}}, color={0,0,255}),
          Text(
            extent={{-150,80},{150,120}},
            textString="%name",
            lineColor={0,0,255})}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Line(points={{-70,0},{-96,0}}, color={0,0,0}),
          Line(points={{0,-90},{0,-70}}, color={0,0,255}),
          Line(points={{70,0},{96,0}}, color={0,0,0})}),
      Documentation(revisions="<html>
<ul>
<li><i> 1998   </i>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>", info="<html>
<p>The RelaticeSensor is a partial model for converting values that can be calculated from two pin connectors into a real valued signal. The special calculation has to be described in the model which inherits the RelativeSensor.  It is often used in sensor devices. To be a true sensor the modeller has to take care that the sensor model does not influence the electrical behavior to be measured.</p>
</html>"));
  end RelativeSensor;

  partial model VoltageSource "Interface for voltage sources"
    extends OnePort;

    parameter SI.Voltage offset=0 "Voltage offset";
    parameter SI.Time startTime=0 "Time offset";
    replaceable Modelica.Blocks.Interfaces.SignalSource signalSource(
        final offset = offset, final startTime=startTime)
    annotation (Placement(transformation(extent={{70,70},{90,90}}, rotation=0)));
  equation
    v = signalSource.y;
    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Ellipse(
            extent={{-50,50},{50,-50}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-150,80},{150,120}},
            textString="%name",
            lineColor={0,0,255}),
          Line(points={{-90,0},{90,0}}, color={0,0,0}),
          Text(
            extent={{-120,50},{-20,0}},
            lineColor={0,0,255},
            textString="+"),
          Text(
            extent={{20,50},{120,0}},
            lineColor={0,0,255},
            textString="-")}),
      Documentation(revisions="<html>
<ul>
<li><i> 1998   </i>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>", info="<html>
<p>The VoltageSource partial model prepares voltage sources by providing the pins, and the offset and startTime parameters, which are the same at all voltage sources. The source behavior is taken from Modelica.Blocks signal sources by inheritance and usage of the replacable possibilities.</p>
</html>"));
  end VoltageSource;

  partial model CurrentSource "Interface for current sources"
    extends OnePort;
    parameter SI.Current offset=0 "Current offset";
    parameter SI.Time startTime=0 "Time offset";
    replaceable Modelica.Blocks.Interfaces.SignalSource signalSource(
        final offset = offset, final startTime=startTime) annotation (Placement(
          transformation(extent={{70,69},{91,89}}, rotation=0)));
  equation
    i = signalSource.y;
    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Ellipse(
            extent={{-50,50},{50,-50}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(points={{-90,0},{-50,0}}, color={0,0,0}),
          Line(points={{50,0},{90,0}}, color={0,0,0}),
          Line(points={{0,-50},{0,50}}, color={0,0,0}),
          Text(
            extent={{-150,120},{150,80}},
            textString="%name",
            lineColor={0,0,255}),
          Polygon(
            points={{90,0},{60,10},{60,-10},{90,0}},
            lineColor={0,0,255},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid)}),
      Documentation(revisions="<html>
<ul>
<li><i> 1998   </i>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>", info="<html>
<p>The CurrentSource partial model prepares current sources by providing the pins, and the offset and startTime parameters, which are the same at all current sources. The source behavior is taken from Modelica.Blocks signal sources by inheritance and usage of the replacable possibilities.</p>
</html>"));
  end CurrentSource;

  annotation (Documentation(info="<html>
<p>This package contains connectors and interfaces (partial models) for analog electrical components. The partial models contain typical combinations of pins, and internal variables which are often used. Furthermode, the thermal heat port is in this package which can be included by inheritance.</p>
</html>",
   revisions="<html>
<dl>
<dt>
<b>Main Authors:</b>
<dd>
Christoph Clau&szlig;
    &lt;<a href=\"mailto:Christoph.Clauss@eas.iis.fraunhofer.de\">Christoph.Clauss@eas.iis.fraunhofer.de</a>&gt;<br>
    Andr&eacute; Schneider
    &lt;<a href=\"mailto:Andre.Schneider@eas.iis.fraunhofer.de\">Andre.Schneider@eas.iis.fraunhofer.de</a>&gt;<br>
    Fraunhofer Institute for Integrated Circuits<br>
    Design Automation Department<br>
    Zeunerstra&szlig;e 38<br>
    D-01069 Dresden<br>
<p>
<dt>
</dl>

<b>Copyright:</b>
<dl>
<dd>
Copyright &copy; 1998-2010, Modelica Association and Fraunhofer-Gesellschaft.<br>
<i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
under the terms of the <b>Modelica license</b>, see the license conditions
and the accompanying <b>disclaimer</b> in the documentation of package
Modelica in file \"Modelica/package.mo\".</i><br>
<p>
</dl>

<ul>
<li><i> 1998</i>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>"));
end Interfaces;
