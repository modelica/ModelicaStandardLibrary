within Modelica.Electrical.Machines.Thermal.InductionMachines;
model ThermalAmbientIMS
  "Thermal ambient for induction machine with slipring"
  extends
    Machines.Interfaces.InductionMachines.PartialThermalAmbientInductionMachines(
      redeclare final Machines.Interfaces.InductionMachines.ThermalPortIMS
      thermalPort(final mr=mr));
  parameter Integer mr=m "Number of rotor phases" annotation(Evaluate=true);
  parameter SI.Temperature Tr(start=TDefault)
    "Temperature of rotor windings"
    annotation (Dialog(enable=not useTemperatureInputs));
  output SI.HeatFlowRate Q_flowRotorWinding=
      temperatureRotorWinding.port.Q_flow
    "Heat flow rate of rotor (squirrel cage)";
  output SI.HeatFlowRate Q_flowBrush=temperatureBrush.port.Q_flow
    "Heat flow rate of brushes";
  output SI.HeatFlowRate Q_flowTotal=Q_flowStatorWinding +
      Q_flowRotorWinding + Q_flowStatorCore + Q_flowRotorCore +
      Q_flowStrayLoad + Q_flowFriction + Q_flowBrush;
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    temperatureRotorWinding annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-50,30})));
  Modelica.Blocks.Interfaces.RealInput TRotorWinding(unit="K") if
    useTemperatureInputs "Temperature of rotor windings" annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={100,-118})));
  Modelica.Blocks.Sources.Constant constTr(final k=Tr) if not
    useTemperatureInputs annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-50,-10})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector
    thermalCollectorRotor(final m=mr)
    annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature temperatureBrush(
      final T=TDefault) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,50})));
equation
  connect(constTr.y, temperatureRotorWinding.T) annotation (Line(
      points={{-50,1},{-50,18}}, color={0,0,127}));
  connect(thermalCollectorRotor.port_b, temperatureRotorWinding.port)
    annotation (Line(
      points={{-50,60},{-50,40}}, color={191,0,0}));
  connect(thermalCollectorRotor.port_a, thermalPort.heatPortRotorWinding)
    annotation (Line(
      points={{-50,80},{-50,100},{0,100}}, color={191,0,0}));
  connect(temperatureBrush.port, thermalPort.heatPortBrush) annotation (
      Line(
      points={{0,60},{0,60},{0,100}}, color={191,0,0}));
  connect(TRotorWinding, temperatureRotorWinding.T) annotation (Line(
      points={{100,-118},{100,8},{-50,8},{-50,18}}, color={0,0,127}));
  annotation (Icon(graphics={Text(
          extent={{-100,-20},{100,-80}},
          textString="IMS")}), Documentation(info="<html>
Thermal ambient for induction machines with slipring rotor to prescribe winding temperatures either constant or via signal connectors.
Additionally, all losses = heat flows are recorded.
</html>"));
end ThermalAmbientIMS;
