within Modelica.Blocks.Examples;
model Rectifier12pulseFFT "Example of FFT block"
  extends Modelica.Electrical.Machines.Examples.Transformers.Rectifier12pulse;
  Modelica.Blocks.Math.RealFFT realFFT(
    startTime=0.04,
    f_max=2000,
    f_res=5,
    resultFileName="rectifier12pulseFFTresult.mat")
                                              annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        origin={-40,-20})));
equation
  connect(currentSensor.i[1], realFFT.u) annotation (Line(points={{-70,-11},{-70,-20},{-52,-20}},
                                 color={0,0,127}));
  annotation (experiment(StopTime=0.25, Interval=0.0001),
    Documentation(info="<html>
<p>
This example is based on a&nbsp;<a href=\"modelica://Modelica.Electrical.Machines.Examples.Transformers.Rectifier12pulse\">12-pulse rectifier example</a>,
calculating the harmonics with the <a href=\"modelica://Modelica.Blocks.Math.RealFFT\">FFT block</a>.
</p>
<p>
Sampling starts after the initial transients are settled - waiting for
<code>2&nbsp;periods&nbsp;= 2/f&nbsp;= 0.04&nbsp;s&nbsp;= realFFT.startTime</code>.
Choosing a&nbsp;maximum frequency <code>f_max&nbsp;=&nbsp;2000&nbsp;Hz</code>,
a&nbsp;frequency resolution <code>f_res&nbsp;=&nbsp;5&nbsp;Hz</code>
(both given in the block <code>realFFT</code>) and
the default oversampling factor <code>f_max_factor&nbsp;=&nbsp;5</code>,
we have to acquire <code>n&nbsp;= 2*f_max/f_res*f_max_factor&nbsp;=&nbsp;4000</code>
sampling intervals.
The resulting sampling interval is <code>samplePeriod&nbsp;=&nbsp;1/(n*f_res)&nbsp;=&nbsp;0.05&nbsp;ms</code>.
Thus, we have to sample for a&nbsp;period of <code>n*samplePeriod = 1/f_res = 0.2 s</code>.
</p>
<p>
The resultfile &quot;rectifier12pulseFFTresult.mat&quot; can be used to plot amplitudes versus frequencies.
Note that for each frequency three rows exit: one with amplitude zero,
one with the calculated amplitude, one with amplitude zero.
Thus, the second column (amplitude) can be easily plotted versus the first column (frequency).
As expected, one can see the 11<sup>th</sup>, 13<sup>th</sup>, 23<sup>th</sup>, 25<sup>th</sup>,
&hellip; harmonic in the result.
</p>
</html>"));
end Rectifier12pulseFFT;
