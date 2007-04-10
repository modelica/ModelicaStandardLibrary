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
  
  annotation (Documentation(info="<html>
<p>
This package contains example models to demonstrate the
usage of package blocks.
</p>
</HTML>
"));
  
  model BusUsage "Demonstration of signal bus usage" 
    extends Modelica.Icons.Example;
    
    annotation (Documentation(info="<html>
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
at hand of this model (Modelica.Blocks.Examples.BusUsage):
</p>

<p align=\"center\">
<img src=\"../Images/Blocks/BusUsage.png\">
</p>

<ul>
<li> Connector instance \"controlBus\" is a hierarchical connector that is
     used to exchange signals between different components. It is
     defined as \"expandable connector\" in order that <b>no</b> central definition
     of the connector is needed but is automatically constructed by the
     signals connected to it (see also Modelica specification 2.2.1).</li>
<li> Input/output signals can be directly connected to the \"controlBus\". When
     connecting, it is optionally possible that a <b>label</b> is displayed
     at the connecting line, that contains the name of the variable on the controlBus
     to which the signal is connected. </li>
<li> A component, such as \"part\", can be directly connected to the \"controlBus\",
     provided it has also a bus connector, or the \"part\" connector is a
     sub-connector contained in the \"controlBus\". </li>
</ul>

<p>
The control and sub-control bus icons are provided within Modelica.Icons.
In <a href=\"Modelica://Modelica.Blocks.Examples.BusUsage_Utilities.Interfaces\">Modelica.Blocks.Examples.BusUsage_Utilities.Interfaces</a>
the buses for this example are defined. Both the \"ControlBus\" and the \"SubControlBus\" are
<b>expandable</b> connectors that do not define any variable. For example, 
<a href=\"Modelica://Modelica.Blocks.Examples.BusUsage_Utilities.Interfaces.ControlBus#text\">Interfaces.ControlBus</a>
is defined as:
</p>
<pre>  <b>expandable connector</b> ControlBus
      <b>extends</b> Modelica.Icons.ControlBus;
      <b>annotation</b> (Icon(Rectangle(extent=[-20, 2; 22, -2], 
                       style(rgbcolor={255,204,51}, thickness=2))));
  <b>end</b> ControlBus;
</pre>
<p>
Note, the \"annotation\" in the connector is important since the color
and thickness of a connector line are taken from the first 
line element in the icon annotation of a connector class. Above, a small rectangle in the
color of the bus is defined (and therefore this rectangle is not
visible). As a result, when connecting from an instance of this
connector to another connector instance, the connecting line has
the color of the \"ControlBus\" with double width (due to \"thickness=2\").
</p>

<p>
An <b>expandable</b> connector is a connector where the content of the connector
is constructed by the variables connected to instances of this connector.
For example, if \"sine.y\" is connected to the \"controlBus\", the following
menu pops-up in Dymola:
</p>

<p align=\"center\">
<img src=\"../Images/Blocks/BusUsage2.png\">
</p>

<p>
The \"Add variable/New name\" field allows the user to define the name of the signal on 
the \"controlBus\". When typing \"realSignal1\" as \"New name\", a connection of the form:
</p>

<pre>     <b>connect</b>(sine.y, controlBus.realSignal1)
</pre>

<p>
is generated and the \"controlBus\" contains the new signal \"realSignal1\". Modelica tools
may give more support in order to list potential signals for a connection. 
For example, in Dymola all variables are listed in the menu that are contained in
connectors which are derived by inheritance from \"controlBus\". Therefore, in
<a href=\"Modelica://Modelica.Blocks.Examples.BusUsage_Utilities.Interfaces.Internal\">Modelica.Blocks.Examples.BusUsage_Utilities.Interfaces.Internal</a>
the expected implementation of the \"ControlBus\" and of the \"SubControlBus\" are given.
For example \"Internal.ControlBus\" is defined as:
</p>

<pre>  <b>expandable connector</b> StandardControlBus 
    <b>extends</b> BusUsage_Utilities.Interfaces.ControlBus;
  
    <b>import</b> SI = Modelica.SIunits;
    SI.AngularVelocity    realSignal1   \"First Real signal\";
    SI.Velocity           realSignal2   \"Second Real signal\";
    Integer               integerSignal \"Integer signal\";
    Boolean               booleanSignal \"Boolean signal\";
    StandardSubControlBus subControlBus \"Combined signal\";
  <b>end</b> StandardControlBus;
</pre>

<p>
Consequently, when connecting now from \"sine.y\" to \"controlBus\", the menu
looks differently:
</p>
<p align=\"center\">
<img src=\"../Images/Blocks/BusUsage3.png\">
</p>
<p>
Note, even if the signals from \"Internal.StandardControlBus\" are listed, these are
just potential signals. The user might still add different signal names.
</p>

</html>"), Diagram);
  public 
    Modelica.Blocks.Sources.IntegerStep integerStep(
      height=1,
      offset=2,
      startTime=0.5)   annotation (extent=[-60,-40; -40,-20],
                                                            rotation=0);
    Modelica.Blocks.Sources.BooleanStep booleanStep(startTime=0.5) 
                                                               annotation (
        extent=[-58,0; -38,20],  rotation=0);
    Modelica.Blocks.Sources.Sine sine(y(redeclare type SignalType = 
            Modelica.SIunits.AngularVelocity)) 
                                     annotation (extent=[-60,40; -40,60],
        rotation=0);
    
    Modelica.Blocks.Examples.BusUsage_Utilities.Part part 
              annotation (extent=[-60,-80; -40,-60]);
    Modelica.Blocks.Math.Gain gain 
      annotation(extent=[-40,70; -60,90],   rotation=0);
  protected 
    BusUsage_Utilities.Interfaces.ControlBus controlBus 
      annotation (extent=[50,-10; 10,30], rotation=90);
  equation 
    
    connect(sine.y, controlBus.realSignal1) annotation (
      points=[-39,50; 0,50; 0,14; 30,14; 30,10],
      style(color=74, rgbcolor={0,0,127}),
      Text(
        string="%second",
        index=1,
        extent=[6,3; 6,3],
        style(color=0, rgbcolor={0,0,0})));
    connect(booleanStep.y, controlBus.booleanSignal) annotation (
      points=[-37,10; 30,10],
      style(color=5, rgbcolor={255,0,255}),
      Text(
        string="%second",
        index=1,
        extent=[6,3; 6,3],
        style(color=0, rgbcolor={0,0,0})));
    connect(integerStep.y, controlBus.integerSignal) annotation (
      points=[-39,-30; 0,-30; 0,4; 30,4; 30,10],
      style(color=45, rgbcolor={255,127,0}),
      Text(
        string="%second",
        index=1,
        extent=[6,3; 6,3],
        style(color=0, rgbcolor={0,0,0})));
    connect(gain.u, controlBus.realSignal1) annotation (
      points=[-38,80; 20,80; 20,16; 26,16; 26,10; 30,10],
      style(color=74, rgbcolor={0,0,127}),
      Text(
        string="%second",
        index=1,
        extent=[6,3; 6,3],
        style(color=0, rgbcolor={0,0,0})));
    connect(part.subControlBus, controlBus.subControlBus) annotation (
      points=[-40,-70; 30,-70; 30,2],
      style(
        color=6,
        rgbcolor={255,204,51},
        thickness=2),
      Text(
        string="%second",
        index=1,
        extent=[6,3; 6,3],
        style(color=0, rgbcolor={0,0,0})));
  end BusUsage;
  
  package BusUsage_Utilities 
    "Utility models and connectors for the demonstration example Modelica.Blocks.Examples.BusUsage" 
    annotation (preferedView="info",Documentation(info="<html>
</html>"), Diagram);
  package Interfaces "Interfaces specialised for this example" 
      
      expandable connector ControlBus 
        "Empty control bus that is adapted to the signals connected to it" 
        extends Modelica.Icons.SignalBus;
        
        annotation (
          Icon(Rectangle(extent=[-20, 2; 22, -2], style(rgbcolor={255,204,51}, thickness=2))),
          Diagram);
        
      end ControlBus;
      
      expandable connector SubControlBus 
        "Empty sub-control bus that is adapted to the signals connected to it" 
        extends Modelica.Icons.SignalSubBus;
        
        annotation (defaultComponentPrefixes="protected",
                    Icon(Rectangle(extent=[-20, 2; 22, -2], style(rgbcolor={255,204,51}, thickness=2))));
        
      end SubControlBus;
      
    package Internal 
        expandable connector StandardControlBus 
          "Used to build up the standard control bus (do not use this connector)" 
          extends 
            Modelica.Blocks.Examples.BusUsage_Utilities.Interfaces.ControlBus;
          
          import SI = Modelica.SIunits;
          SI.AngularVelocity realSignal1 "First Real signal (angular velocity)";
          SI.Velocity realSignal2 "Second Real signal";
          Integer integerSignal "Integer signal";
          Boolean booleanSignal "Boolean signal";
          StandardSubControlBus subControlBus "Combined signal";
          
          annotation (
            Icon(Rectangle(extent=[-20, 2; 22, -2], style(rgbcolor={255,204,51}, thickness=2))),
            Diagram);
          
        end StandardControlBus;
        
        expandable connector StandardSubControlBus 
          "Used to build up the standard sub-control bus (do not use this connector)" 
          extends 
            Modelica.Blocks.Examples.BusUsage_Utilities.Interfaces.SubControlBus;
          
          Real myRealSignal;
          Boolean myBooleanSignal;
          
          annotation (defaultComponentPrefixes="protected",
                      Icon(Rectangle(extent=[-20, 2; 22, -2], style(rgbcolor={255,204,51}, thickness=2))));
        end StandardSubControlBus;
    end Internal;
  end Interfaces;
    
   model Part "Component with sub-control bus" 
      
      annotation (Icon(Rectangle(extent=[-100, 60; 100, -60], style(fillColor=
                  76, fillPattern=1)), Text(
            extent=[-106, 124; 114, 68],
            style(fillColor=76, fillPattern=1),
            string="%name")), Diagram);
     Interfaces.SubControlBus subControlBus 
       annotation (extent=[80,-20; 120,20], rotation=-90);
     Sources.RealExpression realExpression(y=time) 
       annotation (extent=[-6,0; 20,20]);
     Sources.BooleanExpression booleanExpression(y=time > 0.5) 
       annotation (extent=[-6,-30; 20,-10]);
   equation 
     connect(realExpression.y, subControlBus.myRealSignal) annotation (
       points=[21.3,10; 86,10; 86,0; 100,0],
       style(color=74, rgbcolor={0,0,127}),
       Text(
         string="%second",
         index=1,
         extent=[6,3; 6,3],
         style(color=0, rgbcolor={0,0,0})));
     connect(booleanExpression.y, subControlBus.myBooleanSignal) annotation (
       points=[21.3,-20; 58,-20; 58,-2; 100,-2; 100,0],
       style(color=5, rgbcolor={255,0,255}),
       Text(
         string="%second",
         index=1,
         extent=[6,3; 6,3],
         style(color=0, rgbcolor={0,0,0})));
   end Part;
    
  end BusUsage_Utilities;
end Examples;
end Blocks;
