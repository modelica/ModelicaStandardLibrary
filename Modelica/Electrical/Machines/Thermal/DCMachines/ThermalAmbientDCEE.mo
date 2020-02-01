within Modelica.Electrical.Machines.Thermal.DCMachines;
model ThermalAmbientDCEE
  "Thermal ambient for DC machine with electrical excitation"
  extends Machines.Interfaces.DCMachines.PartialThermalAmbientDCMachines(
      redeclare final Machines.Interfaces.DCMachines.ThermalPortDCEE
      thermalPort);
  parameter SI.Temperature Te(start=TDefault)
    "Temperature of (shunt) excitation"
    annotation (Dialog(enable=not useTemperatureInputs));
  output SI.HeatFlowRate Q_flowExcitation=
      temperatureExcitation.port.Q_flow
    "Heat flow rate of (shunt) excitation";
  output SI.HeatFlowRate Q_flowTotal=Q_flowArmature +
      Q_flowCore + Q_flowStrayLoad + Q_flowFriction + Q_flowBrush +
      Q_flowExcitation;
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    temperatureExcitation annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-20,30})));
  Modelica.Blocks.Sources.Constant constTe(final k=Te) if not
    useTemperatureInputs annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-20,-10})));
  Modelica.Blocks.Interfaces.RealInput TExcitation(unit="K") if
    useTemperatureInputs "Temperature of (shunt) excitation" annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-120})));
equation
  connect(constTe.y, temperatureExcitation.T) annotation (Line(
      points={{-20,1},{-20,18}}, color={0,0,127}));
  connect(TExcitation, temperatureExcitation.T) annotation (Line(
      points={{0,-120},{0,-60},{-40,-60},{-40,8},{-20,8},{-20,18}}, color={0,0,127}));
  connect(temperatureExcitation.port, thermalPort.heatPortExcitation)
    annotation (Line(
      points={{-20,40},{-20,100},{0,100}}, color={191,0,0}));
  annotation (Icon(graphics={Text(
                extent={{-100,-20},{100,-80}},
                textString="DCEE")}), Documentation(info="<html>
Thermal ambient for DC machines with electrical (shunt) excitation to prescribe winding temperatures either constant or via signal connectors.
Additionally, all losses = heat flows are recorded.
</html>"));
end ThermalAmbientDCEE;
