within Modelica.Electrical.Machines.Thermal.DCMachines;
model ThermalAmbientDCCE
  "Thermal ambient for DC machine with compound excitation"
  extends Machines.Interfaces.DCMachines.PartialThermalAmbientDCMachines(
      redeclare final Machines.Interfaces.DCMachines.ThermalPortDCCE
      thermalPort);
  parameter SI.Temperature Te(start=TDefault)
    "Temperature of (shunt) excitation"
    annotation (Dialog(enable=not useTemperatureInputs));
  parameter SI.Temperature Tse(start=TDefault)
    "Temperature of series excitation"
    annotation (Dialog(enable=not useTemperatureInputs));
  output SI.HeatFlowRate Q_flowShuntExcitation=
      temperatureShuntExcitation.port.Q_flow
    "Heat flow rate of (shunt) excitation";
  output SI.HeatFlowRate Q_flowSeriesExcitation=
      temperatureSeriesExcitation.port.Q_flow
    "Heat flow rate of series excitation";
  output SI.HeatFlowRate Q_flowTotal=Q_flowArmature +
      Q_flowCore + Q_flowStrayLoad + Q_flowFriction + Q_flowBrush +
      Q_flowShuntExcitation + Q_flowSeriesExcitation;
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    temperatureShuntExcitation annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-20,30})));
  Modelica.Blocks.Sources.Constant constTe(final k=Te) if not
    useTemperatureInputs annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-20,-10})));
  Modelica.Blocks.Interfaces.RealInput T_e(unit="K") if useTemperatureInputs
    "Temperature of (shunt) excitation" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={100,-118}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={100,-118})));
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
  connect(constTe.y, temperatureShuntExcitation.T) annotation (Line(
      points={{-20,1},{-20,18}}, color={0,0,127}));
  connect(T_e, temperatureShuntExcitation.T) annotation (Line(
      points={{100,-118},{100,-60},{-40,-60},{-40,8},{-20,8},{-20,18}}, color={0,0,127}));
  connect(constTse.y, temperatureSeriesExcitation.T) annotation (Line(
      points={{-50,1},{-50,18}}, color={0,0,127}));
  connect(T_se, temperatureSeriesExcitation.T) annotation (Line(
      points={{0,-120},{0,-60},{-70,-60},{-70,8},{-50,8},{-50,18}}, color={0,0,127}));
  connect(temperatureSeriesExcitation.port, thermalPort.heatPortSeriesExcitation)
    annotation (Line(
      points={{-50,40},{-50,100},{0,100}}, color={191,0,0}));
  connect(temperatureShuntExcitation.port, thermalPort.heatPortShuntExcitation)
    annotation (Line(
      points={{-20,40},{-20,100},{0,100}}, color={191,0,0}));
  annotation (Icon(graphics={Text(
                extent={{-100,-20},{100,-80}},
                textString="DCCE")}), Documentation(info="<html>
Thermal ambient for DC machines with compound excitation to prescribe winding temperatures either constant or via signal connectors.
Additionally, all losses = heat flows are recorded.
</html>"));
end ThermalAmbientDCCE;
