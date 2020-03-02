within Modelica.Electrical.Machines.Interfaces.DCMachines;
model PartialThermalAmbientDCMachines
  "Partial thermal ambience for DC machines"
  parameter Boolean useTemperatureInputs=false
    "If true, temperature inputs are used; else, temperatures are constant"
    annotation (Evaluate=true);
  constant SI.Temperature TDefault=293.15
    "Default temperature";
  parameter SI.Temperature Ta(start=TDefault)
    "Temperature of armature"
    annotation (Dialog(enable=not useTemperatureInputs));
  output SI.HeatFlowRate Q_flowArmature=temperatureArmature.port.Q_flow
    "Heat flow rate of armature";
  output SI.HeatFlowRate Q_flowCore=temperatureCore.port.Q_flow
    "Heat flow rate of core losses";
  output SI.HeatFlowRate Q_flowStrayLoad=
      temperatureStrayLoad.port.Q_flow
    "Heat flow rate of stray load losses";
  output SI.HeatFlowRate Q_flowFriction=temperatureFriction.port.Q_flow
    "Heat flow rate of friction losses";
  output SI.HeatFlowRate Q_flowBrush=temperatureBrush.port.Q_flow
    "Heat flow rate of brushes";
  replaceable Machines.Interfaces.DCMachines.PartialThermalPortDCMachines thermalPort
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    temperatureArmature annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-80,30})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature temperatureCore(
      final T=TDefault) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={40,30})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature
    temperatureStrayLoad(final T=TDefault) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={60,10})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature
    temperatureFriction(final T=TDefault) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={80,30})));
  Modelica.Blocks.Interfaces.RealInput TArmature(unit="K") if useTemperatureInputs
    "Temperature of armature" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-100,-120}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-100,-120})));
  Modelica.Blocks.Sources.Constant constTa(final k=Ta) if not
    useTemperatureInputs annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-80,-10})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature temperatureBrush(
      final T=TDefault) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={20,10})));
equation
  connect(constTa.y, temperatureArmature.T) annotation (Line(
      points={{-80,1},{-80,18}}, color={0,0,127}));
  connect(TArmature, temperatureArmature.T) annotation (Line(
      points={{-100,-120},{-100,-60},{-100,8},{-80,8},{-80,18}}, color={0,0,127}));

  connect(temperatureArmature.port, thermalPort.heatPortArmature)
    annotation (Line(
      points={{-80,40},{-80,102},{-1,102}}, color={191,0,0}));
  connect(temperatureBrush.port, thermalPort.heatPortBrush) annotation (
      Line(
      points={{20,20},{20,104},{0,104}}, color={191,0,0}));
  connect(temperatureCore.port, thermalPort.heatPortCore) annotation (
      Line(
      points={{40,40},{40,102},{1,102}}, color={191,0,0}));
  connect(temperatureStrayLoad.port, thermalPort.heatPortStrayLoad)
    annotation (Line(
      points={{60,20},{60,100},{1,100}}, color={191,0,0}));
  connect(temperatureFriction.port, thermalPort.heatPortFriction)
    annotation (Line(
      points={{80,40},{80,98},{1,98}}, color={191,0,0}));
  annotation (Icon(graphics={Rectangle(
                extent={{-100,100},{100,-100}},
                pattern=LinePattern.None,
                fillColor={159,159,223},
                fillPattern=FillPattern.Backward),Line(
                points={{-14,0},{54,0}},
                color={191,0,0},
                thickness=0.5,
                origin={0,-6},
                rotation=90),Polygon(
                points={{-20,-20},{-20,20},{20,0},{-20,-20}},
                lineColor={191,0,0},
                fillColor={191,0,0},
                fillPattern=FillPattern.Solid,
                origin={0,68},
                rotation=90)}), Documentation(info="<html>
Partial thermal ambience for induction machines
</html>"));
end PartialThermalAmbientDCMachines;
