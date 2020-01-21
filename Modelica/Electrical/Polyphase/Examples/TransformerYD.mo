within Modelica.Electrical.Polyphase.Examples;
model TransformerYD "Test example with polyphase components"
  extends Modelica.Icons.Example;
  parameter Integer m=3 "Number of phases" annotation(Evaluate=true);
  parameter SI.Voltage V=1 "Amplitude of Star-Voltage";
  parameter SI.Frequency f=5 "Frequency";
  parameter SI.Inductance Lm=1 "Transformer main inductance";
  parameter SI.Inductance LT=0.003
    "Transformer stray inductance";
  parameter SI.Resistance RT=0.05 "Transformer resistance";
  parameter SI.Resistance RL=1 "Load Resistance";
  parameter Real nT=1/sqrt((1 - Modelica.Math.cos(2*Modelica.Constants.pi/m))
      ^2 + (Modelica.Math.sin(2*Modelica.Constants.pi/m))^2)
    "Transformer ratio";
  Sources.SineVoltage sineVoltage(
    V=fill(V, m),
    f=fill(f, m),
    m=m) annotation (Placement(transformation(
        origin={-80,20},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  Basic.Star starS(m=m) annotation (Placement(transformation(
        origin={-90,-62},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Ground groundS annotation (Placement(
        transformation(extent={{-100,-100},{-80,-80}})));
  Ideal.IdealTransformer idealTransformer(
    m=m,
    n=fill(nT, m),
    Lm1=fill(Lm, m)) annotation (Placement(transformation(extent={{-40,0},{
            -20,20}})));
  Basic.Star starT(m=m) annotation (Placement(transformation(
        origin={-40,-62},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Basic.Delta deltaT2(m=m) annotation (Placement(transformation(
        origin={50,10},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Ground groundT annotation (Placement(
        transformation(extent={{-50,-100},{-30,-80}})));
  Basic.Resistor transformerR(m=m, R=fill(RT/nT^2, m)) annotation (
      Placement(transformation(extent={{-10,10},{10,30}})));
  Basic.Inductor transformerL(m=m, L=fill(LT/nT^2, m)) annotation (
      Placement(transformation(extent={{20,10},{40,30}})));
  Basic.Resistor loadR(m=m, R=fill(RL, m)) annotation (Placement(
        transformation(extent={{70,10},{90,30}})));
  Basic.Star starL(m=m) annotation (Placement(transformation(
        origin={90,-62},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Ground groundL annotation (Placement(
        transformation(extent={{80,-100},{100,-80}})));
initial equation
  transformerL.i[1:m] = zeros(m) "D-connection";

equation
  connect(groundS.p, starS.pin_n)
    annotation (Line(points={{-90,-80},{-90,-72}}, color={0,0,255}));
  connect(groundT.p, starT.pin_n)
    annotation (Line(points={{-40,-80},{-40,-72}}, color={0,0,255}));
  connect(starS.plug_p, sineVoltage.plug_n)
    annotation (Line(points={{-90,-52},{-90,20}}, color={0,0,255}));
  connect(sineVoltage.plug_p, idealTransformer.plug_p1)
    annotation (Line(points={{-70,20},{-40,20}}, color={0,0,255}));
  connect(idealTransformer.plug_n1, starT.plug_p)
    annotation (Line(points={{-40,0},{-40,-52}}, color={0,0,255}));
  connect(idealTransformer.plug_p2, transformerR.plug_p)
    annotation (Line(points={{-20,20},{-10,20}}, color={0,0,255}));
  connect(transformerR.plug_n, transformerL.plug_p)
    annotation (Line(points={{10,20},{20,20}}, color={0,0,255}));
  connect(transformerL.plug_n, deltaT2.plug_p)
    annotation (Line(points={{40,20},{50,20}}, color={0,0,255}));
  connect(deltaT2.plug_n, idealTransformer.plug_n2)
    annotation (Line(points={{50,0},{-20,0}}, color={0,0,255}));
  connect(deltaT2.plug_p, loadR.plug_p)
    annotation (Line(points={{50,20},{70,20}}, color={0,0,255}));
  connect(loadR.plug_n, starL.plug_p)
    annotation (Line(points={{90,20},{90,-52}}, color={0,0,255}));
  connect(starL.pin_n, groundL.p)
    annotation (Line(points={{90,-72},{90,-80}}, color={0,0,255}));
  annotation (Documentation(info="<html>
<p>
Test example with polyphase components:<br>
Star-connected voltage source feeds via a Y-D-transformer with internal impedance (RT, LT) a load resistor RT.<br>
Using f=5 Hz LT=3mH defines nominal voltage drop of approximately 10 %.<br>
Simulate for 1 second (2 periods) and compare voltages and currents of source, transformer and load.
</p>
</html>"),
       experiment(StopTime=1.0, Interval=0.001));
end TransformerYD;
