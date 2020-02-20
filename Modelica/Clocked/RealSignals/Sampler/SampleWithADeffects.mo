within Modelica.Clocked.RealSignals.Sampler;
block SampleWithADeffects
  "Sample with (simulated) Analog-Digital converter effects including noise"
  extends Clocked.RealSignals.Interfaces.PartialSISOSampler;

  parameter Boolean noisy = false
    "= true, if output should be superimposed with noise"
    annotation(Evaluate=true,choices(checkBox=true),Dialog(group="Sampling and noise"));

  parameter Boolean limited = false "= true, if output is limited"
    annotation(Evaluate=true,choices(checkBox=true),Dialog(group="Limiting and quantization"));
  parameter Boolean quantized = false
    "= true, if output quantization effects included"
    annotation(Evaluate=true,choices(checkBox=true),Dialog(enable=limited,group="Limiting and quantization"));
  parameter Real yMax=1 "Upper limit of output (if limited = true)" annotation(Dialog(enable=limited,group="Limiting and quantization"));
  parameter Real yMin=-yMax "Lower limit of output (if limited = true)" annotation(Dialog(enable=limited,group="Limiting and quantization"));
  parameter Integer bits(min=1)=8
    "Number of bits of quantization (if quantized = true)" annotation(Dialog(enable=limited and quantized,group="Limiting and quantization"));

  Sample sample1
    annotation (Placement(transformation(extent={{-84,-6},{-72,6}})));

  replaceable Clocked.RealSignals.Sampler.Utilities.Internal.UniformNoise noise if noisy
    constrainedby Clocked.RealSignals.Interfaces.PartialNoise "Noise model"
    annotation (
    choicesAllMatching=true,
    Dialog(enable=noisy, group="Sampling and noise"),
    Placement(transformation(extent={{-54,-6},{-42,6}})));
  Clocked.RealSignals.Sampler.Utilities.Internal.Limiter limiter(uMax=yMax,
      uMin=yMin) if limited
    annotation (Placement(transformation(extent={{-24,-8},{-8,8}})));
  Clocked.RealSignals.Sampler.Utilities.Internal.Quantization quantization(
    quantized=quantized,
    yMax=yMax,
    yMin=yMin,
    bits=bits) if quantized and limited
    annotation (Placement(transformation(extent={{14,-8},{30,8}})));
protected
  Modelica.Blocks.Interfaces.RealInput uFeedthrough1 if not noisy
    annotation (Placement(transformation(extent={{-58,12},{-42,28}})));
  Modelica.Blocks.Interfaces.RealInput uFeedthrough2 if not limited
    annotation (Placement(transformation(extent={{-26,12},{-10,28}})));
  Modelica.Blocks.Interfaces.RealInput uFeedthrough3 if not quantized or not limited
    annotation (Placement(transformation(extent={{12,12},{28,28}})));
  Modelica.Blocks.Interfaces.RealOutput y1
    "Connector with a Real output signal"
    annotation (Placement(transformation(extent={{-61,-1},{-59,1}})));
  Modelica.Blocks.Interfaces.RealOutput y2
    annotation (Placement(transformation(extent={{-35,-1},{-33,1}})));
  Modelica.Blocks.Interfaces.RealOutput y3
    annotation (Placement(transformation(extent={{3,-1},{5,1}})));
  Modelica.Blocks.Interfaces.RealOutput y4
    annotation (Placement(transformation(extent={{41,-1},{43,1}})));

