within Modelica.Electrical.Machines.Thermal.DCMachines;
model ThermalAmbientDCSE
  "Thermal ambient for DC machine with series excitation"
  extends Machines.Interfaces.DCMachines.PartialThermalAmbientDCMachines(
      redeclare final Machines.Interfaces.DCMachines.ThermalPortDCSE
      thermalPort);
  parameter SI.Temperature Tse(start=TDefault)
    "Temperature of series excitation"
    annotation (Dialog(enable=not useTemperatureInputs));
  output SI.HeatFlowRate Q_flowSeriesExcitation=
      temperatureSeriesExcitation.port.Q_flow
    "Heat flow rate of series excitation";
  output SI.HeatFlowRate Q_flowTotal=Q_flowArmature +
      Q_flowCore + Q_flowStrayLoad + Q_flowFriction + Q_flowBrush +
      Q_flowSeriesExcitation;
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    temperatureSeriesExcitation annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-50,30})));
  Modelica.Blocks.Sources.Constant constTse(final k=Tse) if not
    useTemperatureInputs annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-50,-10})));
  Modelica.Blocks.Interfaces.RealInput T_se(unit="K") if useTemperatureInputs
    "Temperature of series excitation" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-120}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-120})));
equation
  connect(constTse.y, temperatureSeriesExcitation.T) annotation (Line(
      points={{-50,1},{-50,18}}, color={0,0,127}));
  connect(T_se, temperatureSeriesExcitation.T) annotation (Line(
      points={{0,-120},{0,-60},{-70,-60},{-70,8},{-50,8},{-50,18}}, color={0,0,127}));
  connect(temperatureSeriesExcitation.port, thermalPort.heatPortSeriesExcitation)
    annotation (Line(
      points={{-50,40},{-50,100},{0,100}}, color={191,0,0}));
  annotation (Icon(graphics={Text(
                extent={{-100,-20},{100,-80}},
                textString="DCSE")}), Documentation(info="<html>
Thermal ambient for DC machines with serial excitation to prescribe winding temperatures either constant or via signal connectors.
Additionally, all losses = heat flows are recorded.
</html>"));
end ThermalAmbientDCSE;
