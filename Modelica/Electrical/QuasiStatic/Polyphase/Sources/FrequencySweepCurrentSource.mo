within Modelica.Electrical.QuasiStatic.Polyphase.Sources;
model FrequencySweepCurrentSource "Current source with integrated frequency sweep"
  extends Interfaces.TwoPlug;
  import Modelica.Constants.eps;
  SI.Angle gamma(start=0) = plug_p.reference.gamma;
  parameter Integer m=3 "Number of phases" annotation(Evaluate=true);
  parameter SI.Frequency fStart(final min=eps, start=1) "Start sweep frequency";
  parameter SI.Frequency fStop(final min=eps, start=1) "Stop sweep frequency";
  parameter SI.Time startTime=0 "Start time of frequency sweep";
  parameter SI.Time duration(start=1) "Duration of frequency sweep";
  parameter SI.Current I[m](start=fill(1,m)) "RMS current of the source";
  parameter SI.Angle phi[m]=-Modelica.Electrical.Polyphase.Functions.symmetricOrientation(m) "Phase shift of the source";
  SI.Frequency f=currentSource.f   "Actual frequency";
  VariableCurrentSource currentSource(final m=m) annotation (Placement(transformation(extent={{-10,10},{10,-10}})));
  Modelica.Blocks.Sources.LogFrequencySweep logFrequencySweep(
    final wMin=fStart,
    final wMax=fStop,
    final startTime=startTime,
    final duration=duration) annotation (Placement(transformation(extent={{40,-60},{20,-40}})));
  Modelica.ComplexBlocks.Sources.ComplexConstant const[m](final k=
        Modelica.ComplexMath.fromPolar(len=I, phi=phi))
    annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));
equation
  connect(logFrequencySweep.y,currentSource. f) annotation (Line(points={{19,-50},{6,-50},{6,-12}},   color={0,0,127}));
  connect(plug_p,currentSource. plug_p) annotation (Line(points={{-100,0},{-10,0}}, color={85,170,255}));
  connect(currentSource.plug_n, plug_n) annotation (Line(points={{10,0},{100,0}}, color={85,170,255}));
  connect(currentSource.I, const.y) annotation (Line(points={{-6.2,-12},{-6,-12},{-6,-50},{-39,-50}}, color={85,170,255}));
  annotation (defaultComponentName="currentSource",Icon(graphics={
        Ellipse(
          extent={{-50,50},{50,-50}},
          lineColor={85,170,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-90,0},{-50,0}}, color={85,170,255}),
        Line(points={{50,0},{90,0}}, color={85,170,255}),
        Line(points={{0,-50},{0,50}}, color={85,170,255}),
        Text(
          extent={{150,60},{-150,100}},
          textString="%name",
          textColor={0,0,255}),
        Line(
          points={{-44,0},{-32,14},{-20,32},{-12,42},{-6,30},{0,0},{4,-28},{8,-40},{12,-20},{14,2},{16,30},{18,42},{20,28},{24,-32},{26,-40},{28,0}},
          color={192,192,192},
          smooth=Smooth.Bezier),
        Polygon(
          points={{90,0},{60,10},{60,-10},{90,0}},
          lineColor={85,170,255},
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{160,-100},{-160,-60}},
          textString="m=%m")}),
    Documentation(info="<html>
<p>This source provides polyphase constant RMS phase currents <code>I</code> and phase angles <code>phi</code>,
whereas the frequency sweeps from
<code>fStart</code> to <code>fStop</code> with <code>duration</code>. The frequency sweeps such
way that on a logarithmic frequency scale, the frequency curve appears linear.</p>

<div><img src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStatic/SinglePhase/Sources/FrequencySweepSource.png\"
     alt=\"FrequencySweepSource.png\"></div>

</html>"));
end FrequencySweepCurrentSource;
