within Modelica.Fluid.Examples;
package ControlledTankSystem
  "Tank system with controller, start/stop/shut operation and diagram animation"
  extends Modelica.Icons.ExamplesPackage;

  model ControlledTanks
    "Demonstrating the controller of a tank filling/emptying system"
    extends Modelica.Icons.Example;
    package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater;

    Modelica.Fluid.Examples.ControlledTankSystem.Utilities.TankController
      tankController(
      waitTime=50,
      maxLevel=0.9*tank1.height,
      minLevel=0.01)
      annotation (Placement(transformation(extent={{-60,-20},{-20,20}},
            rotation=0)));
    Modelica.Fluid.Examples.ControlledTankSystem.Utilities.RadioButton start(
                                                           reset={stop.on,shut.on},
        buttonTimeTable={20,280})
      annotation (Placement(transformation(extent={{-100,20},{-80,40}},
            rotation=0)));
    Modelica.Fluid.Examples.ControlledTankSystem.Utilities.RadioButton stop(
                                                          reset={start.on,shut.on},
        buttonTimeTable={220,650})
      annotation (Placement(transformation(extent={{-100,-10},{-80,10}},
            rotation=0)));
    Modelica.Fluid.Examples.ControlledTankSystem.Utilities.RadioButton shut(
                                                          reset={start.on,stop.on},
        buttonTimeTable={700})
      annotation (Placement(transformation(extent={{-100,-40},{-80,-20}},
            rotation=0)));
    Modelica.Fluid.Valves.ValveDiscrete valve1(                     redeclare
        package Medium = Medium,
      m_flow_nominal=40,
      dp_nominal=100000)
      annotation (Placement(transformation(
          origin={-10,70},
          extent={{10,-10},{-10,10}},
          rotation=180)));
    Modelica.Fluid.Vessels.OpenTank tank1(
      level_start=0.05,
      redeclare package Medium = Medium,
      crossArea=6,
      height=4,
      nPorts=2,
      portsData={Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(
            diameter=0.2,
            height=4,
            zeta_out=0,
            zeta_in=1),Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(
            diameter=0.2,
            height=0,
            zeta_out=0,
            zeta_in=1)})    annotation (Placement(transformation(extent={{10,30},
              {50,70}},      rotation=0)));
    Modelica.Blocks.Sources.RealExpression level1(y=tank1.level)
      annotation (Placement(transformation(extent={{-90,-60},{-55,-40}},
            rotation=0)));
    Modelica.Fluid.Valves.ValveDiscrete valve2(        redeclare package Medium
        = Medium,
      dp_nominal(displayUnit="Pa") = 1,
      m_flow_nominal=100)
      annotation (Placement(transformation(
          origin={34,0},
          extent={{10,-10},{-10,10}},
          rotation=90)));
    Modelica.Fluid.Valves.ValveDiscrete valve3(        redeclare package Medium
        = Medium,
      dp_nominal(displayUnit="Pa") = 1,
      m_flow_nominal=10)
      annotation (Placement(transformation(
          origin={35,-80},
          extent={{10,-10},{-10,10}},
          rotation=0)));
    Modelica.Fluid.Vessels.OpenTank tank2(
      level_start=0.05,
      redeclare package Medium = Medium,
      height=5,
      crossArea=6,
      nPorts=2,
      portsData={Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(
            diameter=0.2,
            height=5,
            zeta_out=0,
            zeta_in=1),Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(
            diameter=0.2,
            height=0,
            zeta_out=0,
            zeta_in=1)})   annotation (Placement(transformation(extent={{50,-60},
              {90,-20}},       rotation=0)));
    Modelica.Fluid.Sources.Boundary_pT ambient1(redeclare package Medium =
          Medium,nPorts=1,
      p=system.p_ambient,
      T=system.T_ambient)
      annotation (Placement(transformation(extent={{-10,-90},{10,-70}},
            rotation=0)));
    Modelica.Blocks.Sources.RealExpression level2(y=tank2.level)
      annotation (Placement(transformation(extent={{-70,-80},{-33,-60}},
            rotation=0)));
    Modelica.Fluid.Sources.Boundary_pT source(redeclare package Medium =
          Medium, p=2.5e6,nPorts=1,
      T=system.T_ambient)
      annotation (Placement(transformation(
          origin={-40,70},
          extent={{-10,-10},{10,10}},
          rotation=0)));
    inner Modelica.Fluid.System system
                          annotation (Placement(transformation(extent={{-90,70},
              {-70,90}}, rotation=0)));
  equation
    connect(shut.on, tankController.shut) annotation (Line(points={{-79,-30},{
            -72,-30},{-72,-12},{-62,-12}}, color={255,0,255}));
    connect(stop.on, tankController.stop) annotation (Line(points={{-79,0},{-62,
            0}}, color={255,0,255}));
    connect(start.on, tankController.start) annotation (Line(points={{-79,30},{
            -70,30},{-70,12},{-62,12}}, color={255,0,255}));
    connect(tankController.valve1, valve1.open) annotation (Line(points={{-19,12},
            {-10,12},{-10,62}},             color={255,0,255}));
    connect(level1.y, tankController.level1) annotation (Line(points={{-53.25,
            -50},{-52,-50},{-52,-22}}, color={0,0,127}));
    connect(tankController.valve2, valve2.open) annotation (Line(points={{-19,0},
            {-5,0},{-5,4.89859e-016},{26,4.89859e-016}},
                                       color={255,0,255}));
    connect(tankController.valve3, valve3.open) annotation (Line(points={{-19,-12},
            {-10,-12},{-10,-50},{35,-50},{35,-72}},
                                                color={255,0,255}));
    connect(level2.y, tankController.level2) annotation (Line(points={{-31.15,
            -70},{-28,-70},{-28,-22}}, color={0,0,127}));

    connect(source.ports[1], valve1.port_a) annotation (Line(
        points={{-30,70},{-20,70}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(valve3.port_b, ambient1.ports[1]) annotation (Line(
        points={{25,-80},{10,-80}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(tank2.ports[2], valve3.port_a) annotation (Line(
        points={{74,-60},{74,-80},{45,-80}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(valve2.port_b, tank2.ports[1]) annotation (Line(
        points={{34,-10},{34,-20},{50,-20},{50,-60},{66,-60}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(valve1.port_b, tank1.ports[1]) annotation (Line(
        points={{0,70},{10,70},{10,30},{26,30}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(tank1.ports[2], valve2.port_a) annotation (Line(
        points={{34,30},{34,10}},
        color={0,127,255},
        smooth=Smooth.None));
    annotation (
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics),
      experiment(StopTime=900),
      Documentation(info="<html>
<p>
With this example, the controller of a tank filling/emptying system
is demonstrated.
</p>

<p>
The basic operation is to fill and empty the two tanks:
</p>
<ol>
<li> Valve 1 is opened and tank 1 is filled.</li>
<li> When tank 1 reaches its fill level limit,
     valve 1 is closed. </li>
<li> After a waiting time, valve 2 is
     opened and the fluid flows from tank 1 into tank 2.</li>
<li> When tank 1 reaches its minimum level, valve 2 is closed. </li>
<li> After a waiting time, valve 3 is opened and
     the fluid flows out of tank 2</li>
<li> When tank 2 reaches its minimum level, valve 3 is closed</liI>
</ol>
<p>
The above \"normal\" process can be influenced by three
buttons:
</p>
<ul>
<li> Button <b>start</b> starts the above process.
     When this button is pressed after a \"stop\" or
     \"shut\" operation, the process operation continues.
     </li>.
<li> Button <b>stop</b> stops the above process by
     closing all valves. Then, the controller waits for
     further input (either \"start\" or \"shut\" operation).</li>
<li> Button <b>shut</b> is used to shutdown the process,
     by emptying at once both tanks by opening valve 2 and
     valve 3. When this is achieved,
     the process goes back to its start configuration
     where all 3 valves are closed.
     Clicking on \"start\", restarts the process.</li>
</ul>

<p>
The demo-run uses the following button presses:
</p>

<ul>
<li> Button <b>start</b> pressed at 20 s.</li>
<li> Button <b>stop</b> pressed at 220 s </li>
<li> Button <b>start</b> pressed at 280 s </li>
<li> Button <b>stop</b> pressed at 650 s </li>
<li> Button <b>shut</b> pressed at 700 s </li>
<li> Simulate for 900 s</li>
</ul>

<p>
This example is based on
</p>

<dl>
<dt>Dressler I. (2004):</dt>
<dd> <b>Code Generation From JGrafchart to Modelica</b>.
     Master thesis, supervisor: Karl-Erik Arzen,
     Department of Automatic Control, Lund Institute of Technology,
     Lund, Sweden, March 30, 2004<br>&nbsp;</dd>
</dl>

<img src=\"modelica://Modelica/Resources/Images/Fluid/Examples/ControlledTanks.png\" border=\"1\">
</html>"),
      __Dymola_Commands(file=
            "modelica://Modelica/Resources/Scripts/Dymola/Fluid/ControlledTanks/plot level and ports.m_flow.mos"
          "plot level and ports.m_flow"));
  end ControlledTanks;

  package Utilities
    extends Modelica.Icons.Package;

    model TankController "Controller for tank system"
          extends Modelica.StateGraph.Interfaces.PartialStateGraphIcon;
      parameter SI.Height maxLevel "Fill level of tank 1";
      parameter SI.Height minLevel "Lowest level of tank 1 and 2";
      parameter SI.Time waitTime "Wait time, between operations";

      Modelica.StateGraph.InitialStep s1(nIn=2)
                     annotation (Placement(transformation(extent={{-72,30},{-52,
                50}}, rotation=0)));
      Modelica.Fluid.Examples.ControlledTankSystem.Utilities.NormalOperation
        normal(
        maxLevel=maxLevel,
        minLevel=minLevel,
        waitTime=waitTime)
        annotation (Placement(transformation(extent={{-20,20},{20,60}},
              rotation=0)));
      Modelica.StateGraph.Transition T1(condition=start)
                                     annotation (Placement(transformation(
              extent={{-50,50},{-30,30}}, rotation=0)));
      Modelica.StateGraph.Transition T2(condition=level2 < minLevel)
        annotation (Placement(transformation(extent={{27,50},{47,30}}, rotation=
               0)));
      Modelica.StateGraph.Transition T3(condition=stop)
        annotation (Placement(transformation(
            origin={-23,-1},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.StateGraph.Step s2(nOut=2)
              annotation (Placement(transformation(extent={{-50,-60},{-30,-40}},
              rotation=0)));
      Modelica.StateGraph.Transition T4(condition=start)
        annotation (Placement(transformation(
            origin={10,0},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.StateGraph.Transition T5(condition=shut)
                                    annotation (Placement(transformation(extent=
               {{-6,-60},{14,-40}}, rotation=0)));
      Modelica.StateGraph.Step emptyTanks
                      annotation (Placement(transformation(extent={{20,-60},{40,
                -40}}, rotation=0)));
      Modelica.StateGraph.Transition T6(condition=level1 < minLevel and level2
             < minLevel)
        annotation (Placement(transformation(extent={{45,-60},{65,-40}},
              rotation=0)));
      Modelica.Blocks.Interfaces.BooleanInput start
        annotation (Placement(transformation(extent={{-120,50},{-100,70}},
              rotation=0)));
      Modelica.Blocks.Interfaces.BooleanInput stop
        annotation (Placement(transformation(extent={{-120,-10},{-100,10}},
              rotation=0)));
      Modelica.Blocks.Interfaces.BooleanInput shut
        annotation (Placement(transformation(extent={{-120,-70},{-100,-50}},
              rotation=0)));
      Modelica.Blocks.Interfaces.RealInput level1
        annotation (Placement(transformation(
            origin={-60,-110},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Blocks.Interfaces.RealInput level2
        annotation (Placement(transformation(
            origin={60,-110},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Blocks.Interfaces.BooleanOutput valve1
        annotation (Placement(transformation(extent={{100,55},{110,65}},
              rotation=0)));
      Modelica.Blocks.Interfaces.BooleanOutput valve2
        annotation (Placement(transformation(extent={{100,-5},{110,5}},
              rotation=0)));
      Modelica.Blocks.Interfaces.BooleanOutput valve3
        annotation (Placement(transformation(extent={{100,-65},{110,-55}},
              rotation=0)));
      Modelica.Blocks.Sources.BooleanExpression setValve1(y=normal.fillTank1.
            active)
        annotation (Placement(transformation(extent={{20,73},{80,92}}, rotation=
               0)));
      Modelica.Blocks.Sources.BooleanExpression setValve2(y=normal.fillTank2.
            active or emptyTanks.active and level1 > minLevel)
        annotation (Placement(transformation(extent={{-40,-85},{80,-64}},
              rotation=0)));
      Modelica.Blocks.Sources.BooleanExpression setValve3(y=normal.emptyTank2.
            active or emptyTanks.active and level2 > minLevel)
        annotation (Placement(transformation(extent={{-40,-103},{80,-83}},
              rotation=0)));
    equation

      connect(s1.outPort[1], T1.inPort)
                                     annotation (Line(points={{-51.5,40},{-44,
              40}}, color={0,0,0}));
      connect(T1.outPort, normal.inPort)      annotation (Line(points={{-38.5,
              40},{-21.3333,40}}, color={0,0,0}));
      connect(normal.outPort, T2.inPort)      annotation (Line(points={{20.6667,
              40},{33,40}}, color={0,0,0}));
      connect(T5.outPort, emptyTanks.inPort[1])
                                             annotation (Line(points={{5.5,-50},
              {19,-50}}, color={0,0,0}));
      connect(emptyTanks.outPort[1], T6.inPort)
                                             annotation (Line(points={{40.5,-50},
              {51,-50}}, color={0,0,0}));
      connect(setValve1.y, valve1)
        annotation (Line(points={{83,82.5},{90,82.5},{90,60},{105,60}}, color={
              255,0,255}));
      connect(setValve2.y, valve2)
        annotation (Line(points={{86,-74.5},{90,-74.5},{90,0},{105,0}}, color={
              255,0,255}));
      connect(setValve3.y, valve3) annotation (Line(points={{86,-93},{95,-93},{
              95,-60},{105,-60}}, color={255,0,255}));
      connect(normal.suspend[1], T3.inPort)   annotation (Line(points={{-10,
              19.3333},{-10,12},{-23,12},{-23,3}}, color={0,0,0}));
      connect(T3.outPort, s2.inPort[1])
                                     annotation (Line(points={{-23,-2.5},{-23,
              -20},{-60,-20},{-60,-50},{-51,-50}}, color={0,0,0}));
      connect(level1, normal.level1)      annotation (Line(points={{-60,-110},{
              -60,-80},{-80,-80},{-80,20},{-30,20},{-30,24},{-22.6667,24}},
            color={0,0,255}));
      connect(s2.outPort[1], T5.inPort) annotation (Line(points={{-29.5,-49.75},
              {-30,-49.75},{-30,-50},{0,-50}}, color={0,0,0}));
      connect(s2.outPort[2], T4.inPort) annotation (Line(points={{-29.5,-50.25},
              {-29,-50},{-8,-50},{-8,-25},{10,-25},{10,-4}}, color={0,0,0}));
      connect(T2.outPort, s1.inPort[1]) annotation (Line(points={{38.5,40},{70,
              40},{70,70},{-80,70},{-80,40},{-73,40},{-73,40.5}}, color={0,0,0}));
      connect(T6.outPort, s1.inPort[2]) annotation (Line(points={{56.5,-50},{70,
              -50},{70,70},{-80,70},{-80,40},{-74,40},{-73,39.5}}, color={0,0,0}));
      connect(T4.outPort, normal.resume[1])      annotation (Line(points={{10,1.5},
              {10,10},{10.5,10},{10.5,18.6667},{10,18.6667}},      color={0,0,0}));
      annotation (structurallyIncomplete,
        Diagram(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics={Rectangle(extent={{-100,100},{100,-100}},
                lineColor={0,0,0})}),
        Icon(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics={
            Text(
              extent={{-100,68},{-12,54}},
              lineColor={0,0,0},
              textString="start"),
            Text(
              extent={{-99,6},{-14,-9}},
              lineColor={0,0,0},
              textString="stop"),
            Text(
              extent={{-99,-54},{-14,-69}},
              lineColor={0,0,0},
              textString="shut"),
            Text(
              extent={{-94,-82},{-9,-96}},
              lineColor={0,0,0},
              textString="level1"),
            Text(
              extent={{11,-83},{96,-98}},
              lineColor={0,0,0},
              textString="level2"),
            Text(
              extent={{10,68},{99,54}},
              lineColor={0,0,0},
              textString="valve1"),
            Text(
              extent={{7,10},{101,-5}},
              lineColor={0,0,0},
              textString="valve2"),
            Text(
              extent={{2,-51},{102,-67}},
              lineColor={0,0,0},
              textString="valve3")}));
    end TankController;

    model NormalOperation
      "Normal operation of tank system (button start pressed)"
          extends Modelica.StateGraph.PartialCompositeStep;
      parameter SI.Height maxLevel "Fill level of tank 1";
      parameter SI.Height minLevel "Lowest level of tank 1 and 2";
      parameter SI.Time waitTime "Wait time between operations";

      Modelica.Blocks.Interfaces.RealInput level1
        annotation (Placement(transformation(extent={{-190,-140},{-150,-100}},
              rotation=0)));
      Modelica.StateGraph.Step fillTank1
                     annotation (Placement(transformation(extent={{-140,-10},{
                -120,10}}, rotation=0)));
      Modelica.StateGraph.Transition T1(condition=level1 > maxLevel)
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}},
              rotation=0)));
      Modelica.StateGraph.Step fillTank2
                     annotation (Placement(transformation(extent={{-10,-10},{10,
                10}}, rotation=0)));
      Modelica.StateGraph.Transition T3(condition=level1 < minLevel)
        annotation (Placement(transformation(extent={{20,-10},{40,10}},
              rotation=0)));
      Modelica.StateGraph.Step emptyTank2
                      annotation (Placement(transformation(extent={{120,-10},{
                140,10}}, rotation=0)));
      Modelica.StateGraph.Step wait1
                 annotation (Placement(transformation(extent={{-80,-10},{-60,10}},
              rotation=0)));
      Modelica.StateGraph.Transition T2(enableTimer=true, waitTime=waitTime)
        annotation (Placement(transformation(extent={{-50,-10},{-30,10}},
              rotation=0)));
      Modelica.StateGraph.Step wait2
                 annotation (Placement(transformation(extent={{54,-10},{74,10}},
              rotation=0)));
      Modelica.StateGraph.Transition T4(enableTimer=true, waitTime=waitTime)
        annotation (Placement(transformation(extent={{82,-10},{102,10}},
              rotation=0)));
    equation
      connect(fillTank1.inPort[1], inPort)
                                        annotation (Line(points={{-141,0},{-160,
              0}}, color={0,0,0}));
      connect(fillTank1.outPort[1], T1.inPort)
                                            annotation (Line(points={{-119.5,0},
              {-104,0}}, color={0,0,0}));
      connect(fillTank2.outPort[1], T3.inPort)
                                            annotation (Line(points={{10.5,0},{
              26,0}}, color={0,0,0}));
      connect(emptyTank2.outPort[1], outPort)
                                           annotation (Line(points={{140.5,0},{
              155,0}}, color={0,0,0}));
      connect(wait1.outPort[1], T2.inPort)
                                        annotation (Line(points={{-59.5,0},{-44,
              0}}, color={0,0,0}));
      connect(T2.outPort, fillTank2.inPort[1])
                                            annotation (Line(points={{-38.5,0},
              {-11,0}}, color={0,0,0}));
      connect(T1.outPort, wait1.inPort[1])
                                        annotation (Line(points={{-98.5,0},{-81,
              0}}, color={0,0,0}));
      connect(wait2.outPort[1], T4.inPort)
                                        annotation (Line(points={{74.5,0},{88,0}},
            color={0,0,0}));
      connect(T3.outPort, wait2.inPort[1])
        annotation (Line(points={{31.5,0},{53,0}}, color={0,0,0}));
      connect(T4.outPort,emptyTank2.inPort[1])
                                             annotation (Line(points={{93.5,0},
              {119,0}}, color={0,0,0}));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{
                -150,-150},{150,150}}),
                          graphics),
                           Documentation(info="<html>

</html>"));
    end NormalOperation;

    block RadioButton
      "Button that sets its output to true when pressed and is reset when an element of 'reset' becomes true"

      parameter Modelica.SIunits.Time buttonTimeTable[:]
        "Time instants where button is pressend";
      input Boolean reset[:]={false}
        "Reset button to false, if an element of reset becomes true"
        annotation (Dialog(group="Time varying expressions"));

      Modelica.Blocks.Interfaces.BooleanOutput on
        annotation (Placement(transformation(extent={{100,-10},{120,10}},
              rotation=0)));
    protected
      Modelica.Blocks.Sources.BooleanTable table(table=buttonTimeTable);
    algorithm
      when pre(reset) then
         on := false;
      end when;

      when change(table.y) then
         on := true;
      end when;
      annotation (Icon(
          coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                100}}),
          graphics={Rectangle(
              extent={{-100,-100},{100,100}},
              fillColor=DynamicSelect({192,192,192}, if on > 0.5 then {0,255,0} else
                        {192,192,192}),
              fillPattern=DynamicSelect(FillPattern.Solid, if on > 0.5 then
                  FillPattern.Solid else FillPattern.Solid),
              lineColor={128,128,128},
              lineThickness=0.5), Text(
              extent={{-80,-40},{80,40}},
              lineColor={0,0,0},
              textString="%name")},
                              interaction={OnMouseDownSetBoolean(
                              on, true)}),
                              Diagram(coordinateSystem(preserveAspectRatio=false,
                       extent={{-100,-100},{100,100}}),
                                      graphics),
          Documentation(info="<html>

</html>"));
    end RadioButton;
  end Utilities;
end ControlledTankSystem;
