within Modelica.Electrical.Batteries.BaseClasses;
partial model BaseCellWithSensors "Partial cell with sensors"
  extends Modelica.Electrical.Batteries.Icons.BatteryIcon(final displaySOC=SOC);
  replaceable parameter Modelica.Electrical.Batteries.ParameterRecords.CellData cellData
    "Cell parameters"
    annotation (Placement(transformation(extent={{-10,40},{10,60}})));
  parameter Real SOC0=0.1 "Initial SOC";
  parameter Real SOCtolerance=1e-9 "SOC tolerance for detection of depleted or overcharged cell"
    annotation(Dialog(tab="Advanced"));
  extends Modelica.Electrical.Analog.Interfaces.TwoPin;
  output SI.Current i = p.i "Current into the cell";
  output SI.Power power = v*i "Power to the cell";
  output Real SOC = limIntegrator.y "State of charge";
  extends Modelica.Electrical.Analog.Interfaces.PartialConditionalHeatPort;
  replaceable Modelica.Electrical.Batteries.BatteryStacks.CellStack cell(
    final Ns=1,
    final Np=1,
    SOCtolerance=SOCtolerance,
    cellData=cellData,
    SOC(start=SOC0, fixed=true),
    useHeatPort=true,
    T=T) "Cell"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Electrical.Analog.Sensors.MultiSensor multiSensor
    annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
  Modelica.Blocks.Continuous.LimIntegrator limIntegrator(
    k=1/cellData.Qnom,
    outMax=1 - SOCtolerance,
    outMin=SOCtolerance,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=SOC0)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-70,-50})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-30,-40})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowSensor
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-60})));
  Modelica.Electrical.Batteries.Interfaces.CellBus cellBus "Cell bus"
    annotation (Placement(transformation(extent={{-70,-90},{-50,-70}}),
        iconTransformation(extent={{-70,-90},{-50,-70}})));
equation
  connect(p, multiSensor.pc)
    annotation (Line(points={{-100,0},{-70,0}}, color={0,0,255}));
  connect(multiSensor.pc, multiSensor.pv)
    annotation (Line(points={{-70,0},{-70,10},{-60,10}}, color={0,0,255}));
  connect(multiSensor.nc, cell.p)
    annotation (Line(points={{-50,0},{-10,0}}, color={0,0,255}));
  connect(cell.n, n)
    annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
  connect(multiSensor.i, limIntegrator.u) annotation (Line(points={{-66,-11},{-66,
          -20},{-70,-20},{-70,-38}}, color={0,0,127}));
  connect(limIntegrator.y, cellBus.soc) annotation (Line(points={{-70,-61},{-70,
          -80},{-59.95,-80},{-59.95,-79.95}}, color={0,0,127}));
  connect(multiSensor.v, cellBus.v) annotation (Line(points={{-54,-11},{-54,-80},
          {-59.95,-80},{-59.95,-79.95}}, color={0,0,127}));
  connect(multiSensor.i, cellBus.i) annotation (Line(points={{-66,-11},{-66,-20},
          {-90,-20},{-90,-80},{-59.95,-80},{-59.95,-79.95}}, color={0,0,127}));
  connect(multiSensor.power, cellBus.power) annotation (Line(points={{-71,-6},{-90,
          -6},{-90,-80},{-59.95,-80},{-59.95,-79.95}},
                                                   color={0,0,127}));
  connect(heatFlowSensor.port_b, internalHeatPort) annotation (Line(points={{
          -1.77636e-15,-70},{-1.77636e-15,-75},{0,-75},{0,-80}}, color={191,0,0}));
  connect(heatFlowSensor.port_a, cell.heatPort)
    annotation (Line(points={{0,-50},{0,-10}}, color={191,0,0}));
  connect(heatFlowSensor.Q_flow, cellBus.lossPower) annotation (Line(points={{-11,-60},
          {-40,-60},{-40,-79.95},{-59.95,-79.95}},      color={0,0,127}));
  connect(temperatureSensor.T, cellBus.T) annotation (Line(points={{-41,-40},{-54,
          -40},{-54,-79.95},{-59.95,-79.95}},     color={0,0,127}));
  connect(n, multiSensor.nv) annotation (Line(points={{100,0},{20,0},{20,-20},{-60,
          -20},{-60,-10}}, color={0,0,255}));
  connect(heatFlowSensor.port_a, temperatureSensor.port)
    annotation (Line(points={{0,-50},{0,-40},{-20,-40}}, color={191,0,0}));
  annotation (Documentation(info="<html>
<p>
This is a single <a href=\"modelica://Modelica.Electrical.Batteries.BatteryStacks.CellStack\">cell[Np=1, Ns=1]</a> with measurement.
</p>
</html>"));
end BaseCellWithSensors;
