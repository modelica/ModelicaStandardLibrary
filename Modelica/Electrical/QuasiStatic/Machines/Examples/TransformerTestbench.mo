within Modelica.Electrical.QuasiStatic.Machines.Examples;
model TransformerTestbench "Transformer test bench"
  extends Modelica.Icons.Example;
  parameter Integer m=3 "Number of phases" annotation(Evaluate=true);
  parameter SI.Resistance RL[m]=fill(1/3, m)
    "Load resistance";
  output SI.Voltage VS=polarVS.len "Grid voltage";
  output SI.Angle phiS=polarVS.phi "Grid phase";
  output SI.Voltage VL=polarVL.len "Load voltage";
  output SI.Angle phiL=polarVL.phi "Load phase";
  QuasiStatic.Polyphase.Sources.VoltageSource source(
    f=50,
    V=fill(100/sqrt(3), 3),
    m=m,
    gamma(fixed=true, start=0)) annotation (Placement(transformation(
        origin={-90,0},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  QuasiStatic.Polyphase.Basic.Star starS(m=m) annotation (Placement(
        transformation(
        origin={-90,-30},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  QuasiStatic.SinglePhase.Basic.Ground groundS
    annotation (Placement(transformation(extent={{-100,-70},{-80,-50}})));
  QuasiStatic.Polyphase.Sensors.PowerSensor electricalPowerSensorS(m=m)
    annotation (Placement(transformation(extent={{-80,10},{-60,30}})));
  QuasiStatic.Polyphase.Sensors.CurrentSensor currentSensorS(m=m)
    annotation (Placement(transformation(extent={{-60,30},{-40,10}})));
  Modelica.ComplexBlocks.ComplexMath.ComplexToPolar polarIS annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-50,80})));
  QuasiStatic.Polyphase.Sensors.VoltageSensor voltageSensorS(m=m) annotation (
      Placement(transformation(
        origin={-50,-20},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  Modelica.ComplexBlocks.ComplexMath.ComplexToPolar polarVS annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-50,-80})));
  QuasiStatic.Polyphase.Basic.Delta deltaS(m=m) annotation (Placement(
        transformation(origin={-50,0}, extent={{-10,-10},{10,10}})));
  QuasiStatic.SinglePhase.Basic.Resistor earth(R_ref=1e6) annotation (Placement(
        transformation(
        origin={0,-30},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  QuasiStatic.SinglePhase.Basic.Ground groundT
    annotation (Placement(transformation(extent={{-10,-70},{10,-50}})));
  QuasiStatic.Polyphase.Sensors.VoltageSensor voltageSensorL(m=m) annotation (
      Placement(transformation(origin={50,-20}, extent={{-10,-10},{10,10}})));
  Modelica.ComplexBlocks.ComplexMath.ComplexToPolar polarVL annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={50,-80})));
  QuasiStatic.Polyphase.Basic.Delta deltaL(m=m) annotation (Placement(
        transformation(
        origin={50,0},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  QuasiStatic.Polyphase.Sensors.CurrentSensor currentSensorL(m=m)
    annotation (Placement(transformation(extent={{40,30},{60,10}})));
  Modelica.ComplexBlocks.ComplexMath.ComplexToPolar polarIL annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={50,80})));
  QuasiStatic.Polyphase.Sensors.PowerSensor electricalPowerSensorL(m=m)
    annotation (Placement(transformation(extent={{60,10},{80,30}})));
  QuasiStatic.Polyphase.Basic.Resistor load(R_ref=RL, m=m) annotation (
      Placement(transformation(
        origin={90,0},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  QuasiStatic.Polyphase.Basic.Star starL(m=m) annotation (Placement(
        transformation(
        origin={90,-30},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  QuasiStatic.SinglePhase.Basic.Ground groundL
    annotation (Placement(transformation(extent={{80,-70},{100,-50}})));
  Modelica.Electrical.Machines.Utilities.TransformerData transformerData(
    C1=Modelica.Utilities.Strings.substring(
            transformer.VectorGroup,
            1,
            1),
    C2=Modelica.Utilities.Strings.substring(
            transformer.VectorGroup,
            2,
            2),
    f=50,
    V1=100,
    V2=100,
    SNominal=30E3,
    v_sc=0.05,
    P_sc=300) annotation (Placement(transformation(extent={{-10,50},{10,70}})));
  QuasiStatic.Machines.BasicMachines.Transformers.Yd.Yd01 transformer(
    n=transformerData.n,
    R1=transformerData.R1,
    L1sigma=transformerData.L1sigma,
    R2=transformerData.R2,
    L2sigma=transformerData.L2sigma,
    T1Ref=293.15,
    alpha20_1(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero,
    T2Ref=293.15,
    alpha20_2(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero,
    T1Operational=293.15,
    T2Operational=293.15)
    annotation (Placement(transformation(extent={{-20,0},{20,40}})));

  Polyphase.Blocks.SymmetricalComponents symmetricalComponentsIS(final m=m)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-50,50})));
  Polyphase.Blocks.SymmetricalComponents symmetricalComponentsIL(final m=m)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={50,50})));
  Polyphase.Blocks.SymmetricalComponents symmetricalComponentsVS(final m=m)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-50,-50})));
  Polyphase.Blocks.SymmetricalComponents symmetricalComponentsVL(final m=m)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={50,-50})));
