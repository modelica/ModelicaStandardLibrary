within Modelica.Clocked.RealSignals.Sampler;
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
          extent={{-150,-150},{150,-190}},
          textString="%shiftCounter/%resolution")}),
    Documentation(info="<html>
<p>
This block is similar to the
<a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.Hold\">Hold</a>
block. The only difference is that simulated real-world effects are applied on the
clocked input signal u before transforming the signal to a continuous-time signal
with a zero-order hold. In particular:
</p>

<ul>
<li> The output is delayed by a fraction of the clock period,
     if parameter <strong>computationalDelay</strong> = true.
     The delay is defined by shiftCounter/resolution*interval(),
     where <strong>shiftCounter</strong> and <strong>resolution</strong> are Integer parameters and
     interval() is the time duration from the previous to the current
     clock tick. The maximal possible computational delay is one clock
     duration, and therefore there is the restriction that
     shiftCounter &le; resolution.</li>
<li> The output is limited, if parameter <strong>limited</strong> = true.</li>
<li> The output is value discretized in the form of an Digital-Analog converter
     with a definable number of bits,
     if parameters <strong>limited</strong> = true, and <strong>quantized</strong> = true.</li>
</ul>

<h4>Example</h4>

<p>
The following
<a href=\"modelica://Modelica.Clocked.Examples.Elementary.RealSignals.HoldWithDAeffects1\">example</a>
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
<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/HoldWithDAeffects1_Model.png\" alt=\"HoldWithDAeffects1_Model.png\"></td>
    <td valign=\"bottom\">&nbsp;&nbsp;&nbsp;
                        <img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/HoldWithDAeffects1_Result.png\" alt=\"HoldWithDAeffects1_Result.png\"></td>
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
If the hold output is delayed by one sample period, then the <strong>previous</strong>(&hellip;) value of the
input is output, and the first tick is delayed by one sample period,
as shown by the
<a href=\"modelica://Modelica.Clocked.Examples.Elementary.RealSignals.HoldWithDAeffects2\">modified example</a>
from above:<br>
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/HoldWithDAeffects2_Model.png\" alt=\"HoldWithDAeffects2_Model.png\"></td>
    <td valign=\"bottom\">&nbsp;&nbsp;&nbsp;
                        <img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/HoldWithDAeffects2_Result.png\" alt=\"HoldWithDAeffects2_Result.png\"></td>
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
</html>"));
end HoldWithDAeffects;
