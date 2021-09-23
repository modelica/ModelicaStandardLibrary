within Modelica.Magnetic.FluxTubes.Examples.Hysteresis;
model ThreePhaseTransformerWithRectifier
  "Three-phase transformer (including hysteresis effect) with rectifier"
  extends Modelica.Icons.Example;

  Modelica.Electrical.Analog.Basic.Ground ground1 annotation (Placement(transformation(extent={{-120,-90},{-100,-70}})));
  Modelica.Electrical.Analog.Basic.Ground ground2 annotation (Placement(transformation(extent={{-36,-90},{-16,-70}})));
  Modelica.Electrical.Analog.Sources.SineVoltage vSource1(
    offset=0,
    f=50,
    V=50) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-140,-40})));
  Components.Transformer3PhaseYyWithHysteresis transformer(
    EddyCurrents=true,
    N1=200,
    N2=10,
    mat=FluxTubes.Material.HysteresisEverettParameter.M330_50A(),
    sigma=2.2e6,
    HFixed={true,true,true},
    MagRelFixed={true,true,false},
    I1Fixed={true,true,true},
    I2Fixed={true,false,false},
    useHeatPort=false,
    MagRelStart={-0.4,0.8,-0.4},
    l1=0.2,
    l2=0.15,
    a=0.04,
    b=0.04,
    t=0.0005) annotation (Placement(transformation(extent={{-40,-15},{-20,5}})));
  Modelica.Electrical.Analog.Sources.SineVoltage vSource2(
    offset=0,
    f=vSource1.f,
    V=50,
    phase=4.1887902047864) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-120,-40})));
  Modelica.Electrical.Analog.Sources.SineVoltage vSource3(
    offset=0,
    f=vSource1.f,
    V=50,
    phase=2.0943951023932) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-100,-40})));
  Modelica.Electrical.Analog.Basic.Resistor resistor1(R=0) annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={-70,15})));
  Modelica.Electrical.Analog.Basic.Resistor resistor2(R=resistor1.R) annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={-70,-5})));
  Modelica.Electrical.Analog.Basic.Resistor resistor3(R=resistor1.R) annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={-70,-25})));
  Modelica.Electrical.Analog.Ideal.IdealDiode diode1(Vknee=0.7) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={30,20})));
  Modelica.Electrical.Analog.Ideal.IdealDiode diode2(Vknee=0.7) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={30,-30})));
  Modelica.Electrical.Analog.Basic.Resistor resistorL(R=5) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={120,-5})));
  Modelica.Electrical.Analog.Ideal.IdealDiode diode3(Vknee=0.7) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={50,20})));
  Modelica.Electrical.Analog.Ideal.IdealDiode diode4(Vknee=0.7) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={50,-30})));
  Modelica.Electrical.Analog.Ideal.IdealDiode diode5(Vknee=0.7) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={70,20})));
  Modelica.Electrical.Analog.Ideal.IdealDiode diode6(Vknee=0.7) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={70,-30})));
  Modelica.Electrical.Analog.Basic.Capacitor capacitor1(C=1e-6, v(fixed=
          true)) annotation (
     Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={90,20})));
  Modelica.Electrical.Analog.Basic.Inductor inductor1(L=1e-3) annotation (Placement(transformation(extent={{-10,4},{10,24}})));
  Modelica.Electrical.Analog.Basic.Inductor inductor2(L=1e-3)
    annotation (Placement(transformation(extent={{-10,-15},{10,5}})));
  Modelica.Electrical.Analog.Basic.Inductor inductor3(L=1e-3)
    annotation (Placement(transformation(extent={{-10,-35},{10,-15}})));
  Modelica.Electrical.Analog.Basic.Capacitor capacitor2(C=1e-6, v(fixed=
          true)) annotation (
     Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={90,-30})));
  Modelica.Blocks.Sources.RealExpression rExp1(y=transformer.LossPowerStat) annotation (Placement(transformation(extent={{-113,77},{-82,93}})));
  Modelica.Blocks.Sources.RealExpression rExp2(y=transformer.LossPowerEddy) annotation (Placement(transformation(extent={{-113,57},{-81,73}})));
  Modelica.Blocks.Sources.RealExpression rExp3(y=transformer.LossPowerWinding) annotation (Placement(transformation(extent={{-113,37},{-81,53}})));
  Modelica.Blocks.Continuous.Filter pdissStatAvg(f_cut=10)
    "Approx. average static hysteresis losses"
    annotation (Placement(transformation(extent={{-50,80},{-40,90}})));
  Modelica.Blocks.Continuous.Filter pdissEddyAvg(f_cut=10)
    "Approx. average eddy current losses"
    annotation (Placement(transformation(extent={{-50,60},{-40,70}})));
  Modelica.Blocks.Continuous.Filter pdissCopAvg(f_cut=10)
    "Approx. average copper losses"
    annotation (Placement(transformation(extent={{-50,40},{-40,50}})));
initial equation
  transformer.core1.derHstat = 0.0;
  transformer.core2.derHstat = 0.0;
  transformer.core3.derHstat = 0.0;
