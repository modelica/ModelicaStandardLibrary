within Modelica.Thermal.HeatTransfer.Examples;
model Motor "Second order thermal model of a motor"
  extends Modelica.Icons.Example;
  parameter SI.Temperature TAmb(displayUnit="degC") = 293.15
    "Ambient temperature";

  Modelica.Blocks.Sources.CombiTimeTable lossTable(
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    table=[0,100,500; 360,1000,500; 600,100,500]) annotation (Placement(transformation(
        origin={-40,70},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  HeatTransfer.Sources.PrescribedHeatFlow windingLosses(T_ref=368.15, alpha=
        3.03E-3) annotation (Placement(transformation(
        origin={-80,10},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  HeatTransfer.Components.HeatCapacitor winding(C=2500, T(start=TAmb, fixed=
          true))
    annotation (Placement(transformation(extent={{-90,-20},{-70,-40}})));
  HeatTransfer.Celsius.TemperatureSensor Twinding annotation (Placement(
        transformation(
        origin={-60,-50},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  HeatTransfer.Components.ThermalConductor winding2core(G=10)
    annotation (Placement(transformation(extent={{-50,-20},{-30,0}})));
  HeatTransfer.Sources.PrescribedHeatFlow coreLosses annotation (Placement(
        transformation(
        origin={0,10},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  HeatTransfer.Components.HeatCapacitor core(C=25000, T(start=TAmb, fixed=true))
    annotation (Placement(transformation(extent={{-10,-20},{10,-40}})));
  HeatTransfer.Celsius.TemperatureSensor Tcore annotation (Placement(
        transformation(
        origin={-20,-50},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Blocks.Sources.Constant convectionConstant(k=25)
    annotation (Placement(transformation(
        origin={40,30},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  HeatTransfer.Components.Convection convection
    annotation (Placement(transformation(extent={{30,-20},{50,0}})));
  HeatTransfer.Sources.FixedTemperature environment(T=TAmb) annotation (
      Placement(transformation(
        origin={80,-10},
        extent={{-10,-10},{10,10}},
        rotation=180)));
equation
  connect(windingLosses.port, winding.port) annotation (Line(points={{-80,0},
          {-80,-20}}, color={191,0,0}));
  connect(coreLosses.port, core.port) annotation (Line(points={{0,0},{0,
          -10},{0,-20}}, color={191,0,
          0}));
  connect(winding.port, winding2core.port_a)
                                   annotation (Line(points={{-80,-20},{-80,
          -10},{-50,-10}}, color={191,0,0}));
  connect(winding2core.port_b, core.port)
                                annotation (Line(points={{-30,-10},{0,-10},
          {0,-20}}, color={191,0,0}));
  connect(winding.port, Twinding.port) annotation (Line(points={{-80,-20},
          {-80,-10},{-60,-10},{-60,-40}}, color={191,0,0}));
  connect(core.port, Tcore.port) annotation (Line(points={{0,-20},{0,-10},
          {-20,-10},{-20,-40}}, color={191,0,0}));
  connect(winding2core.port_b, convection.solid)
                                      annotation (Line(points={{-30,-10},{
          30,-10}}, color={191,0,0}));
  connect(convection.fluid, environment.port) annotation (Line(points={{50,-10},
          {60,-10},{70,-10}}, color={191,0,0}));
  connect(convectionConstant.y, convection.Gc)
    annotation (Line(points={{40,19},{40,0}}, color={0,0,127}));
  connect(lossTable.y[1], windingLosses.Q_flow) annotation (Line(points={{-40,59},
          {-40,40},{-80,40},{-80,20}}, color={0,0,127}));
  connect(lossTable.y[2], coreLosses.Q_flow) annotation (Line(points={{-40,59},
          {-40,40},{0,40},{0,20}}, color={0,0,
          127}));
  annotation (Documentation(info="<html>
<p>
This example contains a simple second order thermal model of a motor.
The periodic power losses are described by table \"lossTable\":
</p>
<table>
<tr><td>time</td><td>winding losses</td><td>core losses</td></tr>
<tr><td>   0</td><td>           100</td><td>        500</td></tr>
<tr><td> 360</td><td>           100</td><td>        500</td></tr>
<tr><td> 360</td><td>          1000</td><td>        500</td></tr>
<tr><td> 600</td><td>          1000</td><td>        500</td></tr>
</table>
<p>
Since constant speed is assumed, the core losses keep constant
whereas the winding losses are low for 6 minutes (no-load) and high for 4 minutes (over load).
</p>
<p>
The winding losses are corrected by (1 + alpha*(T - T_ref)) because the winding's resistance is temperature dependent whereas the core losses are kept constant (alpha = 0).
</p>
<p>
The power dissipation to the environment is approximated by heat flow through
a thermal conductance between winding and core,
partially storage of the heat in the winding's heat capacity
as well as the core's heat capacity and finally by forced convection to the environment.<br>
Since constant speed is assumed, the convective conductance keeps constant.<br>
Using Modelica.Thermal.FluidHeatFlow it would be possible to model the coolant air flow, too
(instead of simple dissipation to a constant ambient's temperature).
</p>
<p>
Simulate for 7200 s; plot Twinding.T and Tcore.T.
</p>
</html>"),
    experiment(StopTime=7200, Interval=0.01));
end Motor;
