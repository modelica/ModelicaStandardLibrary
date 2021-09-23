within Modelica.Electrical.Analog.Examples.Lines;
model SmoothStep "Compares oLine and tLine behaviour"
  extends Modelica.Icons.Example;
  import Modelica.Units.SI;
  import Modelica.Constants.small;
  parameter SI.Resistance Rload=1000 "Load resistance";
  parameter Real r1(final min=small, final unit="Ohm/m")=1e-6 "Resistance per meter";
  parameter Real g1(final min=small, final unit="S/m")=1e-12 "Conductance per meter";
  parameter Real l1(final min=small, final unit="H/m")=1e-6 "Inductance per meter";
  parameter Real c1(final min=small, final unit="F/m")=1e-11 "Capacitance per meter";
  parameter SI.Length len=100e3 "Length of line";
  parameter Integer N1=1 "Number of lumped segments of oline1";
  parameter Integer N5=5 "Number of lumped segments of oline5";
  parameter Integer N50=50 "Number of lumped segments of oline50";
  parameter SI.Velocity c=1/sqrt(l1*c1) "Speed of EM wave";
  parameter SI.Time  td=len/c "Transmission delay";
  parameter SI.Impedance z0=sqrt(l1/c1) "Charateristic impedance for very high frequency";
  Modelica.Blocks.Sources.Step step(startTime=200e-6) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-80,70})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(T=1e-9, initType=Modelica.Blocks.Types.Init.InitialOutput)
    annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-80,30})));
  Modelica.Electrical.Analog.Sources.SignalVoltage sourceV annotation (
      Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=-90,
        origin={-50,-30})));
  Modelica.Electrical.Analog.Basic.Ground groundS
    annotation (Placement(transformation(extent={{-60,-70},{-40,-50}})));
  Modelica.Electrical.Analog.Lines.OLine oLine1(
    N=N1,
    r=r1,
    l=l1,
    g=g1,
    c=c1,
    length=len)
    annotation (Placement(transformation(extent={{20,50},{40,70}})));
  Modelica.Electrical.Analog.Basic.Resistor R1(R=Rload) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={60,60})));
  Modelica.Electrical.Analog.Lines.OLine oLine5(
    r=r1,
    l=l1,
    g=g1,
    c=c1,
    length=len,
    N=N5)
         annotation (Placement(transformation(extent={{20,20},{40,40}})));
  Modelica.Electrical.Analog.Basic.Resistor R5(R=Rload) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={60,30})));
  Modelica.Electrical.Analog.Lines.OLine oLine50(
    r=r1,
    l=l1,
    g=g1,
    c=c1,
    length=len,
    N=N50)
          annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Modelica.Electrical.Analog.Basic.Resistor R50(R=Rload) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={60,0})));
  Modelica.Electrical.Analog.Basic.Ground groundO
    annotation (Placement(transformation(extent={{70,-30},{90,-10}})));
  Modelica.Electrical.Analog.Lines.TLine tLine(
    Z0=z0,
    TD=td,
    er(start=0),
    v2(start=0)) annotation (Placement(transformation(extent={{-30,
            -40},{-10,-20}})));

  Modelica.Electrical.Analog.Basic.Resistor Rdistr(R=Rload) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={12,-30})));
  Modelica.Electrical.Analog.Basic.Ground groundT
    annotation (Placement(transformation(extent={{-10,-70},{10,-50}})));
initial equation
  oLine1.C.v=zeros(N1);
  oLine1.L.i=zeros(N1 + 1);
  oLine5.C.v=zeros(N5);
  oLine5.L.i=zeros(N5 + 1);
  oLine50.C.v=zeros(N50);
  oLine50.L.i=zeros(N50 + 1);
equation
  connect(groundS.p, sourceV.n) annotation (Line(
      points={{-50,-50},{-50,-40}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(R5.p, oLine5.p2) annotation (Line(
      points={{60,40},{50,40},{50,30},{40,30}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(R5.n, oLine5.p3) annotation (Line(
      points={{60,20},{30,20}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(Rdistr.p, tLine.p2)
    annotation (Line(points={{12,-20},{-10,-20}}, color={0,0,255}));
  connect(R1.p, oLine1.p2) annotation (Line(
      points={{60,70},{50,70},{50,60},{40,60}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(R1.n, oLine1.p3) annotation (Line(
      points={{60,50},{30,50}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(groundT.p, tLine.n2)
    annotation (Line(points={{0,-50},{0,-40},{-10,-40}}, color={0,0,255}));
  connect(R50.p, oLine50.p2) annotation (Line(
      points={{60,10},{50,10},{50,0},{40,0}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(R50.n, oLine50.p3) annotation (Line(
      points={{60,-10},{30,-10}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(oLine1.p1, sourceV.p) annotation (Line(
      points={{20,60},{-50,60},{-50,-20}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(oLine5.p1, sourceV.p) annotation (Line(
      points={{20,30},{-50,30},{-50,-20}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(oLine50.p1, sourceV.p) annotation (Line(
      points={{20,0},{-50,0},{-50,-20}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(tLine.p1, sourceV.p)
    annotation (Line(points={{-30,-20},{-50,-20}}, color={0,0,255}));
  connect(tLine.n1, groundS.p)
    annotation (Line(points={{-30,-40},{-50,-40},{-50,-50}}, color={0,0,255}));
  connect(sourceV.v, firstOrder.y) annotation (Line(
      points={{-62,-30},{-80,-30},{-80,19}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(firstOrder.u, step.y) annotation (Line(
      points={{-80,42},{-80,59}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Rdistr.n, groundT.p)
    annotation (Line(points={{12,-40},{0,-40},{0,-50}},  color={0,0,255}));
  connect(R1.n,groundO. p)
    annotation (Line(points={{60,50},{80,50},{80,-10}}, color={0,0,255}));
  connect(groundO.p, R50.n)
    annotation (Line(points={{80,-10},{60,-10}}, color={0,0,255}));
  connect(groundO.p, R5.n)
    annotation (Line(points={{80,-10},{80,20},{60,20}}, color={0,0,255}));
  annotation (
    experiment(
      StopTime=0.003,
      Interval=1e-06,
      Tolerance=1e-06),
    Documentation(info="<html>
<p>This example shows a comparison of a multi-segment OLine model with the distributed-parameter line model TLine.</p>
<p>If resistances and conductances are negligible, with OLine the results should become closer and closer as the number of segments increases.</p>
<p>Suggested tests:</p>
<h4>Steep step</h4>
<p>Use the model as it is (it has <code>firstOrder.T=1e-9</code>&nbsp;s) and comapare <code>R1.v</code>, <code>R5.v</code>, <code>R50.v</code>, <code>Rdistr.v</code>: <code>Rdistr.v</code> is the ideal voltage of the receiving-end resistor for a lossless line, while the others are approximations with 1, 5, 50 cascaded segment models.</p>
<p>The step in this case is nearly ideal, and therefore is a very tough test for cascaded segments, and in fact they are not very good in approximating the real line behaviour.</p>
<h4>Smoother step</h4>
<p>Repeat the simulation using <code>firstOrder.T=20e-6</code>&nbsp;s. You will see that the OLine compliance with the reference result given by TLine is much better, and 50 segments are probably adequate for several applications; in comparison with, they add the option of evaluating losses.</p>
</html>",
        revisions="<html>
<ul>
<li><em>May, 2021</em>
        implemented by Massimo Ceraolo, University of Pisa
</li>
</ul>
</html>"));
end SmoothStep;
