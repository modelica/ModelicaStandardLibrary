within Modelica.Electrical.Machines.Thermal.SynchronousMachines;
model ThermalAmbientSMEE
  "Thermal ambient for synchronous machine with electrical excitation"
  parameter Boolean useDamperCage(start=true)
    "Enable / disable damper cage" annotation (Evaluate=true);
  extends
    Machines.Interfaces.InductionMachines.PartialThermalAmbientInductionMachines(
      redeclare final Machines.Interfaces.InductionMachines.ThermalPortSMEE
      thermalPort(final useDamperCage=useDamperCage));
  parameter SI.Temperature Tr(start=TDefault)
    "Temperature of damper cage (optional)" annotation (Dialog(enable=(
          not useTemperatureInputs and useDamperCage)));
  parameter SI.Temperature Te(start=TDefault)
    "Temperature of excitation"
    annotation (Dialog(enable=not useTemperatureInputs));
  output SI.HeatFlowRate Q_flowRotorWinding=
      temperatureRotorWinding.port.Q_flow
    "Heat flow rate of damper cage (optional)";
  output SI.HeatFlowRate Q_flowExcitation=
      temperatureExcitation.port.Q_flow "Heat flow rate of excitation";
  output SI.HeatFlowRate Q_flowTotal=Q_flowStatorWinding +
      Q_flowRotorWinding + Q_flowExcitation + Q_flowStatorCore +
      Q_flowRotorCore + Q_flowStrayLoad + Q_flowFriction;
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    temperatureRotorWinding annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-20,30})));
  Modelica.Blocks.Interfaces.RealInput TRotorWinding(unit="K") if (
    useTemperatureInputs and useDamperCage)
    "Temperature of damper cage (optional)" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={100,-120})));
  Modelica.Blocks.Sources.Constant constTr(final k=if useDamperCage then
        Tr else TDefault) if (not useTemperatureInputs or not
    useDamperCage) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-20,-10})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    temperatureExcitation annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-50,30})));
  Modelica.Blocks.Interfaces.RealInput TExcitation(unit="K") if
    useTemperatureInputs "Temperature of excitation" annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-120})));
  Modelica.Blocks.Sources.Constant constTe(final k=Te) if not
    useTemperatureInputs annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-50,-10})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature temperatureBrush(
      final T=TDefault) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,50})));
equation
  connect(constTr.y, temperatureRotorWinding.T) annotation (Line(
      points={{-20,1},{-20,18}}, color={0,0,127}));
  connect(temperatureRotorWinding.port, thermalPort.heatPortRotorWinding)
    annotation (Line(
      points={{-20,40},{-20,100},{0,100}}, color={191,0,0}));
  connect(TRotorWinding, temperatureRotorWinding.T) annotation (Line(
      points={{100,-120},{100,8},{-20,8},{-20,18}}, color={0,0,127}));
  connect(constTe.y, temperatureExcitation.T) annotation (Line(
      points={{-50,1},{-50,18}}, color={0,0,127}));
  connect(TExcitation, temperatureExcitation.T) annotation (Line(
      points={{0,-120},{0,-60},{-66,-60},{-66,8},{-50,8},{-50,18}}, color={0,0,127}));
  connect(temperatureExcitation.port, thermalPort.heatPortExcitation)
    annotation (Line(
      points={{-50,40},{-50,100},{0,100}}, color={191,0,0}));
  connect(temperatureBrush.port, thermalPort.heatPortBrush) annotation (
      Line(
      points={{0,60},{0,100},{0,100}}, color={191,0,0}));
  annotation (Icon(graphics={Text(
          extent={{-100,-20},{100,-80}},
          textString="SMEE")}), Documentation(info="<html>
Thermal ambient for synchronous machines with electrical excitation to prescribe winding temperatures either constant or via signal connectors.
Additionally, all losses = heat flows are recorded.
</html>"));
end ThermalAmbientSMEE;
