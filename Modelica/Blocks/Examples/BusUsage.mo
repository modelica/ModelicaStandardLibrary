within Modelica.Blocks.Examples;
model BusUsage "Demonstrates the usage of a signal bus"
  extends Modelica.Icons.Example;

public
  Modelica.Blocks.Sources.IntegerStep integerStep(
    height=1,
    offset=2,
    startTime=0.5) annotation (Placement(transformation(extent={{-60,-40},{-40,
            -20}})));
  Modelica.Blocks.Sources.BooleanStep booleanStep(startTime=0.5) annotation (
      Placement(transformation(extent={{-58,0},{-38,20}})));
  Modelica.Blocks.Sources.Sine sine(f=1) annotation (Placement(
        transformation(extent={{-60,40},{-40,60}})));

  Modelica.Blocks.Examples.BusUsage_Utilities.Part part annotation (Placement(
        transformation(extent={{-60,-80},{-40,-60}})));
  Modelica.Blocks.Math.Gain gain(k=1) annotation (Placement(transformation(
          extent={{-40,70},{-60,90}})));
protected
  BusUsage_Utilities.Interfaces.ControlBus controlBus annotation (Placement(
        transformation(
        origin={30,10},
        extent={{-20,20},{20,-20}},
        rotation=90)));
equation

  connect(sine.y, controlBus.realSignal1) annotation (Line(
      points={{-39,50},{12,50},{12,14},{30,14},{30,10}}, color={0,0,127}));
  connect(booleanStep.y, controlBus.booleanSignal) annotation (Line(
      points={{-37,10},{30,10}}, color={255,0,255}));
  connect(integerStep.y, controlBus.integerSignal) annotation (Line(
      points={{-39,-30},{0,-30},{0,6},{32,6},{32,10},{30,10}}, color={255,127,0}));
  connect(part.subControlBus, controlBus.subControlBus) annotation (Line(
      points={{-40,-70},{30,-70},{30,10}},
      color={255,204,51},
      thickness=0.5));
  connect(gain.u, controlBus.realSignal1) annotation (Line(
      points={{-38,80},{20,80},{20,18},{32,18},{32,10},{30,10}}, color={0,0,127}));
  annotation (Documentation(info="<html>
<p><strong>Signal bus concept</strong></p>
<p>
In technical systems, such as vehicles, robots or satellites, many signals
are exchanged between components. In a simulation system, these signals
are usually modelled by signal connections of input/output blocks.
Unfortunately, the signal connection structure may become very complicated,
especially for hierarchical models.
</p>

<p>
The same is also true for real technical systems. To reduce complexity
and get higher flexibility, many technical systems use data buses to
exchange data between components. For the same reasons, it is often better
to use a \"signal bus\" concept also in a Modelica model. This is demonstrated
at hand of this model (Modelica.Blocks.Examples.BusUsage):
</p>

<img src=\"modelica://Modelica/Resources/Images/Blocks/Examples/BusUsage.png\"
     alt=\"BusUsage.png\">

<ul>
<li> Connector instance \"controlBus\" is a hierarchical connector that is
     used to exchange signals between different components. It is
     defined as \"expandable connector\" in order that <strong>no</strong> central definition
     of the connector is needed but is automatically constructed by the
     signals connected to it (see also <a href=\"https://specification.modelica.org/v3.4/Ch9.html#expandable-connectors\">Section 9.1.3 (Expandable Connectors) of the Modelica 3.4 specification</a>).</li>
<li> Input/output signals can be directly connected to the \"controlBus\".</li>
<li> A component, such as \"part\", can be directly connected to the \"controlBus\",
     provided it has also a bus connector, or the \"part\" connector is a
     sub-connector contained in the \"controlBus\".</li>
</ul>

<p>
The control and sub-control bus icons are provided within Modelica.Icons.
In <a href=\"modelica://Modelica.Blocks.Examples.BusUsage_Utilities.Interfaces\">Modelica.Blocks.Examples.BusUsage_Utilities.Interfaces</a>
the buses for this example are defined. Both the \"ControlBus\" and the \"SubControlBus\" are
<strong>expandable</strong> connectors that do not define any variable. For example,
<a href=\"modelica://Modelica.Blocks.Examples.BusUsage_Utilities.Interfaces.ControlBus#text\">Interfaces.ControlBus</a>
is defined as:
</p>
<blockquote><pre>
<strong>expandable connector</strong> ControlBus
    <strong>extends</strong> Modelica.Icons.ControlBus;
    <strong>annotation</strong> ();
<strong>end</strong> ControlBus;
</pre></blockquote>
<p>
Note, the \"annotation\" in the connector is important since the color
and thickness of a connector line are taken from the first
line element in the icon annotation of a connector class. Above, a small rectangle in the
color of the bus is defined (and therefore this rectangle is not
visible). As a result, when connecting from an instance of this
connector to another connector instance, the connecting line has
the color of the \"ControlBus\" with double width (due to \"thickness=0.5\").
</p>

<p>
An <strong>expandable</strong> connector is a connector where the content of the connector
is constructed by the variables connected to instances of this connector.
For example, if \"sine.y\" is connected to the \"controlBus\", a pop-up menu may appear:
</p>

<img src=\"modelica://Modelica/Resources/Images/Blocks/Examples/BusUsage2.png\"
     alt=\"BusUsage2.png\">

<p>
The \"Add variable/New name\" field allows the user to define the name of the signal on
the \"controlBus\". When typing \"realSignal1\" as \"New name\", a connection of the form:
</p>

<blockquote><pre>
<strong>connect</strong>(sine.y, controlBus.realSignal1)
</pre></blockquote>

<p>
is generated and the \"controlBus\" contains the new signal \"realSignal1\". Modelica tools
may give more support in order to list potential signals for a connection. Therefore, in
<a href=\"modelica://Modelica.Blocks.Examples.BusUsage_Utilities.Interfaces\">BusUsage_Utilities.Interfaces</a>
the expected implementation of the \"ControlBus\" and of the \"SubControlBus\" are given.
For example \"Internal.ControlBus\" is defined as:
</p>

<blockquote><pre>
<strong>expandable connector</strong> StandardControlBus
  <strong>extends</strong> BusUsage_Utilities.Interfaces.ControlBus;

  <strong>import</strong> Modelica.Units.SI;
  SI.AngularVelocity    realSignal1   \"First Real signal\";
  SI.Velocity           realSignal2   \"Second Real signal\";
  Integer               integerSignal \"Integer signal\";
  Boolean               booleanSignal \"Boolean signal\";
  StandardSubControlBus subControlBus \"Combined signal\";
<strong>end</strong> StandardControlBus;
</pre></blockquote>

<p>
Consequently, when connecting now from \"sine.y\" to \"controlBus\", the menu
looks differently:
</p>

<img src=\"modelica://Modelica/Resources/Images/Blocks/Examples/BusUsage3.png\"
     alt=\"BusUsage3.png\">

<p>
Note, even if the signals from \"Internal.StandardControlBus\" are listed, these are
just potential signals. The user might still add different signal names.
</p>

</html>"),
         experiment(StopTime=2));
end BusUsage;
