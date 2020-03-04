within Modelica.Blocks.Examples;
model SinCosEncoder "Evaluation of a sinusoidal encoder"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  SI.AngularVelocity w=2*pi*ramp.y "2*pi*f";
  Sources.Ramp ramp(
    height=100,
    duration=1,
    offset=0,
    startTime=0)
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
  Sources.CosineVariableFrequencyAndAmplitude
                                            cosB(
    useConstantAmplitude=true,
    offset=1.5,
    phi(fixed=true))
    annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
  Sources.CosineVariableFrequencyAndAmplitude
                                            cosBminus(
    useConstantAmplitude=true,
    constantAmplitude=-1,
    offset=1.5,
    phi(fixed=true))
    annotation (Placement(transformation(extent={{-60,10},{-40,30}})));
  Sources.SineVariableFrequencyAndAmplitude sinA(
    useConstantAmplitude=true,
    offset=1.5,
    phi(fixed=true))
    annotation (Placement(transformation(extent={{-60,-30},{-40,-10}})));
  Sources.SineVariableFrequencyAndAmplitude sinAminus(
    useConstantAmplitude=true,
    constantAmplitude=-1,
    offset=1.5,
    phi(fixed=true))
    annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));
  Math.Feedback feedbackCos
    annotation (Placement(transformation(extent={{-30,40},{-10,60}})));
  Math.Feedback feedbackSin
    annotation (Placement(transformation(extent={{-30,-30},{-10,-10}})));
  Electrical.Machines.SpacePhasors.Blocks.Rotator rotator
    annotation (Placement(transformation(extent={{10,-10},{30,10}})));
  Continuous.Integrator integrator(k=1e6)
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Continuous.Der der1
    annotation (Placement(transformation(extent={{80,-10},{100,10}})));
  Math.WrapAngle wrapAngle(positiveRange=false)
    annotation (Placement(transformation(extent={{80,20},{100,40}})));
  Electrical.Machines.SpacePhasors.Blocks.ToPolar toPolar
    annotation (Placement(transformation(extent={{10,20},{30,40}})));
equation
  connect(ramp.y, sinA.f) annotation (Line(points={{-79,0},{-70,0},{-70,-26},{-62,
          -26}},color={0,0,127}));
  connect(ramp.y, sinAminus.f) annotation (Line(points={{-79,0},{-70,0},{-70,-56},
          {-62,-56}}, color={0,0,127}));
  connect(ramp.y, cosBminus.f) annotation (Line(points={{-79,0},{-70,0},{-70,14},
          {-62,14}}, color={0,0,127}));
  connect(ramp.y, cosB.f) annotation (Line(points={{-79,0},{-70,0},{-70,44},{-62,
          44}}, color={0,0,127}));
  connect(cosBminus.y, feedbackCos.u2)
    annotation (Line(points={{-39,20},{-20,20},{-20,42}}, color={0,0,127}));
  connect(cosB.y, feedbackCos.u1)
    annotation (Line(points={{-39,50},{-28,50}}, color={0,0,127}));
  connect(sinA.y, feedbackSin.u1)
    annotation (Line(points={{-39,-20},{-28,-20}}, color={0,0,127}));
  connect(sinAminus.y, feedbackSin.u2)
    annotation (Line(points={{-39,-50},{-20,-50},{-20,-28}}, color={0,0,127}));
  connect(feedbackCos.y, rotator.u[1])
    annotation (Line(points={{-11,50},{0,50},{0,0},{8,0}}, color={0,0,127}));
  connect(feedbackSin.y, rotator.u[2])
    annotation (Line(points={{-11,-20},{0,-20},{0,0},{8,0}}, color={0,0,127}));
  connect(rotator.y[2], integrator.u)
    annotation (Line(points={{31,0},{38,0}}, color={0,0,127}));
  connect(integrator.y, rotator.angle) annotation (Line(points={{61,0},{70,0},{70,
          -20},{20,-20},{20,-12}}, color={0,0,127}));
  connect(integrator.y, der1.u)
    annotation (Line(points={{61,0},{78,0}}, color={0,0,127}));
  connect(integrator.y, wrapAngle.u)
    annotation (Line(points={{61,0},{70,0},{70,30},{78,30}}, color={0,0,127}));
  connect(feedbackCos.y, toPolar.u[1])
    annotation (Line(points={{-11,50},{0,50},{0,30},{8,30}}, color={0,0,127}));
  connect(feedbackSin.y, toPolar.u[2]) annotation (Line(points={{-11,-20},{0,-20},
          {0,30},{8,30}}, color={0,0,127}));
  annotation (experiment(StopTime=1.0, Interval=5e-05, Tolerance=1e-05), Documentation(info="<html>
<p>
This examples demonstrates robust evaluation of a sin-cos-encoder.
</p>
<p>
The sin-cos-encoder provides four tracks:
</p>
<ul>
<li>cosine</li>
<li>minus sine</li>
<li>sine</li>
<li>minus cosine</li>
</ul>
<p>
All four tracks have the same amplitude and the same offset &gt; amplitude. Offset is used to detect loss of a track.
To remove offset, (minus sine) is subtracted from (sine) and (minus cosine) from (cosine),
resulting in a cosine and a sine signal with doubled amplitude but without offset.
</p>
<p>
Interpreting cosine and sine as real and imaginary part of a phasor, one could calculate the angle of the phasor (i.e. transform rectangular coordinates to polar coordinates).
This is not very robust if the signals are superimposed with some noise.
Therefore the phasor is rotated by an angle that is obtained by a controller. The controller aims at imaginary part equal to zero.
The resulting angle is continuous, i.e. differentiating the angle results in 2*&pi;*frequency.
If desired, the angle can be wrapped to the interval [-&pi;, +&pi;].
</p>
</html>"));
end SinCosEncoder;
