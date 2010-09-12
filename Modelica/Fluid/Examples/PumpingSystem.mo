within Modelica.Fluid.Examples;
model PumpingSystem "Model of a pumping system for drinking water"
  extends Modelica.Icons.Example;
  Modelica.Fluid.Sources.FixedBoundary source(
    nPorts = 1,
    redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    use_T=true,
    T=Modelica.SIunits.Conversions.from_degC(20),
    p=system.p_ambient)
    annotation (Placement(transformation(extent={{-100,-80},{-80,-60}},
          rotation=0)));

  Modelica.Fluid.Pipes.StaticPipe pipe(
    redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    allowFlowReversal=true,
    length=100,
    height_ab=50,
    diameter=0.3)
    annotation (Placement(transformation(
        origin={-30,-51},
        extent={{-9,-10},{11,10}},
        rotation=90)));

  Machines.PrescribedPump pumps(
    checkValve=true,
    redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    N_nominal=1200,
    redeclare function flowCharacteristic =
        Modelica.Fluid.Machines.BaseClasses.PumpCharacteristics.quadraticFlow (
          V_flow_nominal={0,0.25,0.5}, head_nominal={100,60,0}),
    V=50/1000,
    T_start=Modelica.SIunits.Conversions.from_degC(20),
    use_N_in=true,
    nParallel=1,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial)
    annotation (Placement(transformation(extent={{-68,-80},{-48,-60}}, rotation=
           0)));

  Modelica.Fluid.Vessels.OpenTank reservoir(
    massDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    T_start=Modelica.SIunits.Conversions.from_degC(20),
    use_portsData=true,
    crossArea=50,
    level_start=2.2,
    height=3,
    nPorts=3,
    portsData={Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter=0.3),
        Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter=0.3),
        Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter=0.01)})
    annotation (Placement(transformation(extent={{-20,-16},{0,4}}, rotation=0)));

  Modelica.Fluid.Valves.ValveLinear userValve(   redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    allowFlowReversal=false,
    dp_nominal=200000,
    m_flow_nominal=400)
    annotation (Placement(transformation(extent={{58,-38},{74,-22}}, rotation=0)));
  Modelica.Fluid.Sources.FixedBoundary sink(
                                       redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    p=system.p_ambient,
    T=system.T_ambient,
    nPorts=2)
    annotation (Placement(transformation(extent={{100,-40},{80,-20}}, rotation=
            0)));
  Modelica.Blocks.Sources.Step valveOpening(startTime=200, offset=1e-6)
    annotation (Placement(transformation(extent={{56,0},{76,20}}, rotation=0)));
  Modelica.Blocks.Sources.Constant RelativePressureSetPoint(k=2e4)
    annotation (Placement(transformation(extent={{-100,60},{-80,80}}, rotation=
            0)));
  Modelica.Blocks.Logical.OnOffController controller(bandwidth=4000,
      pre_y_start=false)
                        annotation (Placement(transformation(extent={{-40,60},{
            -20,80}}, rotation=0)));
  Modelica.Blocks.Logical.TriggeredTrapezoid PumpRPMGenerator(
    rising=3,
    falling=3,
    amplitude=1200,
    offset=0.001) annotation (Placement(transformation(extent={{0,60},{20,80}},
          rotation=0)));
  Modelica.Fluid.Sensors.RelativePressure reservoirPressure(
                                                        redeclare package
      Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    annotation (Placement(transformation(extent={{10,-12},{30,-32}}, rotation=0)));
  Modelica.Blocks.Continuous.FirstOrder PT1(
    T=2,
    initType=Modelica.Blocks.Types.Init.InitialState,
    y_start=0)
    annotation (Placement(transformation(extent={{40,60},{60,80}}, rotation=0)));

  inner Modelica.Fluid.System system
                                   annotation (Placement(transformation(extent=
            {{60,-96},{80,-76}}, rotation=0)));
equation
  connect(userValve.port_b, sink.ports[1])     annotation (Line(points={{74,-30},
          {77,-30},{77,-28},{80,-28}},
                    color={0,127,255}));
  connect(source.ports[1], pumps.port_a) annotation (Line(points={{-80,-70},{
          -74,-70},{-68,-70}},               color={0,127,255}));
  connect(valveOpening.y, userValve.opening) annotation (Line(points={{77,10},{
          98,10},{98,-12},{66,-12},{66,-23.6}}, color={0,0,127}));
  connect(RelativePressureSetPoint.y, controller.reference)
                                                    annotation (Line(points={{
          -79,70},{-60,70},{-60,76},{-42,76}}, color={0,0,127}));
  connect(controller.y, PumpRPMGenerator.u)
    annotation (Line(points={{-19,70},{-2,70}}, color={255,0,255}));
  connect(reservoirPressure.p_rel, controller.u) annotation (Line(points={{20,
          -13},{20,50},{-52,50},{-52,64},{-42,64}}, color={0,0,127}));
  connect(reservoirPressure.port_b, sink.ports[2])    annotation (Line(
      points={{30,-22},{44,-22},{44,-48},{80,-48},{80,-32}},
      color={0,127,255},
      pattern=LinePattern.Dot));
  connect(PumpRPMGenerator.y, PT1.u)
    annotation (Line(points={{21,70},{38,70}}, color={0,0,127}));
  connect(PT1.y, pumps.N_in) annotation (Line(points={{61,70},{74,70},{74,30},{
          -58,30},{-58,-60}},          color={0,0,127}));
  connect(pipe.port_a, pumps.port_b)         annotation (Line(points={{-30,-60},
          {-30,-70},{-48,-70}},                color={0,127,255}));
  connect(reservoir.ports[1], pipe.port_b) annotation (Line(
      points={{-12.6667,-16},{-12.6667,-30},{-30,-30},{-30,-40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(reservoir.ports[3], reservoirPressure.port_a) annotation (Line(
      points={{-7.33333,-16},{-7,-16},{-7,-22},{10,-22}},
      color={0,127,255},
      smooth=Smooth.None,
      pattern=LinePattern.Dot));
  connect(reservoir.ports[2], userValve.port_a) annotation (Line(
      points={{-10,-16},{-10,-30},{58,-30}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{
            100,100}},
        grid={1,1}),
            graphics),
    Documentation(info="<html>
Water is pumped from a source by a pump (fitted with check valves), through a pipe whose outlet is 50 m higher than the source, into a reservoir. The users are represented by an equivalent valve, connected to the reservoir.
<p>
The water controller is a simple on-off controller, regulating on the gauge pressure measured at the base of the tower; the output of the controller is the rotational speed of the pump, which is represented by the output of a first-order system. A small but nonzero rotational speed is used to represent the standby state of the pumps, in order to avoid singularities in the flow characteristic.
<p>
Simulate for 2000 s. When the valve is opened at time t=200, the pump starts turning on and off to keep the reservoir level around 2 meters, which roughly corresponds to a gauge pressure of 200 mbar
<p>
If using Dymola, turn off \"Equidistant time grid\" to avoid numerical errors.
</p>

<img src=\"modelica://Modelica/Resources/Images/Fluid/Examples/PumpingSystem.png\" border=\"1\">
</html>", revisions="<html>
<ul>
<li><i>Jan 2009</i>
    by R&uuml;diger Franke:<br>
       Reduce diameters of pipe and reservoir ports; use separate port for measurement of reservoirPressure, avoiding disturbances due to pressure losses.</li>
<li><i>1 Oct 2007</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Parameters updated.</li>
<li><i>2 Nov 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Created.</li>
</ul>
</html>"),
    experiment(
      StopTime=2000,
      NumberOfIntervals=5000,
      Tolerance=1e-006),
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={1,1})));
end PumpingSystem;
