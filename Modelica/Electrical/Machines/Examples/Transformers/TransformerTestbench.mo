within Modelica.Electrical.Machines.Examples.Transformers;
model TransformerTestbench "Transformer test bench"
  extends Modelica.Icons.Example;
  parameter SI.Resistance RL[3]=fill(1/3, 3)
    "Load resistance";
  Modelica.Electrical.Polyphase.Sources.SineVoltage source(f=fill(
        50, 3), V=fill(sqrt(2/3)*100, 3)) annotation (Placement(
        transformation(
        origin={-90,-10},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  Modelica.Electrical.Polyphase.Basic.Star starS annotation (Placement(
        transformation(
        origin={-90,-40},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Ground groundS annotation (Placement(
        transformation(extent={{-100,-80},{-80,-60}})));
  Machines.Sensors.ElectricalPowerSensor electricalPowerSensorS
    annotation (Placement(transformation(extent={{-90,0},{-70,20}})));
  Machines.Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensorS
    annotation (Placement(transformation(extent={{-60,20},{-40,0}})));
  Machines.Sensors.VoltageQuasiRMSSensor voltageQuasiRMSSensorS annotation (
      Placement(transformation(
        origin={-50,-30},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  Modelica.Electrical.Polyphase.Basic.Delta deltaS annotation (Placement(
        transformation(
        origin={-50,-10},
        extent={{-10,-10},{10,10}})));
  Modelica.Electrical.Analog.Basic.Resistor earth(R=1e6) annotation (
      Placement(transformation(
        origin={0,-40},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Ground groundT annotation (Placement(
        transformation(extent={{-10,-80},{10,-60}})));
  Machines.Sensors.VoltageQuasiRMSSensor voltageRMSSensorL annotation (
      Placement(transformation(origin={50,-30}, extent={{-10,-10},{10,10}})));
  Modelica.Electrical.Polyphase.Basic.Delta deltaL annotation (Placement(
        transformation(
        origin={50,-10},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  Machines.Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensorL
    annotation (Placement(transformation(extent={{40,20},{60,0}})));
  Machines.Sensors.ElectricalPowerSensor electricalPowerSensorL
    annotation (Placement(transformation(extent={{70,0},{90,20}})));
  Modelica.Electrical.Polyphase.Basic.Resistor load(R=RL) annotation (
      Placement(transformation(
        origin={90,-10},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  Modelica.Electrical.Polyphase.Basic.Star starL annotation (Placement(
        transformation(
        origin={90,-40},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Ground groundL annotation (Placement(
        transformation(extent={{80,-80},{100,-60}})));
  parameter Machines.Utilities.TransformerData transformerData(
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
    P_sc=300) "Transformer data"
    annotation (Placement(transformation(extent={{-10,40},{10,60}})));
  BasicMachines.Transformers.Dy.Dy01 transformer(
    n=transformerData.n,
    R1=transformerData.R1,
    L1sigma=transformerData.L1sigma,
    R2=transformerData.R2,
    L2sigma=transformerData.L2sigma,
    T1Ref=293.15,
    alpha20_1(displayUnit="1/K")=Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero,
    T2Ref=293.15,
    alpha20_2(displayUnit="1/K")=Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero,
    T1Operational=293.15,
    T2Operational=293.15) annotation (Placement(transformation(extent={{-20,
            -10},{20,30}})));

initial equation
  transformer.i2[1:2] = zeros(2);
equation
  connect(starS.pin_n, groundS.p)
    annotation (Line(points={{-90,-50},{-90,-60}}, color={0,0,255}));
  connect(source.plug_n, starS.plug_p)
    annotation (Line(points={{-90,-20},{-90,-30}}, color={0,0,255}));
  connect(starL.pin_n, groundL.p)
    annotation (Line(points={{90,-50},{90,-60}}, color={0,0,255}));
  connect(load.plug_n, starL.plug_p)
    annotation (Line(points={{90,-20},{90,-30}}, color={0,0,255}));
  connect(earth.n, groundT.p)
    annotation (Line(points={{0,-50},{0,-50},{0,-60}}, color={0,0,255}));
  connect(electricalPowerSensorS.plug_nv, starS.plug_p) annotation (Line(
        points={{-80,0},{-80,-30},{-90,-30}}, color={0,0,255}));
  connect(source.plug_p, electricalPowerSensorS.plug_p)
    annotation (Line(points={{-90,0},{-90,10}}, color={0,0,255}));
  connect(electricalPowerSensorS.plug_ni, currentQuasiRMSSensorS.plug_p)
    annotation (Line(points={{-70,10},{-60,10}}, color={0,0,255}));
  connect(currentQuasiRMSSensorL.plug_n, electricalPowerSensorL.plug_p)
    annotation (Line(points={{60,10},{70,10}}, color={0,0,255}));
  connect(electricalPowerSensorL.plug_ni, load.plug_p)
    annotation (Line(points={{90,10},{90,0}}, color={0,0,255}));
  connect(electricalPowerSensorL.plug_nv, starL.plug_p) annotation (Line(
        points={{80,0},{80,-30},{90,-30}}, color={0,0,255}));
  connect(currentQuasiRMSSensorS.plug_n, transformer.plug1) annotation (
      Line(
      points={{-40,10},{-20,10}}, color={0,0,255}));
  connect(transformer.plug2, currentQuasiRMSSensorL.plug_p) annotation (
      Line(
      points={{20,10},{40,10}}, color={0,0,255}));
  connect(deltaS.plug_p, voltageQuasiRMSSensorS.plug_n) annotation (Line(
      points={{-60,-10},{-60,-30}}, color={0,0,255}));
  connect(deltaS.plug_n, voltageQuasiRMSSensorS.plug_p) annotation (Line(
      points={{-40,-10},{-40,-30}}, color={0,0,255}));
  connect(currentQuasiRMSSensorS.plug_n, deltaS.plug_n) annotation (Line(
      points={{-40,10},{-40,-10}}, color={0,0,255}));
  connect(currentQuasiRMSSensorL.plug_p, deltaL.plug_n) annotation (Line(
      points={{40,10},{40,-10}}, color={0,0,255}));
  connect(deltaL.plug_n, voltageRMSSensorL.plug_p) annotation (Line(
      points={{40,-10},{40,-30}}, color={0,0,255}));
  connect(deltaL.plug_p, voltageRMSSensorL.plug_n) annotation (Line(
      points={{60,-10},{60,-30}}, color={0,0,255}));
  annotation (Documentation(info="<html>
<h4>Transformer test bench</h4>
<p>
You may choose different connections as well as vary the load (even not symmetrical).
</p>
<p>
<strong>Please pay attention</strong> to proper grounding of the primary and secondary part of the whole circuit.<br>
The primary and secondary starpoint are available as connectors, if the connection is not delta (D or d).
</p>
<p>
In some cases it may be necessary to ground the transformer's starpoint even though the source's or load's starpoint are grounded:
</p>
<ul>
<li>Yy ... Grounding of transformer's primary or secondary starpoint with reasonable high earthing resistance is necessary.</li>
<li>Yd ... No grounding necessary.</li>
<li>Yz ... Grounding of transformer's primary starpoint with reasonable high earthing resistance is necessary.</li>
<li>Dy ... No grounding necessary.</li>
<li>Dd ... No grounding necessary.</li>
<li>Dz ... No grounding necessary.</li>
</ul>
</html>"),
     experiment(StopTime=0.1, Interval=1E-4, Tolerance=1E-6));
end TransformerTestbench;
