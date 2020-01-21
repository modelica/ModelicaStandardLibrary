within Modelica.Electrical.Machines.Thermal;
model ThermalAmbientTransformer "Thermal ambient for transformers"
  parameter Integer m(min=1) = 3 "Number of phases" annotation(Evaluate=true);
  parameter Boolean useTemperatureInputs=false
    "If true, temperature inputs are used; else, temperatures are constant"
    annotation (Evaluate=true);
  constant SI.Temperature TDefault=293.15
    "Default temperature";
  parameter SI.Temperature T1(start=TDefault)
    "Temperature of primary windings"
    annotation (Dialog(enable=not useTemperatureInputs));
  parameter SI.Temperature T2(start=TDefault)
    "Temperature of secondary windings"
    annotation (Dialog(enable=not useTemperatureInputs));
  output SI.HeatFlowRate Q_flow1=temperature1.port.Q_flow
    "Heat flow rate of primary windings";
  output SI.HeatFlowRate Q_flow2=temperature2.port.Q_flow
    "Heat flow rate of secondary windings";
  output SI.HeatFlowRate Q_flowCore=temperatureCore.port.Q_flow
    "Heat flow rate of core losses";
  output SI.HeatFlowRate Q_flowTotal=Q_flow1 + Q_flow2 +
      Q_flowCore;
  Machines.Interfaces.ThermalPortTransformer thermalPort(final m=m)
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature temperature1
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-80,30})));
  Modelica.Blocks.Sources.Constant constT1(final k=T1) if not
    useTemperatureInputs annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-80,-10})));
  Modelica.Blocks.Interfaces.RealInput TPrimary(unit="K") if useTemperatureInputs
    "Temperature of primary windings" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-100,-120}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-100,-120})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature temperature2
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={80,30})));
  Modelica.Blocks.Sources.Constant constT2(final k=T2) if not
    useTemperatureInputs annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={80,-10})));
  Modelica.Blocks.Interfaces.RealInput TSecondary(unit="K") if useTemperatureInputs
    "Temperature of secondary windings" annotation (Placement(
        transformation(
        extent={{-20,20},{20,-20}},
        rotation=90,
        origin={100,-120})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature temperatureCore(
      final T=TDefault) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,30})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector
    thermalCollector1(final m=m)
    annotation (Placement(transformation(extent={{-90,60},{-70,80}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector
    thermalCollector2(final m=m)
    annotation (Placement(transformation(extent={{70,60},{90,80}})));
equation
  connect(TPrimary, temperature1.T) annotation (Line(
      points={{-100,-120},{-100,-60},{-100,8},{-80,8},{-80,18}}, color={0,0,127}));
  connect(constT1.y, temperature1.T) annotation (Line(
      points={{-80,1},{-80,18}}, color={0,0,127}));
  connect(TSecondary, temperature2.T) annotation (Line(
      points={{100,-120},{100,-60},{100,8},{80,8},{80,18}}, color={0,0,127}));
  connect(constT2.y, temperature2.T) annotation (Line(
      points={{80,1},{80,18}}, color={0,0,127}));
  connect(temperatureCore.port, thermalPort.heatPortCore) annotation (Line(
      points={{0,40},{0,70},{0,100},{1,100}}, color={191,0,0}));
  connect(thermalCollector1.port_b, temperature1.port) annotation (Line(
      points={{-80,60},{-80,40}}, color={191,0,0}));
  connect(thermalCollector2.port_b, temperature2.port) annotation (Line(
      points={{80,60},{80,40}}, color={191,0,0}));
  connect(thermalCollector1.port_a, thermalPort.heatPort1) annotation (Line(
      points={{-80,80},{-80,102},{-1,102}}, color={191,0,0}));
  connect(thermalCollector2.port_a, thermalPort.heatPort2) annotation (Line(
      points={{80,80},{80,98},{-1,98}}, color={191,0,0}));
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
              rotation=90),Text(
              extent={{-100,-20},{100,-80}},
              textString="Trafo")}), Documentation(info="<html>
Thermal ambient for transformers to prescribe winding temperatures either constant or via signal connectors.
Additionally, all losses = heat flows are recorded.
</html>"));
end ThermalAmbientTransformer;
