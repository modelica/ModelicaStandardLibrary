within Modelica.Electrical.Machines.Examples.Transformers;
model AsymmetricalLoad "Asymmetrical load"
  extends Modelica.Icons.Example;
  parameter SI.Resistance RL=1 "Load resistance";
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
  Modelica.Electrical.Polyphase.Sensors.CurrentSensor currentSensorS
    annotation (Placement(transformation(extent={{-60,20},{-40,0}})));
  Modelica.Electrical.Analog.Basic.Ground groundL annotation (Placement(
        transformation(extent={{0,-80},{20,-60}})));
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

  Modelica.Electrical.Polyphase.Basic.PlugToPin_n plugToPin_n(k=1)
    annotation (Placement(transformation(extent={{20,0},{40,20}})));
  Analog.Basic.Resistor load(R=RL) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={50,0})));
  Analog.Basic.Resistor earth(R=1e6) annotation (Placement(transformation(
        origin={-10,-40},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  Analog.Basic.Ground groundT annotation (Placement(transformation(extent=
           {{-20,-80},{0,-60}})));
initial equation
  transformer.i2[1] = 0;
equation
  connect(starS.pin_n, groundS.p)
    annotation (Line(points={{-90,-50},{-90,-60}}, color={0,0,255}));
  connect(source.plug_n, starS.plug_p)
    annotation (Line(points={{-90,-20},{-90,-30}}, color={0,0,255}));
  connect(currentSensorS.plug_n, transformer.plug1) annotation (Line(
      points={{-40,10},{-20,10}}, color={0,0,255}));
  connect(transformer.plug2, plugToPin_n.plug_n) annotation (Line(
      points={{20,10},{28,10}}, color={0,0,255}));
  connect(transformer.starpoint2, groundL.p) annotation (Line(
      points={{10,-10},{10,-60}}, color={0,0,255}));
  connect(load.p, plugToPin_n.pin_n) annotation (Line(
      points={{50,10},{32,10}}, color={0,0,255}));
  connect(transformer.starpoint2, load.n) annotation (Line(
      points={{10,-10},{50,-10}}, color={0,0,255}));
  connect(source.plug_p, currentSensorS.plug_p) annotation (Line(
      points={{-90,0},{-90,10},{-60,10}}, color={0,0,255}));
  connect(earth.n, groundT.p) annotation (Line(points={{-10,-50},{-10,-50},
          {-10,-60}}, color={0,0,255}));
  annotation (Documentation(info="<html>
<h4>Asymmetrical (single-phase) load</h4>
<p>
You may choose different connections.
</p>
<p>
<strong>Please pay attention</strong> to proper grounding of the primary and secondary part of the whole circuit.<br>
The primary and secondary starpoint are available as connectors, if the connection is not delta (D or d).
</p>
<p>
In some cases it may be necessary to ground the transformer's starpoint even though the source's or load's starpoint are grounded:
</p>
<ul>
<li>Yy with primary starpoint connected to source's starpoint: primary current in only one phase</li>
<li>Yy primary starpoint  not connected to source's starpoint: secondary voltage breaks down</li>
<li>Yz ... Grounding of transformer's primary starpoint with reasonable high earthing resistance is necessary.</li>
<li>Dy ... Load current in two   primary phases.</li>
<li>Dz ... Load current in three primary phases.</li>
</ul>
</html>"),
     experiment(StopTime=0.1, Interval=1E-4, Tolerance=1E-6));
end AsymmetricalLoad;
