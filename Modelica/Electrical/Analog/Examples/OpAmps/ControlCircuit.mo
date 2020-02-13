within Modelica.Electrical.Analog.Examples.OpAmps;
model ControlCircuit "Control circuit"
  extends Modelica.Icons.Example;
  parameter SI.Time T1=0.01 "Small time constant";
  parameter SI.Time T2=0.01 "Large time constant";
  parameter SI.Time Ti=T2 "Integral time constant";
  parameter Real kp=T2/(2*T1) "Proportional gain";
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));
  Sources.StepVoltage stepA(V=10, startTime=0.1) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-90,-62})));
  OpAmpCircuits.Feedback feedbackA(p1(i(start=0)))
    annotation (Placement(transformation(extent={{-70,-40},{-50,-20}})));
  OpAmpCircuits.PI PIA(
    v2(fixed=true),
    k=kp,
    T=Ti,
    opAmp(v_in(start=0)))
    annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
  OpAmpCircuits.FirstOrder firstOrder1A(
    v2(fixed=true),
    T=T1,
    opAmp(v_in(start=0)))
    annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
  OpAmpCircuits.Add addA(i1_2(start=0), r(i(start=0)))
    annotation (Placement(transformation(extent={{30,-40},{50,-20}})));
  Sources.StepVoltage step1A(V=1, startTime=0.5) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={20,-60})));
  OpAmpCircuits.FirstOrder firstOrder2A(
    v2(fixed=true),
    T=T2,
    opAmp(v_in(start=0)))
    annotation (Placement(transformation(extent={{60,-40},{80,-20}})));
  Blocks.Sources.Step stepB(height=10, startTime=0.1)
    annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
  Blocks.Math.Feedback feedbackB
    annotation (Placement(transformation(extent={{-70,60},{-50,80}})));
  Blocks.Continuous.PI PIB(
    k=kp,
    T=Ti,
    initType=Modelica.Blocks.Types.Init.InitialOutput)
    annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
  Blocks.Continuous.FirstOrder firstOrder1B(T=T1, initType=Modelica.Blocks.Types.Init.InitialOutput)
    annotation (Placement(transformation(extent={{-10,60},{10,80}})));
  Blocks.Math.Add addB
    annotation (Placement(transformation(extent={{30,60},{50,80}})));
  Blocks.Sources.Step step1B(height=1, startTime=0.5)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={20,30})));
  Blocks.Continuous.FirstOrder firstOrder2B(T=T2, initType=Modelica.Blocks.Types.Init.InitialOutput)
    annotation (Placement(transformation(extent={{60,60},{80,80}})));
equation
  connect(stepA.n, ground.p)
    annotation (Line(points={{-90,-72},{-90,-80}}, color={0,0,255}));
  connect(feedbackA.p2, PIA.p1)
    annotation (Line(points={{-50,-20},{-40,-20}}, color={0,0,255}));
  connect(feedbackA.n2, PIA.n1)
    annotation (Line(points={{-50,-40},{-40,-40}}, color={0,0,255}));
  connect(PIA.p2, firstOrder1A.p1)
    annotation (Line(points={{-20,-20},{-10,-20}}, color={0,0,255}));
  connect(PIA.n2, firstOrder1A.n1)
    annotation (Line(points={{-20,-40},{-10,-40}}, color={0,0,255}));
  connect(stepB.y,feedbackB. u1)
    annotation (Line(points={{-79,70},{-68,70}}, color={0,0,127}));
  connect(feedbackB.y,PIB. u)
    annotation (Line(points={{-51,70},{-42,70}}, color={0,0,127}));
  connect(PIB.y,firstOrder1B. u)
    annotation (Line(points={{-19,70},{-12,70}},
                                               color={0,0,127}));
  connect(firstOrder1B.y, addB.u1) annotation (Line(points={{11,70},{19.5,70},{19.5,
          76},{28,76}}, color={0,0,127}));
  connect(addB.y, firstOrder2B.u)
    annotation (Line(points={{51,70},{58,70}}, color={0,0,127}));
  connect(step1B.y, addB.u2)
    annotation (Line(points={{20,41},{20,64},{28,64}}, color={0,0,127}));
  connect(firstOrder2B.y, feedbackB.u2) annotation (Line(points={{81,70},{90,70},
          {90,50},{-60,50},{-60,62}}, color={0,0,127}));
  connect(stepA.p, feedbackA.p1_2)
    annotation (Line(points={{-90,-52},{-90,-30},{-70,-30}}, color={0,0,255}));
  connect(firstOrder2A.p2, feedbackA.p1) annotation (Line(points={{80,-20},{80,-10},
          {-70,-10},{-70,-20}}, color={0,0,255}));
  connect(ground.p, feedbackA.n1)
    annotation (Line(points={{-90,-80},{-70,-80},{-70,-40}}, color={0,0,255}));
  connect(ground.p, step1A.n)
    annotation (Line(points={{-90,-80},{20,-80},{20,-70}}, color={0,0,255}));
  connect(firstOrder1A.n2, addA.n1)
    annotation (Line(points={{10,-40},{30,-40}}, color={0,0,255}));
  connect(firstOrder1A.p2, addA.p1)
    annotation (Line(points={{10,-20},{30,-20}}, color={0,0,255}));
  connect(step1A.p, addA.p1_2)
    annotation (Line(points={{20,-50},{20,-30},{30,-30}}, color={0,0,255}));
  connect(addA.p2, firstOrder2A.p1)
    annotation (Line(points={{50,-20},{60,-20}}, color={0,0,255}));
  connect(addA.n2, firstOrder2A.n1)
    annotation (Line(points={{50,-40},{60,-40}}, color={0,0,255}));
  annotation (Documentation(info="<html>
<p>This is an analog control circuit with operational amplifiers.</p>
<p>Compare the analog solution with the block circuit, e.g. <code>firstOrder2B.y</code> and <code>firstOrder2A.v2</code>.</p>
</html>"),
    experiment(
      StartTime=0,
      StopTime=1,
      Tolerance=1e-006,
      Interval=0.001));
end ControlCircuit;
