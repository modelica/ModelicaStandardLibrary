within Modelica.Electrical.Polyphase.Sensors;
model ReactivePowerSensor "Three-phase sensor for reactive power"
  extends Modelica.Icons.RoundSensor;
  final parameter Integer m(final min=1) = 3 "Number of phases" annotation(Evaluate=true);
  Interfaces.PositivePlug plug_p(final m=m) annotation (Placement(
        transformation(extent={{-110,-10},{-90,10}})));
  Interfaces.NegativePlug plug_n(final m=m) annotation (Placement(
        transformation(extent={{90,-10},{110,10}})));
  Modelica.Blocks.Interfaces.RealOutput reactivePower(unit="var") "Reactive power"
    annotation (Placement(transformation(
        origin={0,-110},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  Basic.PlugToPins_p plugToPins_p(final m=m)
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Basic.PlugToPins_n plugToPins_n(final m=m)
    annotation (Placement(transformation(extent={{80,-10},{60,10}})));
  Modelica.Electrical.Analog.Sensors.PowerSensor powerSensor1
    annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
  Modelica.Electrical.Analog.Sensors.PowerSensor powerSensor2
    annotation (Placement(transformation(extent={{10,10},{30,-10}})));
  Modelica.Blocks.Math.Add3 add(
    final k1=1/sqrt(3),
    final k2=1/sqrt(3),
    final k3=1/sqrt(3))        annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={0,-80})));
  Modelica.Electrical.Analog.Sensors.PowerSensor powerSensor3
    annotation (Placement(transformation(extent={{30,-40},{50,-20}})));
equation
  connect(plug_p, plugToPins_p.plug_p)
    annotation (Line(points={{-100,0},{-72,0}}, color={0,0,255}));
  connect(plugToPins_n.plug_n, plug_n)
    annotation (Line(points={{72,0},{100,0}}, color={0,0,255}));
  connect(add.y, reactivePower)
    annotation (Line(points={{0,-91},{0,-110}}, color={0,0,127}));
  connect(plugToPins_p.pin_p[1], powerSensor1.pc)
    annotation (Line(points={{-68,0},{-68,30},{-40,30}}, color={0,0,255}));
  connect(powerSensor1.pv, plugToPins_p.pin_p[2]) annotation (Line(points={
          {-30,40},{-50,40},{-50,0},{-68,0}}, color={0,0,255}));
  connect(plugToPins_p.pin_p[3], powerSensor1.nv) annotation (Line(points={
          {-68,0},{-68,-30},{-30,-30},{-30,20}}, color={0,0,255}));
  connect(plugToPins_p.pin_p[3], powerSensor2.pv) annotation (Line(points={
          {-68,0},{-68,-30},{20,-30},{20,-10}}, color={0,0,255}));
  connect(plugToPins_p.pin_p[2], powerSensor2.pc)
    annotation (Line(points={{-68,0},{10,0}}, color={0,0,255}));
  connect(powerSensor1.nc, plugToPins_n.pin_n[1])
    annotation (Line(points={{-20,30},{68,30},{68,0}}, color={0,0,255}));
  connect(powerSensor2.nc, plugToPins_n.pin_n[2])
    annotation (Line(points={{30,0},{68,0}}, color={0,0,255}));
  connect(powerSensor1.nc, powerSensor2.nv)
    annotation (Line(points={{-20,30},{20,30},{20,10}}, color={0,0,255}));
  connect(plugToPins_p.pin_p[3], powerSensor3.pc) annotation (Line(points={
          {-68,0},{-68,-30},{30,-30}}, color={0,0,255}));
  connect(powerSensor3.nc, plugToPins_n.pin_n[3])
    annotation (Line(points={{50,-30},{68,-30},{68,0}}, color={0,0,255}));
  connect(powerSensor1.nc, powerSensor3.pv)
    annotation (Line(points={{-20,30},{40,30},{40,-20}}, color={0,0,255}));
  connect(powerSensor3.nv, plugToPins_n.pin_n[2]) annotation (Line(points={
          {40,-40},{40,-50},{60,-50},{60,0},{68,0}}, color={0,0,255}));
  connect(powerSensor2.power, add.u2) annotation (Line(points={{10,11},{10,
          20},{0,20},{0,-66},{0,-66},{0,-68}}, color={0,0,127}));
  connect(powerSensor1.power, add.u1) annotation (Line(points={{-40,19},{
          -40,-60},{-8,-60},{-8,-68}}, color={0,0,127}));
  connect(powerSensor3.power, add.u3) annotation (Line(points={{30,-41},{30,
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
          textString="var"),Line(points={{100,0},{-100,0}}, color={0,0,255})}),
                                  Documentation(info="<html>
<p>
Contains 3 power meters (Modelica.Electrical.Analog.Sensors.PowerSensor) to measure total reactive power in a three-phase system.
</p>
<p>
For more information see [<a href=\"modelica://Modelica.Electrical.Polyphase.UsersGuide.References\">M&uuml;hl2017</a>].
</p>
</html>"));
end ReactivePowerSensor;
