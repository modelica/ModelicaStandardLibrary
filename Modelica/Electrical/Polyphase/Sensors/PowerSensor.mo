within Modelica.Electrical.Polyphase.Sensors;
model PowerSensor "Polyphase instantaneous power sensor"
  extends Modelica.Icons.RoundSensor;
  parameter Integer m(min=1) = 3 "Number of phases" annotation(Evaluate=true);
  Polyphase.Interfaces.PositivePlug pc(final m=m) "Positive plug, current path"
    annotation (Placement(transformation(extent={{-110,10},{-90,-10}})));
  Polyphase.Interfaces.NegativePlug nc(final m=m) "Negative plug, current path"
    annotation (Placement(transformation(extent={{90,10},{110,-10}})));
  Polyphase.Interfaces.PositivePlug pv(final m=m) "Positive plug, voltage path"
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));
  Polyphase.Interfaces.NegativePlug nv(final m=m) "Negative plug, voltage path"
    annotation (Placement(transformation(extent={{-10,-90},{10,-110}})));
  Modelica.Blocks.Interfaces.RealOutput power(unit="W") annotation (Placement(
        transformation(
        origin={-100,-110},
        extent={{10,-10},{-10,10}},
        rotation=90), iconTransformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-100,-110})));
  Polyphase.Sensors.VoltageSensor voltageSensor(final m=m) annotation (
      Placement(transformation(
        origin={0,-20},
        extent={{10,10},{-10,-10}},
        rotation=90)));
  Polyphase.Sensors.CurrentSensor currentSensor(final m=m)
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  Modelica.Blocks.Math.Product product[m] annotation (Placement(
        transformation(
        origin={-30,-40},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Blocks.Math.Sum sum(final nin=m, final k=ones(m)) annotation (
      Placement(transformation(
        origin={-30,-70},
        extent={{10,-10},{-10,10}},
        rotation=90)));
equation
  connect(pc, currentSensor.plug_p)
    annotation (Line(points={{-100,0},{-50,0}}, color={0,0,255}));
  connect(currentSensor.plug_n, nc)
    annotation (Line(points={{-30,0},{100,0}}, color={0,0,255}));
  connect(voltageSensor.plug_p, pv) annotation (Line(points={{0,
          -10},{0,-10},{0,100}}, color={0,0,255}));
  connect(voltageSensor.plug_n, nv) annotation (Line(points={{0,
          -30},{0,-30},{0,-100}}, color={0,0,255}));
  connect(voltageSensor.v, product.u1) annotation (Line(
      points={{-11,-20},{-24,-20},{-24,-28}}, color={0,0,127}));
  connect(currentSensor.i, product.u2) annotation (Line(
      points={{-40,-11},{-40,-20},{-36,-20},{-36,-28}}, color={0,0,127}));
  connect(product.y, sum.u) annotation (Line(
      points={{-30,-51},{-30,-58}}, color={0,0,127}));
  connect(sum.y, power) annotation (Line(
      points={{-30,-81},{-30,-90},{-100,-90},{-100,-110}}, color={0,0,127}));
  annotation (
    Icon(graphics={Line(points={{0,100},{0,70}}, color={0,0,255}),
          Line(points={{0,-70},{0,-100}}, color={0,0,255}),
                             Ellipse(fillPattern=FillPattern.Solid, extent=
          {{-5,-5},{5,5}}),
          Line(points={{-100,0},{100,0}}, color={0,0,255}),
        Text(
          extent={{-150,110},{150,150}},
          textString="%name",
          textColor={0,0,255}),
        Text(
          extent={{150,-90},{-150,-70}},
          textString="m=%m"),
      Line(points={{-100,-100},{-100,-80},{-58,-38}}, color = {0,0,127}),
        Text(
          extent={{-30,-10},{30,-70}},
          textColor={64,64,64},
          textString="W")}), Documentation(
        info="<html><p>
This power sensor measures instantaneous electrical power of a polyphase system and has a separated voltage and current path. The plugs of the voltage path are <code>pv</code> and <code>nv</code>, the plugs of the current path are <code>pc</code> and <code>nc</code>. The internal resistance of each current path is zero, the internal resistance of each voltage path is infinite.
</p></html>"));
end PowerSensor;
