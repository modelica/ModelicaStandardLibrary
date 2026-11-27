within Modelica.Fluid.Examples;
package Explanatory
  "A set of examples illustrating when special attention has to be paid"
  extends Modelica.Icons.ExamplesPackage;

  model MeasuringTemperature "Differences between using one port with and without explicit junction model and two port sensors for fluid temperature measuring"
     extends Modelica.Icons.Example;
    Modelica.Fluid.Sensors.Temperature T_onePort(redeclare package Medium =
          Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{-20,40},{0,60}})));
    Modelica.Fluid.Sensors.TemperatureTwoPort T_twoPort(redeclare package
        Medium =
          Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{-20,-20},{0,0}})));
    inner Modelica.Fluid.System system(energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
                                        annotation (Placement(transformation(
            extent={{-100,56},{-80,76}})));
    Modelica.Fluid.Vessels.OpenTank openTankCold2(nPorts=1,
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      height=2,
      crossArea=2,
      portsData={Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter=0.05)},
      level_start=0.975,
      T_start=293.15) annotation (Placement(transformation(extent={{20,6},{
              40,26}})));
    Modelica.Fluid.Vessels.OpenTank openTankCold1(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      height=2,
      crossArea=2,
      portsData={Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter=0.05)},
      nPorts=1,
      level_start=0.975,
      T_start=293.15) annotation (Placement(transformation(extent={{20,60},
              {40,80}})));
    Modelica.Fluid.Vessels.OpenTank openTankHot1(nPorts=1,
      level_start=1,
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      height=2,
      crossArea=2,
      portsData={Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter=0.05)},
      T_start=353.15) annotation (Placement(transformation(extent={{60,40},
              {80,60}})));
    Modelica.Fluid.Vessels.OpenTank openTankHot2(nPorts=1,
      level_start=1,
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      height=2,
      crossArea=2,
      portsData={Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter=0.05)},
      T_start=353.15) annotation (Placement(transformation(extent={{60,-10},
              {80,10}})));
    Modelica.Fluid.Sources.MassFlowSource_T mFlow1(
      nPorts=1,
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      use_m_flow_in=true,
      use_T_in=false,
      T=323.15) annotation (Placement(transformation(extent=
             {{-60,30},{-40,50}})));
    Modelica.Fluid.Sources.MassFlowSource_T mFlow2(
      nPorts=1,
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      use_m_flow_in=true,
      T=323.15) annotation (Placement(transformation(extent=
             {{-60,-20},{-40,0}})));
    Modelica.Blocks.Sources.Sine sine(f=1)
                                      annotation (Placement(transformation(extent=
             {{-100,10},{-80,30}})));
    Modelica.Fluid.Sensors.Temperature T_junction(redeclare package Medium =
          Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
    Modelica.Fluid.Vessels.OpenTank openTankCold3(nPorts=1,
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      height=2,
      crossArea=2,
      portsData={Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter=0.05)},
      level_start=0.975,
      T_start=293.15) annotation (Placement(transformation(extent={{20,-60},
              {40,-40}})));
    Modelica.Fluid.Vessels.OpenTank openTankHot3(nPorts=1,
      level_start=1,
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      height=2,
      crossArea=2,
      portsData={Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter=0.05)},
      T_start=353.15) annotation (Placement(transformation(extent={{60,-80},
              {80,-60}})));
    Modelica.Fluid.Sources.MassFlowSource_T mFlow3(
      nPorts=1,
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      use_m_flow_in=true,
      T=323.15) annotation (Placement(transformation(extent=
             {{-60,-90},{-40,-70}})));
    Modelica.Fluid.Fittings.TeeJunctionIdeal junctionIdeal(
                                                         redeclare package
        Medium =
          Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{20,-90},{40,-70}})));
  equation
    connect(mFlow2.ports[1], T_twoPort.port_a) annotation (Line(
        points={{-40,-10},{-20,-10}}, color={0,127,255}));
    connect(mFlow1.ports[1], T_onePort.port) annotation (Line(
        points={{-40,40},{-10,40}}, color={0,127,255}));
    connect(sine.y, mFlow1.m_flow_in) annotation (Line(
        points={{-79,20},{-70,20},{-70,48},{-60,48}}, color={0,0,127}));
    connect(sine.y, mFlow2.m_flow_in) annotation (Line(
        points={{-79,20},{-70,20},{-70,-2},{-60,-2}}, color={0,0,127}));
    connect(mFlow3.ports[1], T_junction.port) annotation (Line(
        points={{-40,-80},{-10,-80}}, color={0,127,255}));
    connect(sine.y, mFlow3.m_flow_in) annotation (Line(
        points={{-79,20},{-70,20},{-70,-72},{-60,-72}}, color={0,0,127}));
    connect(T_junction.port, junctionIdeal.port_1) annotation (Line(
        points={{-10,-80},{20,-80}}, color={0,127,255}));
    connect(T_twoPort.port_b, openTankCold2.ports[1]) annotation (Line(
          points={{0,-10},{0,-10},{30,-10},{30,6}}, color={0,127,255}));
    connect(T_onePort.port, openTankHot1.ports[1]) annotation (Line(
          points={{-10,40},{-10,40},{70,40}}, color={0,127,255}));
    connect(T_twoPort.port_b, openTankHot2.ports[1]) annotation (Line(
          points={{0,-10},{30,-10},{70,-10}}, color={0,127,255}));
    connect(junctionIdeal.port_3, openTankCold3.ports[1]) annotation (Line(points={{30,-70},
            {30,-65},{30,-60}}, color={0,127,255}));
    connect(junctionIdeal.port_2, openTankHot3.ports[1]) annotation (Line(points={{40,-80},
            {55.5,-80},{70,-80}}, color={0,127,255}));
    connect(T_onePort.port, openTankCold1.ports[1]) annotation (Line(
        points={{-10,40},{30,40},{30,60}}, color={0,127,255}));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,
              -100},{100,100}}), graphics={
          Text(
            extent={{42,52},{62,46}},
            textString="T=80"),
          Text(
            extent={{-4,76},{18,70}},
            textString="T=20"),
          Text(
            extent={{-62,20},{-36,12}},
            textString="T=50")}),
                         Documentation(info="<html>
<p>
This model demonstrates the differences that occur when using
one- and two-port temperature sensors with and without explicit junction models.
As shown in the next figure, the same system is shown in 3 different variations.
In all cases exactly the same fluid system is defined. The only difference is
how the temperature is measured:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Examples/Explanatory/MeasuringTemperature1.png\"
     alt=\"MeasuringTemperature1.png\">
</blockquote>

<p>
A pre-defined mass flow rate is present so that fluid flows from the reservoir to the
tanks and after 0.5 s the mass flows from the tanks to the reservoir.
The reservoir has a temperature of 50<sup>0</sup>C whereas the tanks have an
initial temperature of 20<sup>0</sup>C and of 80<sup>0</sup>C. The initial height of the
tanks is made in such a form that fluid always flows out of the cold tank.
When the fluid flows from the reservoir to the tanks, then it mixes with the
cold tank and enters the hot tank.
When the fluid flow from the tanks to the reservoir, then the cold and hot water
from the two tanks first mixes and the flows to the reservoir.
</p>

<p>
A one-port sensor measures the <em>mixing</em> temperature at a connection point.
Therefore T_onePort.T (the blue curve in the figure below) is the
temperature of the mixing point.
A two-port sensor measures the temperature at the <em>upstream</em> side.
Therefore T_twoPort.T (the red curve in the figure below which is identical
to the green curve) shows first the temperature of the reservoir and then
the mixing temperature when fluid flows from the tanks to the reservoir.
The same is measured with T_junction.T (the green curve below), because
the one-port sensor is connected between the mass flow source and the junction
and since the mixing takes place in the junction, the same situation is
present as for T_twoPort.T.
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Examples/Explanatory/MeasuringTemperature2.png\"
     alt=\"MeasuringTemperature2.png\">
</blockquote>

</html>"),
      experiment(StopTime=1.1));
  end MeasuringTemperature;

  model MomentumBalanceFittings
    "Illustrating a case in which kinetic terms play a major role in the momentum balance"
     extends Modelica.Icons.Example;
    Modelica.Fluid.Sources.Boundary_pT leftBoundary1(
      redeclare package Medium = Modelica.Media.Water.StandardWaterOnePhase,
      nPorts=1,
      p=100000)
      annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
    Modelica.Fluid.Sources.Boundary_pT rightBoundary1(
      redeclare package Medium = Modelica.Media.Water.StandardWaterOnePhase,
      nPorts=1,
      p=110000)
      annotation (Placement(transformation(extent={{80,20},{60,40}})));
    Modelica.Fluid.Fittings.AbruptAdaptor suddenExpansion1(
      diameter_a=0.1,
      diameter_b=0.2,
      m_flow_start=60,
      redeclare package Medium = Modelica.Media.Water.StandardWaterOnePhase,
      show_totalPressures=true,
      show_portVelocities=true)
      annotation (Placement(transformation(extent={{-12,20},{8,40}})));
    Modelica.Fluid.Sources.Boundary_pT leftBoundary2(
      redeclare package Medium = Modelica.Media.Water.StandardWaterOnePhase,
      nPorts=1,
      p=100000)
      annotation (Placement(transformation(extent={{-90,-40},{-70,-20}})));
    Modelica.Fluid.Sources.Boundary_pT rightBoundary2(
      redeclare package Medium = Modelica.Media.Water.StandardWaterOnePhase,
      nPorts=1,
      p=110000)
      annotation (Placement(transformation(extent={{90,-40},{70,-20}})));
    Modelica.Fluid.Fittings.AbruptAdaptor suddenExpansion2(
      diameter_a=0.1,
      diameter_b=0.2,
      redeclare package Medium = Modelica.Media.Water.StandardWaterOnePhase,
      show_totalPressures=true,
      show_portVelocities=true)
      annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
    Modelica.Fluid.Fittings.AbruptAdaptor leftAdaptor(
      diameter_a=0.1,
      redeclare package Medium = Modelica.Media.Water.StandardWaterOnePhase,
      diameter_b=1e60)
      annotation (Placement(transformation(extent={{-40,-40},{-60,-20}})));
    Modelica.Fluid.Fittings.AbruptAdaptor rightAdaptor(
      redeclare package Medium = Modelica.Media.Water.StandardWaterOnePhase,
      diameter_a=0.2,
      diameter_b=1e60)
      annotation (Placement(transformation(extent={{40,-40},{60,-20}})));
    inner System system
      annotation (Placement(transformation(extent={{-92,56},{-72,76}})));
  equation
    connect(leftBoundary1.ports[1], suddenExpansion1.port_a) annotation (Line(
        points={{-60,30},{-12,30}}, color={0,127,255}));
    connect(suddenExpansion1.port_b, rightBoundary1.ports[1]) annotation (Line(
        points={{8,30},{60,30}}, color={0,127,255}));
    connect(leftAdaptor.port_b, leftBoundary2.ports[1]) annotation (Line(
        points={{-60,-30},{-70,-30}}, color={0,127,255}));
    connect(leftAdaptor.port_a, suddenExpansion2.port_a) annotation (Line(
        points={{-40,-30},{-10,-30}}, color={0,127,255}));
    connect(suddenExpansion2.port_b,rightAdaptor. port_a) annotation (Line(
        points={{10,-30},{40,-30}}, color={0,127,255}));
    connect(rightAdaptor.port_b, rightBoundary2.ports[1]) annotation (Line(
        points={{60,-30},{70,-30}}, color={0,127,255}));
    annotation (
      Documentation(info="<html>
<p>
This example shows the use of a sudden expansion / contraction model, which is connected to two boundary conditions prescribing static pressure. Notice that the prescribed static pressure on the right boundary is higher than on the left one. Still, the fluid flows from left to right.
</p>
<p>
The reason for this is that the boundary conditions model infinite reservoirs with an infinite diameter and thus zero flow velocity. The sudden expansion model does however have two ends with finite diameters, and, as explained in the <a href=\"modelica://Modelica.Fluid.UsersGuide.Overview\">Overview</a> of the Users' Guide, the momentum balance is not fulfilled exactly for this type of connections. Using a simple <code>connect()</code>-statement, the difference of the kinetic terms is neglected, which is not reasonable in the present model: At the left boundary condition it is zero, and on the left side of the sudden expansion it has a non-zero value. It is not reasonable to neglect it in the shown model, because there is little friction and therefore these kinetic effects dominate. Consequently, only modelling these effects explicitly leads to the correct results.
</p>
<p>
To do so, two additional sudden expansions / contractions are included in the model. The diameter is set to a large value (<code>1e60</code>) close to the boundaries and the proper values close to the original model. These additional components now introduce <em>exact</em> momentum balances and the results are as expected.
</p>
<p>
The total pressures offer an additional perspective on the model. After setting the parameter <code>show_totalPressures</code> on the Advanced tab of the <code>AbruptAdaptor</code>s to <code>true</code>, the total pressures are included in said models and may be plotted. This allows to confirm that the <strong>total</strong> pressure <em>always</em> reduces along the flow direction, even in the upper model.
</p>

<img src=\"modelica://Modelica/Resources/Images/Fluid/Examples/Explanatory/MomentumBalanceFittings.png\" border=\"1\"
     alt=\"MomentumBalanceFittings.png\">
</html>"),
      __Dymola_Commands(file=
            "modelica://Modelica/Resources/Scripts/Dymola/Fluid/MomentumBalanceFittings/Plot the model results.mos"
          "Plot the model results"),
      experiment(StopTime=1.1));
  end MomentumBalanceFittings;

  model SimplerHeatingSystem
    "Simpler model of a heating system; the N in pump is ignored"
    extends Modelica.Icons.Example;
     replaceable package Medium =
        Modelica.Media.CompressibleLiquids.LinearWater_pT_Ambient
       constrainedby Modelica.Media.Interfaces.PartialMedium;

    Modelica.Fluid.Vessels.OpenTank tank(
      redeclare package Medium = Medium,
      crossArea=0.01,
      height=2,
      level_start=1,
      nPorts=2,
      massDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
      use_HeatTransfer=true,
      portsData={Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter=
          0.01),Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter=
          0.01)},
      redeclare model HeatTransfer =
          Modelica.Fluid.Vessels.BaseClasses.HeatTransfer.IdealHeatTransfer (k=10),
      ports(each p(start=1.1e5)),
      T_start=Modelica.Units.Conversions.from_degC(20))
                annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
    Machines.SimplePump pump(
      redeclare package Medium = Medium,
      N_nominal=1500,
      use_T_start=true,
      T_start=Modelica.Units.Conversions.from_degC(40),
      m_flow_start=0.01,
      m_flow_nominal=0.01,
      control_m_flow=false,
      allowFlowReversal=false,
      p_a_start=110000,
      p_b_start=130000,
      p_a_nominal=110000,
      p_b_nominal=130000)
      annotation (Placement(transformation(extent={{-50,10},{-30,30}})));
    Modelica.Fluid.Valves.ValveIncompressible valve(
      redeclare package Medium = Medium,
      CvData=Modelica.Fluid.Types.CvTypes.OpPoint,
      m_flow_nominal=0.01,
      show_T=true,
      allowFlowReversal=false,
      dp_start=18000,
      dp_nominal=10000)
      annotation (Placement(transformation(extent={{60,-80},{40,-60}})));
  protected
    Modelica.Blocks.Interfaces.RealOutput m_flow(unit="kg/s")
      annotation (Placement(transformation(extent={{-6,34},{6,46}})));
  public
    Sensors.MassFlowRate sensor_m_flow(redeclare package Medium = Medium)
      annotation (Placement(transformation(extent={{-20,10},{0,30}})));
    Modelica.Thermal.HeatTransfer.Sources.FixedTemperature T_ambient(T=system.T_ambient)
      annotation (Placement(transformation(extent={{-14,-27},{0,-13}})));
    Modelica.Thermal.HeatTransfer.Components.ThermalConductor wall(G=1.6e3/20)
      annotation (Placement(transformation(
          origin={10,-48},
          extent={{8,-10},{-8,10}},
          rotation=90)));
    Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow burner(
                                                       Q_flow=1.6e3,
      T_ref=343.15,
      alpha=-0.5)
      annotation (Placement(transformation(extent={{16,30},{36,50}})));
    inner Modelica.Fluid.System system(
        m_flow_small=1e-4, energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial)
                          annotation (Placement(transformation(extent={{-90,70},{
              -70,90}})));
    Pipes.DynamicPipe heater(
      redeclare package Medium = Medium,
      use_T_start=true,
      T_start=Modelica.Units.Conversions.from_degC(80),
      length=2,
      redeclare model HeatTransfer =
          Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.IdealFlowHeatTransfer,
      diameter=0.01,
      nNodes=1,
      redeclare model FlowModel =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
      use_HeatTransfer=true,
      modelStructure=Modelica.Fluid.Types.ModelStructure.a_v_b,
      p_a_start=130000)
      annotation (Placement(transformation(extent={{30,10},{50,30}})));

    Pipes.DynamicPipe radiator(
      use_T_start=true,
      redeclare package Medium = Medium,
      length=10,
      T_start=Modelica.Units.Conversions.from_degC(40),
      redeclare model HeatTransfer =
          Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.IdealFlowHeatTransfer,
      diameter=0.01,
      nNodes=1,
      redeclare model FlowModel =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
      use_HeatTransfer=true,
      modelStructure=Modelica.Fluid.Types.ModelStructure.a_v_b,
      p_a_start=110000,
      state_a(p(start=110000)),
      state_b(p(start=110000)))
      annotation (Placement(transformation(extent={{20,-80},{0,-60}})));

  protected
    Modelica.Blocks.Interfaces.RealOutput T_forward(unit="K")
      annotation (Placement(transformation(extent={{74,34},{86,46}})));
    Modelica.Blocks.Interfaces.RealOutput T_return(unit="K")
      annotation (Placement(transformation(extent={{-46,-56},{-58,-44}})));
  public
    Modelica.Fluid.Sensors.Temperature sensor_T_forward(redeclare package Medium =
          Medium)
      annotation (Placement(transformation(extent={{50,30},{70,50}})));
    Modelica.Fluid.Sensors.Temperature sensor_T_return(redeclare package Medium =
          Medium)
      annotation (Placement(transformation(extent={{-20,-60},{-40,-40}})));
  protected
    Modelica.Blocks.Interfaces.RealOutput tankLevel(unit="m")
                                   annotation (Placement(transformation(extent={{-56,34},
              {-44,46}})));
  public
    Modelica.Blocks.Sources.Step handle(
      startTime=2000,
      height=0.9,
      offset=0.1) annotation (Placement(transformation(extent={{26,-27},{40,-13}})));
    Pipes.DynamicPipe pipe(
      redeclare package Medium = Medium,
      use_T_start=true,
      T_start=Modelica.Units.Conversions.from_degC(80),
      redeclare model HeatTransfer =
          Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.IdealFlowHeatTransfer,
      diameter=0.01,
      redeclare model FlowModel =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
      length=10,
      p_a_start=130000)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
                                                                     rotation=-90,
          origin={80,-20})));

  equation
  tankLevel = tank.level;
    connect(sensor_m_flow.m_flow, m_flow) annotation (Line(points={{-10,31},
            {-10,40},{0,40}}, color={0,0,127}));
    connect(sensor_m_flow.port_b, heater.port_a)
                                              annotation (Line(points={{0,20},{0,
            20},{30,20}}, color={0,127,255}));
    connect(T_ambient.port, wall.port_a) annotation (Line(
          points={{0,-20},{10,-20},{10,-40}}, color={191,0,0}));
    connect(sensor_T_forward.T, T_forward) annotation (Line(points={{67,40},{
            80,40}}, color={0,0,127}));
    connect(radiator.port_a, valve.port_b) annotation (Line(points={{20,-70},{20,
            -70},{40,-70}}, color={0,127,255}));
    connect(sensor_T_return.port, radiator.port_b)
                                              annotation (Line(points={{-30,-60},
            {-30,-70},{0,-70}}, color={0,127,255}));
    connect(tank.ports[2], pump.port_a) annotation (Line(
        points={{-69,30},{-69,20},{-50,20}}, color={0,127,255}));
    connect(handle.y, valve.opening) annotation (Line(
        points={{40.7,-20},{50,-20},{50,-62}}, color={0,0,127}));
    connect(pump.port_b, sensor_m_flow.port_a)
                                              annotation (Line(
        points={{-30,20},{-20,20}}, color={0,127,255}));
    connect(sensor_T_return.T, T_return) annotation (Line(
        points={{-37,-50},{-52,-50}}, color={0,0,127}));
    connect(burner.port, heater.heatPorts[1])
                                            annotation (Line(
        points={{36,40},{40.1,40},{40.1,24.4}}, color={191,0,0}));
    connect(wall.port_b, radiator.heatPorts[1]) annotation (Line(
        points={{10,-56},{10,-65.6},{9.9,-65.6}}, color={191,0,0}));
    connect(sensor_T_forward.port, heater.port_b)
                                                annotation (Line(
        points={{60,30},{60,20},{50,20}}, color={0,127,255}));
    connect(heater.port_b, pipe.port_a) annotation (Line(
        points={{50,20},{80,20},{80,-10}}, color={0,127,255}));
    connect(pipe.port_b, valve.port_a) annotation (Line(
        points={{80,-30},{80,-70},{60,-70}}, color={0,127,255}));
    connect(radiator.port_b, tank.ports[1]) annotation (Line(
        points={{0,-70},{-71,-70},{-71,30}}, color={0,127,255}));
    annotation (Documentation(info="<html>
<p>
Simple heating system with a closed flow cycle.
It is based on <a href=\"Modelica.Fluid.Examples.HeatingSystem\">HeatingSystem</a>.
The only change is that pump is simpler removing a non-linear system of equations for N that could in some cases fail.

After 2000s of simulation time the valve fully opens. A simple idealized control is embedded
into the respective components, so that the heating system can be regulated with the valve:
the pump controls the pressure, the burner controls the temperature.
</p>
<p>
One can investigate the temperatures and flows for different settings of <code>system.energyDynamics</code>
(see Assumptions tab of the system object).</p>
<ul>
<li>With <code>system.energyDynamics==Types.Dynamics.FixedInitial</code> the states need to find their steady values during the simulation.</li>
<li>With <code>system.energyDynamics==Types.Dynamics.SteadyStateInitial</code> (default setting) the simulation starts in steady-state.</li>
<li>With <code>system.energyDynamics==Types.Dynamics.SteadyState</code> all but one dynamic states are eliminated.
    The left state <code>tank.m</code> is to account for the closed flow cycle. It is constant as outflow and inflow are equal
    in a steady-state simulation.</li>
</ul>
<p>
Note that a closed flow cycle generally causes circular equalities for the mass flow rates and leaves the pressure undefined.
This is why the tank.massDynamics, i.e., the tank level determining the port pressure, is modified locally to Types.Dynamics.FixedInitial.
</p>
<p>
Also note that the tank is thermally isolated against its ambient. This way the temperature of the tank is also
well defined for zero flow rate in the heating system, e.g., for valveOpening.offset=0 at the beginning of a simulation.
The pipe however is assumed to be perfectly isolated.
If steady-state values shall be obtained with the valve fully closed, then a thermal
coupling between the pipe and its ambient should be defined as well.
</p>
<p>
Moreover it is worth noting that the idealized direct connection between the heater and the pipe, resulting in equal port pressures,
is treated as high-index DAE, as opposed to a nonlinear equation system for connected pressure loss correlations. A pressure loss correlation
could be additionally introduced to model the fitting between the heater and the pipe, e.g., to adapt different diameters.
</p>

<img src=\"modelica://Modelica/Resources/Images/Fluid/Examples/HeatingSystem.png\" border=\"1\"
     alt=\"HeatingSystem.png\">
</html>"),   experiment(StopTime=6000));
  end SimplerHeatingSystem;
end Explanatory;
