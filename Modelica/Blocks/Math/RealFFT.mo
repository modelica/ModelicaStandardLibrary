within Modelica.Blocks.Math;
block RealFFT "Sampling and FFT of input u"
  extends Modelica.Blocks.Interfaces.DiscreteBlock(final samplePeriod=1/(2*f_res*div(ns, 2)));
  parameter SI.Frequency f_max "Maximum frequency of interest";
  parameter SI.Frequency f_res "Frequency resolution";
  final parameter Integer ns=Modelica.Math.FastFourierTransform.realFFTsamplePoints(f_max, f_res, f_max_factor=5) "Number of samples";
  final parameter Integer nf=max(1,min(integer(ceil(f_max/f_res))+1, div(ns, 2))) "Number of frequency points";
  parameter String resultFileName="realFFT.mat" "Result file: f, abs, arg";
  output Integer info(start=0, fixed=true) "Information flag from FFT computation";
  Modelica.Blocks.Interfaces.RealInput u
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}}),iconTransformation(extent={{-140,
            -20},{-100,20}})));
protected
  Real buf[ns](start=zeros(ns), each fixed=true) "Input buffer";
  Real abs[nf](start=zeros(nf), each fixed=true) "FFT amplitudes";
  Real arg[nf](start=zeros(nf), each fixed=true) "FFT phases";
  Integer iTick(start=0, fixed=true) "Sample ticks";
algorithm
  when {sampleTrigger} then
    iTick :=pre(iTick) + 1;
    if iTick <= ns then
      buf[iTick] :=u;
    end if;
  end when;
  when terminal() then
    if iTick < ns then
      assert(false, "Sampling time not sufficient! stopTime>= "+String(startTime + (ns -1)*samplePeriod));
    else
      (info, abs, arg) :=Modelica.Math.FastFourierTransform.realFFT(buf, nf);
      assert(info==0, "Error in FFT");
      Modelica.Math.FastFourierTransform.realFFTwriteToFile(startTime + (ns - 1)*samplePeriod, resultFileName, f_max, abs, arg);
    end if;
  end when;
  annotation (Documentation(info="<html>
<p>
This block samples the input signal, calculates the Fast Fourier Transform by function <a href=\"modelica://Modelica.Math.FastFourierTransform.realFFT\">Math.realFFT</a>,
and (when simulation terminates) writes the output to result file resultFileName by function <a href=\"modelica://Modelica.Math.FastFourierTransform.realFFTwriteToFile\">Math.realFFTwriteToFile</a>.
</p>
<p>
The number of sampling points as well as the samplePeriod is calculated from desired maximum frequency f_max and frequency resolution f_res.
</p>
<h4>Note</h4>
<p>
The user has to take care that enough points can be sampled before the simulation ends: startTime + (ns - 1)*samplePeriod <= stopTime.
</p>
<p>
The result file is written as mat, first column = frequency, second column = amplitudes, third column = phases. The frequency points are separated by rows with amplitude and phase = 0,
so one can plot the result directly as frequency lines.
</p>
</html>"),
         Icon(graphics={    Polygon(
            points={{-80,96},{-86,80},{-74,80},{-80,96}},
            lineColor={135,135,135},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),                    Line(
          points={{-80,-92},{-80,80}},
                                   color={135,135,135}),
                                           Line(points={{-92,-80},{80,
              -80.3976}},
          color={135,135,135}),Polygon(
            points={{96,-80.3976},{80,-74.3976},{80,-86.3976},{96,-80.3976}},
            lineColor={135,135,135},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
        Line(
          points={{-70,60},{-70,-80}},
          thickness=0.5),
        Line(
          points={{-30,-52},{-30,-80}},
          thickness=0.5),
        Line(
          points={{-10,-60},{-10,-80}},
          thickness=0.5),
        Line(
          points={{30,-68},{30,-80}},
          thickness=0.5),
        Line(
          points={{50,-70},{50,-80}},
          thickness=0.5)}));
end RealFFT;
