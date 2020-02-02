within Modelica.Electrical.Polyphase.Sensors;
model CurrentQuasiRMSSensor
  "Continuous quasi current RMS sensor for polyphase system"
  extends Modelica.Icons.RoundSensor;
  extends Polyphase.Interfaces.TwoPlug;
  parameter Integer m(min=1) = 3 "Number of phases" annotation(Evaluate=true);
  Modelica.Blocks.Interfaces.RealOutput I(unit="A")
    "Continuous quasi average RMS of current" annotation (Placement(
        transformation(
        origin={0,-100},
        extent={{-10,-10},{10,10}},
        rotation=270), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-110})));
  Polyphase.Sensors.CurrentSensor currentSensor(final m=m)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Polyphase.Blocks.QuasiRMS quasiRMS(final m=m) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-50})));
equation
  connect(plug_p, currentSensor.plug_p) annotation (Line(points={{-100,
          0},{-100,0},{-10,0}}, color={0,0,255}));
  connect(currentSensor.plug_n, plug_n) annotation (Line(points={{10,0},{
          100,0},{100,0}}, color={0,0,255}));
  connect(currentSensor.i, quasiRMS.u) annotation (Line(
      points={{0,-11},{0,-38}}, color={0,0,127}));
  connect(quasiRMS.y, I) annotation (Line(
      points={{0,-61},{0,-100}}, color={0,0,127}));
  annotation (defaultComponentName="currentRMSSensor", Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={
                           Line(points={{0,-70},{0,-100}}),
          Text(
          extent={{150,-100},{-150,-70}},
          textString="m=%m"),
        Text(
          extent={{-150,80},{150,120}},
              textString="%name",
          textColor={0,0,255}),
        Text(
          extent={{-30,-10},{30,-70}},
          textColor={64,64,64},
          textString="A"),  Line(points={{100,0},{-100,0}}, color={0,0,255})}),
      Documentation(revisions="<html>
</html>",
      info="<html>
<p>
This sensor determines the continuous quasi <a href=\"Modelica://Modelica.Blocks.Math.RootMeanSquare\">RMS</a> value of a polyphase current system, representing an equivalent RMS current vector <code>I</code> or phasor. If the current waveform deviates from a sine curve, the output of the sensor will not be exactly the average RMS value.
</p>
<blockquote><pre>
I = sqrt(sum(i[k]^2 for k in 1:m)/m)
</pre></blockquote>
</html>"));
end CurrentQuasiRMSSensor;
