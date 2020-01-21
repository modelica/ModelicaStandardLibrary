within Modelica.Electrical.Machines.Utilities;
model RampedRheostat "Rheostat with linearly decreasing resistance"
  parameter Integer m=3 "Number of phases" annotation(Evaluate=true);
  Modelica.Electrical.Polyphase.Interfaces.PositivePlug plug_p(final m=m)
    "To positive rotor plug" annotation (Placement(transformation(extent={{
            90,70},{110,50}})));
  Modelica.Electrical.Polyphase.Interfaces.NegativePlug plug_n(final m=m)
    "To negative rotor plug" annotation (Placement(transformation(extent={{
            90,-50},{110,-70}})));
  parameter SI.Resistance RStart "Starting resistance";
  parameter SI.Time tStart
    "Time instance of reducing the rheostat";
  parameter SI.Time tRamp "Duration of ramp";
  Modelica.Electrical.Polyphase.Basic.Star star(final m=m) annotation (
      Placement(transformation(extent={{-20,-70},{-40,-50}})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(
        origin={-70,-60},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Polyphase.Basic.VariableResistor rheostat(final m=m)
    annotation (Placement(transformation(
        origin={60,0},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  Modelica.Blocks.Sources.Ramp ramp[m](
    final height=fill(-RStart, m),
    final duration=fill(tRamp, m),
    final offset=fill(RStart, m),
    final startTime=fill(tStart, m)) annotation (Placement(transformation(
          extent={{-20,-10},{0,10}})));
equation
  connect(plug_p, rheostat.plug_p) annotation (Line(
      points={{100,60},{60,60},{60,10}}, color={0,0,255}));
  connect(rheostat.plug_n, plug_n) annotation (Line(
      points={{60,-10},{60,-60},{100,-60}}, color={0,0,255}));
  connect(rheostat.R, ramp.y) annotation (Line(
      points={{48,0},{26,0},{26,0},{1,0}}, color={0,0,127}));
  connect(rheostat.plug_n, star.plug_p) annotation (Line(
      points={{60,-10},{60,-60},{-20,-60}}, color={0,0,255}));
  connect(star.pin_n, ground.p) annotation (Line(
      points={{-40,-60},{-60,-60}}, color={0,0,255}));
  annotation (defaultComponentName="rheostat",
    Icon(graphics={
        Rectangle(
          extent={{26,40},{54,-40}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{100,-60},{40,-60},{40,-40}}, color={0,0,255}),
        Line(points={{10,-80},{70,-80}}, color={0,0,255}),
        Line(points={{40,-60},{40,-80}}, color={0,0,255}),
        Line(points={{20,-90},{60,-90}}, color={0,0,255}),
        Line(points={{30,-100},{50,-100}}, color={0,0,255}),
        Line(points={{40,40},{40,60},{100,60}}, color={0,0,255}),
        Rectangle(
          extent={{-100,40},{-20,-40}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-90,24},{-72,24},{-30,-30}}, color={0,0,255}),
        Polygon(
          points={{-20,6},{-10,0},{-20,-6},{-20,6}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{10,6},{20,0},{10,-6},{10,6}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-10,0},{10,0}}, color={0,0,255}),
        Line(points={{20,0},{26,0}}, color={0,0,255})}), Documentation(info=
         "<html>
<p>Ramped rheostat, used for starting induction motors with slipring rotor:</p>
<p>The external rotor resistance <code>RStart</code> is reduced to zero,
starting at time <code>tStart</code> with a linear ramp <code>tRamp</code>.</p>
</html>"));
end RampedRheostat;
