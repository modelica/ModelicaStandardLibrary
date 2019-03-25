within Modelica.Electrical.Analog.Examples;
model CompareTransformers
  "Transformer circuit to show the magnetization facilities"
  import Modelica.Constants.pi;
  extends Modelica.Icons.Example;
  parameter SI.Voltage Vdc=0.1 "DC offset of voltage source";
  parameter SI.Voltage Vpeak=0.1 "Peak voltage of voltage source";
  parameter SI.Frequency f=10 "Frequency of voltage source";
  parameter SI.Angle phi0=pi/2 "Phase of voltage source";
  parameter Real n=2 "Turns ratio primary:secondary voltage";
  parameter SI.Resistance R1=0.01
    "Primary resistance w.r.t. primary side";
  parameter SI.Inductance L1sigma=0.05/(2*pi*f)
    "Primary leakage inductance w.r.t. primary side";
  parameter SI.Inductance Lm1= 10./(2*pi*f)
    "Magnetizing inductance w.r.t. primary side";
  parameter SI.Inductance L2sigma=0.05/(2*pi*f)/n^2
    "Secondary leakage inductance w.r.t. secondary side";
  parameter SI.Resistance R2=0.01/n^2
    "Secondary resistance w.r.t. secondary side";
  parameter SI.Resistance RL=1/n^2 "Load resistance";
  final parameter SI.Inductance L1=L1sigma + M*n
    "Primary no-load inductance";
  final parameter SI.Inductance L2=L2sigma + M/n
    "Secondary no-load inductance";
  final parameter SI.Inductance M=Lm1/n "Mutual inductance";
  output SI.Voltage v1B = resistor11.n.v
    "Primary voltage, basic transformer";
  output SI.Current i1B = resistor11.i
    "Primary current, basic transformer";
  output SI.Voltage v2B = resistor12.p.v
    "Secondary voltage, basic transformer";
  output SI.Current i2B = resistor12.i
    "Secondary current, basic transformer";
  output SI.Voltage v1I = resistor21.n.v
    "Primary voltage, basic transformer";
  output SI.Current i1I = resistor21.i
    "Primary current, basic transformer";
  output SI.Voltage v2I = resistor22.p.v
    "Secondary voltage, basic transformer";
  output SI.Current i2I = resistor22.i
    "Secondary current, basic transformer";
  Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage1(
    V=Vpeak,
    phase=phi0,
    freqHz=f,
    offset=Vdc)
    annotation (Placement(transformation(
        origin={-80,40},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Ground ground11
    annotation (Placement(transformation(extent={{-90,0},{-70,20}})));
  Modelica.Electrical.Analog.Basic.Resistor resistor11(R=R1)
    annotation (Placement(transformation(extent={{-80,50},{-60,70}})));
  Modelica.Electrical.Analog.Basic.Resistor resistor12(R=R2)
    annotation (Placement(transformation(extent={{60,50},{80,70}})));
  Modelica.Electrical.Analog.Basic.Resistor load1(R=RL)
    annotation (Placement(transformation(
        origin={80,40},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Ground ground12
    annotation (Placement(transformation(extent={{70,0},{90,20}})));
  Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage2(
    V=Vpeak,
    phase=phi0,
    freqHz=f,
    offset=Vdc)
    annotation (Placement(transformation(
        origin={-80,-50},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Ground ground21
    annotation (Placement(transformation(extent={{-90,-90},{-70,-70}})));
  Modelica.Electrical.Analog.Basic.Resistor resistor21(R=R1)
    annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
  Modelica.Electrical.Analog.Basic.Inductor inductor21(L=L1sigma)
    annotation (Placement(transformation(extent={{-50,-40},{-30,-20}})));
  Modelica.Electrical.Analog.Basic.Inductor inductor22(L=L2sigma, i(start=0, fixed=true))
    annotation (Placement(transformation(extent={{30,-40},{50,-20}})));
  Modelica.Electrical.Analog.Basic.Resistor resistor22(R=R2)
    annotation (Placement(transformation(extent={{60,-40},{80,-20}})));
  Modelica.Electrical.Analog.Basic.Resistor load2(R=RL)
    annotation (Placement(transformation(
        origin={80,-50},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Ground ground22
    annotation (Placement(transformation(extent={{70,-90},{90,-70}})));
  Modelica.Electrical.Analog.Basic.Transformer basicTransformer(
    L1=L1,
    L2=L2,
    M=M) annotation (Placement(transformation(extent={{-10,40},{10,60}})));
  Modelica.Electrical.Analog.Ideal.IdealTransformer idealTransformer(n=n,
      Lm1=Lm1,
    considerMagnetization=false)
    annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));

initial equation
 basicTransformer.i1=0;
 basicTransformer.i2=0;
equation

  connect(sineVoltage1.n, ground11.p)
    annotation (Line(points={{-80,30},{-80,20}}, color={0,0,255}));
  connect(sineVoltage1.p, resistor11.p)
    annotation (Line(points={{-80,50},{-80,60}}, color={0,0,255}));
  connect(load1.n, ground12.p)
    annotation (Line(points={{80,30},{80,20}}, color={0,0,255}));
  connect(resistor12.n, load1.p)
    annotation (Line(points={{80,60},{80,50}}, color={0,0,255}));
  connect(sineVoltage2.n, ground21.p)
    annotation (Line(points={{-80,-60},{-80,-70}}, color={0,0,255}));
  connect(sineVoltage2.p, resistor21.p)
    annotation (Line(points={{-80,-40},{-80,-30}}, color={0,0,255}));
  connect(resistor21.n, inductor21.p)
    annotation (Line(points={{-60,-30},{-50,-30}}, color={0,0,255}));
  connect(inductor22.n, resistor22.p)
    annotation (Line(points={{50,-30},{60,-30}}, color={0,0,255}));
  connect(load2.n, ground22.p)
    annotation (Line(points={{80,-60},{80,-70}}, color={0,0,255}));
  connect(resistor22.n, load2.p)
    annotation (Line(points={{80,-30},{80,-40}}, color={0,0,255}));
  connect(ground11.p, basicTransformer.n1) annotation (Line(points={{-80,20},
          {-10,20},{-10,45}}, color={0,0,255}));
  connect(basicTransformer.n2, ground12.p) annotation (Line(points={{10,45},{10,
          20},{80,20}}, color={0,0,255}));
  connect(basicTransformer.p1, resistor11.n) annotation (Line(points={{-10,55},
          {-10,60},{-60,60}}, color={0,0,255}));
  connect(basicTransformer.p2, resistor12.p) annotation (Line(points={{10,55},{
          10,60},{60,60}}, color={0,0,255}));
  connect(ground21.p, idealTransformer.n1) annotation (Line(points={{-80,-70},
          {-10,-70},{-10,-45}}, color={0,0,255}));
  connect(ground22.p, idealTransformer.n2) annotation (Line(points={{80,-70},{
          10,-70},{10,-45}}, color={0,0,255}));
  connect(idealTransformer.p1, inductor21.n) annotation (Line(points={{-10,
          -35},{-10,-30},{-30,-30}}, color={0,0,255}));
  connect(idealTransformer.p2, inductor22.p) annotation (Line(points={{10,-35},
          {10,-30},{30,-30}}, color={0,0,255}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={Text(
          extent={{-60,-80},{60,-100}},
          lineColor={0,0,255},
          textString="try considerMagnetization=false/true"), Text(
          extent={{-60,20},{60,0}},
          lineColor={0,0,255},
          textString="Basic.Transformer (mutual inductance)")}),
    experiment(StopTime=50, Interval=0.001),
    Documentation(revisions="<html>
<dl>
<dt><em>2009</em></dt>
<dd>by Anton Haumer<br> initially implemented</dd>
</dl>
</html>",
        info="<html>
<p>This example is to demonstrate the behaviour of transformer models. The Basic.Transformer, which consists of mutual coupled inductors, is compared with the ideal transformer model. If the ideal model is used with considerMagnetization=true leakage inductances are taken into account, otherwise not.
The example is constructed in such a way that the ideal transformer circuit with considerMagnetization=true shows the same behaviour as the basic transformer.</p>
<p>Simulate until T=50 s with both considerMagnetization=false and considerMagnetization=true of the ideal transformer.
Plot in separate windows for comparison:
<br>basicTransformer.p1.v and idealTransformer.p1.v
<br>basicTransformer.p1.i and idealTransformer.p1.i
<br>basicTransformer.p2.v and idealTransformer.p2.v
basicTransformer.p2.i and idealTransformer.p2.i</p>
</html>"));
end CompareTransformers;
