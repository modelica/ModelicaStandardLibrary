within Modelica.Electrical.Analog.Examples.Lines;
model CompareLineTrunks "Compares oLine and tLine splitting lines into trunks"
  extends Modelica.Icons.Example;
  import Modelica.Units.SI;
  import Modelica.Constants.small;
  parameter SI.Resistance Rload=1000 "Load resistance";
  parameter Real r1(final min=small, final unit="Ohm/m")=1e-6 "Resistance per meter";
  parameter Real g1(final min=small, final unit="S/m")=1e-12 "Conductance per meter";
  parameter Real l1(final min=small, final unit="H/m")=1e-6 "Inductance per meter";
  parameter Real c1(final min=small, final unit="F/m")=1e-11 "Capacitance per meter";
  parameter SI.Length len=100e3 "Length of line";
  parameter Integer segsPerTrunk=7 "Segments per trunk";
  parameter SI.Velocity c=1/sqrt(l1*c1) "Speed of EM wave";
  parameter SI.Time td=len/c/4 "Transmission delay";
  parameter SI.Impedance z0=sqrt(l1/c1) "Characteristic impedance for very high frequency";
  Modelica.Blocks.Sources.Ramp ramp(startTime=400e-6, duration=50e-6)
    annotation (Placement(transformation(extent={{-88,-10},{-68,10}})));
  Modelica.Electrical.Analog.Sources.SignalVoltage srcLump annotation (
      Placement(transformation(
        origin={-40,30},
        extent={{-10,10},{10,-10}},
        rotation=-90)));
  Modelica.Electrical.Analog.Basic.Ground ground1 annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  Modelica.Electrical.Analog.Lines.OLine oLine1(
    N=segsPerTrunk,
    r=r1,
    l=l1,
    g=g1,
    c=c1,
    length=len/4) annotation (Placement(transformation(extent={{-30,30},{-10,50}})));
  Modelica.Electrical.Analog.Lines.OLine oLine2(
    N=segsPerTrunk,
    r=r1,
    l=l1,
    g=g1,
    c=c1,
    length=len/4) annotation (Placement(transformation(extent={{0,30},{20,50}})));
  Modelica.Electrical.Analog.Lines.OLine oLine3(
    N=segsPerTrunk,
    r=r1,
    l=l1,
    g=g1,
    c=c1,
    length=len/4) annotation (Placement(transformation(extent={{30,30},{50,50}})));
  Modelica.Electrical.Analog.Lines.OLine oLine4(
    N=segsPerTrunk,
    r=r1,
    l=l1,
    g=g1,
    c=c1,
    length=len/4) annotation (Placement(transformation(extent={{60,30},{80,50}})));
  Modelica.Electrical.Analog.Basic.Resistor R1(R=Rload) annotation (Placement(
        transformation(
        origin={90,30},
        extent={{-10,-10},{10,10}},
        rotation=-90)));
  Modelica.Electrical.Analog.Sources.SignalVoltage srcDistr annotation (
      Placement(transformation(
        origin={-40,-30},
        extent={{-10,10},{10,-10}},
        rotation=-90)));
  Basic.Ground ground2 annotation (Placement(transformation(extent={{-50,-70},{-30,-50}})));
  Modelica.Electrical.Analog.Lines.TLine  tLine1(Z0=z0, TD=td,
    er(start=0),
    v2(start=0)) annotation (
      Placement(transformation(extent={{-30,-40},{-10,-20}})));
  Modelica.Electrical.Analog.Lines.TLine  tline2(Z0=z0, TD=td,
    er(start=0),
    v2(start=0)) annotation (
      Placement(transformation(
        origin={32,4},
        extent={{-32,-44},{-12,-24}})));
  Modelica.Electrical.Analog.Lines.TLine  tline3(Z0=z0, TD=td,
    er(start=0),
    v2(start=0)) annotation (
      Placement(transformation(
        origin={62,4},
        extent={{-32,-44},{-12,-24}})));
  Modelica.Electrical.Analog.Lines.TLine  tline4(Z0=z0, TD=td,
    er(start=0),
    v2(start=0)) annotation (
      Placement(transformation(
        origin={92,4},
        extent={{-32,-44},{-12,-24}})));
  Modelica.Electrical.Analog.Basic.Resistor R2(R=Rload) annotation (Placement(
        transformation(
        origin={90,-30},
        extent={{-10,-10},{10,10}},
        rotation=-90)));
initial equation
  oLine1.C.v=zeros(segsPerTrunk);
  oLine1.L.i=zeros(segsPerTrunk + 1);
  oLine2.C.v=zeros(segsPerTrunk);
  oLine2.L.i=zeros(segsPerTrunk + 1);
  oLine3.C.v=zeros(segsPerTrunk);
  oLine3.L.i=zeros(segsPerTrunk + 1);
  oLine4.C.v=zeros(segsPerTrunk);
  oLine4.L.i=zeros(segsPerTrunk + 1);
