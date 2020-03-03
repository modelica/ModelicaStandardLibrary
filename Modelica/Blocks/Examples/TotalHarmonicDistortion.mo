within Modelica.Blocks.Examples;
model TotalHarmonicDistortion "Calculation of total harmonic distortion of voltage"
  extends Modelica.Icons.Example;
  parameter SI.Frequency f1 = 50 "Fundamental wave frequency";
  parameter SI.Voltage V1 = 100 "Fundamental wave RMS voltage";
  parameter SI.Voltage V3 = 20 "Third harmonic wave RMS voltage";
  final parameter Real THD1 = V3/V1 "Theoretically obtained THD with respect to fundamental wave";
  final parameter Real THDrms = V3/sqrt(V1^2+V3^2) "Theoretically obtained THD with respect to RMS";
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(transformation(extent={{-50,-60},{-30,-40}})));
  Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage3(V=sqrt(2)*V3, f=3*f1,
    startTime=0.02)                                           annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-40,10})));
  Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage1(V=sqrt(2)*V1, f=f1,
    startTime=0.02)                                           annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-40,-20})));
  Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270)));
  Modelica.Blocks.Math.TotalHarmonicDistortion thd1(f=f1) annotation (Placement(transformation(extent={{30,10},{50,30}})));
  Modelica.Blocks.Math.TotalHarmonicDistortion thdRMS(f=f1, useFirstHarmonic=false) annotation (Placement(transformation(extent={{30,-30},{50,-10}})));
equation
  connect(voltageSensor.p, sineVoltage3.p) annotation (Line(points={{0,10},{0,30},{-40,30},{-40,20}}, color={0,0,255}));
  connect(sineVoltage3.n, sineVoltage1.p) annotation (Line(points={{-40,0},{-40,-10}}, color={0,0,255}));
  connect(sineVoltage1.n, ground.p) annotation (Line(points={{-40,-30},{-40,-40}}, color={0,0,255}));
  connect(ground.p, voltageSensor.n) annotation (Line(points={{-40,-40},{-40,-30},{0,-30},{0,-10}}, color={0,0,255}));
  connect(thd1.u, voltageSensor.v) annotation (Line(points={{28,20},{20,20},{20,0},{11,0}}, color={0,0,127}));
  connect(voltageSensor.v, thdRMS.u) annotation (Line(points={{11,0},{20,0},{20,-20},{28,-20}}, color={0,0,127}));
  annotation (experiment(
      StopTime=0.1,
      Interval=0.0001,
      Tolerance=1e-06), Documentation(info="<html>
<p>This example compares the result of the
<a href=\"modelica://Modelica.Blocks.Math.TotalHarmonicDistortion\">total harmonic distortion (THD)</a>
with respect to the fundamental wave and with respect to the total root mean square (RMS).
In this simulation model a non-sinusoidal voltage
wave form is created by the superposition two voltage waves:</p>

<ul>
<li>Fundamental wave with RMS voltage <code>V1</code> and frequency <code>f1</code></li>
<li>Third harmonic wave with RMS voltage <code>V3</code> and frequency <code>3*f1</code></li>
</ul>

<p>This simulation model compares numerically determined THD values with results, obtained by
theoretical calculations:</p>

<ul>
<li>Compare the numerically determined THD value <code>thd1.y</code> and the theoretical value <code>THD1</code>,
    both with respect to the fundamental wave; also plot <code>thd1.valid</code></li>
<li>Compare the numerically determined THD value <code>thdRMS.y</code> and the theoretical value <code>THDrms</code>,
    both with respect to the RMS value; also plot <code>thdRMS.valid</code></li>
</ul>
</html>"));
end TotalHarmonicDistortion;
