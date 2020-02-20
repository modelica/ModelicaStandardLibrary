within Modelica.Clocked.RealSignals;
package Sampler "Library of sampler and hold blocks for Real signals"
  extends Modelica.Icons.Package;

  annotation (Documentation(info="<html>
<p>
This package contains blocks that mark boundaries of a clocked partition
and transform a <strong>Real</strong> signal from one partition to the next. Especially,
the following blocks are provided:<br>&nbsp;
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"3\">
<tr><th align=\"left\"><strong>Boundary Type</strong></th>
    <th align=\"left\"><strong>Block Name</strong></th>
    <th align=\"left\"><strong>Description</strong></th></tr>

<tr><td valign=\"top\" rowspan=\"4\">continuous-time &rarr; clocked</td>
      <td><a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.Sample\">Sample</a></td>
      <td>Sample a continuous-time signal.</td>
    </tr>
    <tr>
      <td><a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.SampleClocked\">SampleClocked</a></td>
      <td>Sample and associate a clock to the sampled <strong>scalar</strong> signal.</td>
    </tr>
    <tr>
      <td><a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.SampleVectorizedAndClocked\">SampleVectorizedAndClocked</a></td>
      <td>Sample an input vector and associate a clock to the sampled <strong>vector</strong> signal.</td>
    </tr>
    <tr>
      <td><a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.SampleWithADeffects\">SampleWithADeffects</a></td>
      <td>Sample with (simulated) Analog-Digital converter effects including noise.</td>
    </tr>

<tr><td valign=\"top\" rowspan=\"2\">clocked &rarr; continuous-time</td>
      <td><a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.Hold\">Hold</a></td>
      <td>Hold a clocked signal with zero-order hold.</td>
    </tr>
    <tr>
      <td><a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.HoldWithDAeffects\">HoldWithDAeffects</a></td>
      <td>Hold with (simulated) Digital-Analog converter effects and computational delay.</td>
    </tr>

<tr><td valign=\"top\" rowspan=\"5\">clocked &rarr; clocked</td>
      <td><a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.SubSample\">SubSample</a></td>
      <td>Sub-sample a signal (output clock is slower as input clock).</td>
    </tr>

    <tr>
      <td><a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.SuperSample\">SuperSample</a></td>
      <td>Super-sample a signal (output clock is faster as input clock).</td>
    </tr>

    <tr>
      <td><a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.SuperSampleInterpolated\">SuperSampleInterpolated</a></td>
      <td>Super-sample a signal with linear interpolation (output clock is faster as input clock).</td>
    </tr>

    <tr>
      <td><a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.ShiftSample\">ShiftSample</a></td>
      <td>Shift a signal (output clock is delayed with respect to input clock).</td>
    </tr>

    <tr>
      <td><a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.BackSample\">BackSample</a></td>
      <td>Shift a signal and start the output clock before the input clock with a start value.</td>
    </tr>

<tr><td valign=\"top\" rowspan=\"2\">within clocked partition</td>
      <td><a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.AssignClock\">AssignClock</a></td>
      <td>Assign a clock to a clocked <strong>scalar</strong> signal.</td>
    </tr>
    <tr>
      <td><a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.AssignClockVectorized\">AssignClockVectorized</a></td>
      <td>Assign a clock to a clocked <strong>vector</strong> signal.</td>
    </tr>
</table>

<p>
Additionally, package
<a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.Utilities\">Utilities</a>
contains utility blocks that are used as building blocks for user-relevant blocks.
Especially, block
<a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.Utilities.UpSample\">UpSample</a>
can be used in combination with a
<a href=\"modelica://Modelica.Clocked.RealSignals.Periodic.FIRbyCoefficients\">FIR filter</a>
block to model super-sampling with interpolation and filtering.
</p>
</html>"));
end Sampler;
