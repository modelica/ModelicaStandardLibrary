within Modelica.Blocks.Math;
block Harmonic "Calculate harmonic over period 1/f"
  extends Modelica.Blocks.Icons.Block;
  parameter SI.Frequency f(start=50) "Base frequency";
  parameter Integer k(start=1) "Order of harmonic";
  parameter Boolean useConjugateComplex=false
    "Gives conjugate complex result if true"
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Real x0Cos=0 "Start value of cos integrator state";
  parameter Real x0Sin=0 "Start value of sin integrator state";
  Sources.Cosine      sin1(
    final amplitude=sqrt(2),
    final f=k*f,
    final phase=0) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-80,70})));
  Blocks.Sources.Sine sin2(
    final amplitude=sqrt(2),
    final phase=0,
    final f=k*f) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-80,-70})));
  MultiProduct product1(nu=2)
    annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
  MultiProduct product2(nu=2)
    annotation (Placement(transformation(extent={{-60,-50},{-40,-30}})));
  Mean mean1(final f=f, final x0=x0Cos)
    annotation (Placement(transformation(extent={{-20,30},{0,50}})));
  Mean mean2(final f=f, final x0=x0Sin)
    annotation (Placement(transformation(extent={{-20,-50},{0,-30}})));
  Blocks.Interfaces.RealInput u
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Blocks.Interfaces.RealOutput y_rms
    "Root mean square of polar representation" annotation (Placement(
        transformation(extent={{100,50},{120,70}})));
  Blocks.Interfaces.RealOutput y_arg(unit="rad") "Angle of polar representation"
    annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
  Blocks.Math.RectangularToPolar rectangularToPolar
    annotation (Placement(transformation(extent={{40,-12},{60,8}})));
  Gain gain(final k=if useConjugateComplex then -1 else 1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={80,-30})));
equation

  connect(product2.y, mean2.u) annotation (Line(
      points={{-38.3,-40},{-22,-40}}, color={0,0,127}));
  connect(product1.y, mean1.u) annotation (Line(
      points={{-38.3,40},{-22,40}}, color={0,0,127}));
  connect(mean1.y, rectangularToPolar.u_re) annotation (Line(
      points={{1,40},{20,40},{20,4},{38,4}}, color={0,0,127}));
  connect(mean2.y, rectangularToPolar.u_im) annotation (Line(
      points={{1,-40},{20,-40},{20,-8},{38,-8}}, color={0,0,127}));
  connect(rectangularToPolar.y_abs, y_rms) annotation (Line(
      points={{61,4},{80,4},{80,60},{110,60}}, color={0,0,127}));
  connect(sin1.y, product1.u[1]) annotation (Line(
      points={{-80,59},{-80,59},{-80,43.5},{-60,43.5}}, color={0,0,127}));
  connect(u, product1.u[2]) annotation (Line(
      points={{-120,0},{-80,0},{-80,36.5},{-60,36.5}}, color={0,0,127}));
  connect(u, product2.u[1]) annotation (Line(
      points={{-120,0},{-80,0},{-80,-36.5},{-60,-36.5}}, color={0,0,127}));
  connect(sin2.y, product2.u[2]) annotation (Line(
      points={{-80,-59},{-80,-43.5},{-60,-43.5}}, color={0,0,127}));
  connect(rectangularToPolar.y_arg, gain.u)
    annotation (Line(points={{61,-8},{80,-8},{80,-18}}, color={0,0,127}));
  connect(gain.y, y_arg)
    annotation (Line(points={{80,-41},{80,-60},{110,-60}}, color={0,0,127}));
  annotation (Documentation(info="<html>
<p>
This block calculates the root mean square and the phase angle of a single harmonic <em>k</em> of the input signal u over the given period 1/f, using the
<a href=\"modelica://Modelica.Blocks.Math.Mean\">mean block</a>.
</p>
<p>
Note: The output is updated after each period defined by 1/f.
</p>
<p>
Note:<br>
The harmonic is defined by <code>&radic;2 rms cos(k 2 &pi; f t - arg)</code> if useConjugateComplex=false (default)<br>
The harmonic is defined by <code>&radic;2 rms cos(k 2 &pi; f t + arg)</code> if useConjugateComplex=true
</p>
</html>"),
         Icon(graphics={
        Text(
          extent={{-80,60},{80,20}},
          textString="H%k"),
        Text(
          extent={{-80,-20},{80,-60}},
          textString="f=%f"),
        Text(
          extent={{20,100},{100,60}},
          textString="rms"),
        Text(
          extent={{20,-60},{100,-100}},
          textString="arg")}));
end Harmonic;
