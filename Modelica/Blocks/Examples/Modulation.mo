within Modelica.Blocks.Examples;
model Modulation "Demonstrate amplitude modulation an frequency modulation"
  extends Modelica.Icons.Example;
  Modelica.Blocks.Sources.SineVariableFrequencyAndAmplitude sine(
    useConstantAmplitude=true,
    useConstantFrequency=true,
    constantFrequency=100,
    phi(fixed=true))
    annotation (Placement(transformation(extent={{-10,60},{10,80}})));
  Modelica.Blocks.Sources.Sine amplitude(
    amplitude=0.5,
    f=2,
    offset=1)
    annotation (Placement(transformation(extent={{-52,20},{-32,40}})));
  Modelica.Blocks.Sources.SineVariableFrequencyAndAmplitude sinAM(
    useConstantAmplitude=false,
    useConstantFrequency=true,
    constantFrequency=100,
    phi(fixed=true))
    annotation (Placement(transformation(extent={{-10,20},{10,40}})));
  Sources.CosineVariableFrequencyAndAmplitude cosAM(
    useConstantAmplitude=false,
    useConstantFrequency=true,
    constantFrequency=100,
    phi(fixed=true))
    annotation (Placement(transformation(extent={{-10,-12},{10,8}})));
  Modelica.Blocks.Sources.Sine frequency(
    amplitude=50,
    f=2,
    offset=100)
    annotation (Placement(transformation(extent={{-50,-50},{-30,-30}})));
  Modelica.Blocks.Sources.SineVariableFrequencyAndAmplitude sinFM(
    useConstantAmplitude=true,
    useConstantFrequency=false,
    constantFrequency=100,
    phi(fixed=true))
    annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
  Sources.CosineVariableFrequencyAndAmplitude cosFM(
    useConstantAmplitude=true,
    useConstantFrequency=false,
    constantFrequency=100,
    phi(fixed=true))
    annotation (Placement(transformation(extent={{-10,-80},{10,-60}})));
equation
  connect(amplitude.y, sinAM.amplitude) annotation (Line(points={{-31,30},{-20,30},
          {-20,36},{-12,36}}, color={0,0,127}));
  connect(frequency.y, sinFM.f) annotation (Line(points={{-29,-40},{-20,-40},{-20,
          -46},{-12,-46}}, color={0,0,127}));
  connect(amplitude.y, cosAM.amplitude) annotation (Line(points={{-31,30},{-20,30},
          {-20,4},{-12,4}}, color={0,0,127}));
  connect(frequency.y, cosFM.f) annotation (Line(points={{-29,-40},{-20,-40},{-20,
          -76},{-12,-76}}, color={0,0,127}));
  annotation (experiment(StopTime=1.0, Interval=0.0001), Documentation(info="<html>
<p>
This example demonstrates amplitude modulation (AM) and frequency modulation (FM).
</p>
</html>"));
end Modulation;
