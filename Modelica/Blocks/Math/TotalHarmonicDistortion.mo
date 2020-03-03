within Modelica.Blocks.Math;
block TotalHarmonicDistortion "Output the total harmonic distortion (THD)"
  extends Interfaces.SISO;
  parameter SI.Frequency f(start=1) "Base frequency";
  parameter Boolean useFirstHarmonic = true "THD with respect to first harmonic, if true; otherwise with respect to total RMS";

  Harmonic harmonic(
    final f=f,
    final k=1,
    final x0Cos=0,
    final x0Sin=0) annotation (Placement(transformation(extent={{-70,-62},{-50,-42}})));
  RootMeanSquare rootMeanSquare(final f=f, final x0=0) annotation (Placement(transformation(extent={{-70,20},{-50,40}})));
  Logical.GreaterThreshold greaterThreshold annotation (Placement(transformation(extent={{10,-70},{30,-50}})));
  Interfaces.BooleanOutput valid "True, if output y is valid" annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
  Division division annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  Nonlinear.Limiter limiter(uMin=Modelica.Constants.eps, uMax=Modelica.Constants.inf) annotation (Placement(transformation(extent={{10,-30},{30,-10}})));
  Pythagoras pythagoras(u1IsHypotenuse=true) annotation (Placement(transformation(extent={{10,0},{30,20}})));
  Logical.And andValid annotation (Placement(transformation(extent={{60,-50},{80,-30}})));
  Sources.BooleanExpression booleanExpression(final y=not useFirstHarmonic) annotation (Placement(transformation(extent={{-70,-30},{-50,-10}})));
  Logical.Switch switch1 annotation (Placement(transformation(extent={{-20,-30},{0,-10}})));
equation
  connect(u, rootMeanSquare.u) annotation (Line(points={{-120,0},{-90,0},{-90,30},{-72,30}}, color={0,0,127}));
  connect(u, harmonic.u) annotation (Line(points={{-120,0},{-90,0},{-90,-52},{-72,-52}}, color={0,0,127}));
  connect(harmonic.y_rms, greaterThreshold.u) annotation (Line(points={{-49,-46},{-40,-46},{-40,-60},{8,-60}},  color={0,0,127}));
  connect(division.y, y) annotation (Line(points={{81,0},{110,0}}, color={0,0,127}));
  connect(pythagoras.u1, rootMeanSquare.y) annotation (Line(points={{8,16},{-30,16},{-30,30},{-49,30}},  color={0,0,127}));
  connect(pythagoras.y, division.u1) annotation (Line(points={{31,10},{50,10},{50,6},{58,6}}, color={0,0,127}));
  connect(pythagoras.valid, andValid.u1) annotation (Line(points={{31,4},{40,4},{40,-40},{58,-40}}, color={255,0,255}));
  connect(greaterThreshold.y, andValid.u2) annotation (Line(points={{31,-60},{40,-60},{40,-48},{58,-48}}, color={255,0,255}));
  connect(andValid.y, valid) annotation (Line(points={{81,-40},{90,-40},{90,-60},{110,-60}}, color={255,0,255}));
  connect(limiter.y, division.u2) annotation (Line(points={{31,-20},{50,-20},{50,-6},{58,-6}}, color={0,0,127}));
  connect(harmonic.y_rms, pythagoras.u2) annotation (Line(points={{-49,-46},{-40,-46},{-40,4},{8,4}},  color={0,0,127}));
  connect(switch1.u1, rootMeanSquare.y) annotation (Line(points={{-22,-12},{-30,-12},{-30,30},{-49,30}}, color={0,0,127}));
  connect(harmonic.y_rms, switch1.u3) annotation (Line(points={{-49,-46},{-40,-46},{-40,-28},{-22,-28}}, color={0,0,127}));
  connect(booleanExpression.y, switch1.u2) annotation (Line(points={{-49,-20},{-22,-20}}, color={255,0,255}));
  connect(switch1.y, limiter.u) annotation (Line(points={{1,-20},{8,-20}}, color={0,0,127}));
  annotation (defaultComponentName="thd",
    Icon(coordinateSystem(grid={2,2}), graphics={
        Line(points={{-80,-80},{-80,68}}, color={192,192,192}),
        Polygon(
          points={{-80,90},{-88,68},{-72,68},{-80,90}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-90,0},{68,0}}, color={192,192,192}),
        Polygon(
          points={{90,0},{68,8},{68,-8},{90,0}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-80,0},{-69,34},{-62,53},{-55,68},{-50,75},{-44,79},{-38,80},{-32,76},{-27,70},{-21,59},{-15,44},{-7,21},{10,-31},{17,-50},{24,-64},{29,-73},{35,-78},{41,-81},{46,-78},{52,-71},{57,-62},{64,-47},{72,-25},{80,0},{72,-53},{59,-37},{46,-95},{34,-53},{22,-81},{10,-10},{-3,-27},{-13,63},{-26,46},{-26,48},{-38,94},{-51,49},{-59,80},{-65,18},{-75,38},{-80,0}},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{2,80},{82,20}},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid,
          textString="1",
          visible=useFirstHarmonic),
        Text(
          extent={{2,80},{82,20}},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid,
          textString="rms",
          visible=not useFirstHarmonic),
        Text(
          extent={{-150,-110},{150,-150}},
          textString="f=%f")}),      Documentation(info="<html>
<p>This block determines the total harmonic distortion (THD) over the given period <code>1/f</code>.
Consider that the input <code>u</code> consists of harmonic RMS components
<code>U<sub>1</sub></code>, <code>U<sub>2</sub></code>, <code>U<sub>3</sub></code>, etc.
The total RMS component is then determined by:</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Math/Urms.png\">
</p>

<p>
The calculation of the total harmonic distortion is based on the parameter <code>useFirstHarmonic</code>.
The default value <code>useFirstHarmonic = true</code> represents the <strong>standard</strong> THD calculation used in
<a href=\"http://www.electropedia.org/iev/iev.nsf/display?openform&amp;ievref=551-20-13\">electrical engineering</a>.
The non-default value <code>useFirstHarmonic = false</code>
calculates the THD typically used for the assessment of audio signals.
</p>

<p>
If <code>useFirstHarmonic = true</code>, the total higher harmonic content (harmonic order numbers &gt; 1)
refers to the RMS value of the fundamental wave:<br>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Math/THD1.png\">
</p>

<p>
If <code>useFirstHarmonic = false</code>, the total higher harmonic content (harmonic order numbers &gt; 1)
refers to the total RMS:<br>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Math/THDrms.png\">
</p>

<p>
In case of a zero input signal or within the first period of calculation, the boolean output signal
<code>valid</code> becomes <code>false</code> to indicate that the calculation result is not valid. Valid
calculations are indicated by <code>valid = true</code>.
</p>
</html>"));
end TotalHarmonicDistortion;