equation
  connect(uFeedthrough1, y1) annotation (Line(
      points={{-50,20},{-58,20},{-58,0},{-60,0}},
      color={0,0,127}));
  connect(y1, noise.u) annotation (Line(
      points={{-60,0},{-55.2,0}},
      color={0,0,127}));
  connect(noise.y, y2) annotation (Line(
      points={{-41.4,0},{-34,0}},
      color={0,0,127}));
  connect(y2, limiter.u) annotation (Line(
      points={{-34,0},{-25.6,0}},
      color={0,0,127}));
  connect(uFeedthrough1, y2) annotation (Line(
      points={{-50,20},{-38,20},{-38,0},{-34,0}},
      color={0,0,127}));
  connect(y2, uFeedthrough2) annotation (Line(
      points={{-34,0},{-30,0},{-30,20},{-18,20}},
      color={0,0,127}));
  connect(limiter.y, y3) annotation (Line(
      points={{-7.2,0},{4,0}},
      color={0,0,127}));
  connect(y3, quantization.u) annotation (Line(
      points={{4,0},{12.4,0}},
      color={0,0,127}));
  connect(y3, uFeedthrough3) annotation (Line(
      points={{4,0},{8,0},{8,20},{20,20}},
      color={0,0,127}));
  connect(quantization.y, y4) annotation (Line(
      points={{30.8,0},{42,0}},
      color={0,0,127}));
  connect(uFeedthrough3, y4) annotation (Line(
      points={{20,20},{38,20},{38,0},{42,0}},
      color={0,0,127}));
  connect(uFeedthrough2, y3) annotation (Line(
      points={{-18,20},{0,20},{0,0},{4,0}},
      color={0,0,127}));

  connect(sample1.y, y1) annotation (Line(
      points={{-71.4,0},{-60,0}},
      color={0,0,127}));

  connect(u, sample1.u) annotation (Line(
      points={{-120,0},{-85.2,0}},
      color={0,0,127}));
  connect(y4, y) annotation (Line(
      points={{42,0},{110,0}},
      color={0,0,127}));
  annotation (
   defaultComponentName="sample1",
   Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        initialScale=0.06),
                     graphics={
        Polygon(
          points={{0,-22},{-6,-38},{6,-38},{0,-22}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{0,-100},{0,-38}},color={192,192,192}),
        Line(points={{-40,-72},{40,-72}}, color={192,192,192}),
        Polygon(
          points={{0,8},{-6,-8},{6,-8},{0,8}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid,
          origin={48,-72},
          rotation=-90),
        Line(
          points={{-30,-92},{-10,-92},{-10,-72},{10,-72},{10,-52},{30,-52}},
          color={0,0,127}),
        Text(
          extent={{-150,90},{150,50}},
          textString="%name",
          textColor={0,0,255})}),
    Documentation(info="<html>
<p>
This block is similar to the
<a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.Sample\">Sample</a>
block. The only difference is that after the sampling of the input signal,
simulated real-world effects are applied on the sampled signal. In particular:
</p>

<ul>
<li> The output is limited, if parameter <strong>limited</strong> = true.</li>
<li> The output is value discretized in the form of an Analog-Digital converter
     with a definable number of bits,
     if parameters <strong>limited</strong> = true, and <strong>quantized</strong> = true.</li>
<li> Noise is added to the output if
     parameter <strong>noisy</strong> = true.
     A pseudo random number generator is used to generate uniformly distributed
     random numbers in a given band.</li>
</ul>

<h4>Example</h4>

<p>
The following
<a href=\"modelica://Modelica.Clocked.Examples.Elementary.RealSignals.SampleWithADeffects\">example</a>
samples a sine signal with a periodic clock of 20 ms period, and adds the following effects:
</p>
<ul>
<li> Limits the output to +/- 0.8.</li>
<li> Discretizes the output with an 8 bit AD converter.</li>
<li> Adds large uniform noise with a band of +/- 0.2.</li>
</ul>
<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/SampleWithADeffects_Model.png\" alt=\"SampleWithADeffects_Model.png\"></td>
    <td valign=\"bottom\">&nbsp;&nbsp;&nbsp;
                        <img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/SampleWithADeffects_Result.png\" alt=\"SampleWithADeffects_Result.png\"></td>
    </tr>
<tr><td></td>
    <td align=\"center\">model</td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>

<p>
<br>The output y is quite far away from the continuous-time input signal,
    due to the strong discretization and large noise applied to the
    sampled input.
</p>
</html>"));
end SampleWithADeffects;