equation
  connect(starS.pin_n, groundS.pin) annotation (Line(
      points={{-90,-40},{-90,-50}}, color={85,170,255}));
  connect(source.plug_n, starS.plug_p) annotation (Line(
      points={{-90,-10},{-90,-20}}, color={85,170,255}));
  connect(starL.pin_n, groundL.pin) annotation (Line(
      points={{90,-40},{90,-50}}, color={85,170,255}));
  connect(load.plug_n, starL.plug_p) annotation (Line(
      points={{90,-10},{90,-20}}, color={85,170,255}));
  connect(electricalPowerSensorS.currentP, electricalPowerSensorS.voltageP)
    annotation (Line(
      points={{-80,20},{-80,30},{-70,30}}, color={85,170,255}));
  connect(electricalPowerSensorS.currentN, currentSensorS.plug_p)
    annotation (Line(
      points={{-60,20},{-60,20}}, color={85,170,255}));
  connect(currentSensorS.plug_n, transformer.plug1) annotation (Line(
      points={{-40,20},{-20,20}}, color={85,170,255}));
  connect(transformer.plug2, currentSensorL.plug_p) annotation (Line(
      points={{20,20},{40,20}}, color={85,170,255}));
  connect(currentSensorL.plug_n, electricalPowerSensorL.currentP)
    annotation (Line(
      points={{60,20},{60,20}}, color={85,170,255}));
  connect(electricalPowerSensorL.currentP, electricalPowerSensorL.voltageP)
    annotation (Line(
      points={{60,20},{60,30},{70,30}}, color={85,170,255}));
  connect(electricalPowerSensorL.currentN, load.plug_p) annotation (Line(
      points={{80,20},{80,20},{90,20},{90,10}},
                                color={85,170,255}));
  connect(electricalPowerSensorL.voltageN, starL.plug_p) annotation (Line(
      points={{70,10},{70,-20},{90,-20}}, color={85,170,255}));
  connect(electricalPowerSensorS.voltageN, starS.plug_p) annotation (Line(
      points={{-70,10},{-70,-20},{-90,-20}}, color={85,170,255}));
  connect(earth.pin_n, groundT.pin) annotation (Line(
      points={{0,-40},{0,-50}}, color={85,170,255}));
  connect(deltaS.plug_p, voltageSensorS.plug_n) annotation (Line(
      points={{-60,0},{-60,-20}}, color={85,170,255}));
  connect(deltaS.plug_n, voltageSensorS.plug_p) annotation (Line(
      points={{-40,0},{-40,-20}}, color={85,170,255}));
  connect(currentSensorS.plug_n, deltaS.plug_n) annotation (Line(
      points={{-40,20},{-40,0}}, color={85,170,255}));
  connect(deltaL.plug_p, voltageSensorL.plug_n) annotation (Line(
      points={{60,0},{60,-20}}, color={85,170,255}));
  connect(deltaL.plug_n, voltageSensorL.plug_p) annotation (Line(
      points={{40,0},{40,-20}}, color={85,170,255}));
  connect(currentSensorL.plug_p, deltaL.plug_n) annotation (Line(
      points={{40,20},{40,0}}, color={85,170,255}));
  connect(symmetricalComponentsIS.u,currentSensorS.i)
    annotation (Line(points={{-50,38},{-50,31}}, color={85,170,255}));
  connect(symmetricalComponentsIL.u,currentSensorL.i)
    annotation (Line(points={{50,38},{50,31}}, color={85,170,255}));
  connect(symmetricalComponentsIS.y[1], polarIS.u) annotation (Line(points={{-50,
          61},{-50,64.5},{-50,68}}, color={85,170,255}));
  connect(symmetricalComponentsIL.y[1], polarIL.u)
    annotation (Line(points={{50,61},{50,68}}, color={85,170,255}));
  connect(voltageSensorS.v, symmetricalComponentsVS.u)
    annotation (Line(points={{-50,-31},{-50,-38}}, color={85,170,255}));
  connect(symmetricalComponentsVS.y[1], polarVS.u)
    annotation (Line(points={{-50,-61},{-50,-68}}, color={85,170,255}));
  connect(voltageSensorL.v, symmetricalComponentsVL.u) annotation (Line(points={
          {50,-31},{50,-34.5},{50,-38}}, color={85,170,255}));
  connect(symmetricalComponentsVL.y[1], polarVL.u) annotation (Line(points={{50,
          -61},{50,-64.5},{50,-68}}, color={85,170,255}));
  connect(electricalPowerSensorS.currentP, source.plug_p) annotation (Line(
        points={{-80,20},{-90,20},{-90,10}}, color={85,170,255}));
  annotation (Documentation(info="<html>
Transformer test bench:<br>
You may choose different connections as well as vary the load (even not symmetrical).<br>
<strong>Please pay attention</strong> to proper grounding of the primary and secondary part of the whole circuit.<br>
The primary and secondary starpoint are available as connectors, if the connection is not delta (D or d).<br>
In some cases it may be necessary to ground the transformer's starpoint
even though the source's or load's starpoint are grounded; you may use a reasonable high earthing resistance.
</html>"),
       experiment(StopTime=0.1, Interval=0.001));
end TransformerTestbench;
