within Modelica.Electrical.Machines.Thermal.DCMachines;
model ThermalAmbientDCPM
  "Thermal ambient for DC machine with permanent magnets"
  extends Machines.Interfaces.DCMachines.PartialThermalAmbientDCMachines(
      redeclare final Machines.Interfaces.DCMachines.ThermalPortDCPM
      thermalPort);
  parameter SI.Temperature Tpm(start=TDefault)
    "Temperature of permanent magnet"
    annotation (Dialog(enable=not useTemperatureInputs));
  output SI.HeatFlowRate Q_flowPermanentMagnet=
      temperaturePermanentMagnet.port.Q_flow
    "Heat flow rate of permanent magnets";
  output SI.HeatFlowRate Q_flowTotal=Q_flowArmature +
      Q_flowCore + Q_flowStrayLoad + Q_flowFriction + Q_flowBrush +
      Q_flowPermanentMagnet;
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    temperaturePermanentMagnet annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-20,30})));
  Modelica.Blocks.Sources.Constant constTpm(final k=Tpm) if not
    useTemperatureInputs annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-20,-10})));
  Modelica.Blocks.Interfaces.RealInput TPermanentMagnet(unit="K") if
    useTemperatureInputs "Temperature of permanent magnet" annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-120})));
equation
  connect(temperaturePermanentMagnet.port, thermalPort.heatPortPermanentMagnet)
    annotation (Line(
      points={{-20,40},{-20,100},{0,100}}, color={191,0,0}));
  connect(constTpm.y, temperaturePermanentMagnet.T) annotation (Line(
      points={{-20,1},{-20,18}}, color={0,0,127}));
  connect(TPermanentMagnet, temperaturePermanentMagnet.T) annotation (
      Line(
      points={{0,-120},{0,-60},{-40,-60},{-40,8},{-20,8},{-20,18}}, color={0,0,127}));
  annotation (Icon(graphics={Text(
                extent={{-100,-20},{100,-80}},
                textString="DCPM")}), Documentation(info="<html>
Thermal ambient for DC machines with permanent magnets to prescribe winding temperatures either constant or via signal connectors.
Additionally, all losses = heat flows are recorded.
</html>"));
end ThermalAmbientDCPM;
