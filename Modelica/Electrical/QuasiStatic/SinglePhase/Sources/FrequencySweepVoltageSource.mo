within Modelica.Electrical.QuasiStatic.SinglePhase.Sources;
model FrequencySweepVoltageSource "Voltage source with integrated frequency sweep"
  extends Interfaces.TwoPin;
  import Modelica.Constants.eps;
  SI.Angle gamma(start=0) = pin_p.reference.gamma;
  parameter SI.Frequency fStart(final min=eps, start=1) "Start sweep frequency";
  parameter SI.Frequency fStop(final min=eps, start=1) "Stop sweep frequency";
  parameter SI.Time startTime=0 "Start time of frequency sweep";
  parameter SI.Time duration(start=1) "Duration of frequency sweep";
  parameter SI.Voltage V(start=1) "RMS voltage of the source";
  parameter SI.Angle phi=0 "Phase shift of the source";
  SI.Frequency f = voltageSource.f "Actual frequency";
  Modelica.Blocks.Sources.LogFrequencySweep logFrequencySweep(
    final wMin=fStart,
    final wMax=fStop,
    final startTime=startTime,
    final duration=duration)
    annotation (Placement(transformation(extent={{40,-60},{20,-40}})));
  VariableVoltageSource voltageSource annotation (Placement(transformation(extent={{-20,10},{0,-10}})));
  Modelica.ComplexBlocks.Sources.ComplexConstant const(final k=
        Modelica.ComplexMath.fromPolar(len=V, phi=phi))
    annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));
equation

  connect(logFrequencySweep.y, voltageSource.f) annotation (Line(points={{19,-50},{-4,-50},{-4,-12}}, color={0,0,127}));
  connect(const.y, voltageSource.V) annotation (Line(points={{-39,-50},{-16,-50},{-16,-12}}, color={85,170,255}));
  connect(pin_p, voltageSource.pin_p) annotation (Line(points={{-100,0},{-20,0}}, color={85,170,255}));
  connect(voltageSource.pin_n, pin_n) annotation (Line(points={{0,0},{100,0}},         color={85,170,255}));
  annotation (defaultComponentName="voltageSource",Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Ellipse(
          extent={{-50,50},{50,-50}},
          lineColor={85,170,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-90,0},{-50,0}}, color={85,170,255}),
        Line(points={{50,0},{90,0}}, color={85,170,255}),
        Line(points={{-50,0},{50,0}}, color={85,170,255}),
        Line(points={{-70,30},{-70,10}}, color={85,170,255}),
        Line(points={{-80,20},{-60,20}}, color={85,170,255}),
        Line(points={{60,20},{80,20}}, color={85,170,255}),
        Text(
          extent={{150,60},{-150,100}},
          textString="%name",
          textColor={0,0,255}),
        Line(
          points={{-44,0},{-32,14},{-20,32},{-12,42},{-6,30},{0,0},{4,-28},{8,-40},{12,-20},{14,2},{16,30},{18,42},{20,28},{24,-32},{26,-40},{28,0}},
          color={192,192,192},
          smooth=Smooth.Bezier)}),    Documentation(info="<html>
<p>This source provides a constant RMS phase voltage <code>V</code> and phase angle <code>phi</code>,
whereas the frequency sweeps from
<code>fStart</code> to <code>fStop</code> with <code>duration</code>. The frequency sweeps such
way that on a logarithmic frequency scale, the frequency curve appears linear.</p>

<div><img src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStatic/SinglePhase/Sources/FrequencySweepSource.png\"
     alt=\"FrequencySweepSource.png\"></div>

</html>"));
end FrequencySweepVoltageSource;
