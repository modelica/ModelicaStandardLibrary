within Modelica.Fluid.Examples;
package Explanatory
  "A set of examples illustrating when special attention has to be paid"

  model MeasuringTemperature "Differences between using one port with
   and without explicit junction model and two port sensors for fluid temperature meassuring"
     extends Modelica.Icons.Example;
    Modelica.Fluid.Sensors.Temperature T_onePort(redeclare package Medium =
          Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{-20,40},{0,60}}, rotation=0)));
    Modelica.Fluid.Sensors.TemperatureTwoPort T_twoPort(redeclare package
        Medium =
          Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{-20,0},{0,-20}}, rotation=0)));
    inner Modelica.Fluid.System system(energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
                                        annotation (Placement(transformation(
            extent={{-100,56},{-80,76}},    rotation=0)));
    Modelica.Fluid.Vessels.OpenTank openTankCold2(nPorts=1,
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      height=2,
      crossArea=2,
      portsData={Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter=0.05)},
      level_start=0.975,
      T_start=293.15)                                                                annotation (Placement(transformation(extent={{20,6},{
              40,26}},  rotation=0)));
    Modelica.Fluid.Vessels.OpenTank openTankCold1(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      height=2,
      crossArea=2,
      portsData={Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter=0.05)},
      nPorts=1,
      level_start=0.975,
      T_start=293.15)                                                                annotation (Placement(transformation(extent={{20,60},
              {40,80}}, rotation=0)));
    Modelica.Fluid.Vessels.OpenTank openTankHot1(nPorts=1,
      level_start=1,
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      height=2,
      crossArea=2,
      portsData={Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter=0.05)},
      T_start=353.15)                                                                annotation (Placement(transformation(extent={{60,40},
              {80,60}}, rotation=0)));
    Modelica.Fluid.Vessels.OpenTank openTankHot2(nPorts=1,
      level_start=1,
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      height=2,
      crossArea=2,
      portsData={Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter=0.05)},
      T_start=353.15)                                                                annotation (Placement(transformation(extent={{60,-10},
              {80,10}},rotation=0)));
    Modelica.Fluid.Sources.MassFlowSource_T mFlow1(
      nPorts=1,
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      use_m_flow_in=true,
      use_T_in=false,
      T=323.15)                       annotation (Placement(transformation(extent=
             {{-60,30},{-40,50}}, rotation=0)));
    Modelica.Fluid.Sources.MassFlowSource_T mFlow2(
      nPorts=1,
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      use_m_flow_in=true,
      T=323.15)                       annotation (Placement(transformation(extent=
             {{-60,-20},{-40,0}}, rotation=0)));
    Modelica.Blocks.Sources.Sine sine(freqHz=1)
                                      annotation (Placement(transformation(extent=
             {{-100,10},{-80,30}}, rotation=0)));
    Modelica.Fluid.Sensors.Temperature T_junction(redeclare package Medium =
          Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{-20,-80},{0,-60}}, rotation=0)));
    Modelica.Fluid.Vessels.OpenTank openTankCold3(nPorts=1,
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      height=2,
      crossArea=2,
      portsData={Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter=0.05)},
      level_start=0.975,
      T_start=293.15)                                                                annotation (Placement(transformation(extent={{20,-60},
              {40,-40}}, rotation=0)));
    Modelica.Fluid.Vessels.OpenTank openTankHot3(nPorts=1,
      level_start=1,
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      height=2,
      crossArea=2,
      portsData={Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter=0.05)},
      T_start=353.15)                                                                annotation (Placement(transformation(extent={{60,-80},
              {80,-60}}, rotation=0)));
    Modelica.Fluid.Sources.MassFlowSource_T mFlow3(
      nPorts=1,
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      use_m_flow_in=true,
      T=323.15)                       annotation (Placement(transformation(extent=
             {{-60,-90},{-40,-70}}, rotation=0)));
    Modelica.Fluid.Fittings.TeeJunctionIdeal junctionIdeal(
                                                         redeclare package
        Medium =
          Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{20,-90},{40,-70}}, rotation=0)));
  equation
    connect(mFlow2.ports[1], T_twoPort.port_a)             annotation (Line(
        points={{-40,-10},{-20,-10}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(mFlow1.ports[1], T_onePort.port)             annotation (Line(
        points={{-40,40},{-10,40}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(sine.y, mFlow1.m_flow_in)        annotation (Line(
        points={{-79,20},{-70,20},{-70,48},{-60,48}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(sine.y, mFlow2.m_flow_in)        annotation (Line(
        points={{-79,20},{-70,20},{-70,-2},{-60,-2}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(mFlow3.ports[1], T_junction.port)                    annotation (Line(
        points={{-40,-80},{-10,-80}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(sine.y, mFlow3.m_flow_in)        annotation (Line(
        points={{-79,20},{-70,20},{-70,-72},{-60,-72}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(T_junction.port, junctionIdeal.port_1)          annotation (Line(
        points={{-10,-80},{20,-80}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(T_twoPort.port_b, openTankCold2.ports[1])          annotation (Line(
          points={{0,-10},{0,-10},{30,-10},{30,6}},  color={0,127,255}));
    connect(T_onePort.port, openTankHot1.ports[1])   annotation (Line(
          points={{-10,40},{-10,40},{70,40}},            color={0,127,255}));
    connect(T_twoPort.port_b, openTankHot2.ports[1])          annotation (Line(
          points={{0,-10},{30,-10},{70,-10}},              color={0,127,255}));
    connect(junctionIdeal.port_3, openTankCold3.ports[1]) annotation (Line(points={{30,-70},
            {30,-65},{30,-60}},   color={0,127,255}));
    connect(junctionIdeal.port_2, openTankHot3.ports[1]) annotation (Line(points={{40,-80},
            {55.5,-80},{70,-80}},                          color={0,127,255}));
    connect(T_onePort.port, openTankCold1.ports[1])   annotation (Line(
        points={{-10,40},{30,40},{30,60}},
        color={0,127,255},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,
              -100},{100,100}}), graphics={
          Text(
            extent={{42,52},{62,46}},
            lineColor={0,0,0},
            textString="T=80"),
          Text(
            extent={{-4,76},{18,70}},
            lineColor={0,0,0},
            textString="T=20"),
          Text(
            extent={{-62,20},{-36,12}},
            lineColor={0,0,0},
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
<img src=\"../Images/Fluid/Examples/MeasuringTemperature1.png\">
</blockquote>

<p>
A pre-defined mass flow rate is present so that fluid flows from the reservoir to the
tanks and after 0.5 s the mass flows from the tanks to the reservoir.
The reservoir has a temperature of 50<sup>0</sup>C whereas the tanks have an
initial temperatur of 20<sup>0</sup>C and of 80<sup>0</sup>C. The initial height of the
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
<img src=\"../Images/Fluid/Examples/MeasuringTemperature2.png\">
</blockquote>

</html>"));
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
      diameter_b=Modelica.Constants.inf)
      annotation (Placement(transformation(extent={{-40,-40},{-60,-20}})));
    Modelica.Fluid.Fittings.AbruptAdaptor rightAdaptor(
      redeclare package Medium = Modelica.Media.Water.StandardWaterOnePhase,
      diameter_a=0.2,
      diameter_b=Modelica.Constants.inf)
      annotation (Placement(transformation(extent={{40,-40},{60,-20}})));
    inner System system
      annotation (Placement(transformation(extent={{-92,56},{-72,76}})));
  equation
    connect(leftBoundary1.ports[1], suddenExpansion1.port_a) annotation (Line(
        points={{-60,30},{-12,30}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(suddenExpansion1.port_b, rightBoundary1.ports[1]) annotation (Line(
        points={{8,30},{60,30}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(leftAdaptor.port_b, leftBoundary2.ports[1]) annotation (Line(
        points={{-60,-30},{-70,-30}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(leftAdaptor.port_a, suddenExpansion2.port_a) annotation (Line(
        points={{-40,-30},{-10,-30}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(suddenExpansion2.port_b,rightAdaptor. port_a) annotation (Line(
        points={{10,-30},{40,-30}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(rightAdaptor.port_b, rightBoundary2.ports[1]) annotation (Line(
        points={{60,-30},{70,-30}},
        color={0,127,255},
        smooth=Smooth.None));
    annotation (
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}),
                      graphics),
      Documentation(info="<html>
<p>
This example shows the use of a sudden expansion / contraction model, which is connected to two boundary conditions prescribing static pressure. Notice that the prescribed static pressure on the right boundary is higher than on the left one. Still, the fluid flows from left to right.
</p>
<p>
The reason for this is that the boundary conditions model infinite reservoirs with an infinite diameter and thus zero flow velocity. The sudden expansion model does however have two ends with finite diameters, and, as explained in the <a href=\"Modelica://Modelica.Fluid.UsersGuide.Overview\">Overview</a> of the Users' Guide, the momentum balance is not fulfilled exactly for this type of connections. Using a simple <code>connect()</code>-statement, the difference of the kinetic terms is neglected, which is not reasonable in the present model: At the left boundary condition it is zero, and on the left side of the sudden expansion it has a non-zero value. It is not reasonable to neglect it in the shown model, because there is little friction and therefore these kinetic effects dominate. Consequently, only modelling these effects explicitly leads to the correct results.
</p>
<p>
To do so, two additional sudden expansions / contractions are included in the model. The diameter is set to <code>inf</code> close to the boundaries and the proper values close to the original model. These additional components now introduce <i>exact</i> momentum balances and the results are as expected.
</p>
<p>
The total pressures offer an additional perspective on the model. After setting the parameter <code>show_totalPressures</code> on the Advanced tab of the <code>AbruptAdaptor</code>s to <code>true</code>, the total pressures are included in said models and may be plotted. This allows to confirm that the <b>total</b> pressure <i>always</i> reduces along the flow direction, even in the upper model.
</p>


<p align=\"center\">
<img src=\"../Images/Fluid/Examples/MomentumBalanceFittings.png\" border=\"1\">
</p>


</html>"),
      __Dymola_Commands(file=
            "Scripts/Fluid/MomentumBalanceFittings/Plot the model results.mos"
          "Plot the model results"));
  end MomentumBalanceFittings;
end Explanatory;