equation
  connect(srcLump.v, ramp.y)
    annotation (Line(points={{-52,30},{-60,30},{-60,0},{-67,0}},
                                                          color={0,0,127}));
  connect(oLine1.p1, srcLump.p) annotation (Line(points={{-30,40},{-40,40}},
                         color={0,0,255}));
  connect(tLine1.p1, srcDistr.p) annotation (
    Line(points={{-30,-20},{-40,-20}}, color={0,0,255}));
  connect(srcDistr.n, tLine1.n1) annotation (
    Line(points={{-40,-40},{-30,-40}}, color={0,0,255}));
  connect(oLine1.p2, oLine2.p1)
    annotation (Line(points={{-10,40},{0,40}}, color={0,0,255}));
  connect(oLine2.p2, oLine3.p1)
    annotation (Line(points={{20,40},{30,40}},color={0,0,255}));
  connect(oLine3.p2, oLine4.p1)
    annotation (Line(points={{50,40},{60,40}}, color={0,0,255}));
  connect(oLine4.p2, R1.p)
    annotation (Line(points={{80,40},{90,40}}, color={0,0,255}));
  connect(srcDistr.v, ramp.y) annotation (Line(points={{-52,-30},{-60,-30},{-60,
          0},{-67,0}}, color={0,0,127}));
  connect(tline2.n1, tLine1.n2) annotation (
    Line(points={{0,-40},{-10,-40}}, color={0,0,255}));
  connect(tline2.p1, tLine1.p2) annotation (
    Line(points={{0,-20},{-10,-20}}, color={0,0,255}));
  connect(tline3.n1, tline2.n2) annotation (
    Line(points={{30,-40},{20,-40}}, color={0,0,255}));
  connect(tline3.p1, tline2.p2) annotation (
    Line(points={{30,-20},{20,-20}}, color={0,0,255}));
  connect(tline4.n1, tline3.n2) annotation (
    Line(points={{60,-40},{50,-40}}, color={0,0,255}));
  connect(tline4.p1, tline3.p2) annotation (
    Line(points={{60,-20},{50,-20}}, color={0,0,255}));
  connect(srcLump.n, ground1.p)
    annotation (Line(points={{-40,20},{-40,10}}, color={0,0,255}));
  connect(ground1.p, oLine1.p3)
    annotation (Line(points={{-40,10},{-20,10},{-20,30}}, color={0,0,255}));
  connect(ground1.p, oLine2.p3)
    annotation (Line(points={{-40,10},{10,10},{10,30}}, color={0,0,255}));
  connect(ground1.p, oLine3.p3)
    annotation (Line(points={{-40,10},{40,10},{40,30}}, color={0,0,255}));
  connect(ground1.p, oLine4.p3)
    annotation (Line(points={{-40,10},{70,10},{70,30}}, color={0,0,255}));
  connect(ground1.p, R1.n)
    annotation (Line(points={{-40,10},{90,10},{90,20}}, color={0,0,255}));
  connect(tline4.p2, R2.p)
    annotation (Line(points={{80,-20},{90,-20}}, color={0,0,255}));
  connect(tline4.n2, R2.n)
    annotation (Line(points={{80,-40},{90,-40}}, color={0,0,255}));
  connect(srcDistr.n, ground2.p)
    annotation (Line(points={{-40,-40},{-40,-50}}, color={0,0,255}));
  connect(ground2.p, tline2.n2)
    annotation (Line(points={{-40,-50},{20,-50},{20,-40}}, color={0,0,255}));
  connect(ground2.p, tline3.n2)
    annotation (Line(points={{-40,-50},{50,-50},{50,-40}}, color={0,0,255}));
  connect(ground2.p, tline4.n2)
    annotation (Line(points={{-40,-50},{80,-50},{80,-40}}, color={0,0,255}));
  connect(ground2.p, tLine1.n2)
    annotation (Line(points={{-40,-50},{-10,-50},{-10,-40}}, color={0,0,255}));
  annotation (
    experiment(StopTime=0.004, Interval=4e-006, Tolerance=1e-06),
    Documentation(info="<html>
<p>This example shows a way to look at the traveling wave moving along a power line.</p>
<p>This wave can be seen looking at intermediate points of the line, looking at both OLine (several segments per line trunk) and TLine models.</p>
<p>OLine in the lossless case is less accurate, since shows oscillations that are not present in a distributed parameter line but,
since it allows the addition of resistances and conductances, allows evaluation of losses.</p>
<p>Suggested tests:</p>
<h4>7 segments per trunk, lossless</h4>
<p>Run the model as it is. Since resistances and conductances are very small in OLine, the simulation is substantially lossless.</p>
<p>Show in the same plot <code>ramp.y</code>, <code>oLine1.p2.v</code>, <code>oLine2.p2.v</code>, <code>oLine3.p2.v</code>, <code>oLine4.p2.v</code>.</p>
<p>Show in another plot, simultaneously, <code>ramp.y</code>, <code>tLine1.p2.v</code>, <code>tLine2.p2.v</code>, <code>tLine3.p2.v</code>, <code>tLine4.p2.v</code>. Here oLine shows unreal oscillations, which, however, reduce if the number of segments per trunk increases.</p>
<h4>50 segments per trunk, lossless</h4>
<p>Try increasing this number from 7 to 50 using parameter <code>segsPerTrunk</code>, and look at the same plots as per test 1</p>
<h4>50 segments per trunk, losses</h4>
<p>Leave <code>segsPerTrunk=50</code>, change <code>r1</code> to 1e-3&nbsp;&Omega;, re-simulate: the effect of losses is visible only on the oLine plot.</p>
</html>",
        revisions="<html>
<ul>
<li><em>May, 2021</em>
        implemented by Massimo Ceraolo, University of Pisa
</li>
</ul>
</html>"));
end CompareLineTrunks;
