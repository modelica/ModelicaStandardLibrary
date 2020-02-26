within Modelica.Electrical.Batteries.Examples;
model CCCV_Cell
  "Charge a cell with constant current - constant voltage characteristic"
  extends Modelica.Icons.Example;
  parameter Modelica.Electrical.Batteries.ParameterRecords.ExampleData cellData(
    Qnom=18000,
    useLinearSOCDependency=false,
    Ri=4.2/1200,
    Idis=0.001) "Cell data"
    annotation (Placement(transformation(extent={{-10,-60},{10,-40}})));
  Modelica.Electrical.Batteries.Utilities.CCCVcharger cccvCharger(I=25, Vend=4.2) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-50,0})));
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{-30,-40},{-10,-20}})));
  Modelica.Electrical.Batteries.BatteryStacksWithSensors.Cell cell(cellData=cellData) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270)));
  Analog.Sensors.MultiSensor                     multiSensor
    annotation (Placement(transformation(extent={{-30,30},{-10,50}})));
  Blocks.Continuous.Integrator          energy(u(unit="W"), y(unit="J"))
    annotation (Placement(transformation(extent={{-60,24},{-80,44}})));
equation
  connect(cell.n, ground.p)
    annotation (Line(points={{0,-10},{0,-20},{-20,-20}}, color={0,0,255}));
  connect(ground.p, cccvCharger.n)
    annotation (Line(points={{-20,-20},{-50,-20},{-50,-10}},
                                                   color={0,0,255}));
  connect(cccvCharger.p, multiSensor.pc)
    annotation (Line(points={{-50,10},{-50,40},{-30,40}}, color={0,0,255}));
  connect(multiSensor.pc, multiSensor.pv)
    annotation (Line(points={{-30,40},{-30,50},{-20,50}}, color={0,0,255}));
  connect(multiSensor.nc, cell.p)
    annotation (Line(points={{-10,40},{0,40},{0,10}}, color={0,0,255}));
  connect(ground.p, multiSensor.nv)
    annotation (Line(points={{-20,-20},{-20,30}}, color={0,0,255}));
  connect(multiSensor.power, energy.u)
    annotation (Line(points={{-31,34},{-58,34}}, color={0,0,127}));
  annotation (experiment(
      StopTime=1200,
      Interval=0.1,
      Tolerance=1e-06),
    Documentation(info="<html>
<p>
A single cell depleted to <code>SOC = 0.1</code> is recharged with a CC-CV charger.
Charging current in CC mode is 5C which means the battery is theoretically nearly fulled charged after <code>0.9*3600 s/5 = 648 s</code> and the charger switches to CV mode.
Simulate for 1200 s and plot <code>cell.cellBus.soc</code> versus <code>time</code>.
</p>
</html>"));
end CCCV_Cell;
