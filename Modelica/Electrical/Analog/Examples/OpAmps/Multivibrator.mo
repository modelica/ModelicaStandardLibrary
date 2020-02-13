within Modelica.Electrical.Analog.Examples.OpAmps;
model Multivibrator "Multivibrator with Schmitt trigger"
  extends Modelica.Icons.Example;
  parameter SI.Voltage Vps=+15 "Positive supply";
  parameter SI.Voltage Vns=-15 "Negative supply";
  parameter SI.Frequency f=10 "Desired frequency";
  parameter SI.Resistance R1=1000 "Resistance 1 for adjusting the Schmitt trigger voltage level";
  parameter SI.Resistance R2=1000 "Resistance 2 for adjusting the Schmitt trigger voltage level";
  parameter SI.Resistance R=1000 "Arbitrary resistance";
  parameter SI.Capacitance C=1/f/(2*R*log(1 + 2*R1/R2)) "Calculated capacitance to reach the desired frequency f";
  Modelica.Electrical.Analog.Ideal.IdealizedOpAmpLimited opAmp(
    Vps=Vps,
    Vns=Vns,
    homotopyType = Modelica.Blocks.Types.LimiterHomotopy.LowerLimit,
    strict = true) annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
  Modelica.Electrical.Analog.Sensors.VoltageSensor vOut annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={50,-20})));
  Modelica.Electrical.Analog.Basic.Resistor r1(R=R1, i(start=0)) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-10,-40})));
  Modelica.Electrical.Analog.Basic.Resistor r2(R=R2) annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        origin={10,-20})));
  Modelica.Electrical.Analog.Basic.Resistor r(R=R)
    annotation (Placement(transformation(extent={{20,20},{0,40}})));
  Modelica.Electrical.Analog.Basic.Capacitor c(C=C, v(start=1, fixed=true))
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-30,-40})));
equation
  connect(ground.p, r1.n) annotation (Line(
      points={{-10,-60},{-10,-50}}, color={0,0,255}));
  connect(ground.p, vOut.n) annotation (Line(
      points={{-10,-60},{50,-60},{50,-30}}, color={0,0,255}));
  connect(opAmp.out, vOut.p) annotation (Line(
      points={{20,0},{50,0},{50,-10}}, color={0,0,255}));
  connect(ground.p, c.n) annotation (Line(
      points={{-10,-60},{-30,-60},{-30,-50}}, color={0,0,255}));
  connect(opAmp.out, r.p) annotation (Line(
      points={{20,0},{30,0},{30,30},{20,30}}, color={0,0,255}));
  connect(r.n, opAmp.in_n) annotation (Line(
      points={{0,30},{-10,30},{-10,6},{0,6}}, color={0,0,255}));
  connect(opAmp.out, r2.p) annotation (Line(
      points={{20,0},{30,0},{30,-20},{20,-20}}, color={0,0,255}));
  connect(r2.n, opAmp.in_p) annotation (Line(
      points={{0,-20},{-10,-20},{-10,-6},{0,-6}}, color={0,0,255}));
  connect(opAmp.in_p, r1.p) annotation (Line(
      points={{0,-6},{-10,-6},{-10,-30}}, color={0,0,255}));
  connect(r.n, c.p) annotation (Line(
      points={{0,30},{-30,30},{-30,-30}}, color={0,0,255}));
  annotation (Documentation(info="<html>
<p>This is a Multivibrator with Schmitt trigger according to:</p>
<p>U. Tietze and C. Schenk, Halbleiter-Schaltungstechnik (German), 11th edition, Springer 1999, Chapter 6.5.3</p>
<p>As the initialization system has two solutions, one with the op amp output at the lower saturation limit, and the other one with the two voltage inputs very close to each other, the <code>homotopyType</code> parameter is set to get the solver to converge to the former one, which is the required solution.</p>
</html>"),
    experiment(
      StartTime=0,
      StopTime=1,
      Tolerance=1e-006,
      Interval=0.001));
end Multivibrator;
