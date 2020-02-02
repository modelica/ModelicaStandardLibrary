within Modelica.Electrical.Polyphase.Sensors;
model VoltageQuasiRMSSensor
  "Continuous quasi voltage RMS sensor for polyphase system"
  extends Modelica.Icons.RoundSensor;
  extends Polyphase.Interfaces.TwoPlug;
  parameter Integer m(min=1) = 3 "Number of phases" annotation(Evaluate=true);

  Modelica.Blocks.Interfaces.RealOutput V(unit="V") "Continuous quasi RMS of voltage"
    annotation (Placement(transformation(
        origin={-2,-110},
        extent={{-10,-10},{10,10}},
        rotation=270), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-110})));
  Polyphase.Sensors.VoltageSensor voltageSensor(final m=m)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Polyphase.Blocks.QuasiRMS quasiRMS(final m=m) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-50})));
equation
  connect(plug_p, voltageSensor.plug_p) annotation (Line(points={{-100,
          0},{-100,0},{-10,0}}, color={0,0,255}));
  connect(voltageSensor.plug_n, plug_n) annotation (Line(points={{10,0},{
          100,0},{100,0}}, color={0,0,255}));
  connect(voltageSensor.v, quasiRMS.u) annotation (Line(
      points={{0,-11},{0,-38}}, color={0,0,127}));
  connect(quasiRMS.y, V) annotation (Line(
      points={{0,-61},{0,-86},{0,-110},{-2,-110}}, color={0,0,127}));
  annotation (defaultComponentName="voltageRMSSensor", Icon(graphics={Text(
              extent={{-160,-70},{160,-100}},
              textString="m=%m"),Line(points={{0,-70},{0,-100}}),
          Line(points={{-90,0},{-70,0}}, color={0,0,255}),Line(points={{70,
          0},{90,0}}, color={0,0,255}),
        Text(
          extent={{-150,80},{150,120}},
              textString="%name",
          textColor={0,0,255}),
        Text(
          extent={{-30,-10},{30,-70}},
          textString="V",
          textColor={64,64,64})}),Documentation(revisions="<html>
</html>",
      info="<html>
<p>
This sensor determines the continuous quasi <a href=\"Modelica://Modelica.Blocks.Math.RootMeanSquare\">RMS</a> value of a polyphase voltage system, representing an equivalent RMS voltage <code>V</code> vector or phasor. If the voltage waveform deviates from a sine curve, the output of the sensor will not be exactly the average RMS value.
</p>
<blockquote><pre>
V = sqrt(sum(v[k]^2 for k in 1:m)/m)
</pre></blockquote>
</html>"));
end VoltageQuasiRMSSensor;
