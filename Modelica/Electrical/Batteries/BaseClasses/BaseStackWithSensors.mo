within Modelica.Electrical.Batteries.BaseClasses;
partial model BaseStackWithSensors "Partial stack with sensors"
  extends Modelica.Electrical.Batteries.Icons.BatteryIcon(final displaySOC=SOC);
  replaceable parameter BaseStackData stackData
    annotation (Placement(transformation(extent={{-10,40},{10,60}})));
  parameter Boolean useAllParallelConnections=true "= true, if all parallel connections are used";
  parameter Real SOC0[stackData.Ns, stackData.Np]=fill(0.1, stackData.Ns, stackData.Np) "Initial SOC";
  parameter Real SOCtolerance=1e-9 "SOC tolerance for detection of depleted or overcharged cell"
    annotation(Dialog(tab="Advanced"));
  extends Modelica.Electrical.Analog.Interfaces.TwoPin;
  output SI.Current i = p.i "Current into the stack";
  output SI.Power power = v*i "Power to the stack";
  output Real SOC = socTotal.y "Overall State of charge";
  parameter Boolean useHeatPort = false "=true, if HeatPort is enabled"
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter SI.Temperature T=293.15
    "Fixed device temperature if useHeatPort = false"
    annotation(Dialog(enable=not useHeatPort));
  replaceable Modelica.Electrical.Batteries.BaseClasses.BaseCellWithSensors
    cell[stackData.Ns,stackData.Np](
    each SOCtolerance=SOCtolerance,
    each useHeatPort=false,
    each T=T,
    cellData=stackData.cellData,
    SOC0=SOC0) "Matrix of cells"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Electrical.Analog.Sensors.MultiSensor multiSensor
    annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
  Modelica.Electrical.Batteries.Interfaces.StackBus stackBus(Ns=stackData.Ns,
      Np=stackData.Np) "Stack bus"
    annotation (Placement(transformation(extent={{40,-100},{80,-60}})));
  Modelica.Electrical.Batteries.Interfaces.CellBus batteryBus
    "Battery bus (average / sum over all cells)"
    annotation (Placement(transformation(extent={{-70,-90},{-50,-70}})));
  Modelica.Blocks.Sources.RealExpression socTotal(
    y=sum(stackBus.cellBus.soc.*stackData.cellData.Qnom)/sum(stackData.cellData.Qnom)) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-70,-50})));
  Modelica.Blocks.Sources.RealExpression lossesTotal(y=sum(stackBus.cellBus.lossPower))
    annotation (Placement(transformation(extent={{-20,-70},{-40,-50}})));
  Modelica.Blocks.Sources.RealExpression temperatureTotal(y=sum(stackBus.cellBus.T)/(stackData.Ns*stackData.Np))
    annotation (Placement(transformation(extent={{-20,-50},{-40,-30}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort[stackData.Ns, stackData.Np] if useHeatPort
    "Optional port to which dissipated losses are transported in form of heat"
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}}),
        iconTransformation(extent={{-10,-110},{10,-90}})));
equation
  //connections of cell stack
  connect(multiSensor.nc, cell[1, 1].p)
    annotation (Line(points={{-50,0},{-10,0}}, color={0,0,255}));
  connect(cell[stackData.Ns, 1].n, n)
    annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
  connect(cell.cellBus, stackBus.cellBus) annotation (Line(
      points={{-6,-8},{-6,-14},{60,-14},{60,-44},{60.1,-44},{60.1,-79.9}},
      color={255,204,51},
      thickness=0.5));
  if useAllParallelConnections then
    for ks in 1:stackData.Ns loop
      for kp in 1:stackData.Np-1 loop
        connect(cell[ks, kp].p, cell[ks, kp + 1].p);
        connect(cell[ks, kp].n, cell[ks, kp + 1].n);
      end for;
    end for;
    for ks in 1:stackData.Ns-1 loop
      connect(cell[ks, 1].n, cell[ks + 1, 1].p);
    end for;
  else
    for kp in 1:stackData.Np loop
      for ks in 1:stackData.Ns-1 loop
        connect(cell[ks, kp].n, cell[ks + 1, kp].p);
      end for;
    end for;
    for kp in 1:stackData.Np-1 loop
      connect(cell[1, kp].p, cell[1, kp + 1].p);
      connect(cell[stackData.Ns, kp].n, cell[stackData.Ns, kp + 1].n);
    end for;
  end if;
//other connections
  connect(p,multiSensor.pc)
    annotation (Line(points={{-100,0},{-70,0}}, color={0,0,255}));
  connect(multiSensor.pc,multiSensor.pv)
    annotation (Line(points={{-70,0},{-70,10},{-60,10}}, color={0,0,255}));
  connect(n, multiSensor.nv)
    annotation (Line(points={{100,0},{20,0},{20,-20},{-60,-20},{-60,-10}}, color={0,0,255}));
  connect(multiSensor.i, batteryBus.i) annotation (Line(points={{-66,-11},{-66,-20},
          {-80,-20},{-80,-79.95},{-59.95,-79.95}}, color={0,0,127}));
  connect(multiSensor.power, batteryBus.power) annotation (Line(points={{-71,-6},
          {-80,-6},{-80,-79.95},{-59.95,-79.95}},
                                             color={0,0,127}));
  connect(multiSensor.v, batteryBus.v) annotation (Line(points={{-54,-11},{-54,-46},
          {-54,-79.95},{-59.95,-79.95}}, color={0,0,127}));
  connect(socTotal.y, batteryBus.soc) annotation (Line(points={{-70,-61},{-70,-79.95},
          {-59.95,-79.95}}, color={0,0,127}));
  connect(temperatureTotal.y, batteryBus.T) annotation (Line(points={{-41,-40},{
          -54,-40},{-54,-79.95},{-59.95,-79.95}}, color={0,0,127}));
  connect(lossesTotal.y, batteryBus.lossPower) annotation (Line(points={{-41,-60},
          {-54,-60},{-54,-79.95},{-59.95,-79.95}},color={0,0,127}));
  connect(cell.heatPort, heatPort)
    annotation (Line(points={{0,-10},{0,-100}}, color={191,0,0}));
  annotation (Icon(graphics={  Ellipse(
          visible=useHeatPort,
          extent={{-14,-86},{14,-114}},
          lineColor={191,0,0},
          fillColor={191,0,0},
          fillPattern=FillPattern.Solid)}),
          Documentation(info="<html>
<p>
This is a stack of <code>Ns</code> x <code>Np</code> <a href=\"modelica://Modelica.Electrical.Batteries.BatteryStacksWithSensors.Cell\">cell[Np=1, Ns=1]</a> with measurement, arranged in a matrix.
</p>
</html>"));
end BaseStackWithSensors;
