package Blocks "Library for basic input/output control blocks (continuous, discrete, logical, table blocks)"
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
</p>

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

<p>
Copyright &copy; 1998-2006, Modelica Association and DLR.
</p>
<p>
<i>This Modelica package is <b>free</b> software; it can be redistributed and/or modified
under the terms of the <b>Modelica license</b>, see the license conditions
and the accompanying <b>disclaimer</b> 
<a href=\"Modelica://Modelica.UsersGuide.ModelicaLicense\">here</a>.</i>
</p><br>
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
  
  model PID_Controller "Demonstrate usage of the Continuous.LimPID controller" 
    extends Modelica.Icons.Example;
    parameter Modelica.SIunits.Angle driveAngle=1.57;
    Modelica.Blocks.Continuous.LimPID PI(
      k=100,
      Ti=0.1,
      yMax=12,
      Ni=0.1,
      initType=Modelica.Blocks.Types.Init.SteadyState,
      limitsAtInit=false, 
      controllerType=Modelica.Blocks.Types.SimpleController.PI) 
      annotation (extent=[-56,-20; -36,0]);
    Modelica.Mechanics.Rotational.Inertia inertia1(initType=Modelica.Mechanics.
          Rotational.Types.Init.InitialAngleAcceleration) 
                                              annotation (extent=[2,-20; 22,0]);
    annotation (
      Diagram(
        Rectangle(extent=[-99,48; -32,8], style(color=1, rgbcolor={255,0,0})),
        Text(
          extent=[-98,59; -31,51],
          style(color=1, rgbcolor={255,0,0}),
          string="reference speed generation"),
        Text(
          extent=[-98,-46; -60,-52],
          style(color=1, rgbcolor={255,0,0}),
          string="PI controller"),
        Line(points=[-76,-44; -57,-23], style(
            color=1,
            rgbcolor={255,0,0},
            arrow=1)),
        Rectangle(extent=[-25,6; 99,-50], style(color=1, rgbcolor={255,0,0})),
        Text(
          extent=[4,14; 71,7],
          style(color=1, rgbcolor={255,0,0}),
          string="plant (simple drive train)")),
      Coordsys(
        extent=[-100,-100; 100,100],
        grid=[1,1],
        scale=0),
      experiment(StopTime=4),
      experimentSetupOutput,
      Documentation(info="<html>

<p>
This is a simple drive train controlled by a PID controller:
</p>

<ul>
<li> The two blocks \"kinematic_PTP\" and \"integrator\" are used to generate
     the reference speed (= constant acceleration phase, constant speed phase,
     constant deceleration phase until inertia is at rest). To check
     whether the system starts in steady state, the reference speed is
     zero until time = 0.5 s and then follows the sketched trajectory.</li>

<li> The block \"PI\" is an instance of \"Blocks.Continuous.LimPID\" which is
     a PID controller where several practical important aspects, such as
     anti-windup-compensation has been added. In this case, the control block
     is used as PI controller.</li>

<li> The output of the controller is a torque that drives a motor inertia
     \"inertia1\". Via a complöiant spring/damper component, the load
     inertia \"inertia2\" is attached. A constant external torque of 10 Nm
     is acting on the load inertia.</li>
</ul>

<p>
The PI controller settings included \"limitAtInit=false\", in order that
the controller output limits of 12 Nm are removed from the initialization
problem. 
</p>

<p>
The PI controller is initialized in steady state (initType=SteadyState)
and the drive shall also be initialized in steady state.
However, it is not possible to initialize \"inertia1\" in SteadyState, because
\"der(inertia1.phi)=inertia1.w=0\" is an input to the PI controller that
defines that the derivative of the integrator state is zero (= the same
condition that was already defined by option SteadyState of the PI controller).
Furthermore, one initial condition is missing, because the absolute position
of inertia1 or inertia2 is not defined. The solution shown in this examples is
to initialize the angle and the angular acceleration of \"inertia1\".
</p>

<p>
In the following figure, results of a typical simulation are shown:
</p>

<p>
<img src=\"../Images/Blocks/PID_controller.png\"><br>
<img src=\"../Images/Blocks/PID_controller2.png\">
</p>

<p>
In the upper figure the reference speed (= integrator.y) and
the actual speed (= inertia1.w) are shown. As can be seen,
the system initializes in steady state, since no transients
are present. The inertia follows the reference speed quite good
until the end of the constant speed phase. Then there is a deviation.
In the lower figure the reason can be seen: The output of the
controller (PI.y) is in its limits. The anti-windup compensation
works reasonably, since the input to the limiter (PI.limiter.u)
is forced back to its limit after a transient phase.
</p>

</html>"));
    Modelica.Mechanics.Rotational.Torque torque 
      annotation (extent=[-25,-20; -5,0]);
    Modelica.Mechanics.Rotational.SpringDamper spring(c=1e4, d=100,
      initType=Modelica.Mechanics.Rotational.Types.Init.SteadyState,
      stateSelection=Modelica.Blocks.Types.StateSelection.Prefer) 
      annotation (extent=[32,-20; 52,0]);
    Modelica.Mechanics.Rotational.Inertia inertia2(J=2) 
      annotation (extent=[60,-20; 80,0]);
    Modelica.Blocks.Sources.KinematicPTP kinematicPTP(startTime=0.5, deltaq={
          driveAngle}) annotation (extent=[-92,20; -72,40]);
    Modelica.Blocks.Continuous.Integrator integrator(initType=Modelica.Blocks.
          Types.Init.InitialState) annotation (extent=[-63,20; -43,40]);
    Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor 
      annotation (extent=[22,-50; 2,-30]);
    Modelica.Mechanics.Rotational.ConstantTorque loadTorque(tau_constant=10) 
      annotation (extent=[98,-15; 88,-5]);
  equation 
    connect(spring.flange_b,inertia2. flange_a) 
      annotation (points=[52,-10; 60,-10], style(color=0, rgbcolor={0,0,0}));
    connect(inertia1.flange_b, spring.flange_a) 
      annotation (points=[22,-10; 32,-10], style(color=0, rgbcolor={0,0,0}));
    connect(torque.flange_b, inertia1.flange_a) 
      annotation (points=[-5,-10; 2,-10], style(color=0, rgbcolor={0,0,0}));
    connect(kinematicPTP.y[1], integrator.u) annotation (points=[-71,30; -65,30],
        style(color=74, rgbcolor={0,0,127}));
    connect(speedSensor.flange_a, inertia1.flange_b) 
      annotation (points=[22,-40; 22,-10], style(color=0, rgbcolor={0,0,0}));
    connect(loadTorque.flange, inertia2.flange_b) 
      annotation (points=[88,-10; 80,-10], style(color=0, rgbcolor={0,0,0}));
    connect(PI.y, torque.tau)  annotation (points=[-35,-10; -27,-10], style(
          color=74, rgbcolor={0,0,127}));
    connect(speedSensor.w, PI.u_m)  annotation (points=[1,-40; -46,-40; -46,-22],
        style(color=74, rgbcolor={0,0,127}));
    connect(integrator.y, PI.u_s)  annotation (points=[-42,30; -37,30; -37,11;
          -67,11; -67,-10; -58,-10], style(color=74, rgbcolor={0,0,127}));
  end PID_Controller;
  
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
      Sources.BooleanExpression booleanExpression(
                                                y=pulse.y and step.y) 
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
    Interfaces.Bus bus annotation (Hide=false, extent=[-80, -20; 80, -14]);
  public 
    RestBus restBus(set_realSignal2=true) annotation (extent=[60, 20; 80, 40]);
    Sources.IntegerStep integerStep(
      height=1,
      offset=2,
      startTime=0.5)   annotation (extent=[20,20; 40,40],   rotation=270);
    Sources.BooleanStep booleanStep(startTime=0.5)             annotation (
        extent=[-20,20; 0,40],   rotation=270);
    Sources.Sine sine                annotation (extent=[-60,20; -40,40],
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
    
    Part part annotation (extent=[-96,-60; -76,-40]);
    Modelica.Blocks.Math.Gain gain 
      annotation(extent=[-46,-80; -26,-60], rotation=-90);
  equation 
    
    connect(restBus.bus, bus) annotation (points=[70,19; 70,-17; 0,-17],
                                                                    style(color=
           77));
    connect(part.multiSignal, bus.multiSignal) annotation (points=[-75,-50; -58,
          -50; -58,-16; 0,-16; 0,-17]);
    connect(sine.y, bus.realSignal1) 
      annotation(points=[-50,19; -50,-17; 0,-17],
                                           style(color=3, rgbcolor={0,0,255}));
    connect(booleanStep.y, bus.booleanSignal)           annotation(points=[-10,
          19; -10,-16; 0,-16; 0,-17],
                        style(color=5, rgbcolor={255,0,255}));
    connect(integerStep.y, bus.integerSignal)           annotation(points=[30,
          19; 30,-17; 0,-17],         style(color=45, rgbcolor={255,127,0}));
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
