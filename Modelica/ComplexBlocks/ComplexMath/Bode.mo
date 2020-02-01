within Modelica.ComplexBlocks.ComplexMath;
block Bode "Calculate quantities to plot Bode diagram"
  extends Modelica.ComplexBlocks.Icons.ComplexBlock;
  parameter Boolean useDivisor = true "Use divisor input, if true" annotation(Evaluate = true, HideResult = true, choices(  checkBox = true));
  constant Modelica.Units.SI.AmplitudeLevelDifference dB = 20 "Amplitude level difference";
  Interfaces.ComplexInput u "Dividend if useDivisor == true" annotation (Placement(transformation(extent={{-140,40},{-100,80}}),   iconTransformation(extent={{-140,40},{-100,80}})));
  Interfaces.ComplexInput divisor if useDivisor "Divisor" annotation (Placement(transformation(extent={{-140,-80},{-100,-40}}), iconTransformation(extent={{-140,-80},{-100,-40}})));
  Blocks.Interfaces.RealOutput abs_y "Absolute value of ratio u / divisor" annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-60,-110}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-60,-110})));
  Blocks.Interfaces.RealOutput arg_y(unit="rad") "Angle of ratio u / divisor" annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={60,-110}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={60,-110})));
  Interfaces.ComplexOutput y "Quotient y = u / divisor" annotation (Placement(transformation(extent={{100,-10},{120,10}}), iconTransformation(extent={{100,-10},{120,10}})));
  Sources.ComplexConstant complexOne(final k=Complex(1, 0)) if not useDivisor "Complex(1,0)" annotation (Placement(transformation(extent={{-100,-50},{-80,-30}})));
  Division division(final useConjugateInput1=false, final useConjugateInput2=false)
                    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  ComplexToPolar complexToPolar(final useConjugateInput=false) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={0,-20})));
  Blocks.Interfaces.RealOutput dB_y(unit="dB") "Log10 of absolute value of ratio u / divisor in dB" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-110}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-110})));
  Blocks.Math.Log10 log10_y annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={-10,-70})));
  Blocks.Math.Gain gain(final k=dB) annotation (Placement(transformation(extent={{10,-80},{30,-60}})));
  Blocks.Nonlinear.Limiter limiter(final uMax=Modelica.Constants.inf, final uMin=Modelica.Constants.eps) annotation (Placement(transformation(extent={{-50,-80},{-30,-60}})));
equation

  connect(complexOne.y, division.u2) annotation (Line(points={{-79,-40},{-70,-40},{-70,-6},{-62,-6}}, color={85,170,255}));
  connect(divisor, division.u2) annotation (Line(points={{-120,-60},{-70,-60},{-70,-6},{-62,-6}}, color={85,170,255}));
  connect(division.u1, u) annotation (Line(points={{-62,6},{-70,6},{-70,60},{-120,60}}, color={85,170,255}));
  connect(division.y, y) annotation (Line(points={{-39,0},{110,0},{110,0}}, color={85,170,255}));
  connect(complexToPolar.u, y) annotation (Line(points={{0,-8},{0,0},{110,0}},  color={85,170,255}));
  connect(complexToPolar.phi, arg_y) annotation (Line(points={{6,-32},{6,-40},{60,-40},{60,-110}}, color={0,0,127}));
  connect(complexToPolar.len, abs_y) annotation (Line(points={{-6,-32},{-6,-40},{-60,-40},{-60,-110}}, color={0,0,127}));
  connect(log10_y.y, gain.u) annotation (Line(points={{1,-70},{8,-70}},     color={0,0,127}));
  connect(gain.y, dB_y) annotation (Line(points={{31,-70},{40,-70},{40,-90},{0,-90},{0,-110}},color={0,0,127}));
  connect(limiter.y, log10_y.u) annotation (Line(points={{-29,-70},{-22,-70}}, color={0,0,127}));
  connect(complexToPolar.len, limiter.u) annotation (Line(points={{-6,-32},{-6,-40},{-60,-40},{-60,-70},{-52,-70}}, color={0,0,127}));
  annotation (Icon(graphics={
        Line(points={{-78,44},{80,44}}, color={192,192,192}),
        Line(points={{-78,34},{80,34}}, color={192,192,192}),
        Line(points={{-78,20},{80,20}}, color={192,192,192}),
        Line(points={{-78,-2},{80,-2}}, color={192,192,192}),
        Line(points={{-78,-48},{80,-48}}, color={192,192,192}),
        Line(points={{-50,-48},{-50,44}}, color={192,192,192}),
        Line(points={{50,-48},{50,44}}, color={192,192,192}),
        Line(points={{-78,40},{80,40}}, color={192,192,192}),
                               Polygon(
              points={{90,-48},{68,-40},{68,-56},{90,-48}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
                        Polygon(
              points={{-70,90},{-78,68},{-62,68},{-70,90}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
        Line(points={{-70,-56},{-70,68}}, color={135,135,135}),
        Line(
          points={{-78,44},{-50,44},{70,-66}},
          color={85,170,255},
          thickness=0.5),               Text(
        extent={{-150,150},{150,110}},
        textString="%name",
        textColor={0,0,255}),
        Text(
          extent={{-80,-90},{-40,-70}},
          lineThickness=0.5,
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid,
          textString="|y|",
          textColor={128,128,128}),
        Text(
          extent={{-20,-90},{20,-70}},
          lineThickness=0.5,
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid,
          textString="dB",
          textColor={128,128,128}),
        Text(
          extent={{40,-90},{80,-70}},
          lineThickness=0.5,
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid,
          textString="∠",
          textColor={128,128,128}),
        Text(
          visible = useDivisor,
          extent={{-56,94},{94,54}},
          textColor={128,128,128},
          textString="u / divisor")}),
    Documentation(info="<html>
<p>This complex block is used to determine variables of a Bode diagram for the output <code>y</code>.
The output <code>y</code> is calculated by <code>u / divisor</code> if <code>useDivisor == true</code>.
Otherwise the output <code>y = u</code>.</p>
<ul>
<li><code>abs_y</code> Absolute value of <code>y</code></li>
<li><code>arg_y</code> Angle of <code>y</code></li>
<li><code>dB_y</code> Logarithm to the base 10 of the absolute value of <code>y</code> in dB</li>
</ul>
</html>"));
end Bode;
