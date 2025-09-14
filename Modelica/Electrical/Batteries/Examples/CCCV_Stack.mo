within Modelica.Electrical.Batteries.Examples;
model CCCV_Stack
  "Charge a stack with constant current - constant voltage characteristic"
  extends Modelica.Icons.Example;
  parameter Modelica.Units.SI.Current Isc = 1200 "Short-circuit current of cell at OCVmax";
  parameter Modelica.Electrical.Batteries.ParameterRecords.ExampleData cellDataOriginal(
    Qnom=18000,
    useLinearSOCDependency=false,
    Ri=cellDataOriginal.OCVmax/Isc,
    Idis=0.001) "Original cell data"
    annotation (Placement(transformation(extent={{-40,-60},{-20,-40}})));
  parameter Modelica.Electrical.Batteries.ParameterRecords.ExampleData cellDataDegraded(
    Qnom=18000,
    useLinearSOCDependency=false,
    Ri=2*cellDataDegraded.OCVmax/Isc,
    Idis=0.001) "Degraded cell data"
    annotation (Placement(transformation(extent={{20,-60},{40,-40}})));
  parameter Modelica.Electrical.Batteries.ParameterRecords.StackData
    stackData(
    Ns=3,
    Np=2,
    kDegraded=[1,1],
    cellDataOriginal=cellDataOriginal,
    cellDataDegraded=cellDataDegraded) "Stack data"
    annotation (Placement(transformation(extent={{-10,-60},{10,-40}})));
  Modelica.Electrical.Batteries.Utilities.CCCVcharger cccvCharger(I=stackData.Np*25, Vend=stackData.Ns*4.2)
    annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-50,0})));
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{-30,-40},{-10,-20}})));
  Modelica.Electrical.Batteries.BatteryStacksWithSensors.Stack stack(
    stackData=stackData,
    useHeatPort=true,
    SOC0=fill(
          0.1,
          stackData.Ns,
          stackData.Np)) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90)));
  Modelica.Electrical.Batteries.Utilities.BusTranscription busTranscription(
      Np=stackData.Np, Ns=stackData.Ns)
    annotation (Placement(transformation(extent={{30,-30},{50,-10}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollectorMatrix thermalCollectorMatrix(
    Ns=stackData.Ns, Np=stackData.Np) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={40,20})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=293.15)
    annotation (Placement(transformation(extent={{80,10},{60,30}})));
  Modelica.Electrical.Analog.Sensors.MultiSensor multiSensor
    annotation (Placement(transformation(extent={{-30,30},{-10,50}})));
  Modelica.Blocks.Continuous.Integrator energy(u(unit="W"), y(unit="J"))
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        origin={-70,34})));
equation
  connect(ground.p, cccvCharger.n) annotation (Line(points={{-20,-20},{-50,-20},
          {-50,-10}},      color={0,0,255}));
  connect(ground.p, stack.n)
    annotation (Line(points={{-20,-20},{0,-20},{0,-10}}, color={0,0,255}));
  connect(stack.stackBus, busTranscription.stackBus) annotation (Line(
      points={{8,-6},{20,-6},{20,-20},{30,-20}},
      color={255,204,51},
      thickness=0.5));
  connect(stack.heatPort, thermalCollectorMatrix.port_a)
    annotation (Line(points={{10,0},{20,0},{20,20},{30,20}}, color={191,0,0}));
  connect(thermalCollectorMatrix.port_b, fixedTemperature.port)
    annotation (Line(points={{50,20},{60,20}}, color={191,0,0}));
  connect(cccvCharger.p, multiSensor.pc)
    annotation (Line(points={{-50,10},{-50,40},{-30,40}}, color={0,0,255}));
  connect(multiSensor.pc, multiSensor.pv)
    annotation (Line(points={{-30,40},{-30,50},{-20,50}}, color={0,0,255}));
  connect(ground.p, multiSensor.nv)
    annotation (Line(points={{-20,-20},{-20,30}}, color={0,0,255}));
  connect(multiSensor.nc, stack.p)
    annotation (Line(points={{-10,40},{0,40},{0,10}}, color={0,0,255}));
  connect(multiSensor.power, energy.u)
    annotation (Line(points={{-31,34},{-58,34}}, color={0,0,127}));
  annotation (experiment(
      StopTime=1200,
      Interval=0.1,
      Tolerance=1e-06),
    Documentation(info="<html>
<p>
A stack of cells with one degraded cell (with indices <code>[1,1]</code>, with double inner resistance), all cells depleted to <code>SOC = 0.1</code>, is recharged with a CC-CV charger.
Simulate for 1200 s and plot versus <code>time</code>:
</p>
<ul>
<li><code>stack.batteryBus.soc</code></li>
<li><code>busTransription.stackBusArrays.soc[1,1]</code></li>
<li><code>busTransription.stackBusArrays.soc[1,2]</code></li>
</ul>
</html>"));
end CCCV_Stack;
