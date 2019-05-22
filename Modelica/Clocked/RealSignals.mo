within Modelica.Clocked;
package RealSignals "Library of clocked blocks for Real signals"
  extends Modelica.Icons.Package;
  package Sampler "Library of sampler and hold blocks for Real signals"
    block Sample
      "Sample the continuous-time, Real input signal and provide it as clocked output signal (clock is inferred)"
      extends Clocked.RealSignals.Interfaces.PartialSISOSampler;

    equation
      y = sample(u);

      annotation (
       defaultComponentName="sample1",
       Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={2,2},
            initialScale=0.06),
                         graphics={
            Text(
              extent={{-200,50},{200,115}},
              lineColor={0,0,255},
              textString="%name")}),
        Diagram(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={2,2},
            initialScale=0.06)),
        Documentation(info="<html>
<p>
This block samples the continuous-time, Real input signal u and provides it as
clocked output signal y. The clock of the output signal is inferred
(that is, it needs to be defined somewhere else in the clocked partition).
If this is not desired, use block
<a href=\"modelica://Modelica_Synchronous.RealSignals.Sampler.SampleClocked\">SampleClocked</a>
instead, to explicitly assign a clock to the output signal.
</p>

<p>
To be more precise: The input signal u(t) must be a continuous-time signal.
The output signal y(ti) is associated to a clock (defined somewhere else).
At a clock tick, the left limit of u is assigned to y:
<code>y(ti) = u(ti-eps)</code> (= the value of u just before the clock
became active). Since the operator returns the left limit of u, it introduces an
infinitesimal small delay between the continuous-time and the clocked partition.
This corresponds to the reality, where a sampled data system cannot act infinitely
fast and even for a very idealized simulation, an infinitesimal small delay is present.
As a result, algebraic loops between clocked and continuous-time partitions cannot
occur.
</p>

<h4>Examples</h4>

<p>
The following
<a href=\"Modelica_Synchronous.Examples.Elementary.RealSignals.Sample1\">example</a>
samples a sine signal with a periodic clock of 20 ms period:<br>
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Synchronous/Resources/Images/RealSignals/Sample1_Model.png\"></td>
    <td valign=\"bottom\">&nbsp;&nbsp;&nbsp;
                        <img src=\"modelica://Modelica_Synchronous/Resources/Images/RealSignals/Sample1_Result.png\"></td>
    </tr>
<tr><td></td>
    <td align=\"center\">model</td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>

<p>
<br>In the following
<a href=\"Modelica_Synchronous.Examples.Elementary.RealSignals.Sample2\">example</a>
the continuous-time input signal contains a discontinuous value change at the 0.1 s
clock tick. It can be seen that the Sample block samples the left limit of the
step signal:<br>
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Synchronous/Resources/Images/RealSignals/Sample2_Model.png\"></td>
    <td valign=\"bottom\">&nbsp;&nbsp;&nbsp;
                        <img src=\"modelica://Modelica_Synchronous/Resources/Images/RealSignals/Sample2_Result.png\"></td>
    </tr>
<tr><td></td>
    <td align=\"center\">model</td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>

<p>
<br>In the following
<a href=\"Modelica_Synchronous.Examples.Elementary.RealSignals.Sample3\">example</a>
a direct feedthrough in the continuous-time and in the clocked partition is present.
Without a time-delay, this would result in an algebraic loop. However, since block
Sample samples the left limit of a continuous-time signal, sampling introduces a
delay of one sample period that breaks the algebraic loop:
<br>
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Synchronous/Resources/Images/RealSignals/Sample3_Model.png\"></td>
    </tr>
<tr><td></td>
    <td align=\"center\">model<br></td>
   </tr>
<tr><td></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Synchronous/Resources/Images/RealSignals/Sample3_Result.png\"></td>
    </tr>
<tr><td></td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>

<p>
Note, the reason for the delay is that sample2.y (= the green, clocked signal)
is the left limit of hold.y (= the red, continuous-time signal).
</p>
</html>"));
    end Sample;
    extends Modelica.Icons.Package;

    block SampleClocked
      "Sample the continuous-time, Real input signal and provide it as clocked output signal. The clock is provided as input signal"
      extends Clocked.RealSignals.Interfaces.SamplerIcon;
      Modelica.Blocks.Interfaces.RealInput u
        "Connector of continuous-time, Real input signal"
        annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
      Modelica.Blocks.Interfaces.RealOutput y
        "Connector of clocked, Real output signal"
        annotation (Placement(transformation(extent={{100,-10},{120,10}})));
      Clocked.ClockSignals.Interfaces.ClockInput clock
        "Output signal y is associated with this clock input" annotation (
          Placement(transformation(
            extent={{-20,-20},{20,20}},
            rotation=90,
            origin={0,-120})));

    equation
      y = sample(u,clock);

      annotation (
       defaultComponentName="sample1",
       Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={2,2},
            initialScale=0.06),
                         graphics={
            Line(
              points={{0,-100},{0,18}},
              color={175,175,175},
              pattern=LinePattern.Dot,
              thickness=0.5),
            Text(
              extent={{-200,50},{200,115}},
              lineColor={0,0,255},
              textString="%name")}),
        Diagram(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={2,2},
            initialScale=0.06)),
        Documentation(info="<html>
This block is similar to the
<a href=\"modelica://Modelica_Synchronous.RealSignals.Sampler.Sample\">Sample</a>
block. The only difference is that a clock signal is provided via a second
input and the output is associated to this clock.
</p>

<p>
Note, it does not make much sense to vectorize this block, because then
also the clock input is vectorized. Instead, if the input signal is a vector, use block
<a href=\"modelica://Modelica_Synchronous.RealSignals.Sampler.SampleVectorizedAndClocked\">SampleVectorizedAndClocked</a>
that has a <b>vector</b> Real input and output, as well as a <b>scalar</b> clock input.
</p>

<h4>Example</h4>

<p>
The following
<a href=\"Modelica_Synchronous.Examples.Elementary.RealSignals.SampleClocked\">example</a>
samples a sine signal with a periodic clock of 20 ms period:<br>
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Synchronous/Resources/Images/RealSignals/SampleClocked_Model.png\"></td>
    <td valign=\"bottom\">&nbsp;&nbsp;&nbsp;
                        <img src=\"modelica://Modelica_Synchronous/Resources/Images/RealSignals/SampleClocked_Result.png\"></td>
    </tr>
<tr><td></td>
    <td align=\"center\">model</td>
    <td align=\"center\">simulation result<br></td>
   </tr>
</table>
</html>"));
    end SampleClocked;

    block SampleVectorizedAndClocked
      "Sample the continuous-time, Real input signal vector and provide it as clocked output signal vector. The clock is provided as input signal"
      extends Clocked.RealSignals.Interfaces.SamplerIcon;
      parameter Integer n(min=1)=1
        "Size of input signal vector u (= size of output signal vector y)";
      Modelica.Blocks.Interfaces.RealInput u[n]
        "Connector of continuous-time, Real input signal vector"
        annotation (Placement(transformation(extent={{-140,-20},{-100,20}}), iconTransformation(extent={{-140,-20},{-100,20}})));
      Modelica.Blocks.Interfaces.RealOutput y[n]
        "Connector of clocked, Real output signal vector"
        annotation (Placement(transformation(extent={{100,-10},{120,10}})));
       Clocked.ClockSignals.Interfaces.ClockInput clock
        "Output signal vector y is associated with this clock input"
        annotation (Placement(transformation(
            extent={{-20,-20},{20,20}},
            rotation=90,
            origin={0,-120})));
    equation
      y = sample(u,clock);

      annotation (
       defaultComponentName="sample1",
       Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={2,2},
            initialScale=0.06),
                         graphics={
            Line(
              points={{0,-100},{0,18}},
              color={175,175,175},
              pattern=LinePattern.Dot,
              thickness=0.5),
            Text(
              extent={{-200,50},{200,115}},
              lineColor={0,0,255},
              textString="%name"),
            Text(
              extent={{-160,-30},{20,-80}},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              textString="n=%n")}),
        Diagram(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={2,2},
            initialScale=0.06)),
        Documentation(info="<html>
<p>
This block is similar to the
<a href=\"modelica://Modelica_Synchronous.RealSignals.Sampler.SampleClocked\">SampleClocked</a>
block. The only difference is that the continuous-time input signal is a vector: All input
signals are sampled and are associated with the
scalar clock signal provided via the second input.
</p>

<h4>Example</h4>

<p>
The following
<a href=\"Modelica_Synchronous.Examples.Elementary.RealSignals.SampleVectorizedAndClocked\">example</a>
has a vector as input, consisting of two different sine signals. These
signals are sampled with a periodic clock of 20 ms period:<br>
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Synchronous/Resources/Images/RealSignals/SampleVectorizedAndClocked_Model.png\"></td>
    <td valign=\"bottom\">&nbsp;&nbsp;&nbsp;
                        <img src=\"modelica://Modelica_Synchronous/Resources/Images/RealSignals/SampleVectorizedAndClocked_Result.png\"></td>
    </tr>
<tr><td></td>
    <td align=\"center\">model</td>
    <td align=\"center\">simulation result<br></td>
   </tr>
</table>
</html>"));
    end SampleVectorizedAndClocked;

    block SampleWithADeffects
      "Sample with (simulated) Analog-Digital converter effects including noise"
      extends Clocked.RealSignals.Interfaces.PartialSISOSampler;

      parameter Boolean noisy = false
        "= true, if output should be superimposed with noise"
        annotation(Evaluate=true,choices(checkBox=true),Dialog(enable=sampled,group="Sampling and noise"));

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
            grid={2,2},
            initialScale=0.06),
                         graphics={
            Polygon(
              points={{0,-22},{-6,-38},{6,-38},{0,-22}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Line(points={{0,-112},{0,-38}},color={192,192,192}),
            Line(points={{-62,-72},{66,-72}}, color={192,192,192}),
            Polygon(
              points={{0,8},{-6,-8},{6,-8},{0,8}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid,
              origin={74,-72},
              rotation=-90),
            Line(
              points={{-50,-112},{-30,-112},{-30,-92},{-10,-92},{-10,-72},{10,-72},{
                  10,-52},{30,-52},{30,-32},{50,-32}},
              color={0,0,127}),
            Text(
              extent={{-200,40},{200,100}},
              lineColor={0,0,255},
              textString="%name")}),
        Diagram(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={2,2},
            initialScale=0.06)),
        Documentation(info="<html>
This block is similar to the
<a href=\"modelica://Modelica_Synchronous.RealSignals.Sampler.Sample\">Sample</a>
block. The only difference is that after the sampling of the input signal,
simulated real-world effects are applied on the sampled signal. In particular:
</p>

<ul>
<li> The output is limited, if parameter <b>limited</b> = true.</li>
<li> The output is value discretized in the form of an Analog-Digital converter
     with a defineable number of bits,
     if parameters <b>limited</b> = true, and <b>quantized</b> = true.</li>
<li> Noise is added to the output if
     parameter <b>noisy</b> = true.
     A pseudo random number generator is used to generate uniformly distributed
     random numbers in a given band.</li>
</ul>

<h4>Example</h4>

<p>
The following
<a href=\"Modelica_Synchronous.Examples.Elementary.RealSignals.SampleWithADeffects\">example</a>
samples a sine signal with a periodic clock of 20 ms period, and adds the following effects:
</p>
<ul>
<li> Limits the output to +/- 0.8.</li>
<li> Discretizes the output with an 8 bit AD converter.</li>
<li> Adds large uniform noise with a band of +/- 0.2.</li>
</ul>
<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Synchronous/Resources/Images/RealSignals/SampleWithADeffects_Model.png\"></td>
    <td valign=\"bottom\">&nbsp;&nbsp;&nbsp;
                        <img src=\"modelica://Modelica_Synchronous/Resources/Images/RealSignals/SampleWithADeffects_Result.png\"></td>
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

    block Hold
      "Hold the clocked, Real input signal and provide it as continuous-time output signal (zero order hold)"
    extends Clocked.RealSignals.Interfaces.PartialSISOHold;

    equation
        y = hold(u);

      annotation (
        defaultComponentName="hold1",
        Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={2,2},
            initialScale=0.06),
                         graphics={
            Ellipse(
              extent={{-70,-30},{-50,-50}},
              lineColor={0,0,127},
              fillColor={0,0,127},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-30,28},{-10,8}},
              lineColor={0,0,127},
              fillColor={0,0,127},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{10,70},{30,50}},
              lineColor={0,0,127},
              fillColor={0,0,127},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{50,10},{70,-10}},
              lineColor={0,0,127},
              fillColor={0,0,127},
              fillPattern=FillPattern.Solid)}),
        Documentation(info="<html>
<p>
This block holds the clocked Real input signal u with a zero order hold
and provides it as continuous-time output signal y.
The clock of the input signal is inferred
(that is, it needs to be defined somewhere else in the clocked partition).
</p>

<p>
To be more precise: The input signal u(ti) must be a clocked signal.
The output signal y(t) is a piecewise constant continuous-time signal.
When the clock of u ticks at time ti, the block output y(ti) = u(ti). Otherwise y(t), t &ge;ti, is the value of
u(ti) from the last clock activation at time ti. Before the first clock activation of u,
the block outputs the value of parameter <b>y_start</b>. The value of
this parameter is displayed below the icon.
</p>

<h4>Example</h4>

<p>
The following
<a href=\"modelica://Modelica_Synchronous.Examples.Elementary.RealSignals.Hold\">example</a>
samples a sine signal with a periodic clock of 20 ms period and delays it for 2 sample periods.
The resulting signal is hold with the Hold block. As a result, the clock of hold.u starts
ticking at 40 ms. The output hold.y of the block is a continuous-time signal that is present
from the start of the simulation. Before the first tick of the clock of hold.u, it is set
to -1.0 (= the value of parameter hold.y_start).<br>
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Synchronous/Resources/Images/RealSignals/Hold_Model.png\"></td>
    <td valign=\"bottom\">&nbsp;&nbsp;&nbsp;
                        <img src=\"modelica://Modelica_Synchronous/Resources/Images/RealSignals/Hold_Result.png\"></td>
    </tr>
<tr><td></td>
    <td align=\"center\">model</td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>
&nbsp;
</html>"),
        Diagram(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            initialScale=0.06)));
    end Hold;

    block HoldWithDAeffects
      "Hold with (simulated) Digital-Analog converter effects and computational delay"
      extends Clocked.RealSignals.Interfaces.PartialSISOHold;

      parameter Boolean computationalDelay = false
        "=true, if a computational delay should be imposed"
        annotation(Evaluate=true, choices(checkBox=true), Dialog(group="Computational delay in seconds = interval() * shiftCounter/resolution"));
      parameter Integer shiftCounter(min=0,max=resolution) = 0
        "(min=0, max=resolution), computational delay = interval()*shiftCounter/resolution"
        annotation(Dialog(enable=computationalDelay, group="Computational delay in seconds = interval() * shiftCounter/resolution"));
      parameter Integer resolution(min=1) = 1
        "Time quantization resolution of sample interval" annotation(Dialog(enable=computationalDelay, group="Computational delay in seconds = interval() * shiftCounter/resolution"));

      parameter Boolean limited = false "= true, if output is limited"
         annotation(Evaluate=true,choices(checkBox=true),Dialog(group="Limiting and quantization"));
      parameter Boolean quantized = false
        "= true, if output quantization effects included"
        annotation(Evaluate=true,choices(checkBox=true),Dialog(enable=limited,group="Limiting and quantization"));
      parameter Real yMax=1 "Upper limit of output (if limited = true)" annotation(Dialog(enable=limited,group="Limiting and quantization"));
      parameter Real yMin=-yMax "Lower limit of output (if limited = true)" annotation(Dialog(enable=limited,group="Limiting and quantization"));
      parameter Integer bits(min=1)=8
        "Number of bits of quantization (if quantized = true)" annotation(Dialog(enable=limited and quantized,group="Limiting and quantization"));

      Clocked.RealSignals.Sampler.Utilities.Internal.Limiter limiter(uMax=yMax,
          uMin=yMin) if limited
        annotation (Placement(transformation(extent={{-56,-8},{-40,8}})));
      Clocked.RealSignals.Sampler.Utilities.Internal.Quantization quantization(
        quantized=quantized,
        yMax=yMax,
        yMin=yMin,
        bits=bits) if quantized and limited
        annotation (Placement(transformation(extent={{-18,-8},{-2,8}})));
      Clocked.RealSignals.Sampler.Utilities.Internal.ComputationalDelay compDelay(
          shiftCounter=shiftCounter, resolution=resolution) if
        computationalDelay
        annotation (Placement(transformation(extent={{20,-8},{36,8}})));
      Hold hold1(y_start=y_start)
                 annotation (Placement(transformation(extent={{78,-6},{90,6}})));
    protected
      Modelica.Blocks.Interfaces.RealInput uFeedthrough2 if not limited
        annotation (Placement(transformation(extent={{-58,12},{-42,28}})));
      Modelica.Blocks.Interfaces.RealInput uFeedthrough3 if not quantized or not limited
        annotation (Placement(transformation(extent={{-20,12},{-4,28}})));
      Modelica.Blocks.Interfaces.RealInput uFeedthrough4 if not computationalDelay
        annotation (Placement(transformation(extent={{18,12},{34,28}})));
      Modelica.Blocks.Interfaces.RealOutput y2
        annotation (Placement(transformation(extent={{-67,-1},{-65,1}})));
      Modelica.Blocks.Interfaces.RealOutput y3
        annotation (Placement(transformation(extent={{-29,-1},{-27,1}})));
      Modelica.Blocks.Interfaces.RealOutput y4
        annotation (Placement(transformation(extent={{9,-1},{11,1}})));
      Modelica.Blocks.Interfaces.RealOutput y5
        annotation (Placement(transformation(extent={{63,-1},{65,1}})));
    equation
      connect(y2, limiter.u) annotation (Line(
          points={{-66,0},{-57.6,0}},
          color={0,0,127}));
      connect(y2, uFeedthrough2) annotation (Line(
          points={{-66,0},{-62,0},{-62,20},{-50,20}},
          color={0,0,127}));
      connect(limiter.y, y3) annotation (Line(
          points={{-39.2,0},{-28,0}},
          color={0,0,127}));
      connect(y3, quantization.u) annotation (Line(
          points={{-28,0},{-19.6,0}},
          color={0,0,127}));
      connect(y3, uFeedthrough3) annotation (Line(
          points={{-28,0},{-24,0},{-24,20},{-12,20}},
          color={0,0,127}));
      connect(quantization.y, y4) annotation (Line(
          points={{-1.2,0},{10,0}},
          color={0,0,127}));
      connect(y4, compDelay.u) annotation (Line(
          points={{10,0},{18.4,0}},
          color={0,0,127}));
      connect(uFeedthrough3, y4) annotation (Line(
          points={{-12,20},{6,20},{6,0},{10,0}},
          color={0,0,127}));
      connect(y4, uFeedthrough4) annotation (Line(
          points={{10,0},{14,0},{14,20},{26,20}},
          color={0,0,127}));
      connect(uFeedthrough2, y3) annotation (Line(
          points={{-50,20},{-32,20},{-32,0},{-28,0}},
          color={0,0,127}));

      connect(y5, compDelay.y) annotation (Line(
          points={{64,0},{36.8,0}},
          color={0,0,127}));
      connect(y5, uFeedthrough4) annotation (Line(
          points={{64,0},{46,0},{46,20},{26,20}},
          color={0,0,127}));

      connect(y5, hold1.u) annotation (Line(
          points={{64,0},{76.8,0}},
          color={0,0,127}));
      connect(u, y2) annotation (Line(
          points={{-120,0},{-66,0}},
          color={0,0,127}));
      connect(hold1.y, y) annotation (Line(
          points={{90.6,0},{110,0}},
          color={0,0,127}));
      annotation (
        defaultComponentName="hold1",
        Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={2,2},
            initialScale=0.06),
                         graphics={
            Ellipse(
              extent={{-88,-30},{-68,-50}},
              lineColor={0,0,127},
              fillColor={0,0,127},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-48,30},{-28,10}},
              lineColor={0,0,127},
              fillColor={0,0,127},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-8,70},{12,50}},
              lineColor={0,0,127},
              fillColor={0,0,127},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{32,10},{52,-10}},
              lineColor={0,0,127},
              fillColor={0,0,127},
              fillPattern=FillPattern.Solid),
            Text(visible=computationalDelay,
              extent={{-200,-146},{200,-211}},
              textString="%shiftCounter/%resolution")}),
        Documentation(info="<html>
This block is similar to the
<a href=\"modelica://Modelica_Synchronous.RealSignals.Sampler.Hold\">Hold</a>
block. The only difference is that simulated real-world effects are applied on the
clocked input signal u before transforming the signal to a continuous-time signal
with a zero-order hold. In particular:
</p>

<ul>
<li> The output is delayed by a fraction of the clock period,
     if parameter <b>computationalDelay</b> = true.
     The delay is defined by shiftCounter/resolution*interval(),
     where <b>shiftCounter</b> and </b>resolution</b> are Integer parameters and
     interval() is the time duration from the previous to the current
     clock tick. The maximal possible computational delay is one clock
     duration, and therefore there is the restriction that
     shiftCounter &le; resolution.</li>
<li> The output is limited, if parameter <b>limited</b> = true.</li>
<li> The output is value discretized in the form of an Digital-Analog converter
     with a defineable number of bits,
     if parameters <b>limited</b> = true, and <b>quantized</b> = true.</li>
</ul>

<h4>Example</h4>

<p>
The following
<a href=\"Modelica_Synchronous.Examples.Elementary.RealSignals.HoldWithDAeffects1\">example</a>
samples a sine signal with an amplitude of 2.0 with a periodic clock of 20 ms period
and delays it for 2 sample periods.
The resulting signal is hold with the HoldWithDAeffects block. As a result, the clock of hold.u starts
ticking at 40 ms. The output hold.y of the block is a continuous-time signal that is present
from the start of the simulation. Before the first tick of the clock of hold.u, it is set
to 0.5 (= the value of parameter hold.y_start). Additionally,
the following effects are added to the hold block:</p>
<ul>
<li> The output is limited to +/- 1.9.</li>
<li> A computational delay of half of a sample period (= 1/2*20 ms = 10 ms)
     is defined.<br></li>
</ul>
<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Synchronous/Resources/Images/RealSignals/HoldWithDAeffects1_Model.png\"></td>
    <td valign=\"bottom\">&nbsp;&nbsp;&nbsp;
                        <img src=\"modelica://Modelica_Synchronous/Resources/Images/RealSignals/HoldWithDAeffects1_Result.png\"></td>
    </tr>
<tr><td></td>
    <td align=\"center\">model</td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>

<p>
<br>Due to the limitation of the output signal, the values of hold.u &ge; 1.9
    are limited to 1.9.
</p>

<p>
If the hold output is delayed by one sample period, then the <b>previous</b>(..) value of the
input is output, and the first tick is delayed by one sample period,
as shown by the
<a href=\"Modelica_Synchronous.Examples.Elementary.RealSignals.HoldWithDAeffects2\">modified example</a>
from above:<br>
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Synchronous/Resources/Images/RealSignals/HoldWithDAeffects2_Model.png\"></td>
    <td valign=\"bottom\">&nbsp;&nbsp;&nbsp;
                        <img src=\"modelica://Modelica_Synchronous/Resources/Images/RealSignals/HoldWithDAeffects2_Result.png\"></td>
    </tr>
<tr><td></td>
    <td align=\"center\">model</td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>
<p>
<br>Note, the computational delay of one sample period is defined
    by shiftCounter=1, resolution=1, as shown in the icon of the
    hold block.
</p>
</html>"),
        Diagram(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            initialScale=0.06)));
    end HoldWithDAeffects;

    block SubSample
      "Sub-sample the clocked Real input signal and provide it as clocked output signal"
      parameter Boolean inferFactor=true
        "= true, if sub-sampling factor is inferred"  annotation(Evaluate=true, choices(checkBox=true));
      parameter Integer factor(min=1)=1
        "Sub-sampling factor >= 1 (ignored if inferFactor=true)"
                                                                annotation(Evaluate=true, Dialog(enable=not inferFactor));

      Modelica.Blocks.Interfaces.RealInput u
        "Connector of clocked, Real input signal"
        annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
      Modelica.Blocks.Interfaces.RealOutput y
        "Connector of clocked, Real output signal (clock of y is slower as clock of u)"
        annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    equation
      if inferFactor then
         y = subSample(u);
      else
         y = subSample(u,factor);
      end if;

      annotation (
       defaultComponentName="subSample1",
       Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={2,2},
            initialScale=0.06),
            graphics={
            Rectangle(
              extent={{-94,82},{86,-96}},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None),
            Line(
              points={{-100,0},{-80,0},{-80,-60},{60,-60},{60,0},{100,0}},
              pattern=LinePattern.Dot,
              color={0,0,127}),                        Line(
              points={{-80,-60},{-80,0},{-100,0}},
              color={0,0,127},
              pattern=LinePattern.Dot),
            Text(
              extent={{-200,165},{200,100}},
              lineColor={0,0,255},
              textString="%name"),
            Text(visible=not inferFactor,
              extent={{-200,-85},{200,-150}},
              textString="%factor"),
            Ellipse(
              extent={{-95,-45},{-65,-75}},
              lineColor={0,0,127},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{45,15},{75,-15}},
              lineColor={0,0,127},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-46,-20},{-26,-40}},
              lineColor={0,0,127},
              fillColor={0,0,127},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{4,71},{24,51}},
              lineColor={0,0,127},
              fillColor={0,0,127},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-83,-57},{-77,-63}},
              lineColor={0,0,127},
              fillColor={0,0,127},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{57,3},{63,-3}},
              lineColor={0,0,127},
              fillColor={0,0,127},
              fillPattern=FillPattern.Solid),
            Line(
              points={{-36,-60},{-36,-30},{14,-30},{14,60},{60,60},{60,0}},
              color={215,215,215},
              pattern=LinePattern.Dot),
            Polygon(
              points={{25,0},{5,20},{5,10},{-25,10},{-25,-10},{5,-10},{5,-20},
                  {25,0}},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid,
              lineColor={95,95,95},
              origin={-51,26},
              rotation=-90)}),
        Diagram(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={2,2},
            initialScale=0.06)),
        Documentation(info="<html>
<p>
This block sub-samples the clocked Real input signal u and provides it as
clocked output signal y.
</p>

<p>
To be more precise:
The clock of y is factor-times slower than the clock of u. At every factor ticks of the clock of u, the output y returns the value of u. The first activation of the clock of y coincides with the first activation of the clock of u. By default, the sub-sampling factor is inferred,
that is, it must be defined somewhere else. If parameter <b>inferFactor</b> = false,
then the sub-sampling factor is defined by Integer parameter <b>factor</b>.
</p>

<h4>Example</h4>

<p>
The following
<a href=\"Modelica_Synchronous.Examples.Elementary.RealSignals.SubSample\">example</a>
samples a sine signal with a periodic clock of 20 ms period, and
then sub-samples the resulting clocked signal with a factor of 3:<br>
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Synchronous/Resources/Images/RealSignals/SubSample_Model.png\"></td>
    <td valign=\"bottom\">&nbsp;&nbsp;&nbsp;
                        <img src=\"modelica://Modelica_Synchronous/Resources/Images/RealSignals/SubSample_Result.png\"></td>
    </tr>
<tr><td></td>
    <td align=\"center\">model</td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>
<p>
As can be seen, subSample.y picks every third-value of sample.y due to the
sub-sampling, and the sub-sampling factor = 3 is displayed in the icon of the
subSample block. Note the down-arrow in the icon of the subSample block indicates that the
clock of subSample.y is slower as the clock of subSample.u.
</p>
</html>"));
    end SubSample;

    block SuperSample
      "Super-sample the clocked Real input signal and provide it as clocked output signal"
      parameter Boolean inferFactor=true
        "= true, if super-sampling factor is inferred"  annotation(Evaluate=true, choices(checkBox=true));
      parameter Integer factor(min=1)=1
        "Super-sampling factor >= 1 (ignored if inferFactor=true)"
                                                    annotation(Evaluate=true, Dialog(enable=not inferFactor));

      Modelica.Blocks.Interfaces.RealInput u
        "Connector of clocked, Real input signal"
        annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
      Modelica.Blocks.Interfaces.RealOutput y
        "Connector of clocked, Real output signal (clock of y is faster as clock of u)"
        annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    equation
      if inferFactor then
         y = superSample(u);
      else
         y = superSample(u,factor);
      end if;

      annotation (
       defaultComponentName="superSample1",
       Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={2,2},
            initialScale=0.06),
                         graphics={
            Rectangle(
              extent={{-88,86},{90,-72}},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None),
                                   Line(points={{-80,-60},{-40,-60},{-40,-60},
                  {0,-60},{0,-60},{0,-60},{0,80},{40,80},{40,80},{80,80},{80,
                  0},{80,0},{80,0},{100,0}},
                                     color={0,0,127},
              pattern=LinePattern.Dot),                Line(
              points={{-80,-60},{-80,0},{-100,0}},
              color={0,0,127},
              pattern=LinePattern.Dot),
            Text(
              extent={{-200,175},{200,110}},
              lineColor={0,0,255},
              textString="%name"),
            Text(visible=not inferFactor,
              extent={{-200,-85},{200,-150}},
              textString="%factor"),
            Ellipse(
              extent={{-95,-45},{-65,-75}},
              lineColor={0,0,127},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-83,-57},{-77,-63}},
              lineColor={0,0,127},
              fillColor={0,0,127},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-15,96},{15,66}},
              lineColor={0,0,127},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-3,83},{3,77}},
              lineColor={0,0,127},
              fillColor={0,0,127},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{65,16},{95,-14}},
              lineColor={0,0,127},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{77,3},{83,-3}},
              lineColor={0,0,127},
              fillColor={0,0,127},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-48,-46},{-18,-76}},
              lineColor={0,0,127},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{34,96},{64,66}},
              lineColor={0,0,127},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{25,0},{5,20},{5,10},{-25,10},{-25,-10},{5,-10},{5,-20},
                  {25,0}},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid,
              lineColor={95,95,95},
              origin={-49,26},
              rotation=90)}),
        Diagram(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={2,2},
            initialScale=0.06)),
        Documentation(info="<html>
<p>
This block super-samples the clocked Real input signal u and provides it as
clocked output signal y.
</p>

<p>
To be more precise:
The clock of y is factor-times faster than the clock of u. At every tick of the clock of y, the value of y is set to
the value of u from the last tick of the clock of u. The first activation of the clock of y coincides with the first activation of the clock of u. By default, the super-sampling factor is inferred,
that is, it must be defined somewhere else. If parameter <b>inferFactor</b> = false,
then the super-sampling factor is defined by Integer parameter <b>factor</b>.
</p>

<p>
For control applications this block introduces unnecessary \"vibrations\".
In such a case it is better to use block
<a href=\"Modelica_Synchronous.RealSignals.Sampler.SuperSampleInterpolated\">SuperSampleInterpolated</a>
instead.
</p>

<h4>Example</h4>

<p>
The following
<a href=\"Modelica_Synchronous.Examples.Elementary.RealSignals.SuperSample\">example</a>
samples a sine signal with a periodic clock of 20 ms period, and
then super-samples the resulting clocked signal with a factor of 3:<br>
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Synchronous/Resources/Images/RealSignals/SuperSample_Model.png\"></td>
    <td valign=\"bottom\">&nbsp;&nbsp;&nbsp;
                        <img src=\"modelica://Modelica_Synchronous/Resources/Images/RealSignals/SuperSample_Result.png\"></td>
    </tr>
<tr><td></td>
    <td align=\"center\">model</td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>
<p>
As can be seen, superSample introduces factor-1 additional clock ticks for the
output y. The super-sampling factor = 3 is displayed in the icon of the
superSample block. Note the up-arrow in the icon of the superSample block indicates that the
clock of superSample.y is faster as the clock of superSample.u.
</p>
</html>"));
    end SuperSample;

    block SuperSampleInterpolated
      "Super-sample the clocked Real input signal and provide it linearly interpolated as clocked output signal (this is also called an Interpolator)"

      parameter Boolean inferFactor=true
        "= true, if super-sampling factor is inferred"  annotation(Evaluate=true, choices(checkBox=true));
      parameter Integer factor(min=1)=1
        "Super-sampling factor >= 1 (if inferFactor=false)"
                                                    annotation(Evaluate=true, Dialog(enable=not inferFactor));
      Modelica.Blocks.Interfaces.RealInput u
        "Connector of clocked, Real input signal"
        annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
      Modelica.Blocks.Interfaces.RealOutput y
        "Connector of clocked, Real output signal"
        annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    protected
      Real uu(start=0.0);
      Real u_super;
      Real u_pre;
      Real u_preSuper;
      Integer usedFactor = if inferFactor then integer( (superSample(interval(u))/interval(u_super)) + 0.5) else factor;
      Integer ticks(start=0);
      Boolean first(start=true);
    equation
      when Clock() then  // clock of u
         uu = u;
         first = false;
         u_pre = if previous(first) then u else previous(uu);
      end when;

      when Clock() then  // clock of y
         if inferFactor then
            u_super = superSample(u);
         else
            u_super = superSample(u,factor);
         end if;
         u_preSuper = superSample(u_pre);
         ticks = if previous(ticks) < usedFactor then previous(ticks) + 1 else 1;
         y = u_preSuper + ticks/usedFactor*(u_super - u_preSuper);
      end when;

      annotation (
       defaultComponentName="superSampleIpo1",
       Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={2,2},
            initialScale=0.06),
                         graphics={
            Rectangle(
              extent={{-90,90},{92,-90}},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None),
            Line(
              points={{-100,0},{-40,0},{-40,-60},{16,-60},{16,0},{74,0},{74,80},{110,
                  80},{110,80},{110,80},{110,80},{120,80}},
              color={0,0,127},
              pattern=LinePattern.Dot),
            Text(
              extent={{-200,175},{200,110}},
              lineColor={0,0,255},
              textString="%name"),
            Text(visible=not inferFactor,
              extent={{-200,-85},{200,-150}},
              textString="%factor"),
            Ellipse(
              extent={{-55,-43},{-25,-73}},
              lineColor={0,0,127},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{59,94},{89,64}},
              lineColor={0,0,127},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-2,16},{28,-14}},
              lineColor={0,0,127},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-89,-51},{-71,-69}},
              lineColor={0,0,127},
              fillColor={0,0,127},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{7,88},{25,70}},
              lineColor={0,0,127},
              fillColor={0,0,127},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{25,0},{5,20},{5,10},{-25,10},{-25,-10},{5,-10},{5,-20},
                  {25,0}},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid,
              lineColor={95,95,95},
              origin={-61,46},
              rotation=90)}),
        Diagram(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={2,2},
            initialScale=0.06)),
        Documentation(info="<html>
<p>
This block super-samples the clocked Real input signal u and provides it
linearly interpolated between the u-values as
clocked output signal y.
</p>

<p>
To be more precise:
The clock of y is factor-times faster than the clock of u. At every tick of the clock of y, the value of y is set to
the value of the linearly interpolated value between the last available values of u.
The first activation of the clock of y coincides with the first activation of the clock of u.
By default, the super-sampling factor is inferred,
that is, it must be defined somewhere else. If parameter <b>inferFactor</b> = false,
then the super-sampling factor is defined by Integer parameter <b>factor</b>.
</p>

<p>
For control applications, this block is better suited as block
<a href=\"Modelica_Synchronous.RealSignals.Sampler.SuperSample\">SuperSample</a>
since it does not induce \"vibrations\".
</p>

<h4>Example</h4>

<p>
The following
<a href=\"Modelica_Synchronous.Examples.Elementary.RealSignals.SuperSampleInterpolated\">example</a>
samples a sine signal with a periodic clock of 20 ms period, and
then super-samples the resulting clocked signal with a factor of 3
and interpolates the result linearly:<br>
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Synchronous/Resources/Images/RealSignals/SuperSampleInterpolated_Model.png\"></td>
    <td valign=\"bottom\">&nbsp;&nbsp;&nbsp;
                        <img src=\"modelica://Modelica_Synchronous/Resources/Images/RealSignals/SuperSampleInterpolated_Result.png\"></td>
    </tr>
<tr><td></td>
    <td align=\"center\">model</td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>
<p>
As can be seen, block superSampleIpo introduces 3 additional clock ticks for the
output y and determines the values at these clock ticks, so that the last two available
values of the input u are linearly interpolated. The super-sampling factor = 3 is displayed in the icon of the
superSampleIpo block. Note the up-arrow in the icon of the SuperSampleInterpolation block indicates that the
clock of superSampleIpo.y is faster as the clock of superSampleIpo.u.
</p>
</html>"));
    end SuperSampleInterpolated;

    block ShiftSample
      "Shift the clocked Real input signal by a fraction of the last interval and and provide it as clocked output signal"

      parameter Integer shiftCounter(min=0)=0 "Numerator of shifting formula"
            annotation(Evaluate=true, Dialog(group="Shift first clock activation for 'shiftCounter/resolution*interval(u)' seconds"));
      parameter Integer resolution(min=1)=1 "Denominator of shifting formula"
            annotation(Evaluate=true, Dialog(group="Shift first clock activation for 'shiftCounter/resolution*interval(u)' seconds"));

      Modelica.Blocks.Interfaces.RealInput u
        "Connector of clocked, Real input signal"
        annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
      Modelica.Blocks.Interfaces.RealOutput y
        "Connector of clocked, Real output signal"
        annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    equation
         y = shiftSample(u,shiftCounter,resolution);
      annotation (
       defaultComponentName="shiftSample1",
       Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={2,2},
            initialScale=0.06),
                         graphics={
            Rectangle(
              extent={{-94,86},{84,-92}},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None),
                                   Line(points={{20,-50},{60,-50},{60,50}},
                                     color={0,0,127},
              pattern=LinePattern.Dot),
            Text(
              extent={{-200,175},{200,110}},
              lineColor={0,0,255},
              textString="%name"),
            Text(
              extent={{-200,-85},{200,-150}},
              textString="%shiftCounter/%resolution"),
                                   Line(points={{-80,-50},{-40,-50},{-40,50}},
                                     color={0,0,127},
              pattern=LinePattern.Dot),
            Ellipse(
              extent={{10,-40},{30,-60}},
              lineColor={0,0,127},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{50,60},{70,40}},
              lineColor={0,0,127},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{34,0},{14,20},{14,10},{-16,10},{-16,-10},{14,-10},{14,-20},{34,
                  0}},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid,
              lineColor={95,95,95}),
            Ellipse(
              extent={{-90,-40},{-70,-60}},
              lineColor={0,0,127},
              fillColor={0,0,127},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-50,60},{-30,40}},
              lineColor={0,0,127},
              fillColor={0,0,127},
              fillPattern=FillPattern.Solid)}),
        Diagram(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={2,2},
            initialScale=0.06)),
        Documentation(info="<html>
<p>
This block shifts the first activation of the clock of the output y by
fraction shiftCounter/resolution of the period (or for a non-periodic signal by a fraction of the last interval)
and the output y is set to the last available value of the input u.
Here, <b>shiftCounter</b> and <b>resolution</b> are positive Integer parameters.
</p>

<p>
To be more precise:
The block constructs (conceptually) a clock &ldquo;cBase&rdquo;
</p>

<pre>
   <b>Clock</b> cBase = <b>subSample</b>(<b>superSample</b>(u, resolution), shiftCounter)
</pre>

<p>
and the clock of y starts at the second clock tick of cBase. At every tick of the clock of y,
the operator returns the value of u from the last tick of the clock of u.
</p>

<p>
Note, for
<a href=\"Modelica_Synchronous.ClockSignals.Clocks.EventClock\">EventClock</a>s
there is the restriction that
block <b>ShiftSample</b> can only shift the number of ticks of the EventClock clock,
but cannot introduce new ticks, due to the restriction of operator <b>superSample</b> on
EventClocks.
</p>

<p>
Also note, that this block does not simply shift the signal in time,
since only the value of u from the last tick of the clock of u is used for the output.
If a time-delayed clock is desired, use instead block
<a href=\"modelica://Modelica_Synchronous.RealSignals.NonPeriodic.FractionalDelay\">NonPeriodic.FractionalDelay</a>
where the input signal is delayed by a time period and old values of u are stored in a buffer.
If the time delay is less than one period, the two blocks, ShiftSample and FractionalDelay,
give the same result.
</p>

<h4>Example</h4>

<p>
The following
<a href=\"Modelica_Synchronous.Examples.Elementary.RealSignals.ShiftSample\">example</a>
samples a sine signal with a periodic clock of 20 ms period, and
then shifts it with shiftCounter = 4 and resolution = 3:<br>
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Synchronous/Resources/Images/RealSignals/ShiftSample_Model.png\"></td>
    <td valign=\"bottom\">&nbsp;&nbsp;&nbsp;
                        <img src=\"modelica://Modelica_Synchronous/Resources/Images/RealSignals/ShiftSample_Result.png\"></td>
    </tr>
<tr><td></td>
    <td align=\"center\">model</td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>
<p>
The first activation of output y of block shiftSample1 is shifted in time (4/3*20ms). The parameter values <b>shiftCounter</b> = 4 and <b>resolution</b> = 3 are visible at the bottom of the icon. Also note, that the signal is not simply a shift in time. The output of a ShiftSample block will always be the value from the <i>last</i> tick of the clock of its inputs.
</p>

</html>"));
    end ShiftSample;

    block BackSample
      "Shift the clock of the Real input signal backwards in time (and access the most recent value of the input at this new clock)"
      parameter Integer backCounter(min=0)=0 "Numerator of shifting formula"
            annotation(Evaluate=true, Dialog(group="Shift first clock activation backwards in time for 'shiftCounter/resolution*interval(u)' seconds"));
      parameter Integer resolution(min=1)=1 "Denominator of shifting formula"
            annotation(Evaluate=true, Dialog(group="Shift first clock activation backwards in time for 'shiftCounter/resolution*interval(u)' seconds"));
      parameter Real y_start=0
        "Value of output y before the first clock tick of the input u";

      Modelica.Blocks.Interfaces.RealInput u(start=y_start)
        "Connector of clocked, Real input signal"
        annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
      Modelica.Blocks.Interfaces.RealOutput y
        "Connector of clocked, Real output signal (clock of y is faster als clock of u)"
        annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    equation
      y = backSample(u,backCounter,resolution);

      annotation (
       defaultComponentName="backSample1",
       Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={2,2},
            initialScale=0.06),
                         graphics={
            Rectangle(
              extent={{-90,84},{88,-94}},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None),
                                   Line(points={{20,-50},{60,-50},{60,50}},
                                     color={0,0,127},
              pattern=LinePattern.Dot),
            Text(
              extent={{-200,175},{200,110}},
              lineColor={0,0,255},
              textString="%name"),
            Text(
              extent={{-200,-135},{200,-200}},
              textString="%backCounter/%resolution"),
                                   Line(points={{-80,-50},{-40,-50},{-40,50}},
                                     color={0,0,127},
              pattern=LinePattern.Dot),
            Ellipse(
              extent={{-90,-40},{-70,-60}},
              lineColor={0,0,127},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-50,60},{-30,40}},
              lineColor={0,0,127},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-16,0},{4,20},{4,10},{34,10},{34,-10},{4,-10},{4,-20},{-16,0}},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid,
              lineColor={95,95,95}),
            Ellipse(
              extent={{10,-40},{30,-60}},
              lineColor={0,0,127},
              fillColor={0,0,127},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{50,60},{70,40}},
              lineColor={0,0,127},
              fillColor={0,0,127},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-200,-74},{200,-139}},
              textString="y_start=%y_start")}),
        Diagram(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={2,2},
            initialScale=0.06)),
        Documentation(info="<html>
<p>
This block shifts the first activation of the clock of the output y by
fraction backCounter/resolution of the period (or for a non-periodic signal by a fraction of the last interval)
before the first activation of the clock of u.
The output y is set to the last available value of the input u.
Here, <b>backCounter</b> and <b>resolution</b> are positive Integer parameters.
</p>

<p>
To be more precise:
The block constructs (conceptually) a clock &ldquo;cBase&rdquo;
</p>

<pre>
   <b>Clock</b> cBase = <b>subSample</b>(<b>superSample</b>(u, resolution), backCounter)
</pre>

<p>
and the first clock tick of y is shifted before the first tick of the clock of u,
such that this duration is identical to the duration
between the first and second clock tick of cBase.
Before the first tick of the clock of u, the block outputs
the value of parameter <b>y_start</b>. After that, the block returns the last
available value of u.
</p>

<p>
Note, for
<a href=\"Modelica_Synchronous.ClockSignals.Clocks.EventClock\">EventClock</a>s
there is the restriction that
block <b>BackSample</b> can only shift the number of ticks of the EventClock clock,
but cannot introduce new ticks, due to the restriction of operator <b>superSample</b> on
EventClocks.
</p>

<p>
Also note, that this block does not simply shift the signal in time,
since only the value of u from the last tick of the clock of u is used for the output.
In particular, a <b>BackSample</b> block following a <b>ShiftSample</b>
block cannot be used to recover the input signal of ShiftSample
(for a causal system this is impossible).
</p>


<h4>Example</h4>

<p>
The following
<a href=\"Modelica_Synchronous.Examples.Elementary.RealSignals.BackSample\">example</a>
samples a sine signal with a periodic clock of 20 ms period,
shift-samples it with shiftCounter = 4 and resolution = 3 and then back-samples it with backCounter=4 and resolution = 3:<br>
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Synchronous/Resources/Images/RealSignals/BackSample_Model.png\"></td>
    <td valign=\"bottom\">&nbsp;&nbsp;&nbsp;
                        <img src=\"modelica://Modelica_Synchronous/Resources/Images/RealSignals/BackSample_Result.png\"></td>
    </tr>
<tr><td></td>
    <td align=\"center\">model</td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>
<p>
The first activation of output y of block backSample1 is shifted (4/3*20ms) before the first activation of output y of block shiftSample1. As a consequence, the activation times of the output y are coincident with the input signal of the shiftSample1 block. However, as described above, the output of block backSample1 <b>does not</b> recover the original sampled sine signal! For the first two ticks the output holds the value of the parameter <b>y_start</b> = 0.5. After that the output at a clock tick of block backSample1 is the <i>last</i> value of the output of the shiftSample1 block. The parameter values <b>y_start</b> = 0.5, <b>shiftCounter</b> = 4 and <b>resolution</b> = 3 are visible at the bottom of the icon.
</p>
</html>"));
    end BackSample;

    block AssignClock "Assigns a clock to a clocked Real signal"

      Modelica.Blocks.Interfaces.RealInput u
        "Connector of clocked, Real input signal"
        annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
      Modelica.Blocks.Interfaces.RealOutput y
        "Connector of clocked, Real output signal"
        annotation (Placement(transformation(extent={{100,-10},{120,10}})));
      Clocked.ClockSignals.Interfaces.ClockInput clock annotation (Placement(
            transformation(
            extent={{-20,-20},{20,20}},
            rotation=90,
            origin={0,-120})));
    equation
      when clock then
        y = u;
      end when;

      annotation (
       defaultComponentName="assignClock1",
       Icon(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={2,2},
            initialScale=0.06),
                         graphics={
            Text(
              extent={{-200,100},{200,160}},
              lineColor={0,0,255},
              textString="%name"),
            Rectangle(
              extent={{-90,90},{88,-88}},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None),
                                   Line(points={{-80,-60},{-40,-60},{-40,0},{
                  0,0},{0,0},{0,0},{0,80},{40,80},{40,40},{80,40},{80,0},{80,
                  0},{80,0},{100,0}},color={0,0,127},
              pattern=LinePattern.Dot),                Line(
              points={{-80,-60},{-80,0},{-106,0}},
              color={0,0,127},
              pattern=LinePattern.Dot),
            Ellipse(
              extent={{-90,-50},{-70,-70}},
              lineColor={0,0,127},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-50,10},{-30,-10}},
              lineColor={0,0,127},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-10,90},{10,70}},
              lineColor={0,0,127},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{30,50},{50,30}},
              lineColor={0,0,127},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{70,10},{90,-10}},
              lineColor={0,0,127},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(
              points={{0,-100},{0,0}},
              color={175,175,175},
              pattern=LinePattern.Dot,
              thickness=0.5)}),
        Diagram(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={2,2},
            initialScale=0.06)),
        Documentation(info="<html>
<p>
This block assigns a clock to the Real input signal u
and provides u as output signal y.
</p>

<h4>Example</h4>

<p>
The following
<a href=\"Modelica_Synchronous.Examples.Elementary.RealSignals.AssignClock\">example</a>
shows a discrete counter. In order to execute the counter with a sample period of 20ms an AssignClock block is used. Due to clock inference all equations within the blocks are deduced to be active at the clock ticks given by the periodicClock block.
<br>
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Synchronous/Resources/Images/RealSignals/AssignClock_Model.png\"></td>
    <td valign=\"bottom\">&nbsp;&nbsp;&nbsp;
                        <img src=\"modelica://Modelica_Synchronous/Resources/Images/RealSignals/AssignClock_Result.png\"></td>
    </tr>
<tr><td></td>
    <td align=\"center\">model</td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>
<p>
At every clock tick (that is at every 20ms) the output of the unitDelay1 block is incremented by one.
</p>
</html>",     revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
    <tr>
      <th>Date</th>
      <th>Author</th>
      <th>Company/Institute</th>
      <th>Comment</th>
    </tr>
    <tr>
      <td valign=\"top\">2012-08-20</td>
      <td valign=\"top\">Bernhard Thiele</td>
      <td>DLR, Institute for System Dynamics and Control</td>
      <td valign=\"top\">Initial version</td>
    </tr>
</table>
</html>"));
    end AssignClock;

    block AssignClockVectorized
      "Assigns a clock to a clocked Real signal vector"

      parameter Integer n(min=1)=1
        "Size of input signal vector u (= size of output signal vector y)";
      Modelica.Blocks.Interfaces.RealInput u[n]
        "Connector of clocked, Real input signal"
        annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
      Modelica.Blocks.Interfaces.RealOutput y[n]
        "Connector of clocked, Real output signal"
        annotation (Placement(transformation(extent={{100,-10},{120,10}})));
       Clocked.ClockSignals.Interfaces.ClockInput clock annotation (Placement(
            transformation(
            extent={{-20,-20},{20,20}},
            rotation=90,
            origin={0,-120})));
    equation
      when clock then
        y = u;
      end when;

      annotation (
       defaultComponentName="assignClock1",
       Icon(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={2,2},
            initialScale=0.06),
                         graphics={
            Text(
              extent={{-196,128},{204,188}},
              lineColor={0,0,255},
              textString="%name"),
            Text(
              extent={{0,-32},{180,-82}},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              textString="n=%n"),  Line(points={{-80,-60},{-40,-60},{-40,0},{
                  0,0},{0,0},{0,0},{0,80},{40,80},{40,40},{80,40},{80,0},{80,
                  0},{80,0},{100,0}},color={0,0,127},
              pattern=LinePattern.Dot),                Line(
              points={{-80,-60},{-80,0},{-106,0}},
              color={0,0,127},
              pattern=LinePattern.Dot),
            Ellipse(
              extent={{-90,-50},{-70,-70}},
              lineColor={0,0,127},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-50,10},{-30,-10}},
              lineColor={0,0,127},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-10,90},{10,70}},
              lineColor={0,0,127},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{30,50},{50,30}},
              lineColor={0,0,127},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{70,10},{90,-10}},
              lineColor={0,0,127},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(
              points={{0,-100},{0,70}},
              color={175,175,175},
              pattern=LinePattern.Dot,
              thickness=0.5)}),
        Diagram(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={2,2},
            initialScale=0.06)),
        Documentation(info="<html>
<p>
This block assigns a clock to the Real <b>vector</b> input signal u
and provides u as vector output signal y.
</p>


<h4>Example</h4>

<p>
The following
<a href=\"Modelica_Synchronous.Examples.Elementary.RealSignals.AssignClockVectorized\">example</a>
shows two discrete counters. In order to execute the counters with a sample period of 20ms an AssignClockVectorized block is used. Due to clock inference all equations within the blocks are deduced to be active at the clock ticks given by the periodicClock block.
<br>
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Synchronous/Resources/Images/RealSignals/AssignClockVectorized_Model.png\"></td>
    <td valign=\"bottom\">&nbsp;&nbsp;&nbsp;
                        <img src=\"modelica://Modelica_Synchronous/Resources/Images/RealSignals/AssignClockVectorized_Result.png\"></td>
    </tr>
<tr><td></td>
    <td align=\"center\">model</td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>
<p>
At every clock tick (that is every 20ms) the output of the unitDelay1 block is incremented by one and that of the unitDelay2 block is incremented by two. The vector size of the input and output is provided by parameter <b>n</b>=2 which is also shown in the icon
of block assignClock1.
</p>
</html>"));
    end AssignClockVectorized;

    package Utilities "Utility components that are usually not directly used"
       extends Modelica.Icons.UtilitiesPackage;

      block UpSample
        "Upsample the clocked Real input signal and provide it as clocked output signal"

        parameter Boolean inferFactor=true
          "= true, if upsampling factor is inferred"  annotation(Evaluate=true, choices(checkBox=true));
        parameter Integer factor(min=1)=1
          "Upsampling factor >= 1 (if inferFactor=false)" annotation(Evaluate=true, Dialog(enable=not inferFactor));
        Modelica.Blocks.Interfaces.RealInput u
          "Connector of clocked, Real input signal"
          annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
        Modelica.Blocks.Interfaces.RealOutput y
          "Connector of clocked, Real output signal (clock of y is faster as clock of u)"
          annotation (Placement(transformation(extent={{100,-10},{120,10}})));
      protected
        Real dummy annotation(HideResult=true);
        Boolean b(start=false);
        Boolean b_super(start=false);
        Real u_super;
      equation
        when Clock() then // clock of u
           dummy = u;
           b = not previous(b);
        end when;

        when Clock() then // clock of y
           b_super = superSample(b);
           if inferFactor then
              u_super = superSample(u);
           else
              u_super = superSample(u,factor);
           end if;
           y = if b_super <> previous(b_super) then u_super else 0.0;
        end when;

        annotation (
         defaultComponentName="upSample1",
         Icon(coordinateSystem(
              preserveAspectRatio=true,
              extent={{-100,-100},{100,100}},
              grid={2,2},
              initialScale=0.06),
                           graphics={
              Rectangle(
                extent={{-92,90},{88,-90}},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid,
                pattern=LinePattern.None),
              Line(
                points={{-78,-60},{40,-60},{40,0},{40,0}},
                color={215,215,215},
                pattern=LinePattern.Dot), Line(points={{-80,-60},{-40,-60},{-40,-60},{-40,0},
                    {-40,0},{0,0},{40,0},{40,80},{40,80},{40,80},{80,80},{80,0},{80,0},
                    {100,0}},          color={0,0,127},
                pattern=LinePattern.Dot),                Line(
                points={{-80,-60},{-80,0},{-100,0}},
                color={0,0,127},
                pattern=LinePattern.Dot),
              Text(
                extent={{-200,175},{200,110}},
                lineColor={0,0,255},
                textString="%name"),
              Ellipse(
                extent={{-95,-45},{-65,-75}},
                lineColor={0,0,127},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{-83,-57},{-77,-63}},
                lineColor={0,0,127},
                fillColor={0,0,127},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{25,96},{55,66}},
                lineColor={0,0,127},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{37,83},{43,77}},
                lineColor={0,0,127},
                fillColor={0,0,127},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{-55,16},{-25,-14}},
                lineColor={0,0,127},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{-6,16},{24,-14}},
                lineColor={0,0,127},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{64,16},{94,-14}},
                lineColor={0,0,127},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Text(visible=not inferFactor,
                extent={{-200,-80},{200,-145}},
                textString="%factor"),
              Line(
                points={{80,80},{120,80}},
                color={215,215,215},
                pattern=LinePattern.Dot),
              Polygon(
                points={{25,0},{5,20},{5,10},{-25,10},{-25,-10},{5,-10},{5,-20},
                    {25,0}},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid,
                lineColor={95,95,95},
                origin={-71,52},
                rotation=90)}),
          Diagram(coordinateSystem(
              preserveAspectRatio=false,
              extent={{-100,-100},{100,100}},
              grid={2,2},
              initialScale=0.06)),
          Documentation(info="<html>
<p>
This block upsamples the clocked Real input signal u and provides it as clocked output signal y.
</p>

<p>
To be more precise:
The clock of y is factor-times faster than the clock of u. At every tick of the clock of u, the value of y is set to
the value of u, at intermediate ticks of clock y, the value of y is set to zero. The first activation of the clock of y coincides with the first activation of the clock of u. By default, the upsampling factor is inferred,that is, it must be defined somewhere else. If parameter <b>inferFactor</b> = false, then the upsampling factor is defined by the Integer parameter <b>factor</b>.
</p>

<p>
For signal interpolation an <i>upsample</i> should be followed by an appropriate filter (antiimaging).
</p>

<h4>Examples</h4>

<p>
The following
<a href=\"Modelica_Synchronous.Examples.Elementary.RealSignals.UpSample1\">example</a>
samples a sine signal with a periodic clock of 20 ms period, and
then upsamples the resulting clocked signal with a factor of 3:<br>
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Synchronous/Resources/Images/RealSignals/UpSample1_Model.png\"></td>
    <td valign=\"bottom\">&nbsp;&nbsp;&nbsp;
                        <img src=\"modelica://Modelica_Synchronous/Resources/Images/RealSignals/UpSample1_Result.png\"></td>
    </tr>
<tr><td></td>
    <td align=\"center\">model</td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>
<p>
The upsampling factor is explicitly given at the upSample2 block, which also makes the factor visible in the icon. For the upSample1 block the factor is inferred.
As can be seen, upsample1 introduces 3 additional clock ticks for the
output y. Note, the up-arrow in the icon of the upSample blocks indicates that the
clocks of their outputs is faster than the clocks of their inputs.
</p>

<p>
The following
<a href=\"Modelica_Synchronous.Examples.Elementary.RealSignals.UpSample2\">example</a>
samples a sine signal with a periodic clock of 20 ms period,
upsamples the resulting clocked signal with a factor of 3
and applies varies filters on this signal:<br>
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Synchronous/Resources/Images/RealSignals/UpSample2_Model.png\"></td>
    </tr>
<tr><td></td>
    <td align=\"center\">model<br></td>
   </tr>
<tr><td></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Synchronous/Resources/Images/RealSignals/UpSample2_Result1.png\"></td>
    </tr>
<tr><td></td>
    <td align=\"center\">simulation result 1<br></td>
   </tr>
<tr><td></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Synchronous/Resources/Images/RealSignals/UpSample2_Result2.png\"></td>
    </tr>
<tr><td></td>
    <td align=\"center\">simulation result 2</td>
   </tr>
</table>

<p>
This model shows various possibilities to operate on an up-sampled signal:
When filtering the upsampled signal with filter block FIR1
using FIR coefficients {1,1,1}, then the result is identical to a super-sampled
signal (see signal FIR1.y in figure \"simulation result 1\").
On the other hand, when filtering the upsampled signal with filter
block FIR2 using FIR coefficients {1/3, 2/3, 1, 2/3, 1/3}, then
the result is a linearly interpolated super-sampled signal
(see signal FIR2.y in figure \"simulation result 2\").
The same result can be achieved with block
<a href=\"modelica://Modelica_Synchronous.RealSignals.Sampler.SuperSampleInterpolated\">SuperSampleInterpolated</a>
(see signal superSampleIpo1.y in figure \"simulation result 2\").
The only difference are the first clock ticks, since the FIR2 signal is
initialized a bit differently.
</p>
</html>"));
      end UpSample;

        block AssignClockToTriggerHold
        "Generate a Boolean continuous-time trigger signal from a clocked Real input"
          extends Clocked.ClockSignals.Interfaces.ClockedBlockIcon;
          parameter Boolean y_start=false "Initial value of output signal";
          Modelica.Blocks.Interfaces.RealInput u
            annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
          Modelica.Blocks.Interfaces.BooleanOutput y
          "Connector of Boolean output signal"     annotation (Placement(
                transformation(extent={{100,-10},{120,10}}),
                iconTransformation(extent={{100,-10},{120,10}})));
      protected
          Boolean y2(start=y_start);
          Boolean y3(start=y_start, fixed=true);
          Real uu annotation(HideResult=true);
        equation
          when Clock() then
             uu = u "Dummy assignment to relate clock of u with y2";
             y2 = not previous(y2);
          end when;
          y3 = hold(y2);
          y = change(y3);
          annotation (
            defaultComponentName="clockToTrigger",
            Icon(coordinateSystem(
              preserveAspectRatio=true,
              extent={{-100,-100},{100,100}},
              grid={1,1}), graphics={
                Polygon(
                  points={{-80,88},{-88,66},{-72,66},{-80,88}},
                  lineColor={255,0,255},
                  fillColor={255,0,255},
                  fillPattern=FillPattern.Solid),
                Line(points={{-80,66},{-80,-82}}, color={255,0,255}),
                Line(points={{-90,-70},{72,-70}}, color={255,0,255}),
                Polygon(
                  points={{90,-70},{68,-62},{68,-78},{90,-70}},
                  lineColor={255,0,255},
                  fillColor={255,0,255},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{71,7},{85,-7}},
                  lineColor=DynamicSelect({235,235,235}, if y > 0.5 then {0,255,0} else
                            {235,235,235}),
                  fillColor=DynamicSelect({235,235,235}, if y > 0.5 then {0,255,0} else
                            {235,235,235}),
                  fillPattern=FillPattern.Solid),
              Line(points={{-60,-70},{-60,70}}),
              Line(points={{-20,-70},{-20,70}}),
              Line(points={{20,-70},{20,70}}),
              Line(points={{60,-70},{60,70}})}),
            Diagram(coordinateSystem(
              preserveAspectRatio=true,
              extent={{-100,-100},{100,100}},
              grid={1,1})),
            Documentation(info="<html>
<p>
This block creates a Boolean, continuous time, trigger signal whenever the clock of the input signal is active.
</p>

<p>
A particular use-case in which that block might be useful is the combination of \"old-style\" sampled blocks (i.e., \"unclocked\" discrete control functions implemented using equations between \"when trigger then\" clauses) with clocked blocks.
</p>

<h4>Example</h4>

<p>
The following
<a href=\"Modelica_Synchronous.Examples.Elementary.RealSignals.AssignClockToTriggerHold\">example</a>
samples a sine signal with a periodic clock of 20 ms period. After that a continuous time Boolean trigger signal is generated at every clock tick of that sampled signal. The generated signal is used as trigger signal for an \"old-style\" <a href=\"Modelica.Blocks.Discrete.TriggeredSampler\">TriggeredSampler</a>  block from the Modelica.Blocks.Discrete package:<br>
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Synchronous/Resources/Images/RealSignals/AssignClockToTriggerHold_Model.png\"></td>
    <td valign=\"bottom\">&nbsp;&nbsp;&nbsp;
                        <img src=\"modelica://Modelica_Synchronous/Resources/Images/RealSignals/AssignClockToTriggerHold_Result.png\"></td>
    </tr>
<tr><td></td>
    <td align=\"center\">model</td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>
<p>
Note, that it is clearly visible in the plot that the \"old-style\" discrete variables have an implicit zero-order hold semantics, while the new clocked variables are only active whenever their associated clock ticks. Just compare variable sample.y (clocked) with triggeredSampler.y (unclocked) to observe the difference.
</p>
</html>"));
        end AssignClockToTriggerHold;

        block AssignClockToSquareWaveHold
        "Generate a Boolean continuous-time square-wave output from a clocked Real input"
          extends Clocked.ClockSignals.Interfaces.ClockedBlockIcon;
          parameter Boolean y_start=false "Initial value of output signal";
          Modelica.Blocks.Interfaces.RealInput u
            annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
          Modelica.Blocks.Interfaces.BooleanOutput y
          "Connector of Boolean output signal"     annotation (Placement(
                transformation(extent={{100,-10},{120,10}}),
                iconTransformation(extent={{100,-10},{120,10}})));
      protected
          Boolean y2(start=y_start);
          Real uu;
        equation
          when Clock() then
             uu = u "Dummy assignment to relate clock of u with y2";
             y2 = not previous(y2);
          end when;
          y = hold(y2);
          annotation (
            defaultComponentName="clockToSquareWave",
            Icon(coordinateSystem(
              preserveAspectRatio=true,
              extent={{-100,-100},{100,100}},
              grid={1,1}), graphics={
                Polygon(
                  points={{-80,88},{-88,66},{-72,66},{-80,88}},
                  lineColor={255,0,255},
                  fillColor={255,0,255},
                  fillPattern=FillPattern.Solid),
                Line(points={{-80,66},{-80,-82}}, color={255,0,255}),
                Line(points={{-90,-70},{72,-70}}, color={255,0,255}),
                Polygon(
                  points={{90,-70},{68,-62},{68,-78},{90,-70}},
                  lineColor={255,0,255},
                  fillColor={255,0,255},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{71,7},{85,-7}},
                  lineColor=DynamicSelect({235,235,235}, if y > 0.5 then {0,255,0} else
                            {235,235,235}),
                  fillColor=DynamicSelect({235,235,235}, if y > 0.5 then {0,255,0} else
                            {235,235,235}),
                  fillPattern=FillPattern.Solid),
                                       Line(points={{-80,-70},{-40,-70},{-40,44},
                    {0,44},{0,-70},{40,-70},{40,44},{79,44}})}),
            Diagram(coordinateSystem(
              preserveAspectRatio=true,
              extent={{-100,-100},{100,100}},
              grid={1,1})),
            Documentation(info="<html>
<p>
This block creates a Boolean, continuous time, square-wave output. Whenever the clock of the input signal is active the Boolean output value changes.
</p>

<h4>Example</h4>

<p>
The following
<a href=\"Modelica_Synchronous.Examples.Elementary.RealSignals.AssignClockToSquareWaveHold\">example</a>
samples a sine signal with a periodic clock of 20 ms period. After that a Boolean, continuous time, square-wave signal is generated that changes its value at every clock tick of the sampled signal:<br>
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Synchronous/Resources/Images/RealSignals/AssignClockToSquareWaveHold_Model.png\"></td>
    <td valign=\"bottom\">&nbsp;&nbsp;&nbsp;
                        <img src=\"modelica://Modelica_Synchronous/Resources/Images/RealSignals/AssignClockToSquareWaveHold_Result.png\"></td>
    </tr>
<tr><td></td>
    <td align=\"center\">model</td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>
</html>"));
        end AssignClockToSquareWaveHold;

      package Internal
        "Internal blocks and functions that are usually of no interest for the user"
        extends Modelica.Icons.InternalPackage;
        block ComputationalDelay
          "Delays a clocked signal for at most one period, in order to model a computational delay"
        extends Clocked.RealSignals.Interfaces.PartialClockedSISO;
          parameter Integer shiftCounter(min=0,max=resolution) = 0
            "(min=0, max=resolution), computational delay = interval()*shiftCounter/resolution"
               annotation(Evaluate=true,Dialog(group="Computational delay in seconds = interval() * shiftCounter/resolution"));
          parameter Integer resolution(min=1) = 1
            "Time quantization resolution of sample interval"
               annotation(Evaluate=true,Dialog(group="Computational delay in seconds = interval() * shiftCounter/resolution"));
        protected
          Real ubuf(start=0.0);
        equation
          assert(resolution >= shiftCounter, "The maximal computational delay has the length of one sample interval, however a larger value than that was set");
          ubuf = u;
          if shiftCounter < resolution then
             y = shiftSample(u, shiftCounter, resolution);
          else
             y = shiftSample(previous(ubuf), shiftCounter, resolution);
          end if;

          annotation (Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,
                    -100},{100,100}})), Documentation(info="<html>
<p>
This block delays a clocked Real input signal by the fraction
shiftCounter/resolution of the last interval.
There is the restriction that shiftCounter/resolution &le; 1.
</p>
</html>"));
        end ComputationalDelay;

        block UniformNoise "Add band-limited uniform noise using a variant of the Wichmann-Hill algorithm"
          extends Clocked.RealSignals.Interfaces.PartialNoise;
          parameter Real noiseMax=0.1 "Upper limit of noise band";
          parameter Real noiseMin=-noiseMax "Lower limit of noise band";
          parameter Integer firstSeed[3](each min=0, each max=255) = {23,87,187}
            "Integer[3] defining random sequence; required element range: 0..255";
        protected
          Integer seedState[3](start=firstSeed, each fixed=true)
            "State of seed"                                                      annotation(HideResult=true);
          Real noise "Noise in the range 0..1" annotation(HideResult=true);
        equation
          (noise,seedState) =
            Clocked.RealSignals.Sampler.Utilities.Internal.random(previous(
            seedState));
            y = u + noiseMin + (noiseMax - noiseMin)*noise;

          annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                    -100},{100,100}})),
            Documentation(info="<html>
<p>
This block adds uniformly distributed noise
in the range noiseMin .. noiseMax to the clocked Real input signal
and provides the sum as clocked Real output signal.
</p>

<p>
The Integer[3] parameter vector <b>firstSeed</b> is used to initialize the
basic random number generator. The 3 elements of firstSeed need
to be in the range [0, 255]. The use of the same seed vector
will lead to the same sequence of numbers when these are computed serially.
This is usually not desired. Therefore, for every usage of block
<b>Noise</b> a different firstSeed should be defined.
</p>

<p>
This noise generator is based on a function that generates
a random real number uniformely in the semi-open range [0.0, 1.0).
The function uses the standard Wichmann-Hill generator,
combining three pure multiplicative congruential generators of
modulus 30269, 30307 and 30323. Its period (how many numbers it
generates before repeating the sequence exactly) is 6,953,607,871,644.
While of much higher quality than the rand() function supplied by
most C libraries, the theoretical properties are much the same
as for a single linear congruential generator of large modulus.
For more details, see the underlying function
<a href=\"modelica://Modelica_Synchronous.RealSignals.Sampler.Utilities.Internal.random\">Internal.random</a>.
</p>

<h4>Example</h4>
<p>
The following
<a href=\"Modelica_Synchronous.Examples.Elementary.RealSignals.UniformNoise\">example</a>
samples zero signal with a periodic clock of 20 ms period, and adds
noise in the range from -0.1 .. 0.1:<br>
</p>


<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Synchronous/Resources/Images/RealSignals/UniformNoise_Model.png\"></td>
    </tr>
<tr><td></td>
    <td align=\"left\">model<br></td>
   </tr>
<tr><td></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Synchronous/Resources/Images/RealSignals/UniformNoise_Result.png\"></td>
    </tr>
<tr><td></td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>
</html>"),  Icon(graphics={
                Polygon(
                  points={{-81,90},{-89,68},{-73,68},{-81,90}},
                  lineColor={192,192,192},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid),
                Text(
                  extent={{-74,92},{90,68}},
                  lineColor={255,0,0},
                  textString="%noiseMax"),
                Line(points={{-81,78},{-81,-90}}, color={192,192,192}),
                Line(points={{-89,62},{85,62}}, color={255,0,0}),
                Line(points={{-81,-17},{-67,-17},{-67,-1},{-59,-1},{-59,-49},{
                      -51,-49},{-51,-27},{-43,-27},{-43,57},{-35,57},{-35,25}},
                                                                       color={0,0,
                      127},
                  pattern=LinePattern.Dot),
                Line(points={{-35,25},{-35,-35},{-25,-35},{-25,-17},{-15,-17},{
                      -15,-45},{-5,-45},{-5,37},{1,37},{1,51},{7,51},{7,-5},{17,
                      -5},{17,7},{23,7},{23,-23},{33,-23},{33,49},{43,49},{43,
                      15},{51,15},{51,-51},{61,-51}},
                    color={0,0,127},
                  pattern=LinePattern.Dot),
                Line(points={{-90,-23},{82,-23}}, color={192,192,192}),
                Polygon(
                  points={{91,-22},{69,-14},{69,-30},{91,-22}},
                  lineColor={192,192,192},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid),
                Line(points={{-90,-54},{84,-54}}, color={255,0,0}),
                Ellipse(
                  extent={{-84,-13},{-78,-19}},
                  lineColor={0,0,127},
                  fillColor={0,0,127},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{-70,3},{-64,-3}},
                  lineColor={0,0,127},
                  fillColor={0,0,127},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{-62,-47},{-56,-53}},
                  lineColor={0,0,127},
                  fillColor={0,0,127},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{-54,-23},{-48,-29}},
                  lineColor={0,0,127},
                  fillColor={0,0,127},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{-46,59},{-40,53}},
                  lineColor={0,0,127},
                  fillColor={0,0,127},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{-38,-33},{-32,-39}},
                  lineColor={0,0,127},
                  fillColor={0,0,127},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{-28,-15},{-22,-21}},
                  lineColor={0,0,127},
                  fillColor={0,0,127},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{-18,-41},{-12,-47}},
                  lineColor={0,0,127},
                  fillColor={0,0,127},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{-8,39},{-2,33}},
                  lineColor={0,0,127},
                  fillColor={0,0,127},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{-2,53},{4,47}},
                  lineColor={0,0,127},
                  fillColor={0,0,127},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{4,-1},{10,-7}},
                  lineColor={0,0,127},
                  fillColor={0,0,127},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{14,9},{20,3}},
                  lineColor={0,0,127},
                  fillColor={0,0,127},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{20,-19},{26,-25}},
                  lineColor={0,0,127},
                  fillColor={0,0,127},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{30,53},{36,47}},
                  lineColor={0,0,127},
                  fillColor={0,0,127},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{40,19},{46,13}},
                  lineColor={0,0,127},
                  fillColor={0,0,127},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{48,-47},{54,-53}},
                  lineColor={0,0,127},
                  fillColor={0,0,127},
                  fillPattern=FillPattern.Solid),
                Text(
                  extent={{-80,-62},{98,-84}},
                  lineColor={255,0,0},
                  textString="%noiseMin")}));
        end UniformNoise;

        block UniformNoiseXorshift64star
          "Add band-limited uniform noise based on a xorshift64* number generator"
          extends Clocked.RealSignals.Interfaces.PartialNoise;
          parameter Real noiseMax=0.1 "Upper limit of noise band";
          parameter Real noiseMin=-noiseMax "Lower limit of noise band";

          parameter Integer globalSeed = 30020 "Global seed to initialize random number generator";
          // Random number generators with exposed state
          parameter Integer localSeed = 614657 "Local seed to initialize random number generator";
          output Real r64(start=0) "Random number generated with Xorshift64star";
        protected
          discrete Integer state64[2](start=Modelica.Math.Random.Generators.Xorshift64star.initialState(localSeed, globalSeed));

        equation
          (r64, state64) = Modelica.Math.Random.Generators.Xorshift64star.random(previous(state64));
           y = u + noiseMin + (noiseMax - noiseMin)*r64;

          annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                    -100},{100,100}})),
            Documentation(info="<html>
<p>This block adds uniformly distributed noise in the range noiseMin .. noiseMax to the clocked Real input signal and provides the sum as clocked Real output signal. </p>
<p>
It is based on the xorshift64* algorithm.
For more details, see the documentation to
<a href=\"modelica://Modelica.Math.Random.Generators.Xorshift64star\">Xorshift64star</a>.
</p>
<p><b>2019-05-20 TODO:</b> Add an example which exercises this block.</p>
</html>"),  Icon(graphics={
                Polygon(
                  points={{-81,90},{-89,68},{-73,68},{-81,90}},
                  lineColor={192,192,192},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid),
                Text(
                  extent={{-74,92},{90,68}},
                  lineColor={255,0,0},
                  textString="%noiseMax"),
                Line(points={{-81,78},{-81,-90}}, color={192,192,192}),
                Line(points={{-89,62},{85,62}}, color={255,0,0}),
                Line(points={{-81,-17},{-67,-17},{-67,-1},{-59,-1},{-59,-49},{
                      -51,-49},{-51,-27},{-43,-27},{-43,57},{-35,57},{-35,25}},
                                                                       color={0,0,
                      127},
                  pattern=LinePattern.Dot),
                Line(points={{-35,25},{-35,-35},{-25,-35},{-25,-17},{-15,-17},{
                      -15,-45},{-5,-45},{-5,37},{1,37},{1,51},{7,51},{7,-5},{17,
                      -5},{17,7},{23,7},{23,-23},{33,-23},{33,49},{43,49},{43,
                      15},{51,15},{51,-51},{61,-51}},
                    color={0,0,127},
                  pattern=LinePattern.Dot),
                Line(points={{-90,-23},{82,-23}}, color={192,192,192}),
                Polygon(
                  points={{91,-22},{69,-14},{69,-30},{91,-22}},
                  lineColor={192,192,192},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid),
                Line(points={{-90,-54},{84,-54}}, color={255,0,0}),
                Ellipse(
                  extent={{-84,-13},{-78,-19}},
                  lineColor={0,0,127},
                  fillColor={0,0,127},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{-70,3},{-64,-3}},
                  lineColor={0,0,127},
                  fillColor={0,0,127},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{-62,-47},{-56,-53}},
                  lineColor={0,0,127},
                  fillColor={0,0,127},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{-54,-23},{-48,-29}},
                  lineColor={0,0,127},
                  fillColor={0,0,127},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{-46,59},{-40,53}},
                  lineColor={0,0,127},
                  fillColor={0,0,127},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{-38,-33},{-32,-39}},
                  lineColor={0,0,127},
                  fillColor={0,0,127},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{-28,-15},{-22,-21}},
                  lineColor={0,0,127},
                  fillColor={0,0,127},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{-18,-41},{-12,-47}},
                  lineColor={0,0,127},
                  fillColor={0,0,127},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{-8,39},{-2,33}},
                  lineColor={0,0,127},
                  fillColor={0,0,127},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{-2,53},{4,47}},
                  lineColor={0,0,127},
                  fillColor={0,0,127},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{4,-1},{10,-7}},
                  lineColor={0,0,127},
                  fillColor={0,0,127},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{14,9},{20,3}},
                  lineColor={0,0,127},
                  fillColor={0,0,127},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{20,-19},{26,-25}},
                  lineColor={0,0,127},
                  fillColor={0,0,127},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{30,53},{36,47}},
                  lineColor={0,0,127},
                  fillColor={0,0,127},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{40,19},{46,13}},
                  lineColor={0,0,127},
                  fillColor={0,0,127},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{48,-47},{54,-53}},
                  lineColor={0,0,127},
                  fillColor={0,0,127},
                  fillPattern=FillPattern.Solid),
                Text(
                  extent={{-80,-62},{98,-84}},
                  lineColor={255,0,0},
                  textString="%noiseMin")}));
        end UniformNoiseXorshift64star;

        model Quantization "DAC quantization effects"
        extends Clocked.RealSignals.Interfaces.PartialClockedSISO;

          parameter Boolean quantized = false
            "= true, if quantization effects shall be computed";
          parameter Real yMax=1 "Upper limit of output";
          parameter Real yMin=-1 "Lower limit of output";
          parameter Integer bits(min=1)=8
            "Number of bits of quantization (if quantized = true)";
        protected
          parameter Real resolution = if quantized then ((yMax - yMin)/2^bits) else 0;
        equation

          if quantized then
            y = resolution*floor(abs(u/resolution) + 0.5)*
                   (if u >= 0 then +1 else -1);
          else
            y = u;
          end if;
          annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                    -100},{100,100}})), Diagram(coordinateSystem(
                  preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
            Documentation(info="<html>
<p>
The clocked Real input signal is value discretized
(the discretization is defined by parameter <b>bits</b>).
</p>
</html>"));
        end Quantization;

            block Limiter "Limit the range of a signal"
            extends Clocked.RealSignals.Interfaces.PartialClockedSISO;
              parameter Real uMax(start=1) "Upper limits of input signals";
              parameter Real uMin= -uMax "Lower limits of input signals";

            equation
              assert(uMax >= uMin, "Limiter: Limits must be consistent. However, uMax (=" + String(uMax) +
                                   ") < uMin (=" + String(uMin) + ")");
              y = if u > uMax then uMax else if u < uMin then uMin else u;
              annotation (
                Documentation(info="<HTML>
<p>
The Limiter block passes its input signal as output signal
as long as the input is within the specified upper and lower
limits. If this is not the case, the corresponding limits are passed
as output.
</p>
</HTML>"),      Icon(coordinateSystem(
                preserveAspectRatio=true,
                extent={{-100,-100},{100,100}},
                grid={2,2}), graphics={
                Line(points={{0,-90},{0,68}}, color={192,192,192}),
                Polygon(
                  points={{0,90},{-8,68},{8,68},{0,90}},
                  lineColor={192,192,192},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid),
                Line(points={{-90,0},{68,0}}, color={192,192,192}),
                Polygon(
                  points={{90,0},{68,-8},{68,8},{90,0}},
                  lineColor={192,192,192},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid),
                Line(points={{-80,-70},{-50,-70},{50,70},{80,70}}),
                Text(
                  extent={{-150,-150},{150,-110}},
                  textString="uMax=%uMax"),
                Text(
                  extent={{-150,150},{150,110}},
                  textString="%name",
                  lineColor={0,0,255})}),
                Diagram(coordinateSystem(
                preserveAspectRatio=true,
                extent={{-100,-100},{100,100}},
                grid={2,2}), graphics={
                Line(points={{0,-60},{0,50}}, color={192,192,192}),
                Polygon(
                  points={{0,60},{-5,50},{5,50},{0,60}},
                  lineColor={192,192,192},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid),
                Line(points={{-60,0},{50,0}}, color={192,192,192}),
                Polygon(
                  points={{60,0},{50,-5},{50,5},{60,0}},
                  lineColor={192,192,192},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid),
                Line(points={{-50,-40},{-30,-40},{30,40},{50,40}}),
                Text(
                  extent={{46,-6},{68,-18}},
                  lineColor={128,128,128},
                  textString="u"),
                Text(
                  extent={{-30,70},{-5,50}},
                  lineColor={128,128,128},
                  textString="y"),
                Text(
                  extent={{-58,-54},{-28,-42}},
                  lineColor={128,128,128},
                  textString="uMin"),
                Text(
                  extent={{26,40},{66,56}},
                  lineColor={128,128,128},
                  textString="uMax")}));
            end Limiter;

        function random "Pseudo random number generator"
          extends Modelica.Icons.Function;

          input Integer seedIn[3]
            "Integer vector defining random number sequence, e.g., {23,87,187}";
          output Real x "Random number between 0 and 1";
          output Integer seedOut[3]
            "Modified seed to be used for next call of random()";
        algorithm
          seedOut[1] := rem((171*seedIn[1]), 30269);
          seedOut[2] := rem((172*seedIn[2]), 30307);
          seedOut[3] := rem((170*seedIn[3]), 30323);
          // zero is a poor seed, therfore substitute 1;
          if seedOut[1] == 0 then
            seedOut[1] := 1;
          end if;
          if seedOut[2] == 0 then
            seedOut[2] := 1;
          end if;
          if seedOut[3] == 0 then
            seedOut[3] := 1;
          end if;
          x := rem((seedOut[1]/30269.0 + seedOut[2]/30307.0 + seedOut[3]/30323.0), 1.0);
          annotation (
            Documentation(info="<HTML>
<p>
<i>Random</i> generates a sequence of uniform distributed
pseudo-random numbers. The algorithm is a variant of the
multiplicative congruential algorithm, known as the
Wichmann-Hill generator:
<pre>    x(k) = (a1*x(k-1)) mod m1
    y(k) = (a2*y(k-1)) mod m2
    z(k) = (a3*z(k-1)) mod m3
    U(k) = (x(k)/m1 + y(k)/m2 + z(k)/m3) mod 1
</pre>
This generates pseudo-random numbers U(k) uniformly distributed
in the interval (0,1). There are many forms of generators depending
on the parameters m (prime numbers) and a. The sequence needs an
initial Integer vector {x,y,z} known as the seed. The use of the same
seed will lead to the same sequence of numbers.
</p>
<p>
<b>Remarks</b>
</p>
<p>Random number generators (RNG) are pseudo-functions which are not true
functions but algorithms which deliver a fixed sequence of (usually Integer) numbers
which should have a very large period before they repeat itself and
appropriate statistic properties such that the sequence appears to be
a random draw. For real-valued random numbers, the integers are scaled to
the real interval 0.0-1.0. They result in a uniformly distributed random variate
between 0-1, which has to be transformed to give a random variate of a wanted
distribution. There are two types of techniques for transforming random variates:
</p>
<ul>
<li>Acceptance-Rejection techniques</li>
<li>Transformation techniques</li>
</ul>
<p>Acceptance-Rejection techniques throw away some of the generated variates and are thus less efficient. They can not be avoided for all distributions. A good summary about random number generation and most of the transformation techniques used below is given in:</p>
 <address> Discrete Event Simulation <br>
 Jerry Banks and John S. Carson II<br>
 Prentice Hall Inc.<br>
 Englewood Cliffs, New Jersey<br>
 </address>
<p>Some of the other references are quoted below.</p>
<pre>
        WICHMANN-HILL RANDOM NUMBER GENERATOR
        Wichmann, B. A. & Hill, I. D. (1982)
          Algorithm AS 183:
          An efficient and portable pseudo-random number generator
          Applied Statistics 31 (1982) 188-190
        see also:
          Correction to Algorithm AS 183
          Applied Statistics 33 (1984) 123
        McLeod, A. I. (1985)
          A remark on Algorithm AS 183
          Applied Statistics 34 (1985),198-200
        In order to completely avoid external functions, all seeds are
        set via parameters. For simulation purposes this is almost
        always the desired behaviour.
        Translated by Hubertus Tummescheit from Python source provided by
        Guido van Rossum translated from C source by Adrian Baddeley.
        http://www.python.org/doc/current/lib/module-random.html
        R A N D O M   V A R I A B L E   G E N E R A T O R S
        distributions on the real line:
        ------------------------------
            normal (Gaussian) 2 versions
</pre>
<h4>Reference Literature:</h4>
<ul>
<li>function random: Wichmann, B. A. & Hill, I. D. (1982), Algorithm AS 183:
  <br>
  An efficient and portable pseudo-random number generator, Applied Statistics 31 (1982) 188-190<br>
  see also: Correction to Algorithm AS 183, Applied Statistics 33 (1984) 123 <br>
  McLeod, A. I. (1985), A remark on Algorithm AS 183, Applied Statistics 34 (1985),198-200</li>
<li>function normalvariate: Kinderman, A.J. and Monahan, J.F., 'Computer generation of random
  variables using the ratio of uniform deviates', ACM Trans Math Software, 3, (1977),
  pp257-260.</li>
<li>function gaussianvariate: Discrete Event Simulation, Jerry Banks and John S. Carson II,
<br>
  Prentice Hall Inc. Englewood Cliffs, New Jersey, page 315/316</li>
</ul>
<p>
Copyright &copy; Hubertus Tummescheit and Department of Automatic Control, Lund University, Sweden.
</p>
<p>
<i>This Modelica function is <b>free</b> software; it can be redistributed and/or modified
under the terms of the BSD-3-Clause license.</i>
</p>
</HTML>", revisions="<html>
<p>2019-05-20: Changed license to BSD-3-Clause after consultation with Hubertus Tummescheit.</p>
</html>"));
        end random;

        annotation (Documentation(info="<html>
<p>
The blocks in this package are internal that should usually not be
utilized directly by the user (they are used as building blocks
in \"higher level\" blocks).
</p>
</html>"));
      end Internal;

      annotation (Documentation(info="<html>
<p>
This package contains utility blocks that are usually not directly utilized
but are used as building blocks for \"higher level\" blocks.
</p>
</html>"));
    end Utilities;

    annotation (Documentation(info="<html>
<p>
This package contains blocks that mark boundaries of a clocked partition
and transform a <b>Real</b> signal from one partition to the next. Especially,
the following blocks are provided:<br>&nbsp;
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"3\">
<tr><th align=\"left\"><b>Boundary Type</b></th>
    <th align=\"left\"><b>Block Name</b></th>
    <th align=\"left\"><b>Description</b></th></tr>

<tr><td valign=\"top\" rowspan=\"4\">continuous-time &rarr; clocked</td>
      <td><a href=\"modelica://Modelica_Synchronous.RealSignals.Sampler.Sample\">Sample</a></td>
      <td>Sample a continuous-time signal.</td>
    </tr>
    <tr>
      <td><a href=\"modelica://Modelica_Synchronous.RealSignals.Sampler.SampleClocked\">SampleClocked</a></td>
      <td>Sample and associate a clock to the sampled <b>scalar</b> signal.</td>
    </tr>
    <tr>
      <td><a href=\"modelica://Modelica_Synchronous.RealSignals.Sampler.SampleVectorizedAndClocked\">SampleVectorizedAndClocked</a></td>
      <td>Sample an input vector and associate a clock to the sampled <b>vector</b> signal.</td>
    </tr>
    <tr>
      <td><a href=\"modelica://Modelica_Synchronous.RealSignals.Sampler.SampleWithADeffects\">SampleWithADeffects</a></td>
      <td>Sample with (simulated) Analog-Digital converter effects including noise.</td>
    </tr>

<tr><td valign=\"top\" rowspan=\"2\">clocked &rarr; continuous-time</td>
      <td><a href=\"modelica://Modelica_Synchronous.RealSignals.Sampler.Hold\">Hold</a></td>
      <td>Hold a clocked signal with zero-order hold.</td>
    </tr>
    <tr>
      <td><a href=\"modelica://Modelica_Synchronous.RealSignals.Sampler.HoldWithDAeffects\">HoldWithDAeffects</a></td>
      <td>Hold with (simulated) Digital-Analog converter effects and computational delay.</td>
    </tr>

<tr><td valign=\"top\" rowspan=\"5\">clocked &rarr; clocked</td>
      <td><a href=\"modelica://Modelica_Synchronous.RealSignals.Sampler.SubSample\">SubSample</a></td>
      <td>Sub-sample a signal (output clock is slower as input clock). </td>
    </tr>

    <tr>
      <td><a href=\"modelica://Modelica_Synchronous.RealSignals.Sampler.SuperSample\">SuperSample</a></td>
      <td>Super-sample a signal (output clock is faster as input clock). </td>
    </tr>

    <tr>
      <td><a href=\"modelica://Modelica_Synchronous.RealSignals.Sampler.SuperSampleInterpolated\">SuperSampleInterpolated</a></td>
      <td>Super-sample a signal with linear interpolation (output clock is faster as input clock). </td>
    </tr>

    <tr>
      <td><a href=\"modelica://Modelica_Synchronous.RealSignals.Sampler.ShiftSample\">ShiftSample</a></td>
      <td>Shift a signal (output clock is delayed with respect to input clock).  </td>
    </tr>

    <tr>
      <td><a href=\"modelica://Modelica_Synchronous.RealSignals.Sampler.BackSample\">BackSample</a></td>
      <td>Shift a signal and start the output clock before the input clock with a start value.  </td>
    </tr>


<tr><td valign=\"top\" rowspan=\"2\">within clocked partition</td>
      <td><a href=\"modelica://Modelica_Synchronous.RealSignals.Sampler.AssignClock\">AssignClock</a></td>
      <td>Assign a clock to a clocked <b>scalar</b> signal.</td>
    </tr>
    <tr>
      <td><a href=\"modelica://Modelica_Synchronous.RealSignals.Sampler.AssignClockVectorized\">AssignClockVectorized</a></td>
      <td>Assign a clock to a clocked <b>vector</b> signal.</td>
    </tr>
</table>

<p>
Additionally, package
<a href=\"modelica://Modelica_Synchronous.RealSignals.Sampler.Utilities\">Utilities</a></td>
contains utility blocks that are used as building blocks for user-relevant blocks.
Especially, block
<a href=\"modelica://Modelica_Synchronous.RealSignals.Sampler.Utilities.UpSample\">UpSample</a>
can be used in combination with a
<a href=\"modelica://Modelica_Synchronous.RealSignals.Periodic.FIRbyCoefficients\">FIR filter</a>
block to model super-sampling with interpolation and filtering.
</p>
</html>"));
  end Sampler;

  package NonPeriodic
    "Library of blocks that operate on periodically and non-periodically clocked signals"
  extends Modelica.Icons.Package;

    block PI
      "Discrete-time PI controller with clocked input and output signals (for periodic and aperiodic systems using the parameterization of the continuous PI controller)"
      extends Clocked.RealSignals.Interfaces.PartialClockedSISO;
      parameter Real k "Gain of continuous PI controller";
      parameter Real T(min=Modelica.Constants.small)
        "Time constant of continuous PI controller";
      output Real x(start=0) "Discrete PI state";
    protected
      Real Ts = interval(u) "Sample time (periodic or non-periodic)";
    equation
      when Clock() then
         x = previous(x) + u*(Ts/T);
         y = k*(x + u);
      end when;

      annotation (defaultComponentName="PI1",
           Icon(graphics={
            Polygon(
              points={{90,-82},{68,-74},{68,-90},{90,-82}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Line(points={{-90,-82},{82,-82}}, color={192,192,192}),
            Line(points={{-80,76},{-80,-92}}, color={192,192,192}),
            Polygon(
              points={{-80,90},{-88,68},{-72,68},{-80,90}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Line(
              points={{-80,-82},{-80,-10},{-32,-10},{-32,18},{54,18},{54,46},{84,46},
                  {84,78}},
              color={0,0,127},
              pattern=LinePattern.Dot),
            Text(
              extent={{-32,-4},{80,-58}},
              lineColor={192,192,192},
              textString="PI"),
            Text(
              extent={{-150,-150},{150,-110}},
              textString="T=%T"),
            Ellipse(
              extent={{-87,-3},{-75,-15}},
              lineColor={0,0,127},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-38,24},{-26,12}},
              lineColor={0,0,127},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{48,52},{60,40}},
              lineColor={0,0,127},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}),
        Documentation(info="<html>
<p>
Discrete-time PI controller that has been derived from the continuous-time
PI controller
</p>
<pre>
                 1
   y = k * (1 + ---) * u
                T*s
           T*s + 1
     = k * ------- * u
             T*s
</pre>
<p>
by using the implicit Euler discretization formula. The block is
parametrized with the gain k and the time constant T of the continuous
PI block. As a result, the discrete-time form of the PI controller depends
explicitly on the sample time of the controller and changing this sample time,
will give still a similar performance.
</p>
</html>"));
    end PI;

    block UnitDelay "Delays the clocked input signal for one sample period"
      extends Clocked.RealSignals.Interfaces.PartialClockedSISO(u(final start=
              y_start));
      parameter Real y_start=0 "Value of output signal at first clock tick";
    equation
      y = previous(u);
      annotation (defaultComponentName="unitDelay1",
           Icon(graphics={
            Line(points={{-30,0},{30,0}}, color={0,0,127}),
            Text(
              extent={{-90,10},{90,90}},
              textString="1",
              lineColor={0,0,127}),
            Text(
              extent={{-90,-10},{90,-90}},
              textString="z",
              lineColor={0,0,127}),
            Text(
              extent={{-150,-140},{150,-100}},
              textString="y_start=%y_start")}),
        Documentation(info="<html>
<p>
This block describes a unit delay:
</p>
<pre>
  // Time domain description
     y(ti) = previous(u(ti))

  // Discrete transfer function
             1
     y(z) = --- * u(z)
             z
</pre>

<p>
that is, the output signal y is the input signal u at the
previous clock tick. At the first clock tick, the output
y is set to parameter y_start.
</p>
</html>"));
    end UnitDelay;

    block FractionalDelay
      "Delays the clocked input signal for a fractional multiple of the sample period"
    extends Clocked.RealSignals.Interfaces.PartialClockedSISO;

      parameter Integer shift(min=0) = 0
        "Delay = interval() * shift/resolution";
      parameter Integer resolution(min=1) = 1
        "Time quantization resolution of sample interval";
    protected
      parameter Integer n = div(shift,resolution);
      Real u_buffer[n+1](each start=0.0)
        "The previous values of the inputs; u_last[1] = u, u_last[2] = previous(u_last[1]); u_last[3] = previous(u_last[2])";
      Boolean first(start=true) "Used to identify the first clock tick";
    equation
     first = false;
     u_buffer = if previous(first) then fill(u,n+1) else cat(1, {u}, previous(u_buffer[1:n]));
     y = shiftSample(u_buffer[n+1], shift, resolution);

      annotation (Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,
                -100},{100,100}})),
        Icon(graphics={
            Line(
              points={{-100,0},{-80,0},{-80,40},{-20,40},{-20,-40},{40,-40},{40,0},{
                  100,0}},
              color={215,215,215},
              pattern=LinePattern.Dot),
            Line(
              points={{-100,0},{-50,0},{-50,40},{10,40},{10,-40},{70,-40},{70,-0.3125},
                  {100,0}},
              pattern=LinePattern.Dot,
              color={0,0,127}),
            Text(
              extent={{4,-102},{4,-142}},
              textString="%shift/%resolution"),
            Ellipse(
              extent={{-90,50},{-70,30}},
              lineColor={0,0,127},
              fillColor={0,0,127},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-30,-30},{-10,-50}},
              lineColor={0,0,127},
              fillColor={0,0,127},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{30,10},{50,-10}},
              lineColor={0,0,127},
              fillColor={0,0,127},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-60,50},{-40,30}},
              lineColor={0,0,127},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{0,-30},{20,-50}},
              lineColor={0,0,127},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{60,10},{80,-10}},
              lineColor={0,0,127},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}),
        Documentation(info="<html>
<p>
This block delays a signal. Similar to the <a href=\"Modelica_Synchronous.RealSignals.Sampler.ShiftSample\">ShiftSample</a> block the first activation of the clock of the output y is delayed by <b>shiftCounter</b>/<b>resolution</b>*interval(u) relative to the input u (interval(u) is the sample period of the clock associated to input u). However, in contrast to ShiftSample, the block provides a buffer for the input values and truly delays the input signal.
</p>

<h4>Example</h4>

<p>
The following
<a href=\"Modelica_Synchronous.Examples.Elementary.RealSignals.FractionalDelay\">example</a>
shows how a sample sine signal is delayed.
<br>
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Synchronous/Resources/Images/RealSignals/FractionalDelay_Model.png\"></td>
    <td valign=\"bottom\">&nbsp;&nbsp;&nbsp;
                        <img src=\"modelica://Modelica_Synchronous/Resources/Images/RealSignals/FractionalDelay_Result.png\"></td>
    </tr>
<tr><td></td>
    <td align=\"center\">model</td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>
<p>
The parameter values <b>shiftCounter</b>=3 and <b>resolution</b>=2 are visible at the bottom of the fractionalDelay block.
</p>
</html>"));
    end FractionalDelay;

    annotation (Documentation(info="<html>
<p>
This package contains blocks that can be utilized for periodic and non-periodic
clocks. These blocks usually utilize the duration of the last interval for the computation of the
output signal. For example, the coefficients of the
<a href=\"Modelica_Synchronous.RealSignals.NonPeriodic.PI\">PI</a>
block are computed from the coefficients of a continuous-time PI block
and from the duration of the last interval.
</p>
</html>"));
  end NonPeriodic;

  package Periodic
    "Library of blocks that are designed to operate only on periodically clocked signals (mainly described by z transforms)"
  extends Modelica.Icons.Package;

    block StateSpace "Discrete-time State Space block"
      parameter Real A[:, size(A, 1)] "Matrix A of state space model";
      parameter Real B[size(A, 1), :] "Matrix B of state space model";
      parameter Real C[:, size(A, 1)] "Matrix C of state space model";
      parameter Real D[size(C, 1), size(B, 2)]=zeros(size(C, 1), size(B, 2))
        "Matrix D of state space model";
      extends Clocked.RealSignals.Interfaces.PartialClockedMIMO(final nin=size(
            B, 2), final nout=size(C, 1));
      output Real x[size(A, 1)](each start=0.0) "State vector";

    equation
      when Clock() then
        x = A*previous(x) + B*u;
        y = C*previous(x) + D*u;
      end when;
      annotation (
        Documentation(info="<html>
<p>
This block defines the state space representation of a discrete-time block
with input vector u, output vector y and state vector x:
</p>
<pre>
    x = A * previous(x) + B * u
    y = C * previous(x) + D * u
</pre>
<p>
where previous(x) is the value of the clocked state x at
the previous clock tick.
The input is a vector of length nu, the output is a vector
of length ny and nx is the number of states. Accordingly
</p>
<pre>
        A has the dimension: A(nx,nx),
        B has the dimension: B(nx,nu),
        C has the dimension: C(ny,nx),
        D has the dimension: D(ny,nu)
</pre>
<p>
Example:
</p>
<pre>
     parameter: A = [0.12, 2;3, 1.5]
     parameter: B = [2, 7;3, 1]
     parameter: C = [0.1, 2]
     parameter: D = zeros(ny,nu)

results in the following equations:
  [x[1]]   [0.12  2.00] [previous(x[1])]   [2.0  7.0] [u[1]]
  [    ] = [          ]*[              ] + [        ]*[    ]
  [x[2]]   [3.00  1.50] [previous(x[2])]   [0.1  2.0] [u[2]]

                        [previous(x[1])]            [u[1]]
  y[1]   = [0.1  2.0] * [              ] + [0  0] * [    ]
                        [previous(x[2])]            [u[2]]
</pre>
</HTML>
",     revisions="<html>
<p><b>Release Notes:</b></p>
<ul>
<li><i>August 13, 2012</i>
    by <a href=\"http://www.dlr.de/rm/\">Bernhard Thiele</a>:<br>
    Used the code from Blocks.Discrete.StateSpace and converted it into
    the Modelica 3.3 clocked equation style.</li>
</ul>
</html>"),
    Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={2,2}), graphics={
            Text(
              extent={{-90,15},{-15,90}},
              textString="A",
              lineColor={0,0,127}),
            Text(
              extent={{15,15},{90,90}},
              textString="B",
              lineColor={0,0,127}),
            Text(
              extent={{-52,28},{54,-20}},
              textString="z",
              lineColor={0,0,127}),
            Text(
              extent={{-90,-15},{-15,-90}},
              textString="C",
              lineColor={0,0,127}),
            Text(
              extent={{15,-15},{90,-90}},
              textString="D",
              lineColor={0,0,127})}),
        Diagram(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={2,2}), graphics={
            Rectangle(extent={{-60,60},{60,-60}}, lineColor={0,0,255}),
            Text(
              extent={{-54,50},{52,-10}},
              textString="zx=Ax+Bu"),
            Text(
              extent={{-56,14},{54,-50}},
              textString="  y=Cx+Du"),
            Line(points={{-102,0},{-60,0}}, color={0,0,255}),
            Line(points={{60,0},{100,0}}, color={0,0,255})}));
    end StateSpace;

    block TransferFunction "Discrete-time Transfer Function block"
      extends Clocked.RealSignals.Interfaces.PartialClockedSISO;
      parameter Real b[:]={1} "Numerator coefficients of transfer function.";
      parameter Real a[:] "Denominator coefficients of transfer function.";

      output Real x[size(a, 1) - 1](each start=0.0)
        "State vector of controller canonical form";
    protected
      parameter Integer nb=size(b, 1) "Size of Numerator of transfer function";
      parameter Integer na=size(a, 1)
        "Size of Denominator of transfer function";
      Real x1;
      Real xext[size(a, 1)];

    equation
      when Clock() then
        /* State variables x are defined according to
       controller canonical form. */
        x1 = (u - a[2:size(a, 1)]*previous(x))/a[1];
        xext = vector([x1; previous(x)]);
        x = xext[1:size(x, 1)];
        y = vector([zeros(na - nb, 1); b])*xext;
      end when;
      annotation (
        Documentation(info="<html>
<p>The <b>discrete transfer function</b> block defines the
transfer function between the input signal u and the output
signal y. The numerator has the order nb-1, the denominator
has the order na-1.</p>
<pre>          b(1)*z^(nb-1) + b(2)*z^(nb-2) + ... + b(nb)
   y(z) = -------------------------------------------- * u(z)
          a(1)*z^(na-1) + a(2)*z^(na-2) + ... + a(na)
</pre>
<p>State variables <b>x</b> are defined according to
<b>controller canonical</b> form. Initial values of the
states can be set as start values of <b>x</b>.<p>
<p>Example:</p>
<pre>     TransferFunction g(b = {2,4}, a = {1,3});
</pre>
<p>results in the following transfer function:</p>
<pre>        2*z + 4
   y = --------- * u
         z + 3
</pre>

</HTML>
",   revisions="<html>
<p><b>Release Notes:</b></p>
<ul>
<li><i>August 13, 2012</i>
    by <a href=\"http://www.dlr.de/rm/\">Bernhard Thiele</a>:<br>
    Used the original code from Blocks.Discrete.TransferFunction and converted it into
    the Modelica 3.3 clocked equation style.</li>
<li><i>November 15, 2000</i>
    by <a href=\"http://www.dynasim.se\">Hans Olsson</a>:<br>
    Converted to when-semantics of Modelica 1.4 with special
    care to avoid unnecessary algebraic loops.</li>
<li><i>June 18, 2000</i>
    by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
    Realized based on a corresponding model of Dieter Moormann
    and Hilding Elmqvist.</li>
</ul>
</html>"),
        Icon(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={2,2}), graphics={
            Line(points={{82,0},{-84,0}}, color={0,0,127}),
            Text(
              extent={{-92,92},{86,12}},
              lineColor={0,0,127},
              textString="b(z)"),
            Text(
              extent={{-90,-12},{90,-90}},
              lineColor={0,0,127},
              textString="a(z)"),
            Text(
              extent={{-200,-105},{200,-145}},
              textString="b=%b"),
            Text(
              extent={{-200,-150},{200,-190}},
              textString="a=%a")}),
        Diagram(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={2,2}), graphics={
            Rectangle(extent={{-60,60},{60,-60}}, lineColor={0,0,255}),
            Line(
              points={{40,0},{-44,0}},
              thickness=0.5),
            Text(
              extent={{-54,54},{54,4}},
              textString="b(z)"),
            Text(
              extent={{-54,-6},{56,-56}},
              textString="a(z)"),
            Line(points={{-100,0},{-60,0}}, color={0,0,255}),
            Line(points={{60,0},{100,0}}, color={0,0,255})}));
    end TransferFunction;

    block PI "Discrete-time PI controller"
      extends Clocked.RealSignals.Interfaces.PartialClockedSISO;
      parameter Real kd "Gain of discrete PI controller";
      parameter Real Td(min=Modelica.Constants.small)
        "Time constant of discrete PI controller";
      output Real x(start=0) "Discrete PI state";
    equation
      when Clock() then
         x = previous(x) + u/Td;
         y = kd*(x + u);
      end when;

      annotation (defaultComponentName="PI1",
           Icon(graphics={
            Polygon(
              points={{90,-82},{68,-74},{68,-90},{90,-82}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Line(points={{-90,-82},{82,-82}}, color={192,192,192}),
            Line(points={{-80,76},{-80,-92}}, color={192,192,192}),
            Polygon(
              points={{-80,90},{-88,68},{-72,68},{-80,90}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Line(
              points={{-80,-82},{-80,-10},{-32,-10},{-32,18},{16,18},{16,46},{64,46},
                  {64,80}},
              color={0,0,127},
              pattern=LinePattern.Dot),
            Text(
              extent={{-30,-4},{82,-58}},
              lineColor={192,192,192},
              textString="PI"),
            Text(
              extent={{-150,-150},{150,-110}},
              textString="Td=%Td"),
            Ellipse(
              extent={{-87,-3},{-75,-15}},
              lineColor={0,0,127},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-37,25},{-25,13}},
              lineColor={0,0,127},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{9,52},{21,40}},
              lineColor={0,0,127},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{58,87},{70,75}},
              lineColor={0,0,127},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}),
        Documentation(info="<html>
<p>
This block defines a discrete-time PI controller by the formula:
</p>
<pre>
// State space form:
   x(ti) = previous(x(ti)) + u(ti)/Td;
   y(ti) = kd*(x(ti) + u(ti));

// Transfer function form:
   y(z) = kd*(c*z-1)/(z-1)*u(z);
          c = 1 + 1/Td
</pre>
<p>
where kd is the gain, Td is the time constant, ti is the time instant
of the i-th clock tick and z is the inverse shift operator.
</p>

<p>
This discrete-time form has been derived from the continuous-time
form of a PI controller by using the implicit Euler discretization formula.
</p>
</html>"));
    end PI;

    block MovingAverage
      "Moving average filter (= FIR filter with coefficients a = fill(1/n,n), but implemented recursively)"
      extends Clocked.RealSignals.Interfaces.PartialClockedSISO;
      parameter Integer n = 2
        "Number of points that are averaged (= number of coefficients of corresponding FIR filter)";
    protected
      Real u_buffer[n+1](each start=0.0)
        "The previous values of the inputs; u_buffer[1] = u, u_buffer[2] = previous(u_buffer[1]); u_buffer[3] = previous(u_buffer[2])";
      Boolean first(start=true) "Used to identify the first clock tick";
      Real uu(start=0.0)
        "Dummy variable to provide a dummy start value for u (which has no effect)";
      Real yy(start=0.0)
        "Dummy variable to provide a dummy start value for y (which has no effect)";
    equation
      when Clock() then
         first = false;
         uu = u;

         // At the first clock tick u_last is filled with "u" (to initialize in steady state).
         u_buffer = if previous(first) then fill(uu,n+1) else
                         cat( 1, {uu}, previous(u_buffer[1:n]));

         // Moving average formula
         y = if previous(first) then uu else previous(yy) + (u_buffer[1] - u_buffer[n+1])/n;
         yy = y;
      end when;
      annotation (
        Documentation(info="<HTML>
<p>
This block computes the output y as the average of the input u and of
its past values (= moving average filter):
</p>
<pre>
 y(i) = ( u(i) + u(i-1) + u(i-2) + ... ) / n
</pre>
<p>
where y(i) and u(i) are the values of y and u at clock tick i, and n are the number of
u and past u values that are taken into account.
</p>

<p>
This block could also be implemented with block
<a href=\"modelica://Modelica_Synchronous.RealSignals.Periodic.FIRbyCoefficients\">FIRbyCoefficients</a>
by using the coefficients a = fill(1/n, n). However, block <i>MovingAverage</i> is
a more efficient implementation since it can be implemented recursively,
contrary to a general FIR filter.
</p>

</HTML>
"),     Icon(graphics={
         Line(points={{-84,78},{-84,-90}}, color={192,192,192}),
        Line(points={{-90,-82},{82,-82}}, color={192,192,192}),
          Rectangle(extent={{-84,-82},{-18,4}},
                lineColor={192,192,192}, fillColor={255,255,255},
                fillPattern=FillPattern.Backward),
        Line(points={{-84,30},{-72,30},{-52,28},{-32,20},{-26,16},{-22,12},{-18,6},{
                  -14,-4},{-4,-46},{0,-64},{2,-82}},
                                             color={0,0,127}),
        Polygon(points={{-84,90},{-92,68},{-76,68},{-84,90},{-84,90}}, lineColor={192,192,192}, fillColor={192,192,192},
                fillPattern =  FillPattern.Solid),
          Line(points={{2,-82},{4,-64},{8,-56},{12,-56},{16,-60},{18,-66},{20,-82}},
                                                                             color={0,0,127}),
          Line(points={{20,-80},{20,-78},{20,-72},{22,-66},{24,-64},{28,-64},{32,-66},
                  {34,-70},{36,-78},{36,-82},{36,-74},{38,-68},{40,-66},{44,-66},{46,
                  -68},{48,-72},{50,-78},{50,-82},{50,-78},{52,-70},{54,-68},{58,-68},
                  {62,-72},{64,-76},{64,-78},{64,-80},{64,-82}},
                                                color={0,0,127}),
        Polygon(points={{90,-82},{68,-74},{68,-90},{90,-82}}, lineColor={192,192,192}, fillColor={192,192,192},
                fillPattern = FillPattern.Solid),
            Text(
              extent={{-26,88},{88,48}},
              lineColor={175,175,175},
              fillColor={255,255,255},
              fillPattern=FillPattern.Backward,
              textString="MA"),
            Text(
              extent={{-150,-110},{150,-150}},
              fillPattern=FillPattern.Solid,
              textString="n=%n")}));
    end MovingAverage;

    block FIRbyCoefficients "FIR filter defined by coefficients"
      extends Clocked.RealSignals.Interfaces.PartialClockedSISO;
      input Real a[:]={1/2,1/2} "Coefficients of FIR filter" annotation(Dialog);
      parameter Real cBufStart[size(a,1)-1] = ones(size(a,1)-1)
        "The u-buffer [u(i-1), u(i-2), ..., u(size(a,1)-1)] is initialized with u(i=1)*cBufStart"
                              annotation(Dialog(tab="Advanced"));
    protected
      parameter Integer n = size(a, 1) - 1 "Order of filter";
      Real u_buffer[n+1](each start=0.0)
        "The previous values of the inputs; u_buffer[1] = u, u_buffer[2] = previous(u_buffer[1]); u_buffer[3] = previous(u_buffer[2])";
      Boolean first(start=true) "Used to identify the first clock tick";
    equation
      when Clock() then
         first = false;

         // At the first clock tick u_last is filled with "u" (to initialize in steady state).
         u_buffer = if previous(first) then cat( 1, {u}, u*cBufStart)  else
                         cat( 1, {u}, previous(u_buffer[1:n]));

         // FIR formula
         y = a*u_buffer;
      end when;

      annotation (defaultComponentName="FIR1",
        Documentation(info="<html>
<p>
This block computes the output y as a linear combination of the input u
and of its past values (= FIR filter):
</p>
<pre>
 y(i) = a[1]*u(i) + a[2]*u(i-1) + a[3]*u(i-2) + ...
</pre>
<p>
where y(i) and u(i) are the values of y and u at clock tick i and
a[:] are the filter coefficients.
</p>

<p>
At the first clock tick i=1 the past values are filled with u at this clock tick (= steady state initialization).
</p>
</html>"),
        Icon(graphics={
        Polygon(points={{-84,90},{-92,68},{-76,68},{-84,90},{-84,90}}, lineColor={192,192,192}, fillColor={192,192,192},
                fillPattern =  FillPattern.Solid),
         Line(points={{-84,78},{-84,-90}}, color={192,192,192}),
        Line(points={{-84,30},{-72,30},{-52,28},{-32,20},{-26,16},{-22,12},{-18,6},{
                  -14,-4},{-4,-46},{0,-64},{2,-82}},
                                             color={0,0,127}),
          Rectangle(extent={{-84,-82},{-18,4}},
                lineColor={192,192,192}, fillColor={255,255,255},
                fillPattern=FillPattern.Backward),
          Line(points={{2,-82},{4,-64},{8,-56},{12,-56},{16,-60},{18,-66},{20,-82}},
                                                                             color={0,0,127}),
          Line(points={{20,-80},{20,-78},{20,-72},{22,-66},{24,-64},{28,-64},{32,-66},
                  {34,-70},{36,-78},{36,-82},{36,-74},{38,-68},{40,-66},{44,-66},{46,
                  -68},{48,-72},{50,-78},{50,-82},{50,-78},{52,-70},{54,-68},{58,-68},
                  {62,-72},{64,-76},{64,-78},{64,-80},{64,-82}},
                                                color={0,0,127}),
        Polygon(points={{90,-82},{68,-74},{68,-90},{90,-82}}, lineColor={192,192,192}, fillColor={192,192,192},
                fillPattern = FillPattern.Solid),
        Line(points={{-90,-82},{82,-82}}, color={192,192,192}),
            Text(
              extent={{-26,86},{88,56}},
              lineColor={175,175,175},
              fillColor={255,255,255},
              fillPattern=FillPattern.Backward,
              textString="FIR"),
            Text(
              extent={{-150,-110},{150,-150}},
              fillPattern=FillPattern.Solid,
              textString="a=%a")}));
    end FIRbyCoefficients;

    annotation (Documentation(info="<html>
<p>
This package contains blocks that are designed for periodically clocked
system. Changing the sample rate (without changing at the same time the
parameters of the block), or using the blocks on non-periodically
clocked signals, will usually result in non-expected behavior.
</p>
</html>"));
  end Periodic;

  package TimeBasedSources
    "Package of signal source blocks generating clocked simulation time based Real signals"
     extends Modelica.Icons.SourcesPackage;

        block Step "Generate step signal of type Real"
          extends Interfaces.PartialClockedSO;
          parameter Real height = 1 "Height of step";
          parameter Real offset = 0 "Offset of output signal y";
          parameter Modelica.SIunits.Time startTime = 0
        "Output y = offset for time < startTime";
    protected
          Modelica.SIunits.Time simTime;
        equation
          simTime = sample(time);
          y = offset + (if simTime < startTime then 0 else height);
          annotation (
            Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics={
            Line(points={{-80,68},{-80,-80}}, color={192,192,192}),
            Polygon(
              points={{-80,90},{-88,68},{-72,68},{-80,90}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Line(points={{-90,-70},{82,-70}}, color={192,192,192}),
            Polygon(
              points={{90,-70},{68,-62},{68,-78},{90,-70}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Line(points={{-80,-70},{0,-70},{0,50},{80,50}}, pattern=LinePattern.Dot),
            Text(
              extent={{-150,-150},{150,-110}},
              textString="startTime=%startTime"),
                Ellipse(
                  extent={{-86,-63},{-74,-75}},
                  lineColor={0,0,127},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{-45,-63},{-33,-75}},
                  lineColor={0,0,127},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{-5,56},{7,44}},
                  lineColor={0,0,127},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{32,56},{44,44}},
                  lineColor={0,0,127},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{71,57},{83,45}},
                  lineColor={0,0,127},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid)}),
            Diagram(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics={
            Polygon(
              points={{-80,90},{-86,68},{-74,68},{-80,90}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Line(points={{-80,68},{-80,-80}}, color={95,95,95}),
            Line(
              points={{-80,-18},{0,-18},{0,50},{80,50}},
              color={0,0,255},
              thickness=0.5),
            Line(points={{-90,-70},{82,-70}}, color={95,95,95}),
            Polygon(
              points={{90,-70},{68,-64},{68,-76},{90,-70}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{70,-80},{94,-100}},
              textString="time"),
            Text(
              extent={{-21,-72},{25,-90}},
              textString="startTime"),
            Line(points={{0,-17},{0,-71}}, color={95,95,95}),
            Text(
              extent={{-68,-36},{-22,-54}},
              textString="offset"),
            Line(points={{-13,50},{-13,-17}}, color={95,95,95}),
            Polygon(
              points={{2,50},{-19,50},{2,50}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-13,-17},{-16,-4},{-10,-4},{-13,-17},{-13,-17}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-13,50},{-16,37},{-9,37},{-13,50}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-68,26},{-22,8}},
              textString="height"),
            Polygon(
              points={{-13,-69},{-16,-56},{-10,-56},{-13,-69},{-13,-69}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Line(points={{-13,-18},{-13,-70}}, color={95,95,95}),
            Polygon(
              points={{-13,-18},{-16,-31},{-9,-31},{-13,-18}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-72,100},{-31,80}},
              textString="y")}),
        Documentation(info="<html>
<p>The block is similar to the block in <a href=\"modelica://Modelica.Blocks.Sources.Step\">Modelica.Blocks.Sources.Step</a>, but adapted to work in clocked partitions (by internal sampling of the continuous <b>time</b> variable).</p>
<p>
The Real output y is a step signal:
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/Step.png\">
</p>

<h4>Example</h4>
<p>
See model <a href=\"Modelica_Synchronous.Examples.Elementary.RealSignals.TimeBasedStep\">Modelica_Synchronous.Examples.Elementary.RealSignals.TimeBasedStep</a>.
<br>
</p>

</html>"));
        end Step;

        block Ramp "Generate ramp signal"
          extends Interfaces.PartialClockedSO;
          parameter Real height=1 "Height of ramps";
          parameter Modelica.SIunits.Time duration(min=Modelica.Constants.small, start = 2)
        "Durations of ramp";
          parameter Real offset=0 "Offset of output signal";
          parameter Modelica.SIunits.Time startTime=0
        "Output = offset for time < startTime";
    protected
          Modelica.SIunits.Time simTime;
        equation
          simTime = sample(time);
          y = offset + (if simTime < startTime then 0 else if simTime < (startTime +
            duration) then (simTime - startTime)*height/duration else height);
          annotation (
            Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics={
            Line(points={{-80,68},{-80,-80}}, color={192,192,192}),
            Polygon(
              points={{-80,90},{-88,68},{-72,68},{-80,90}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Line(points={{-90,-70},{82,-70}}, color={192,192,192}),
            Polygon(
              points={{90,-70},{68,-62},{68,-78},{90,-70}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Line(points={{-80,-70},{-40,-70},{31,38}}, pattern=LinePattern.Dot),
            Text(
              extent={{-150,-150},{150,-110}},
              textString="duration=%duration"),
            Line(points={{31,38},{86,38}}, pattern=LinePattern.Dot),
                Ellipse(
                  extent={{-86,-64},{-74,-76}},
                  lineColor={0,0,127},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{-34,-48},{-22,-60}},
                  lineColor={0,0,127},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{13,27},{25,15}},
                  lineColor={0,0,127},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{64,44},{76,32}},
                  lineColor={0,0,127},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid)}),
            Diagram(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics={
            Polygon(
              points={{-80,90},{-86,68},{-74,68},{-80,90}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Line(points={{-80,68},{-80,-80}}, color={95,95,95}),
            Line(
              points={{-80,-20},{-20,-20},{50,50}},
              color={0,0,255},
              thickness=0.5),
            Line(points={{-90,-70},{82,-70}}, color={95,95,95}),
            Polygon(
              points={{90,-70},{68,-64},{68,-76},{90,-70}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-40,-20},{-42,-30},{-37,-30},{-40,-20}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Line(
              points={{-40,-20},{-40,-70}},
              color={95,95,95},
              thickness=0.25),
            Polygon(
              points={{-40,-70},{-43,-60},{-38,-60},{-40,-70},{-40,-70}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-72,-39},{-34,-50}},
              textString="offset"),
            Text(
              extent={{-38,-72},{6,-83}},
              textString="startTime"),
            Text(
              extent={{-78,92},{-37,72}},
              textString="y"),
            Text(
              extent={{70,-80},{94,-91}},
              textString="time"),
            Line(points={{-20,-20},{-20,-70}}, color={95,95,95}),
            Line(
              points={{-19,-20},{50,-20}},
              color={95,95,95},
              thickness=0.25),
            Line(
              points={{50,50},{101,50}},
              color={0,0,255},
              thickness=0.5),
            Line(
              points={{50,50},{50,-20}},
              color={95,95,95},
              thickness=0.25),
            Polygon(
              points={{50,-20},{42,-18},{42,-22},{50,-20}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-20,-20},{-11,-18},{-11,-22},{-20,-20}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{50,50},{48,40},{53,40},{50,50}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{50,-20},{47,-10},{52,-10},{50,-20},{50,-20}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{53,23},{82,10}},
              textString="height"),
            Text(
              extent={{-2,-21},{37,-33}},
              textString="duration")}),
        Documentation(info="<html>
<p>The block is similar to the block in <a href=\"modelica://Modelica.Blocks.Sources.Ramp\">Modelica.Blocks.Sources.Ramp</a>, but adapted to work in clocked partitions (by internal sampling of the continuous <b>time</b> variable).</p>
<p>
The Real output y is a ramp signal:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/Ramp.png\">
</p>

<h4>Example</h4>
<p>
See model <a href=\"Modelica_Synchronous.Examples.Elementary.RealSignals.TimeBasedRamp\">Modelica_Synchronous.Examples.Elementary.RealSignals.TimeBasedRamp</a>.
<br>
</p>
</html>"));
        end Ramp;

        block Sine "Generate sine signal"
          extends Interfaces.PartialClockedSO;
          parameter Real amplitude=1 "Amplitude of sine wave";
          parameter Modelica.SIunits.Frequency freqHz(start=1)
        "Frequency of sine wave";
          parameter Modelica.SIunits.Angle phase=0 "Phase of sine wave";
          parameter Real offset=0 "Offset of output signal";
          parameter Modelica.SIunits.Time startTime=0
        "Output = offset for time < startTime";
    protected
          constant Real pi=Modelica.Constants.pi;
    protected
                  Modelica.SIunits.Time simTime;
        equation
          simTime = sample(time);
          y = offset + (if simTime < startTime then 0 else amplitude*
            Modelica.Math.sin(2*pi*freqHz*(simTime - startTime) + phase));
          annotation (
            Icon(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics={
            Line(points={{-80,68},{-80,-80}}, color={192,192,192}),
            Polygon(
              points={{-80,90},{-88,68},{-72,68},{-80,90}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Line(points={{-90,0},{68,0}}, color={192,192,192}),
            Polygon(
              points={{90,0},{68,8},{68,-8},{90,0}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Line(points={{-80,0},{-68.7,34.2},{-61.5,53.1},{-55.1,66.4},{-49.4,
                  74.6},{-43.8,79.1},{-38.2,79.8},{-32.6,76.6},{-26.9,69.7},{-21.3,
                  59.4},{-14.9,44.1},{-6.83,21.2},{10.1,-30.8},{17.3,-50.2},{23.7,
                  -64.2},{29.3,-73.1},{35,-78.4},{40.6,-80},{46.2,-77.6},{51.9,-71.5},
                  {57.5,-61.9},{63.9,-47.2},{72,-24.8},{80,0}}, pattern=LinePattern.Dot),
            Text(
              extent={{-147,-152},{153,-112}},
              textString="freqHz=%freqHz"),
                Ellipse(
                  extent={{-86,6},{-74,-6}},
                  lineColor={0,0,127},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{-59,72},{-47,60}},
                  lineColor={0,0,127},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{-31,72},{-19,60}},
                  lineColor={0,0,127},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{-7,6},{5,-6}},
                  lineColor={0,0,127},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{19,-60},{31,-72}},
                  lineColor={0,0,127},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{49,-60},{61,-72}},
                  lineColor={0,0,127},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid)}),
            Diagram(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics={
            Line(points={{-80,-90},{-80,84}}, color={95,95,95}),
            Polygon(
              points={{-80,97},{-84,81},{-76,81},{-80,97}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Line(points={{-99,-40},{85,-40}}, color={95,95,95}),
            Polygon(
              points={{97,-40},{81,-36},{81,-45},{97,-40}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Line(
              points={{-41,-2},{-31.6,34.2},{-26.1,53.1},{-21.3,66.4},{-17.1,
                  74.6},{-12.9,79.1},{-8.64,79.8},{-4.42,76.6},{-0.201,69.7},{
                  4.02,59.4},{8.84,44.1},{14.9,21.2},{27.5,-30.8},{33,-50.2},{
                  37.8,-64.2},{42,-73.1},{46.2,-78.4},{50.5,-80},{54.7,-77.6},{
                  58.9,-71.5},{63.1,-61.9},{67.9,-47.2},{74,-24.8},{80,0}},
              color={0,0,255},
              thickness=0.5),
            Line(
              points={{-41,-2},{-80,-2}},
              color={0,0,255},
              thickness=0.5),
            Text(
              extent={{-87,12},{-40,0}},
              textString="offset"),
            Line(points={{-41,-2},{-41,-40}}, color={95,95,95}),
            Text(
              extent={{-60,-43},{-14,-54}},
              textString="startTime"),
            Text(
              extent={{75,-47},{100,-60}},
              textString="time"),
            Text(
              extent={{-80,99},{-40,82}},
              textString="y"),
            Line(points={{-9,79},{43,79}}, color={95,95,95}),
            Line(points={{-41,-2},{50,-2}}, color={95,95,95}),
            Polygon(
              points={{33,79},{30,66},{37,66},{33,79}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{37,57},{83,39}},
              textString="amplitude"),
            Polygon(
              points={{33,-2},{30,11},{36,11},{33,-2},{33,-2}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Line(points={{33,77},{33,-2}}, color={95,95,95}),
                Ellipse(
                  extent={{-47,4},{-35,-8}},
                  lineColor={0,0,127},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{-16,85},{-4,73}},
                  lineColor={0,0,127},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{15,5},{27,-7}},
                  lineColor={0,0,127},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{44,-74},{56,-86}},
                  lineColor={0,0,127},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{74,5},{86,-7}},
                  lineColor={0,0,127},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid)}),
        Documentation(info="<html>
<p>The block is similar to the block in <a href=\"modelica://Modelica.Blocks.Sources.Sine\">Modelica.Blocks.Sources.Sine</a>, but adapted to work in clocked partitions (by internal sampling of the continuous <b>time</b> variable).</p>
<p>The Real output y is a sine signal: </p>
<p><img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/Sine.png\"></p>

<h4>Example</h4>
<p>
See model <a href=\"Modelica_Synchronous.Examples.Elementary.RealSignals.TimeBasedSine\">Modelica_Synchronous.Examples.Elementary.RealSignals.TimeBasedSine</a>.
<br>
</p>
</html>"));
        end Sine;

    annotation (Documentation(info="<html>
<p>
This package provides <b>source</b> components akin to the blocks provided in
<a href=\"Modelica.Blocks.Sources\">Modelica.Blocks.Sources</a>, but with the difference
that they provide a <b>clocked</b> output signal.
</p>
<p>
As an effect it is not necessary to use an intermediate Sample block if the output signal
is connected to a system that requires a clocked input signal. Therefore, it it can be slightly more convenient
to use the blocks provided in this package than to use the blocks offered by <a href=\"Modelica.Blocks.Sources\">Modelica.Blocks.Sources</a>
(since one does not need to add an additional Sample block for the transition from a continuous time signal to a clocked signal).
</p>
</html>"));
  end TimeBasedSources;

  package TickBasedSources
    "Package of signal source blocks generating clocked ticked/sample based Real signals"
     extends Modelica.Icons.SourcesPackage;

        block Step
      "Generate step signal of type Real based on counted clock ticks"
          extends Interfaces.PartialClockedSO;
          parameter Real height = 1 "Height of step";
          parameter Real offset = 0 "Offset of output signal y";
          parameter Integer startTick(min=1) = 1
        "Output y = offset for clock tick < startTick";
    protected
          Integer counter(start=0);
        equation
          // stop counter after counter = startTick to avoid integer overflow for long running simulations
          counter = if previous(counter) < startTick then previous(counter) + 1 else previous(counter);
          y = offset + (if counter < startTick then 0 else height);
          annotation (
            Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics={
            Line(points={{-80,68},{-80,-80}}, color={192,192,192}),
            Polygon(
              points={{-80,90},{-88,68},{-72,68},{-80,90}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Line(points={{-90,-70},{82,-70}}, color={192,192,192}),
            Polygon(
              points={{90,-70},{68,-62},{68,-78},{90,-70}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Line(points={{-80,-70},{0,-70},{0,50},{80,50}}, pattern=LinePattern.Dot),
            Text(
              extent={{-150,-150},{150,-110}},
              textString="startTick=%startTick"),
                Ellipse(
                  extent={{-86,-63},{-74,-75}},
                  lineColor={0,0,127},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{-45,-63},{-33,-75}},
                  lineColor={0,0,127},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{-5,56},{7,44}},
                  lineColor={0,0,127},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{32,56},{44,44}},
                  lineColor={0,0,127},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{71,57},{83,45}},
                  lineColor={0,0,127},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid)}),
            Diagram(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics={
            Polygon(
              points={{-80,90},{-86,68},{-74,68},{-80,90}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Line(points={{-80,68},{-80,-80}}, color={95,95,95}),
            Line(
              points={{-80,-18},{0,-18},{0,50},{80,50}},
              color={0,0,255},
              thickness=0.5,
                  pattern=LinePattern.Dot),
            Line(points={{-90,-70},{82,-70}}, color={95,95,95}),
            Polygon(
              points={{90,-70},{68,-64},{68,-76},{90,-70}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{70,-80},{94,-100}},
              textString="tick"),
            Text(
              extent={{-21,-72},{25,-90}},
              textString="startTick"),
            Line(points={{0,-17},{0,-71}}, color={95,95,95}),
            Text(
              extent={{-68,-36},{-22,-54}},
              textString="offset"),
            Line(points={{-13,50},{-13,-17}}, color={95,95,95}),
            Polygon(
              points={{2,50},{-19,50},{2,50}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-13,-17},{-16,-4},{-10,-4},{-13,-17},{-13,-17}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-13,50},{-16,37},{-9,37},{-13,50}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-68,26},{-22,8}},
              textString="height"),
            Polygon(
              points={{-13,-69},{-16,-56},{-10,-56},{-13,-69},{-13,-69}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Line(points={{-13,-18},{-13,-70}}, color={95,95,95}),
            Polygon(
              points={{-13,-18},{-16,-31},{-9,-31},{-13,-18}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-72,100},{-31,80}},
              textString="y"),
                Ellipse(
                  extent={{-6,55},{6,43}},
                  lineColor={0,0,127},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{-47,-12},{-35,-24}},
                  lineColor={0,0,127},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{-86,-12},{-74,-24}},
                  lineColor={0,0,127},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{33,56},{45,44}},
                  lineColor={0,0,127},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{72,56},{84,44}},
                  lineColor={0,0,127},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid)}),
        Documentation(info="<html>
<p>
The Real output y is a step signal. The signal is defined in terms of clock ticks instead of simulation time:
</p>

<p>
<img src=\"modelica://Modelica_Synchronous/Resources/Images/RealSignals/TickBasedSources_Step.png\"/>
</p>

</html>"));
        end Step;

        block Ramp "Generate ramp signal based on counted clock ticks"
          extends Interfaces.PartialClockedSO;
          parameter Real height=1 "Height of ramps";
          parameter Integer durationTicks(min=1) = 1
        "Durations of ramp in number of clock ticks";
          parameter Real offset=0 "Offset of output signal";

          parameter Integer startTick(min=1) = 1
        "Output y = offset for clock tick < startTick";
    protected
          Integer counter(start=0);
        equation
          // stop counter after counter = startTick+durationTicks to avoid integer overflow for long running simulations
          counter = if previous(counter) < startTick+durationTicks then previous(counter) + 1 else previous(counter);

          y = offset + (if counter < startTick then 0 else if counter < (startTick +
            durationTicks) then (counter - startTick)*height/durationTicks else height);
          annotation (
            Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics={
            Line(points={{-80,68},{-80,-80}}, color={192,192,192}),
            Polygon(
              points={{-80,90},{-88,68},{-72,68},{-80,90}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Line(points={{-90,-70},{82,-70}}, color={192,192,192}),
            Polygon(
              points={{90,-70},{68,-62},{68,-78},{90,-70}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Line(points={{-80,-70},{-40,-70},{31,38}}, pattern=LinePattern.Dot),
            Text(
              extent={{-150,-150},{150,-110}},
              textString="duration ticks=%durationTicks"),
            Line(points={{31,38},{86,38}}, pattern=LinePattern.Dot),
                Ellipse(
                  extent={{-86,-64},{-74,-76}},
                  lineColor={0,0,127},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{-34,-48},{-22,-60}},
                  lineColor={0,0,127},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{13,27},{25,15}},
                  lineColor={0,0,127},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{64,44},{76,32}},
                  lineColor={0,0,127},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid)}),
            Diagram(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics={
            Polygon(
              points={{-80,90},{-86,68},{-74,68},{-80,90}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Line(points={{-80,68},{-80,-80}}, color={95,95,95}),
            Line(
              points={{-80,-20},{-20,-20},{50,50}},
              color={0,0,255},
              thickness=0.5,
              pattern=LinePattern.Dot),
            Line(points={{-90,-70},{82,-70}}, color={95,95,95}),
            Polygon(
              points={{90,-70},{68,-64},{68,-76},{90,-70}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-40,-20},{-42,-30},{-37,-30},{-40,-20}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Line(
              points={{-40,-20},{-40,-70}},
              color={95,95,95},
              thickness=0.25),
            Polygon(
              points={{-40,-70},{-43,-60},{-38,-60},{-40,-70},{-40,-70}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-72,-39},{-34,-50}},
              textString="offset"),
            Text(
              extent={{-38,-72},{6,-83}},
              textString="startTick"),
            Text(
              extent={{-78,92},{-37,72}},
              textString="y"),
            Text(
              extent={{70,-80},{94,-91}},
              textString="tick"),
            Line(points={{-20,-20},{-20,-70}}, color={95,95,95}),
            Line(
              points={{-19,-20},{50,-20}},
              color={95,95,95},
              thickness=0.25),
            Line(
              points={{50,50},{87,50}},
              color={0,0,255},
              thickness=0.5,
              pattern=LinePattern.Dot),
            Line(
              points={{50,50},{50,-20}},
              color={95,95,95},
              thickness=0.25),
            Polygon(
              points={{50,-20},{42,-18},{42,-22},{50,-20}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-20,-20},{-11,-18},{-11,-22},{-20,-20}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{50,50},{48,40},{53,40},{50,50}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{50,-20},{47,-10},{52,-10},{50,-20},{50,-20}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{53,23},{82,10}},
              textString="height"),
            Text(
              extent={{-8,-21},{42,-39}},
              textString="durationTicks"),
                Ellipse(
                  extent={{-86,-14},{-74,-26}},
                  lineColor={0,0,127},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{-26,-14},{-14,-26}},
                  lineColor={0,0,127},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{10,22},{22,10}},
                  lineColor={0,0,127},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{44,56},{56,44}},
                  lineColor={0,0,127},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{81,56},{93,44}},
                  lineColor={0,0,127},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid)}),
        Documentation(info="<html>
<p>
The Real output y is a ramp signal. The signal is defined in terms of clock ticks instead of simulation time:
</p>

<p>
<img src=\"modelica://Modelica_Synchronous/Resources/Images/RealSignals/TickBasedSources_Ramp.png\"/>
</p>
</html>"));
        end Ramp;

        block Sine "Generate sine signal"
          extends Interfaces.PartialClockedSO;
          parameter Real amplitude=1 "Amplitude of sine wave";
          parameter Real offset=0 "Offset of output signal";
          parameter Integer periodTicks = 10
        "Number of clock ticks for one period";
          parameter Integer periodOffset=0
        "Number of periods the sine signal is offset";
          parameter Integer startTick(min=1)=1
        "Output = offset for clock tick < startTick";
    protected
          constant Real pi=Modelica.Constants.pi;
          Real Ts = interval(y) "Sample time (periodic or non-periodic)";
          Integer counter(start=0);
          Boolean startOutput(start=false)
        "Flag whether counter >= startTick reached once";
        equation
          // restart counter after reaching threshold to avoid integer overflow for long running simulations
          if previous(startOutput) then
              counter = if previous(counter) == (periodTicks-1) then 0 else previous(counter) + 1;
              startOutput = previous(startOutput);
          else
            startOutput = previous(counter) >= (startTick-1);
            counter = if startOutput then 0 else previous(counter) + 1;
          end if;

          y = offset + (if startOutput then
          amplitude*Modelica.Math.sin(2*pi/periodTicks*(counter + periodOffset)) else 0);
          annotation (
            Icon(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics={
            Line(points={{-80,68},{-80,-80}}, color={192,192,192}),
            Polygon(
              points={{-80,90},{-88,68},{-72,68},{-80,90}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Line(points={{-90,0},{68,0}}, color={192,192,192}),
            Polygon(
              points={{90,0},{68,8},{68,-8},{90,0}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Line(points={{-80,0},{-68.7,34.2},{-61.5,53.1},{-55.1,66.4},{-49.4,
                  74.6},{-43.8,79.1},{-38.2,79.8},{-32.6,76.6},{-26.9,69.7},{-21.3,
                  59.4},{-14.9,44.1},{-6.83,21.2},{10.1,-30.8},{17.3,-50.2},{23.7,
                  -64.2},{29.3,-73.1},{35,-78.4},{40.6,-80},{46.2,-77.6},{51.9,-71.5},
                  {57.5,-61.9},{63.9,-47.2},{72,-24.8},{80,0}}, pattern=LinePattern.Dot),
            Text(
              extent={{-147,-152},{153,-112}},
              textString="periodTicks=%periodTicks"),
                Ellipse(
                  extent={{-86,6},{-74,-6}},
                  lineColor={0,0,127},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{-59,72},{-47,60}},
                  lineColor={0,0,127},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{-31,72},{-19,60}},
                  lineColor={0,0,127},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{-7,6},{5,-6}},
                  lineColor={0,0,127},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{19,-60},{31,-72}},
                  lineColor={0,0,127},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{49,-60},{61,-72}},
                  lineColor={0,0,127},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid)}),
            Diagram(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics={
            Line(points={{-80,-90},{-80,84}}, color={95,95,95}),
            Polygon(
              points={{-80,97},{-84,81},{-76,81},{-80,97}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Line(points={{-99,-40},{85,-40}}, color={95,95,95}),
            Polygon(
              points={{97,-40},{81,-36},{81,-45},{97,-40}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Line(
              points={{-41,-2},{-31.6,34.2},{-26.1,53.1},{-21.3,66.4},{-17.1,
                  74.6},{-12.9,79.1},{-8.64,79.8},{-4.42,76.6},{-0.201,69.7},{
                  4.02,59.4},{8.84,44.1},{14.9,21.2},{27.5,-30.8},{33,-50.2},{
                  37.8,-64.2},{42,-73.1},{46.2,-78.4},{50.5,-80},{54.7,-77.6},{
                  58.9,-71.5},{63.1,-61.9},{67.9,-47.2},{74,-24.8},{80,0}},
              color={0,0,255},
              thickness=0.5,
              pattern=LinePattern.Dot),
            Text(
              extent={{-87,12},{-40,0}},
              textString="offset"),
            Line(points={{-41,-2},{-41,-40}}, color={95,95,95}),
            Text(
              extent={{-60,-43},{-14,-54}},
              textString="startTick"),
            Text(
              extent={{75,-47},{100,-60}},
              textString="tick"),
            Text(
              extent={{-80,99},{-40,82}},
              textString="y"),
            Line(points={{-9,79},{43,79}}, color={95,95,95}),
            Line(points={{-41,-2},{50,-2}}, color={95,95,95}),
            Polygon(
              points={{33,79},{30,66},{37,66},{33,79}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{37,57},{83,39}},
              textString="amplitude"),
            Polygon(
              points={{33,-2},{30,11},{36,11},{33,-2},{33,-2}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Line(points={{33,77},{33,-2}}, color={95,95,95}),
                Ellipse(
                  extent={{-16,85},{-4,73}},
                  lineColor={0,0,127},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{15,5},{27,-7}},
                  lineColor={0,0,127},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{44,-74},{56,-86}},
                  lineColor={0,0,127},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{74,5},{86,-7}},
                  lineColor={0,0,127},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
            Line(
              points={{-80,-2},{-41,-2}},
              color={0,0,255},
              thickness=0.5,
              pattern=LinePattern.Dot),
                Ellipse(
                  extent={{-86,4},{-74,-8}},
                  lineColor={0,0,127},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{-47,4},{-35,-8}},
                  lineColor={0,0,127},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid)}),
        Documentation(info="<html>
<p>
The Real output y is a sine signal. The signal is defined in terms of clock ticks instead of simulation time:
</p>

<p>
<img src=\"modelica://Modelica_Synchronous/Resources/Images/RealSignals/TickBasedSources_Sine.png\"/>
</p>
</html>"));
        end Sine;
    annotation (Documentation(info="<html>
<p>This package provides <b>source</b> components akin to the blocks provided in <a href=\"Modelica.Blocks.Sources\">Modelica.Blocks.Sources</a>, but with the difference that they provide </p>
<p><ol>
<li>a <b>clocked</b> output signal and</li>
<li>are parametrized in terms of <b>clock ticks</b> rather than simulation time.</li>
</ol></p>
</html>"));
  end TickBasedSources;

  package Interfaces
    "Library of partial blocks for components with clocked Real signals"
    extends Modelica.Icons.InterfacesPackage;

    partial block SamplerIcon
      "Basic graphical layout of block used for sampling of Real signals"

      annotation (
        Icon(
          coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            initialScale=0.06),
          graphics={
            Rectangle(
              extent={{-99,40},{99,-40}},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None),
            Line(points={{-100,0},{-45,0}}, color={0,0,127}),
            Ellipse(
              extent={{-25,-10},{-45,10}},
              lineColor={0,0,127},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{-35,0},{30,35}}, color={0,0,127}),
            Ellipse(
              extent={{45,-10},{25,10}},
              lineColor={0,0,127},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{45,0},{100,0}}, color={0,0,127})}),
        Diagram(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            initialScale=0.06)));
    end SamplerIcon;

    partial block PartialSISOSampler
      "Basic block used for sampling of Real signals"
    extends Clocked.RealSignals.Interfaces.SamplerIcon;
      Modelica.Blocks.Interfaces.RealInput u
        "Connector of continuous-time, Real input signal"
        annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
      Modelica.Blocks.Interfaces.RealOutput y
        "Connector of clocked, Real output signal"
        annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    equation

    end PartialSISOSampler;

    partial block PartialSISOHold
      "Basic block used for zero order hold of Real signals"

      parameter Real y_start = 0.0
        "Value of output y before the first tick of the clock associated to input u";

      Modelica.Blocks.Interfaces.RealInput u(final start=y_start)
        "Connector of clocked, Real input signal"
        annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
      Modelica.Blocks.Interfaces.RealOutput y
        "Connector of continuous-time, Real output signal"
        annotation (Placement(transformation(extent={{100,-10},{120,10}})));

      annotation (
        defaultComponentName="hold1",
        Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={2,2},
            initialScale=0.06),
                         graphics={
            Rectangle(
              extent={{-80,80},{80,-80}},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None),
                                   Line(points={{-60,-40},{-20,-40},{-20,20},{20,20},
                  {20,60},{60,60},{60,0},{100,0},{100,0},{100,0},{100,0},{120,0}},
                                     color={0,0,127}), Line(
              points={{-60,-40},{-60,0},{-100,0}},
              color={0,0,127}),
            Text(
              extent={{-200,-80},{200,-145}},
              textString="%y_start"),
            Text(
              extent={{-200,129},{200,64}},
              lineColor={0,0,255},
              textString="%name")}),
        Documentation(info="<HTML>

</HTML>
"),     Diagram(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            initialScale=0.06)));
    end PartialSISOHold;

    partial block PartialClockedSISO
      "Block with clocked single input and clocked single output Real signals"
      extends Clocked.ClockSignals.Interfaces.ClockedBlockIcon;

      Modelica.Blocks.Interfaces.RealInput u
        "Connector of clocked, Real input signal"
        annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
      Modelica.Blocks.Interfaces.RealOutput y
        "Connector of clocked, Real output signal"
        annotation (Placement(transformation(extent={{100,-10},{120,10}})));

    end PartialClockedSISO;

    partial block PartialClockedMIMO
      "Block with multiple clocked input and multiple clocked output Real signals"
      extends Clocked.ClockSignals.Interfaces.ClockedBlockIcon;

      parameter Integer nin=1 "Number of inputs";
      parameter Integer nout=1 "Number of outputs";

      Modelica.Blocks.Interfaces.RealInput u[nin]
        "Connector of clocked, Real input signals"
                                   annotation (Placement(transformation(extent=
              {{-140,-20},{-100,20}})));
      Modelica.Blocks.Interfaces.RealOutput y[nout]
        "Connector of clocked, Real output signals"
                                    annotation (Placement(transformation(extent=
             {{100,-10},{120,10}})));

    end PartialClockedMIMO;

    partial block PartialClockedSO
      "Block with clocked single output Real signal"
      extends Clocked.ClockSignals.Interfaces.ClockedBlockIcon;

      Modelica.Blocks.Interfaces.RealOutput y
        "Connector of clocked, Real output signal"
        annotation (Placement(transformation(extent={{100,-10},{120,10}})));

      annotation (Diagram(coordinateSystem(preserveAspectRatio=
                false, extent={{-100,-100},{100,100}})));
    end PartialClockedSO;

    partial block PartialNoise
      "Interface for SISO blocks with Real signals that add noise to the signal"
      extends Clocked.RealSignals.Interfaces.PartialClockedSISO;
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}})));
    end PartialNoise;
    annotation (Documentation(info="<html>
<p>
This package contains partial blocks that are used to
construct blocks operating on clocked Real signals.
</p>
</html>"));
  end Interfaces;
  annotation (Documentation(info="<html>
<p>
This package contains blocks that operate on clocked Real signals.
Especially blocks are provided to transform from continuous-time Real signals to
clocked Real signals (with Sampler blocks) and vice versa
(with Hold blocks), as well as to transform a clocked Real signal from
one clock to a different clock in a time-synchronized way.
</p>
</html>"));
end RealSignals;
