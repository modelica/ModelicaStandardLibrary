package Examples "Demonstration examples of the components of this package" 
  
  extends Icons.Library;
  
  encapsulated model BusUsage "Demonstration of signal bus usage" 
    import Modelica.Icons;
    import Modelica.Blocks.Interfaces.BusAdaptors;
    import Modelica.Blocks.Sources;
    
    extends Icons.Example;
    
    annotation( Documentation(info="<HTML>
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
variables are provided as Modelica.Blocks.Interfaces.<b>RealPort</b>, 
Modelica.Blocks.Interfaces.<b>IntegerPort</b>, 
Modelica.Blocks.Interfaces.<b>BooleanPort</b>.
For example, the RealPort connector is basically defined as:
</p>
<pre>  <b>connector</b> RealPort = Real;
</pre>

<p>
This allows a definition of a bus in the form:
</p>

<pre>   <b>connector</b> Bus
      RealPort r1;
      RealPort r2;
        ...
   <b>end</b> Bus;
</pre>

<p>
and a connection to r1 and r2 is possible since these are connectors. 
Unfortunately, signals defined in this way have, by default, no unit. 
To improve this situation, a RealPort is actually defined as
</p>

<pre>   <b>connector</b> RealPort 
      <b>replaceable type</b> SignalType = Real;
      <b>extends</b> SignalType;
   <b>end</b> RealPort;
</pre>

<p>
This allows a redeclaration of the Real type to the desired type, such as:
</p>

<pre>   <b>connector</b> Bus
      <b>import</b> SI=Modelica.SIunits;
      RealPort v(<b>redeclare</b> SignalType=SI.Velocity);
      RealPort p(<b>redeclare</b> SignalType=SI.Pressure);
      ...
   <b>end</b> Bus;
</pre>

<p>
In order to connect from a RealPort connector to an InPort or OutPort 
connector of a block from the Modelica.Blocks package, an adaptor block 
is needed, since the two connectors are not compatible. Appropriate adaptors 
are provided in Modelica.Blocks.Interfaces.<b>BusAdaptors</b>. The usage can 
be seen in the diagram layer of the model at hand
(Modelica.Blocks.Examples.BusUsage). 
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

<p>Simulate the system for 1 s. The outputs of the 'receive' signal
blocks should be the same as the inputs of the 'send' signal blocks.
</p>
</HTML>"));
  protected 
    Interfaces.Bus bus annotation( extent=[-80, -20; 80, -14]);
  public 
    BusAdaptors.SendReal putRealSignal1 annotation( extent=[-60, 0; -40, 20],
        rotation=-90);
    BusAdaptors.SendBoolean putBooleanSignal annotation( extent=[-20, 0; 0, 20],
          rotation=-90);
    BusAdaptors.SendInteger putIntegerSignal annotation( extent=[20, 0; 40, 20],
          rotation=-90);
    BusAdaptors.ReceiveReal getRealSignal1 annotation( extent=[-40, -80; -20, -
          60], rotation=-90);
    BusAdaptors.ReceiveBoolean getBooleanSignal annotation( extent=[0, -80; 20,
            -60], rotation=-90);
    BusAdaptors.ReceiveInteger getIntegerSignal annotation( extent=[40, -80; 60,
            -60], rotation=-90);
    RestBus restBus(set_realSignal2=true) annotation( extent=[60, 20; 80, 40]);
    Sources.IntegerStep generateIntegerSignal(
      height={1},
      offset={2},
      startTime={0.5}) annotation( extent=[20, 60; 40, 80], rotation=270);
    Sources.BooleanStep generateBooleanSignal(startTime={0.5}) annotation(
        extent=[-20, 60; 0, 80], rotation=270);
    Sources.Sine generateRealSignal1 annotation( extent=[-60, 60; -40, 80],
        rotation=270);
    
    encapsulated package Interfaces "Interfaces specialised for this example" 
      
      connector MultiPort "Combined port of real and boolean signal" 
        Real myRealSignal;
        Boolean myBooleanSignal;
        
        annotation( Icon(Rectangle(extent=[-100, 100; 100, -100], style(
                  fillColor=76, fillPattern=1))), Diagram(Rectangle(extent=[-
                  100, 100; 100, -100], style(fillColor=76, fillPattern=1))));
      end MultiPort;
      
      connector Bus "Signal bus" 
        import SI = Modelica.SIunits;
        import Modelica.Blocks.Interfaces.*;
        
        RealPort realSignal1(redeclare type SignalType = SI.AngularVelocity) 
          "First Real signal (angular velocity)";
        RealPort realSignal2 "Second Real signal";
        IntegerPort integerSignal "Integer signal";
        BooleanPort booleanSignal "Boolean signal";
        MultiPort multiSignal "Combined signal";
        
        annotation(
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
      
      Examples.BusUsage.Interfaces.MultiPort multiSignal annotation( extent=[
            100, -10; 120, 10]);
      
      annotation( Icon(Rectangle(extent=[-100, 60; 100, -60], style(fillColor=
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
      
      annotation( Icon(
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
      Examples.BusUsage.Interfaces.Bus bus annotation( extent=[-10, -120; 10, -
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
    
    Part part annotation( extent=[-100, -60; -80, -40]);
  equation 
    
    connect(putRealSignal1.toBus, bus.realSignal1) annotation( points=[-50, -2;
            -50, -16], style(color=77));
    connect(putIntegerSignal.toBus, bus.integerSignal) annotation( points=[30,
          -2; 30, -16], style(color=77));
    connect(generateRealSignal1.outPort, putRealSignal1.inPort) annotation(
        points=[-50, 58; -50, 24], style(color=3));
    connect(generateBooleanSignal.outPort, putBooleanSignal.inPort) annotation(
       points=[-10, 58; -10, 24], style(color=5));
    connect(generateIntegerSignal.outPort, putIntegerSignal.inPort) annotation(
       points=[30, 58; 30, 24], style(color=45));
    connect(getRealSignal1.fromBus, bus.realSignal1) annotation( points=[-30, -
          58; -30, -18], style(color=77));
    connect(getIntegerSignal.fromBus, bus.integerSignal) annotation( points=[50,
            -60; 50, -18], style(color=77));
    connect(restBus.bus, bus) annotation( points=[70, 20; 70, -18], style(color=
           77));
    connect(putBooleanSignal.toBus, bus.booleanSignal) annotation( points=[-10,
            -2; -10, -16], style(color=77));
    connect(getBooleanSignal.fromBus, bus.booleanSignal) annotation( points=[10,
            -60; 10, -18], style(color=77));
    connect(part.multiSignal, bus.multiSignal) annotation( points=[-78, -50; -
          70, -50; -70, -18]);
  end BusUsage;
  
  annotation( Documentation(info="<html>
<p>
This package contains currently one example model to demonstrate the usage of the
signal bus concept provided by the Modelica.Blocks package.
</p>

<p><b>Copyright &copy; 2002, Modelica Association and DLR.</b></p>

<p><i>
The Modelica package is <b>free</b> software; it can be redistributed and/or modified
under the terms of the <b>Modelica license</b>, see the license conditions
and the accompanying <b>disclaimer</b> in the documentation of package
Modelica in file \"Modelica/package.mo\".
</i></p>
</HTML>
"));
  
end Examples;