equation
  connect(vSource1.n, ground1.p) annotation (Line(points={{-140,-50},{-140,-70},{-110,-70}}, color={0,0,255}));
  connect(vSource2.n, ground1.p) annotation (Line(points={{-120,-50},{-120,-70},{-110,-70}}, color={0,0,255}));
  connect(vSource3.n, ground1.p) annotation (Line(points={{-100,-50},{-100,-70},{-110,-70}}, color={0,0,255}));
  connect(resistor1.n, transformer.p1) annotation (Line(points={{-60,15},{-50,15},{-50,1},{-40,1}}, color={0,0,255}));
  connect(resistor1.p, vSource1.p) annotation (Line(points={{-80,15},{-140,15},{-140,-30}}, color={0,0,255}));
  connect(resistor2.n, transformer.p2) annotation (Line(points={{-60,-5},{-40,-5}}, color={0,0,255}));
  connect(resistor2.p, vSource2.p) annotation (Line(points={{-80,-5},{-120,-5},{-120,-30}}, color={0,0,255}));
  connect(vSource3.p, resistor3.p) annotation (Line(points={{-100,-30},{-100,-25},{-80,-25}}, color={0,0,255}));
  connect(resistor3.n, transformer.p3) annotation (Line(points={{-60,-25},{-50,-25},{-50,-11},{-40,-11}}, color={0,0,255}));
  connect(diode2.n, diode1.p) annotation (Line(points={{30,-20},{30,10}}, color={0,0,255}));
  connect(diode4.n, diode3.p) annotation (Line(points={{50,-20},{50,10}}, color={0,0,255}));
  connect(diode6.n, diode5.p) annotation (Line(points={{70,-20},{70,10}}, color={0,0,255}));
  connect(diode2.p, diode4.p) annotation (Line(points={{30,-40},{50,-40}}, color={0,0,255}));
  connect(diode4.p, diode6.p) annotation (Line(points={{50,-40},{70,-40}}, color={0,0,255}));
  connect(diode1.n, diode3.n) annotation (Line(points={{30,30},{50,30}}, color={0,0,255}));
  connect(diode3.n, diode5.n) annotation (Line(points={{50,30},{70,30}}, color={0,0,255}));
  connect(diode5.n, capacitor1.p) annotation (Line(points={{70,30},{90,30}}, color={0,0,255}));
  connect(resistorL.p, capacitor1.p) annotation (Line(points={{120,5},{120,30},{90,30}}, color={0,0,255}));
  connect(transformer.n1, inductor1.p) annotation (Line(points={{-20,1},{-10,1},{-10,14}}, color={0,0,255}));
  connect(transformer.n2, inductor2.p) annotation (Line(points={{-20,-5},{-10,-5}}, color={0,0,255}));
  connect(inductor2.n, diode3.p) annotation (Line(points={{10,-5},{50,-5},{50,10}}, color={0,0,255}));
  connect(inductor3.p, transformer.n3) annotation (Line(points={{-10,-25},{-10,-11},{-20,-11}}, color={0,0,255}));
  connect(inductor3.n, diode6.n) annotation (Line(points={{10,-25},{10,-10},{70,-10},{70,-20}}, color={0,0,255}));
  connect(capacitor2.n, diode6.p) annotation (Line(points={{90,-40},{70,-40}}, color={0,0,255}));
  connect(capacitor2.p, capacitor1.n) annotation (Line(points={{90,-20},{90,10}},color={0,0,255}));
  connect(inductor1.n, diode1.p) annotation (Line(points={{10,14},{10,0},{30,0},{30,10}}, color={0,0,255}));
  connect(resistorL.n, capacitor2.n) annotation (Line(points={{120,-15},{120,-40},{90,-40}}, color={0,0,255}));
  connect(transformer.starPoint1, ground1.p) annotation (Line(points={{-34,-15},{-34,-70},{-110,-70}}, color={0,0,255}));
  connect(transformer.starPoint2, ground2.p) annotation (Line(points={{-26,-15},{-26,-70}}, color={0,0,255}));
  connect(ground2.p, capacitor2.p) annotation (Line(points={{-26,-70},{105,-70},{105,-4},{90,-4},{90,-20}}, color={0,0,255}));
  connect(rExp3.y,pdissCopAvg. u) annotation (Line(points={{-79.4,45},{-51,45}}, color={0,0,127}));
  connect(rExp2.y,pdissEddyAvg. u) annotation (Line(points={{-79.4,65},{-51,65}}, color={0,0,127}));
  connect(rExp1.y,pdissStatAvg. u) annotation (Line(points={{-80.45,85},{-51,85}}, color={0,0,127}));
  annotation (experiment(StartTime=0, StopTime=0.2, Interval=1e-4, Tolerance=1e-006), Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-150,-100},{150,100}},
        grid={1,1})), Documentation(info="<html>
<p>
This is a model of a three-phase transformer and rectifier unit using the <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.Hysteresis.Components.Transformer3PhaseYyWithHysteresis\">Transformer3PhaseYyWithHysteresis</a> model. Use the following simulation settings:
</p>

<ul>
  <li>Stop time: 0.2 s</li>
  <li>Number of intervals: 5000</li>
  <li>Tolerance: 1e-6</li>
</ul>

<p>
An example simulation shows the transformer inrush currents due to an initially magnetized transformer core.
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
<caption><strong>Fig. 1:</strong> Transformer inrush currents due to initial magnetization of the magnetic core; (a) transformer primary currents; (b)  transformer secondary currents; (c) flux densities of the transformer legs; (d) B(H) hysteresis loops of transformer leg one.; (e) instantaneous static hysteresis, eddy current and copper losses of the transformer; (f) approximated average static hysteresis, eddy current and copper losses of the transformer</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Examples/Hysteresis/ThreePhaseTransformerWithRectifier/plot01.png\" hspace=\"10\" vspace=\"10\">
    </td>
  </tr>
</table>
</html>"));
end ThreePhaseTransformerWithRectifier;
