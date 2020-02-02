within Modelica.Electrical.QuasiStatic.Polyphase.Sensors;
model ReactivePowerSensor "Three-phase sensor for reactive power"
  extends Modelica.Icons.RoundSensor;
  final parameter Integer m(final min=1) = 3 "Number of phases" annotation(Evaluate=true);
  Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.PositivePlug plug_p(final m=m)
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.NegativePlug plug_n(final m=m)
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Blocks.Interfaces.RealOutput reactivePower "Reactive power"
    annotation (Placement(transformation(
        origin={0,-110},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  Modelica.Electrical.QuasiStatic.Polyphase.Basic.PlugToPins_p plugToPins_p(final m=m)
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  Modelica.Electrical.QuasiStatic.Polyphase.Basic.PlugToPins_n plugToPins_n(final m=m)
    annotation (Placement(transformation(extent={{80,20},{60,40}})));
  Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.PowerSensor powerSensor1
    annotation (Placement(transformation(extent={{-40,50},{-20,70}})));
  Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.PowerSensor powerSensor2
    annotation (Placement(transformation(extent={{10,40},{30,20}})));
  Modelica.Blocks.Math.Add3 add(
    final k1=1/sqrt(3),
    final k2=1/sqrt(3),
    final k3=1/sqrt(3))        annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={0,-80})));
  Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.PowerSensor powerSensor3
    annotation (Placement(transformation(extent={{30,-10},{50,10}})));
  Modelica.ComplexBlocks.ComplexMath.ComplexToReal complexToReal1(final
      useConjugateInput=false) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-40,-30})));
  Modelica.ComplexBlocks.ComplexMath.ComplexToReal complexToReal2(final
      useConjugateInput=false) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-30})));
  Modelica.ComplexBlocks.ComplexMath.ComplexToReal complexToReal3(final
      useConjugateInput=false) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={30,-30})));
equation
  connect(add.y, reactivePower)
    annotation (Line(points={{0,-91},{0,-110}}, color={0,0,127}));
  connect(plug_p, plugToPins_p.plug_p)
    annotation (Line(points={{-100,0},{-90,0},{-90,30},{-72,30}},
                                                color={85,170,255}));
  connect(plugToPins_n.plug_n, plug_n)
    annotation (Line(points={{72,30},{90,30},{90,0},{100,0}},
                                              color={85,170,255}));
  connect(plugToPins_p.pin_p[1], powerSensor1.currentP)
    annotation (Line(points={{-68,30},{-68,60},{-40,60}},color={85,170,255}));
  connect(plugToPins_p.pin_p[2], powerSensor1.voltageP) annotation (Line(points={{-68,30},
          {-50,30},{-50,70},{-30,70}},        color={85,170,255}));
  connect(powerSensor1.currentN, plugToPins_n.pin_n[1])
    annotation (Line(points={{-20,60},{68,60},{68,30}},color={85,170,255}));
  connect(plugToPins_p.pin_p[3], powerSensor1.voltageN) annotation (Line(points={{-68,30},
          {-68,0},{-30,0},{-30,50}},             color={85,170,255}));
  connect(plugToPins_p.pin_p[2], powerSensor2.currentP)
    annotation (Line(points={{-68,30},{10,30}},
                                              color={85,170,255}));
  connect(powerSensor2.currentN, plugToPins_n.pin_n[2])
    annotation (Line(points={{30,30},{68,30}},
                                             color={85,170,255}));
  connect(plugToPins_p.pin_p[3], powerSensor2.voltageP) annotation (Line(points={{-68,30},
          {-68,0},{20,0},{20,20}},              color={85,170,255}));
  connect(powerSensor1.currentN, powerSensor2.voltageN)
    annotation (Line(points={{-20,60},{20,60},{20,40}}, color={85,170,255}));
  connect(plugToPins_p.pin_p[3], powerSensor3.currentP) annotation (Line(
        points={{-68,30},{-68,0},{30,0}}, color={85,170,255}));
  connect(powerSensor3.currentN, plugToPins_n.pin_n[3])
    annotation (Line(points={{50,0},{68,0},{68,30}}, color={85,170,255}));
  connect(powerSensor1.currentN, powerSensor3.voltageP) annotation (Line(
        points={{-20,60},{40,60},{40,10}}, color={85,170,255}));
  connect(powerSensor3.voltageN, plugToPins_n.pin_n[2]) annotation (Line(
        points={{40,-10},{40,-20},{60,-20},{60,30},{68,30}}, color={85,170,
          255}));
  connect(powerSensor1.apparentPower, complexToReal1.u) annotation (Line(points={{-40,49},{-40,-18}}, color={85,170,255}));
  connect(complexToReal2.u, powerSensor2.apparentPower) annotation (Line(points={{0,-18},{0,50},{10,50},{10,41}}, color={85,170,255}));
  connect(powerSensor3.apparentPower, complexToReal3.u) annotation (Line(points={{30,-11},{30,-18}}, color={85,170,255}));
  connect(complexToReal1.re, add.u1) annotation (Line(points={{-34,-42},{
          -34,-60},{-8,-60},{-8,-68}}, color={0,0,127}));
  connect(complexToReal2.re, add.u2) annotation (Line(points={{6,-42},{6,
          -50},{0,-50},{0,-68}}, color={0,0,127}));
  connect(complexToReal3.re, add.u3) annotation (Line(points={{36,-42},{36,
          -60},{8,-60},{8,-68}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={
                                       Line(points={{0,-100},
          {0,-70}}, color={0,0,127}),
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
          textString="var"),
        Line(points={{70,0},{100,0}}, color={85,170,255}),
        Line(points={{-100,0},{-70,0}}, color={85,170,255})}),
                                  Documentation(info="<html>
<p>
Contains 3 power meters (Modelica.Electrical.Analog.Sensors.PowerSensor) to measure total reactive power in a three-phase system.
</p>
<p>
For more information see [<a href=\"modelica://Modelica.Electrical.Polyphase.UsersGuide.References\">M&uuml;hl2017</a>].
</p>
</html>"));
end ReactivePowerSensor;
