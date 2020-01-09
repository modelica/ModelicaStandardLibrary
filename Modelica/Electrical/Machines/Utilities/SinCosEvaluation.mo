within Modelica.Electrical.Machines.Utilities;
block SinCosEvaluation "Evaluation of the signals of a sin-cos-resolver"
  extends Modelica.Blocks.Icons.Block;
  Blocks.Interfaces.RealInput u[4] "Signal from sin-cos-resolver"
    annotation (Placement(transformation(extent={{-140,20},{-100,-20}})));
  Blocks.Math.Feedback feedbackCos
    annotation (Placement(transformation(extent={{-70,30},{-50,50}})));
  Blocks.Math.Feedback feedbackSin
    annotation (Placement(transformation(extent={{-70,-30},{-50,-50}})));
  SpacePhasors.Blocks.Rotator rotator
    annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  Blocks.Continuous.Integrator integrator(final k=1e6)
    annotation (Placement(transformation(extent={{10,-10},{30,10}})));
  Blocks.Continuous.Der der1
    annotation (Placement(transformation(extent={{60,-70},{80,-50}})));
  Blocks.Interfaces.RealOutput phi(unit="rad") "Angle"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Blocks.Interfaces.RealOutput w(unit="rad/s") "Angular velocity"
    annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
equation
  connect(u[1], feedbackCos.u1) annotation (Line(points={{-120,15},{-80,15},
          {-80,40},{-68,40}}, color={0,0,127}));
  connect(u[2], feedbackCos.u2)
    annotation (Line(points={{-120,5},{-60,5},{-60,32}}, color={0,0,127}));
  connect(u[3], feedbackSin.u1) annotation (Line(points={{-120,-5},{-80,-5},
          {-80,-40},{-68,-40}}, color={0,0,127}));
  connect(u[4], feedbackSin.u2) annotation (Line(points={{-120,-15},{-60,
          -15},{-60,-32}}, color={0,0,127}));
  connect(feedbackCos.y, rotator.u[1]) annotation (Line(points={{-51,40},{
          -40,40},{-40,0},{-22,0}}, color={0,0,127}));
  connect(feedbackSin.y, rotator.u[2]) annotation (Line(points={{-51,-40},{
          -40,-40},{-40,0},{-22,0}}, color={0,0,127}));
  connect(rotator.y[2], integrator.u)
    annotation (Line(points={{1,0},{8,0}}, color={0,0,127}));
  connect(integrator.y, rotator.angle) annotation (Line(points={{31,0},{40,
          0},{40,-20},{-10,-20},{-10,-12}}, color={0,0,127}));
  connect(integrator.y, der1.u) annotation (Line(points={{31,0},{40,0},{40,
          -60},{58,-60}}, color={0,0,127}));
  connect(integrator.y, phi)
    annotation (Line(points={{31,0},{110,0}}, color={0,0,127}));
  connect(der1.y, w)
    annotation (Line(points={{81,-60},{110,-60}}, color={0,0,127}));
  annotation (Icon(graphics={
        Line(points={{-80,80},{-76.2,79.8},{-70.6,76.6},{-64.9,69.7},{-59.3,
              59.4},{-52.9,44.1},{-44.83,21.2},{-27.9,-30.8},{-20.7,-50.2},{-14.3,
              -64.2},{-8.7,-73.1},{-3,-78.4},{2.6,-80},{8.2,-77.6},{13.9,-71.5},
              {19.5,-61.9},{25.9,-47.2},{34,-24.8},{42,0}}, smooth=Smooth.Bezier),
        Line(points={{-80,0},{-68.7,34.2},{-61.5,53.1},{-55.1,66.4},{-49.4,
              74.6},{-43.8,79.1},{-38.2,79.8},{-32.6,76.6},{-26.9,69.7},{-21.3,
              59.4},{-14.9,44.1},{-6.83,21.2},{10.1,-30.8},{17.3,-50.2},{23.7,
              -64.2},{29.3,-73.1},{35,-78.4},{40.6,-80},{46.2,-77.6},{51.9,-71.5},
              {57.5,-61.9},{63.9,-47.2},{72,-24.8},{80,0}}, smooth = Smooth.Bezier)}),
      Documentation(info="<html>
<p>
The <a href=\"modelica://Modelica.Electrical.Machines.Sensors.SinCosResolver\">sin-cos-resolver</a> provides four tracks:
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
Interpreting cosine and sine as real and imaginary part of a phasor, one could calculate the angle of the phasor (i.e., transform rectangular coordinates to polar coordinates).
This is not very robust if the signals are superimposed with some noise.
Therefore the phasor is rotated by an angle that is obtained by a controller. The controller aims at imaginary part equal to zero.
The resulting angle is continuous, i.e. differentiating the angle results in 2*&pi;*frequency.
If desired, the angle can be wrapped to the interval ]-&pi;, +&pi;].
</p>
<p>
If the <a href=\"modelica://Modelica.Electrical.Machines.Sensors.SinCosResolver\">sin-cos-resolver</a> provides one period of the tracks during a rotation of 2&pi;/p,
the result is the angle with respect to one pole pair and can be directly used for field oriented control.
</p>
</html>"));
end SinCosEvaluation;
