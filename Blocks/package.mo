package Blocks "Library for basic input/output control blocks"
import SI = Modelica.SIunits;


extends Modelica.Icons.Library2;


annotation(preferedView="info",
  Window(
    x=0.03,
    y=0.05,
    width=0.21,
    height=0.48,
    library=1,
    autolayout=1),
  Icon(
    Rectangle(extent=[-32, -6; 16, -35], style(color=0)),
    Rectangle(extent=[-32, -56; 16, -85], style(color=0)),
    Line(points=[16, -20; 49, -20; 49, -71; 16, -71], style(color=0)),
    Line(points=[-32, -72; -64, -72; -64, -21; -32, -21], style(color=0)),
    Polygon(points=[16, -71; 29, -67; 29, -74; 16, -71], style(
        color=0,
        fillColor=0,
        fillPattern=1)),
    Polygon(points=[-32, -21; -46, -17; -46, -25; -32, -21], style(
        color=0,
        fillColor=0,
        fillPattern=1))), Documentation(info="<html>
<p>
This library contains input/output blocks to build up block diagrams.
The library is structured in the following sublibraries:
</p>
<pre>
  Interfaces    Connectors and partial models for block diagram components
  Examples      Demonstration examples
  Continuous    Basic continuous input/output blocks
  Discrete      Discrete control blocks
  Logical       Logical and relational operations on Boolean signals
  Nonlinear     Discontinuous or non-differentiable algebraic
                control blocks
  Math          Mathematical functions as input/output blocks
  Sources       Sources such as signal generators
  Routing       Combine and extract signals
  Tables        One and two-dimensional interpolation in tables
  Types         Constants and types with choices, especially to build menus
</pre>
<dl>
<dt><b>Main Author:</b>
<dd><a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a><br>
    Deutsches Zentrum f&uuml;r Luft und Raumfahrt e. V. (DLR)<br>
    Oberpfaffenhofen<br>
    Postfach 1116<br>
    D-82230 Wessling<br>
    email: <A HREF=\"mailto:Martin.Otter@dlr.de\">Martin.Otter@dlr.de</A><br>
</dl>
<br>

<br>
<p><b>Copyright &copy; 1999-2004, Modelica Association and DLR.</b></p>
<p><i>
The Modelica package Modelica.Blocks is <b>free</b> software; it can be redistributed and/or modified
under the terms of the <b>Modelica license</b>, see the license conditions
and the accompanying <b>disclaimer</b> 
<a href=\"Modelica://Modelica.UsersGuide.ModelicaLicense\">here</a>.

</i></p>
</HTML>
", revisions="<html>
<ul>
<li><i>June 23, 2004</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Introduced new block connectors and adapated all blocks to the new connectors.
       Included subpackages Continuous, Discrete, Logical, Nonlinear from
       package ModelicaAdditions.Blocks.
       Included subpackage ModelicaAdditions.Table in Modelica.Blocks.Sources
       and in the new package Modelica.Blocks.Tables.
       Added new blocks to Blocks.Sources and Blocks.Logical.
       </li>
<li><i>October 21, 2002</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>
       and <a href=\"http://www.robotic.dlr.de/Christian.Schweiger/\">Christian Schweiger</a>:<br>
       New subpackage Examples, additional components.
       </li>
<li><i>June 20, 2000</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a> and
       Michael Tiller:<br>
       Introduced a replaceable signal type into
       Blocks.Interfaces.RealInput/RealOutput:
<pre>
   replaceable type SignalType = Real
</pre>
       in order that the type of the signal of an input/output block
       can be changed to a physical type, for example:
<pre>
   Sine sin1(outPort(redeclare type SignalType=Modelica.SIunits.Torque))
</pre>
      </li>
<li><i>Sept. 18, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Renamed to Blocks. New subpackages Math, Nonlinear.
       Additional components in subpackages Interfaces, Continuous
       and Sources. </li>
<li><i>June 30, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized a first version, based on an existing Dymola library
       of Dieter Moormann and Hilding Elmqvist.</li>
</ul>
</html>"));


package Examples "Demonstration examples of the components of this package" 
  
  extends Icons.Library;
  
     model ShowLogicalSources 
       extends Modelica.Icons.Example;
       Sources.BooleanTable table(table={2,4,6,8}) 
                                       annotation(extent=[-60,-100; -40,-80]);
       Sources.BooleanConstant const    annotation(extent=[-60,60; -40,80]);
       Sources.BooleanStep step(startTime=4) annotation(extent=[-60,20; -40,40]);
       Sources.BooleanPulse pulse(period=1.5) annotation(extent=[-60,-20; -40,0]);
       annotation(Diagram,
      experiment(StopTime=10),
      experimentSetupOutput);
      Sources.SampleTrigger sample(
                          period=0.5) annotation(extent=[-60,-60; -40,-40]);
    Sources.BooleanExpression booleanExpression(y=pulse.y and step.y) 
      annotation(extent=[20,20; 80,40]);
     end ShowLogicalSources;
  
    model LogicalNetwork1 
    
    extends Modelica.Icons.Example;
    Sources.BooleanTable table2(table={1,3,5,7}) annotation(extent=[-80,-20; -60,0]);
    Sources.BooleanTable table1(table={2,4,6,8}) annotation(extent=[-80,20; -60,40]);
    Logical.Not Not1 annotation(extent=[-40,-20; -20,0]);
    
    annotation(Diagram,
        experiment(StopTime=10),
        experimentSetupOutput);
    Logical.And And1 annotation(extent=[0,-20; 20,0]);
    Logical.Or Or1 annotation(extent=[40,20; 60,40]);
    Logical.Pre Pre1 annotation(extent=[-40,-60; -20,-40]);
    equation 
    
    connect(table2.y, Not1.u) annotation(points=[-59,-10; -42,-10], style(
          color=5, rgbcolor={255,0,255}));
    
    connect(And1.y, Or1.u2) annotation(points=[21,-10; 28,-10; 28,22; 38,22],
        style(color=5, rgbcolor={255,0,255}));
    
    connect(table1.y, Or1.u1) annotation(points=[-59,30; 38,30], style(color=
            5, rgbcolor={255,0,255}));
    
    connect(Not1.y, And1.u1) annotation(points=[-19,-10; -2,-10], style(color=
           5, rgbcolor={255,0,255}));
    
    connect(Pre1.y, And1.u2) annotation(points=[-19,-50; -10,-50; -10,-18; -2,
          -18], style(color=5, rgbcolor={255,0,255}));
    
    connect(Or1.y, Pre1.u) annotation(points=[61,30; 68,30; 68,-70; -60,-70;
          -60,-50; -42,-50], style(color=5, rgbcolor={255,0,255}));
    
    end LogicalNetwork1;
  
  encapsulated model BusUsage "Demonstration of signal bus usage" 
    import Modelica.Icons;
    import Modelica.Blocks.Interfaces.Adaptors;
    import Modelica.Blocks.Sources;
    import Modelica;
    
    extends Icons.Example;
    
    annotation (preferedView="info",Documentation(info="<HTML>
<p><b>Signal bus concept</b></p>
<p>
In technical systems, such as vehicles, robots or satellites, many signals
are exchanged between components. In a simulation system, these signals 
are  usually modelled by signal connections of input/output blocks.
Unfortunately, the signal connection structure may become very complicated,
especially for hierarchical models.
</p>
<p>
The same is also true for real technical systems. To reduce complexity
and get higher flexibility, many technical systems use data buses to 
exchange data between components. For the same reasons, it is often better
to use a \"signal bus\" concept also in a Modelica model. This is demonstrated
at hand of this model (Modelica.Blocks.Examples.BusUsage), see diagram layer:
</p>
<ul>
<li>The thick line in the middle called \"bus\" is just a connector instance
    which is drawn such that it looks like a \"usual\" bus representation. </li>
<li>A component, such as \"part\", can be directly connected to the \"bus\", 
    provided it has also a bus connector, or the \"part\" connector is a 
    sub-connector contained in the \"bus\". </li>
</ul>
<p>
Difficulties arise if the input or output connector of an 
input/output block shall be connected directly to a variable 
of a bus because connections can only be performed between 
connectors but not between variables. For convenience, 
single variable connectors for Real, Integer and Boolean 
variables are provided as Modelica.Blocks.Interfaces.<b>RealSignal</b>, 
Modelica.Blocks.Interfaces.<b>IntegerSignal</b>, 
Modelica.Blocks.Interfaces.<b>BooleanSignal</b>.
For example, the RealSignal connector is basically defined as:
</p>
<pre>  <b>connector</b> RealSignal = Real;
</pre>
<p>
This allows a definition of a bus in the form:
</p>
<pre>   <b>connector</b> Bus
      RealSignal r1;
      RealSignal r2;
        ...
   <b>end</b> Bus;
</pre>
<p>
and a connection to r1 and r2 is possible since these are connectors. 
Unfortunately, signals defined in this way have, by default, no unit. 
To improve this situation, a RealSignal is actually defined as
</p>
<pre>   <b>connector</b> RealSignal
      <b>replaceable type</b> SignalType = Real;
      <b>extends</b> SignalType;
   <b>end</b> RealSignal;
</pre>
<p>
This allows a redeclaration of the Real type to the desired type, such as:
</p>
<pre>   <b>connector</b> Bus
      <b>import</b> SI=Modelica.SIunits;
      RealSignal v(<b>redeclare</b> SignalType=SI.Velocity);
      RealSignal p(<b>redeclare</b> SignalType=SI.Pressure);
      ...
   <b>end</b> Bus;
</pre>
<p>
Note, since RealSignal, RealInput and RealOutput have basically
the same definition, it is possible to directly connector
from a RealSignal of a bus to a RealInput or RealOutput of
a block component.
</p>
<p>
If a bus connector contains many signals it is no longer so easy 
to test just one part of a system, because all parts of 
the bus connector must get a value. To simplify this, 
it is practical to provide a <b>RestBus</b> component which 
sets all parts of a bus to a default value when selected 
via the parameter menu. This is also demonstrated in the example 
model (see diagram layer).
</p>
<p>Simulate the system for 1 s. The output of the \"gain\" block
should be the same as the one from the \"generateRealSignal1\"
block.
</p>
</HTML>"), Diagram);
  protected 
    Interfaces.Bus bus annotation (extent=[-80, -20; 80, -14]);
  public 
    RestBus restBus(set_realSignal2=true) annotation (extent=[60, 20; 80, 40]);
    Sources.IntegerStep generateIntegerSignal(
      height=1,
      offset=2,
      startTime=0.5)   annotation (extent=[20,40; 40,60],   rotation=270);
    Sources.BooleanStep generateBooleanSignal(startTime=0.5)   annotation (
        extent=[-20,40; 0,60],   rotation=270);
    Sources.Sine generateRealSignal1 annotation (extent=[-60,40; -40,60],
        rotation=270);
    
    encapsulated package Interfaces "Interfaces specialised for this example" 
      
      connector MultiPort "Combined port of real and boolean signal" 
        Real myRealSignal;
        Boolean myBooleanSignal;
        
        annotation (Icon(Rectangle(extent=[-100, 100; 100, -100], style(
                  fillColor=76, fillPattern=1))), Diagram(Rectangle(extent=[-
                  100, 100; 100, -100], style(fillColor=76, fillPattern=1))));
      end MultiPort;
      
      connector Bus "Signal bus" 
        import SI = Modelica.SIunits;
        import Modelica.Blocks.Interfaces.*;
        
        RealSignal realSignal1(redeclare type SignalType = SI.AngularVelocity) 
          "First Real signal (angular velocity)";
        RealSignal realSignal2 "Second Real signal";
        IntegerSignal integerSignal "Integer signal";
        BooleanSignal booleanSignal "Boolean signal";
        MultiPort multiSignal "Combined signal";
        
        annotation (
          Icon(Rectangle(extent=[-100, 100; 100, -100], style(
                color=77,
                fillColor=77,
                fillPattern=1)), Text(
              extent=[-134, 168; 134, 108],
              string="%name",
              style(color=77))),
          Diagram(Text(
              extent=[-134, 168; 134, 108],
              string="%name",
              style(color=77)), Rectangle(extent=[-100, 100; 100, -100], style(
                color=77,
                fillColor=77,
                fillPattern=1))),
          Documentation(info="<HTML>
<p>Defines connector for signalbus.</p>
</HTML>
"));
      end Bus;
    end Interfaces;
    
    encapsulated model Part "Component with MultiPort connector" 
      import Modelica.Blocks.Examples;
      
      Examples.BusUsage.Interfaces.MultiPort multiSignal annotation (extent=[
            100, -10; 120, 10]);
      
      annotation (Icon(Rectangle(extent=[-100, 60; 100, -60], style(fillColor=
                  76, fillPattern=1)), Text(
            extent=[-106, 124; 114, 68],
            style(fillColor=76, fillPattern=1),
            string="%name")));
    equation 
      multiSignal.myRealSignal = time;
      multiSignal.myBooleanSignal = time > 0.5;
    end Part;
    
    encapsulated model RestBus 
      "Set default values for bus variables that are not defined elsewhere" 
      
      import Modelica.Blocks.Examples;
      
      parameter Boolean set_realSignal1=false 
        "Set dummy value for desiredThrottle";
      parameter Boolean set_realSignal2=false "Set dummy value for brake";
      parameter Boolean set_integerSignal=false 
        "Set dummy value for controlLeverPosition";
      parameter Boolean set_booleanSignal=false 
        "Set dummy value for desiredGear";
      parameter Boolean set_multiSignal=false "Set dummy value for ignition";
      
      annotation (Icon(
          Rectangle(extent=[-100, 100; 100, -100], style(fillColor=7,
                fillPattern=1)),
          Text(
            extent=[-100, 156; 100, 96],
            string="%name",
            style(pattern=0)),
          style(color=77),
          Text(
            extent=[46, -10; 88, -40],
            style(color=0),
            string="0"),
          Text(
            extent=[-82, 62; 38, 34],
            style(color=0),
            string="false"),
          Line(points=[-28, 24; -28, -66; 0, -66; 0, -104; 0, -102], style(
              color=77,
              fillColor=7,
              fillPattern=1)),
          Line(points=[68, -46; 68, -66; 0, -66; 0, -108], style(
              color=77,
              fillColor=7,
              fillPattern=1)),
          Rectangle(extent=[-90, 78; 46, 24], style(color=0)),
          Rectangle(extent=[40, -4; 92, -46], style(color=0))));
      Examples.BusUsage.Interfaces.Bus bus annotation (extent=[-10, -120; 10, -
            100], rotation=90);
    equation 
      if set_realSignal1 then
        bus.realSignal1 = 0;
      end if;
      if set_realSignal2 then
        bus.realSignal2 = 0;
      end if;
      if set_integerSignal then
        bus.integerSignal = 0;
      end if;
      if set_booleanSignal then
        bus.booleanSignal = false;
      end if;
      if set_multiSignal then
        bus.multiSignal.myRealSignal = 0;
        bus.multiSignal.myBooleanSignal = false;
      end if;
    end RestBus;
    
    Part part annotation (extent=[-100, -60; -80, -40]);
    Modelica.Blocks.Math.Gain gain 
      annotation(extent=[-46,-80; -26,-60], rotation=-90);
  equation 
    
    connect(restBus.bus, bus) annotation (points=[70,19; 70,-17; 0,-17],
                                                                    style(color=
           77));
    connect(part.multiSignal, bus.multiSignal) annotation (points=[-79,-50; -70,
          -50; -70,-18]);
    connect(generateRealSignal1.y, bus.realSignal1) 
      annotation(points=[-50,39; -50,-16], style(color=3, rgbcolor={0,0,255}));
    connect(generateBooleanSignal.y, bus.booleanSignal) annotation(points=[-10,
          39; -10,-18], style(color=5, rgbcolor={255,0,255}));
    connect(generateIntegerSignal.y, bus.integerSignal) annotation(points=[30,
          39; 32,39; 32,-16; 34,-16], style(color=45, rgbcolor={255,127,0}));
    connect(gain.u, bus.realSignal1) annotation(points=[-36,-58; -36,-18],
        style(color=3, rgbcolor={0,0,255}));
  end BusUsage;
  
  annotation (Documentation(info="<html>
<p>
This package contains example models to demonstrate the 
usage of package blocks.
</p>
</HTML>
"));
  
end Examples;

end Blocks;
