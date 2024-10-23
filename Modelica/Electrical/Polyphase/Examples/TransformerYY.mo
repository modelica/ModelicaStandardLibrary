within Modelica.Electrical.Polyphase.Examples;
model TransformerYY "Test example with polyphase components"
  extends Modelica.Icons.Example;
  parameter Integer m=3 "Number of phases" annotation(Evaluate=true);
  parameter SI.Voltage V=1 "Amplitude of Star-Voltage";
  parameter SI.Frequency f=5 "Frequency";
  parameter SI.Inductance Lm=1 "Transformer main inductance";
  parameter SI.Inductance LT=0.003
    "Transformer stray inductance";
  parameter SI.Resistance RT=0.05 "Transformer resistance";
  parameter SI.Resistance RL=1 "Load Resistance";
  parameter Real nT=1 "Transformer ratio";
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
    Lm1=fill(Lm, m),
    n=fill(nT, m)) annotation (Placement(transformation(extent={{-40,0},{-20,
            20}})));
  Basic.Star starT1(m=m) annotation (Placement(transformation(
        origin={-40,-62},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Basic.Star starT2(m=m) annotation (Placement(transformation(
        origin={-20,-62},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Ground groundT2 annotation (Placement(
        transformation(extent={{-30,-100},{-10,-80}})));
  Basic.Resistor transformerR(m=m, R=fill(RT, m)) annotation (Placement(
        transformation(extent={{0,10},{20,30}})));
  Basic.Inductor transformerL(m=m, L=fill(LT, m),
    iL(start=zeros(m), fixed=cat(1,fill(true,m-1),{false}))) annotation (Placement(
        transformation(extent={{30,10},{50,30}})));
  Basic.Resistor loadR(m=m, R=fill(RL, m)) annotation (Placement(
        transformation(extent={{70,10},{90,30}})));
  Basic.Star starL(m=m) annotation (Placement(transformation(
        origin={90,-62},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Ground groundT1 annotation (Placement(
        transformation(extent={{-50,-100},{-30,-80}})));
equation
  connect(starS.pin_n, groundS.p)
    annotation (Line(points={{-90,-72},{-90,-80}}, color={0,0,255}));
  connect(starT1.pin_n, groundT1.p)
    annotation (Line(points={{-40,-72},{-40,-80}}, color={0,0,255}));
  connect(starT2.pin_n, groundT2.p) annotation (Line(points={{-20,-72},{-20,
          -76},{-20,-76},{-20,-80}}, color={0,0,255}));
  connect(starS.plug_p, sineVoltage.plug_n)
    annotation (Line(points={{-90,-52},{-90,20}}, color={0,0,255}));
  connect(sineVoltage.plug_p, idealTransformer.plug_p1)
    annotation (Line(points={{-70,20},{-40,20}}, color={0,0,255}));
  connect(idealTransformer.plug_n1, starT1.plug_p)
    annotation (Line(points={{-40,0},{-40,-52}}, color={0,0,255}));
  connect(starT2.plug_p, idealTransformer.plug_n2) annotation (Line(points=
          {{-20,-52},{-20,-26},{-20,0}}, color={0,0,255}));
  connect(idealTransformer.plug_p2, transformerR.plug_p)
    annotation (Line(points={{-20,20},{0,20}}, color={0,0,255}));
  connect(transformerR.plug_n, transformerL.plug_p)
    annotation (Line(points={{20,20},{30,20}}, color={0,0,255}));
  connect(transformerL.plug_n, loadR.plug_p)
    annotation (Line(points={{50,20},{70,20}}, color={0,0,255}));
  connect(loadR.plug_n, starL.plug_p)
    annotation (Line(points={{90,20},{90,-52}}, color={0,0,255}));
  annotation (Documentation(info="<html>
<p>Test example with polyphase components:</p>
<p>Star-connected voltage source feeds via a Y-Y-transformer with internal impedance (RT, LT) a load resistor RT.</p>
<p>Using f=5 Hz LT=3mH defines nominal voltage drop of approximately 10 &percnt;.</p>
<p>Simulate for 1 second (2 periods) and compare voltages and currents of source, transformer and load. </p>
<h4>Note</h4>
<p>
From the <code>m</code> currents <code>m-1</code> have to be initialized with fixed = true, one of the <code>m</code> currents with fixed = false, 
due to the fact that the star connection enforces sum of the currents = 0.
</p>
<p>
Tools are expected to present a proper initialization section of the menu of <code>transformerL</code> which allows 
to set the start values of the <code>m</code> currents and the fixed attributes individually, i.e. as an array. 
Especially, a checkbox for the fixed attributes should be avoided.
</p>
<p>
If this is not the case, you have to write the code manually:
</p>
<p><code>
  Modelica.Electrical.PolyPhase.Basic.Inductor transformerL(m=m, L=fill(LT, m),
    <strong>iL(start=zeros(m), fixed=cat(1,fill(true,m-1),{false}))</strong>);</code>
</p>
</html>"),
       experiment(StopTime=1.0, Interval=0.001),
    Diagram(graphics={Text(
          extent={{0,60},{80,40}},
          textColor={28,108,200},
          textString="Regarding initialization:
see Documentation")}));
end TransformerYY;
