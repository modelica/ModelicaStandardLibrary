within Modelica.Math;
package FastFourierTransform
  "Library of functions for the Fast Fourier Transform (FFT)"
  extends Modelica.Icons.Package;

  package Examples
    "Examples demonstrating the usage of the Math.FastFourierTransform functions"
   extends Modelica.Icons.ExamplesPackage;

    model RealFFT1
      "Example demonstrating the use of an FFT calculation during simulation"
      import Modelica.Constants.pi;
      extends Modelica.Icons.Example;
      parameter Modelica.SIunits.Frequency f_max = 4
        "Maximum frequency of interest";
      parameter Modelica.SIunits.Frequency f_resolution = 0.2
        "Frequency resolution";
      parameter Modelica.SIunits.Frequency f1 = 2 "Frequency of first sine";
      parameter Modelica.SIunits.Frequency f2 = 3 "Frequency of second sine";
      Real y(final start=0, final fixed=true)
        "Signal from which FFT is computed";
      final parameter Integer nfi = max(1,min(integer(ceil(f_max/f_resolution))+1,nf))
        "Number of frequency points of the interested frequency range (only up to f_max";
      final parameter Real fi[nfi](each fixed=false)
        "FFT frequencies of interested frequency points";
      Real Ai[nfi] "FFT amplitudes of interested frequency points";
      Integer info(final start=0, final fixed=true)
        "Information flag from FFT computation; = 0: FFT successfully computed";
    protected
      parameter Integer ns = realFFTsamplePoints(        f_max, f_resolution);
      parameter Modelica.SIunits.Frequency f_max_FFT = f_resolution*div(ns, 2)
        "Maximum frequency used by FFT";
      parameter Integer nf = div(ns,2) + 1 "Number of frequency points";
      parameter Modelica.SIunits.Time Ts = 1/(2*f_max_FFT) "Sample period";
      parameter Modelica.SIunits.Time T = (ns - 1)*Ts
        "Simulation time for one FFT calculation";
      Integer iTick(start=0, fixed=true);
      Real A[nf](each start=0, each fixed=true) "FFT amplitudes";
      Real y_buf[ns](each start=0, each fixed=true);
    initial equation
      for i in 1:nfi loop
         fi[i] = (i-1)*f_resolution;
      end for;

    algorithm
      when sample(0,Ts) then
         iTick :=pre(iTick) + 1;
         y := 5 + 3*sin(2*pi*f1*time) + 1.5*sin(2*pi*f2*time);
         if iTick >= 1 and iTick <= ns then
            y_buf[iTick] := y;
         end if;
      end when;

    equation
      when iTick >= ns then
        (info,A) = realFFT(y_buf);
         Ai = A[1:nfi];
      end when;

      annotation (experiment(StopTime=6),
        Documentation(revisions="<html>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td valign=\"top\"> Nov. 29, 2015 </td>
    <td valign=\"top\">
     Initial version implemented by
     Martin R. Kuhn and Martin Otter
     (<a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>.</td></tr>
</table>
</html>",
      info="<html>
<p>
In this example the signal y
</p>

<pre>
   y = 5 + 3*sin(2*pi*f1) + 1.5*sin(2*pi*f2)
</pre>

<p>
is sampled and an FFT is computed from the sampled signal (default: f1 = 2 Hz, f2 = 3 Hz).
In the public part the FFT is stored up to f_max (internally in the protected part the FFT is stored up to 5*f_max).
With the default values for f_max (= 4 Hz) and f_resolution (= 0.2 Hz), the following results are achieved:
</p>

<pre>   fi[0]  = 0,  Ai[0]  = 5;   // mean value of signal
   fi[11] = 2,  Ai[11] = 3;   // frequency/amplitude of first sine
   fi[16] = 3,  Ai[16] = 1.5; // frequency/amplitude of second sine
</pre>

<p>
A plot of the resulting FFT is shown in the next image:
</p>

<p><blockquote>
<img src=\"modelica://Modelica/Resources/Images/Math/FFT1.png\">
</blockquote></p>


</html>"));
    end RealFFT1;
    annotation (Documentation(revisions="<html>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td valign=\"top\"> Nov. 29, 2015 </td>
    <td valign=\"top\">
     Initial version implemented by
     Martin R. Kuhn and Martin Otter
     (<a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>.</td></tr>
</table>
</html>"));
  end Examples;

  function realFFTinfo
    "Print information about real FFT for given f_max and f_resolution"
    import Modelica.Utilities.Streams.print;
    input Modelica.SIunits.Frequency f_max "Maximum frequency";
    input Modelica.SIunits.Frequency f_resolution "Frequency resolution";
    input Integer f_max_factor(min=1)=5
      "Maximum FFT frequency >= f_max*f_max_factor (sample frequency = 2*Maximum FFT Frequency)";
  protected
    Integer ns = realFFTsamplePoints(f_max, f_resolution, f_max_factor);
    Integer nf = div(ns,2)+1;
    Modelica.SIunits.Frequency f_max_used = f_resolution*div(ns, 2);
    Modelica.SIunits.Frequency fs = f_max_used*2;
    Modelica.SIunits.Time Ts= 1/(2*f_max_used) "Sample period";
    Modelica.SIunits.Time T=(ns - 1)*Ts "Simulation time for FFT calculation";
    Integer e2, e3, e5;
    Boolean success;
  algorithm
    (success,e2,e3,e5) := Internal.prime235Factorization(ns);

    print("\n... Real FFT properties");
    print(" Desired:");
    print("    f_max         = " + String(f_max) + " Hz");
    print("    f_resolution  = " + String(f_resolution) + " Hz");
    print("    f_max_factor  = " + String(f_max_factor));
    print(" Calculated:");
    print("    Number of sample points    = " + String(ns) + " (= 2^"+String(e2)+"*3^"+String(e3)+"*5^"+String(e5)+")");
    print("    Sampling frequency         = " + String(fs) + " Hz (= " + String(f_resolution) + "*" + String(ns) + ")");
    print("    Sampling period            = " + String(Ts) + " s (= " + "1/" + String(fs) + ")");
    print("    Maximum FFT frequency      = " + String(f_max_used) + " Hz (= " + String(f_resolution) + "*" + String(ns) + "/2; "
                                                                   + "f={0," + String(f_resolution) + ","
                                                                   + String(2*f_resolution) + ",...,"
                                                                   + String(f_max_used) + "} Hz)");
    print("    Number of frequency points = " + String(nf) + " (= " + String(ns) + "/2+1)");
    print("    Simulation time            = " + String(T) + " s");
    annotation (Documentation(revisions="<html>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td valign=\"top\"> Nov. 29, 2015 </td>
    <td valign=\"top\">
     Initial version implemented by
     Martin R. Kuhn and Martin Otter
     (<a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>.</td></tr>
</table>
</html>",
        info="<html>
<h4>Syntax</h4>

<blockquote><p>
<b>realFFTinfo</b>(f_max, f_resolution, f_max_factor=5);
</p></blockquote>

<h4>Description</h4>
<p>
From the maximum interested frequency f_max (in [Hz]) and the frequency resolution f_resolution (in [Hz]) the
function computes the key FFT data as used by the FFT blocks and prints them to the output window.
</p>

<h4>Example</h4>
<blockquote>
realFFTinfo(f_max=170, f_resolution=0.3)
</blockquote>

<p>
results in the following output:
</p>

<pre>
... Real FFT properties
 Desired:
    f_max         = 170 Hz
    f_resolution  = 0.3 Hz
    f_max_factor  = 5
 Calculated:
    Number of sample points    = 5760 (= 2^7*3^2*5^1)
    Sampling frequency         = 1728 Hz (= 0.3*5760)
    Sampling period            = 0.000578704 s (= 1/1728)
    Maximum FFT frequency      = 864 Hz (= 0.3*5760/2; f={0,0.3,0.6,...,864} Hz)
    Number of frequency points = 2881 (= 5760/2+1)
    Simulation time            = 3.33275 s
</pre>
</html>"));
  end realFFTinfo;

  function realFFTsamplePoints "Return number of sample points for a real FFT"
     input Modelica.SIunits.Frequency f_max "Maximum frequency of interest";
     input Modelica.SIunits.Frequency f_resolution "Frequency resolution";
     input Integer f_max_factor(min=1)=5
      "Maximum FFT frequency >= f_max*f_max_factor (sample frequency = 2*Maximum FFT Frequency)";
     output Integer ns
      "Number of sample points that can be expressed as ns = 2^i*3^j*5^k and ns is even";
  protected
     Integer ns1;
  algorithm
     // Check input arguments
     assert(f_resolution > 0, "f_resolution > 0 required");
     assert(f_max > f_resolution, "f_max > f_resolution required");

     // Compute best ns according to f_max*f_max_factor and f_resolution = roundAgainstInfinity(2*f_max*f_max_factor/f_resolution)
     ns1 :=2*integer(ceil(f_max*f_max_factor/f_resolution));

     // If necessary, enlarge ns1 so that it is even and can be expressed as 2^i*3^j*5^k
     ns :=if mod(ns1, 2) == 0 then ns1 else ns1 + 1;

     while true loop
        ns1 :=ns;
        while mod(ns1,2) == 0 loop ns1 :=div(ns1, 2);end while;
        while mod(ns1,3) == 0 loop ns1 :=div(ns1, 3);end while;
        while mod(ns1,5) == 0 loop ns1 :=div(ns1, 5);end while;

        if ns1 <= 1 then
           break;
        end if;
        ns :=ns + 2;
     end while;
    annotation (Documentation(revisions="<html>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td valign=\"top\"> Nov. 29, 2015 </td>
    <td valign=\"top\">
     Initial version implemented by
     Martin R. Kuhn and Martin Otter
     (<a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>.</td></tr>
</table>
</html>",
      info="<html>
<h4>Syntax</h4>

<blockquote><p>
ns = <b>realFFTsamplePoints</b>(f_max, f_resolution, f_max_factor=5);
</p></blockquote>

<h4>Description</h4>
<p>
From the maximum interested frequency f_max (in [Hz]) and the frequency resolution f_resolution (in [Hz]) the
function computes the number of sample points ns that is as small as possible and fulfills the following criteria:
</p>

<ul>
<li> Maximum FFT frequency &ge; f_max_factor*f_max (= the largest frequency value of the frequency vector).</li>
<li> Frequency axis resolution is f_resolution.</li>
<li> The number of sample points can be expressed as 2^a*3^b*5^c
     (and a,b,c are appropriate Integers).</li>
<li> The number of sample points is even.</li>
</ul>

<p>
Note, in the original publication about the efficient computation of FFT (Cooley and Tukey, 1965),
the number of sample points must be 2^a. However, all newer FFT algorithms do not have
this strong restriction and especially not the open source software
<a href=\"http://sourceforge.net/projects/kissfft/\">KissFFT</a> from Mark Borgerding
used in this function
</p>

<h4>References</h4>

<dl>
<dt>Mark Borgerding (2010):</dt>
<dd> <b>KissFFT, version 1.3.0</b>.
     <a href=\"http://sourceforge.net/projects/kissfft/\">http://sourceforge.net/projects/kissfft/</a>.
     <br>&nbsp;
     </dd>

<dt>James W. Cooley, John W. Tukey (1965):</dt>
<dd> <b>An algorithm for the machine calculation of complex Fourier series</b>.
     Math. Comput. 19: 297–301. doi:10.2307/2003354.
     <br>&nbsp;
     </dd>

<dt>Martin R. Kuhn, Martin Otter, Tim Giese (2015):</dt>
<dd> <b>Model Based Specifications in Aircraft Systems Design</b>.
     Modelica 2015 Conference, Versailles, France,
     pp. 491-500, Sept.23-25, 2015.
     Download from:
     <a href=\"http://www.ep.liu.se/ecp/118/053/ecp15118491.pdf\">http://www.ep.liu.se/ecp/118/053/ecp15118491.pdf</a>
     </dd>
</dl>


<h4>Example</h4>
<blockquote>
ns = realFFTinfo(f_max=170, f_resolution=0.3)
</blockquote>

<p>
results in the following output:
</p>

<pre>   ns = 5760
</pre>
</html>"));
  end realFFTsamplePoints;

  function realFFT "Return amplitude and phase vectors for a real FFT"
    input Real  u[:]
      "Signal for which FFT shall be computed (size(nu,1) MUST be EVEN and should be an integer multiple of 2,3,5, that is size(nu,1) = 2^a*3^b*5^c, with a,b,c Integer >= 0)";
    output Integer info
      "Information flag (0: FFT computed, 1: nu is not even, 3: another error)";
    output Real amplitudes[ div(size(u,1),2)+1] "Amplitudes of FFT";
    output Real phases[     div(size(u,1),2)+1] "Phases of FFT";
  protected
    Integer nu = size(u,1);
    Integer nf = div(size(u,1),2)+1;
    Real u_DC;
    Real u2[size(u,1)];
  algorithm
    u_DC :=sum(u)/nu;
    u2   :=u - fill(u_DC, nu);
    (info, amplitudes, phases) :=Internal.rawRealFFT(u);
    amplitudes[1] :=u_DC;
  annotation (Documentation(revisions="<html>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td valign=\"top\"> Nov. 29, 2015 </td>
    <td valign=\"top\">
     Initial version implemented by
     Martin R. Kuhn and Martin Otter
     (<a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>.</td></tr>
</table>
</html>",
      info="<html>
<h4>Syntax</h4>

<blockquote><p>
(info, amplitudes, phases) = <b>realFFT</b>(u);
</p></blockquote>

<h4>Description</h4>
<p>
The input argument of this function is a Real vector u. size(u,1) <b>must</b> be even. An efficient computation
is performed, if size(u,1) = 2^a*3^b*5^c (a,b,c Integer &ge; 0).
The function computes a real FFT (Fast Fourier Transform) of u and returns the result
in form of the outputs amplitudes and phases. Argument info provides additional information:
</p>

<pre>   info = 0: Successful FFT computation.
   info = 1: size(u,1) is not even.
   info = 3: Another error.
</pre>

<p>
Note, in the original publication about the efficient computation of FFT (Cooley and Tukey, 1965),
the number of sample points must be 2^a. However, all newer FFT algorithms do not have
this strong restriction and especially not the open source software
<a href=\"http://sourceforge.net/projects/kissfft/\">KissFFT</a> from Mark Borgerding
used in this function.
</p>

<p>
The function returns the FFT such that amplitudes[1] is the mean value of u (= sum(u)/size(u,1)), and
amplitudes[i] is the amplitude of a sine-function at the i-th frequency.
</p>

<h4>References</h4>

<dl>
<dt>Mark Borgerding (2010):</dt>
<dd> <b>KissFFT, version 1.3.0</b>.
     <a href=\"http://sourceforge.net/projects/kissfft/\">http://sourceforge.net/projects/kissfft/</a>.
     <br>&nbsp;
     </dd>

<dt>James W. Cooley, John W. Tukey (1965):</dt>
<dd> <b>An algorithm for the machine calculation of complex Fourier series</b>.
     Math. Comput. 19: 297–301. doi:10.2307/2003354.
     <br>&nbsp;
     </dd>

<dt>Martin R. Kuhn, Martin Otter, Tim Giese (2015):</dt>
<dd> <b>Model Based Specifications in Aircraft Systems Design</b>.
     Modelica 2015 Conference, Versailles, France,
     pp. 491-500, Sept.23-25, 2015.
     Download from:
     <a href=\"http://www.ep.liu.se/ecp/118/053/ecp15118491.pdf\">http://www.ep.liu.se/ecp/118/053/ecp15118491.pdf</a>
     </dd>
</dl>


<h4>Example</h4>
<blockquote>
(info, A) = realFFT({0,0.1,0.2,0.4,0.5, 0.6})
</blockquote>
</html>"));
  end realFFT;

  package Internal
    "Internal library that should not be used directly by the user"
    extends Modelica.Icons.InternalPackage;
    function rawRealFFT
      "Compute raw Fast Fourier Transform for real signal vector"
      input Real  u[:]
        "Signal for which FFT shall be computed (size(nu,1) MUST be EVEN and should be an integer multiple of 2,3,5, that is size(nu,1) = 2^a*3^b*5^c, with a,b,c Integer >= 0)";
      output Integer info
        "Information flag (0: FFT computed, 1: nu is not even, 2: nwork is wrong, 3: another error)";
      output Real amplitudes[div(size(u,1),2)+1] "Amplitudes of FFT";
      output Real phases[    div(size(u,1),2)+1] "Phases of FFT";
    protected
      Real work[3*size(u,1) + 2*(div(size(u,1),2)+1)];
      external "C" info = ModelicaFFT_kiss_fftr(u, size(u,1), work, size(work,1), amplitudes, phases) annotation(Library="ModelicaExternalC");
      annotation (Documentation(revisions="<html>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td valign=\"top\"> Nov. 29, 2015 </td>
    <td valign=\"top\">
     Initial version implemented by
     Martin R. Kuhn and Martin Otter
     (<a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>.</td></tr>
</table>
</html>",
      info="<html>
<h4>Syntax</h4>

<blockquote><p>
(info, amplitudes, phases) = <b>rawRealFFT</b>(u);
</p></blockquote>

<h4>Description</h4>
<p>
Raw interface to a function of the Kiss_FFT package to compute the FFT of a real, sampled signal.
The input argument of this function is a Real vector u. size(u,1) <b>must</b> be even. An efficient computation
is performed, if size(u,1) = 2^a*3^b*5^c (a,b,c Integer &ge; 0).
The function computes a real FFT (Fast Fourier Transform) of u and returns the result
in form of the outputs amplitudes and phases. Argument info provides additional information:
</p>

<pre>   info = 0: Successful FFT computation.
   info = 1: size(u,1) is not even.
   info = 2: size(work,1) is not correct (= a protected utility array).
   info = 3: Another error.
</pre>

<p>
Note, in the original publication about the efficient computation of FFT (Cooley and Tukey, 1965),
the number of sample points must be 2^a. However, all newer FFT algorithms do not have
this strong restriction and especially not the open source software
<a href=\"http://sourceforge.net/projects/kissfft/\">KissFFT</a> from Mark Borgerding
used in this function.
</p>

<h4>References</h4>

<dl>
<dt>Mark Borgerding (2010):</dt>
<dd> <b>KissFFT, version 1.3.0</b>.
     <a href=\"http://sourceforge.net/projects/kissfft/\">http://sourceforge.net/projects/kissfft/</a>.
     <br>&nbsp;
     </dd>

<dt>James W. Cooley, John W. Tukey (1965):</dt>
<dd> <b>An algorithm for the machine calculation of complex Fourier series</b>.
     Math. Comput. 19: 297–301. doi:10.2307/2003354.
     <br>&nbsp;
     </dd>

<dt>Martin R. Kuhn, Martin Otter, Tim Giese (2015):</dt>
<dd> <b>Model Based Specifications in Aircraft Systems Design</b>.
     Modelica 2015 Conference, Versailles, France,
     pp. 491-500, Sept.23-25, 2015.
     Download from:
     <a href=\"http://www.ep.liu.se/ecp/118/053/ecp15118491.pdf\">http://www.ep.liu.se/ecp/118/053/ecp15118491.pdf</a>
     </dd>
</dl>


<h4>Example</h4>
<blockquote>
(info, A, phases) = realFFT({0,0.1,0.2,0.4,0.5, 0.6})
</blockquote>
</html>"));
    end rawRealFFT;

    function prime235Factorization
      "Factorization of an integer in prime numbers 2,3,5"
      input Integer n;
      output Boolean success "= true, if factorization in 2,3,5 is possible";
      output Integer e2 "n = 2^e2*3^e3*5^e5";
      output Integer e3 "n = 2^e2*3^e3*5^e5";
      output Integer e5 "n = 2^e2*3^e3*5^e5";
    protected
      Integer ns1 = n;
    algorithm
      e2:=0;
      e3:=0;
      e5:=0;
      while mod(ns1,2) == 0 loop
         ns1 :=div(ns1, 2);
         e2 :=e2 + 1;
      end while;

      while mod(ns1,3) == 0 loop
         ns1 :=div(ns1, 3);
         e3 := e3+1;
      end while;

      while mod(ns1,5) == 0 loop
         ns1 :=div(ns1, 5);
         e5 :=e5 + 1;
      end while;

      success :=ns1 <= 1;
      annotation (Documentation(revisions="<html>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td valign=\"top\"> Nov. 29, 2015 </td>
    <td valign=\"top\">
     Initial version implemented by
     Martin R. Kuhn and Martin Otter
     (<a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>.</td></tr>
</table>
</html>",
      info="<html>
<h4>Syntax</h4>

<blockquote><p>
(success, e2, e3, e5) = <b>prime235Factorization</b>(n);
</p></blockquote>

<h4>Description</h4>
<p>
Compute the factorization of input Integer n in prime numbers 2, 3, and 5. If this is possible, success = true and
e2 is the number of prime numbers2, e3 the number of prime numbers 3 and e5 the number of prime numbers 5.
If this is not possible, success = false, and e2, e3, e5 are dummy values.
</p>

<h4>Example</h4>
<blockquote><pre>(success, e2, e3, e5) = prime235Factorization(60)   // success=true, e2=2, e3=1, e5=1 (= 2^2*3^1*5^1)
(success, e2, e3, e5) = prime235Factorization(7)    // success=false
</pre></blockquote>
</html>"));
    end prime235Factorization;
  annotation (Documentation(revisions="<html>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td valign=\"top\"> Nov. 29, 2015 </td>
    <td valign=\"top\">
     Initial version implemented by
     Martin R. Kuhn and Martin Otter
     (<a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>.</td></tr>
</table>
</html>"));
  end Internal;
annotation (Documentation(info="<html>
<p>
This package provides functions to compute the Fast Fourier Transform (FFT).

<p>
For an example see <a href=\"modelica://Modelica.Math.FastFourierTransform.Examples.RealFFT1\">Examples.RealFFT1</a>
where the following signal is computed during simulation
</p>

<pre>
   y = 5 + 3*sin(2*pi*2) + 1.5*sin(2*pi*3)
</pre>

<p>
the continuous-time signal y is sampled and the FFT is computed with a call to realFFT(f_max=4, f_resolution=0.2),
resulting in:
</p>

<p><blockquote>
<img src=\"modelica://Modelica/Resources/Images/Math/FFT1.png\">
</blockquote></p>


<h4>References</h4>

<dl>
<dt>Mark Borgerding (2010):</dt>
<dd> <b>KissFFT, version 1.3.0</b>.
     <a href=\"http://sourceforge.net/projects/kissfft/\">http://sourceforge.net/projects/kissfft/</a>.
     <br>&nbsp;
     </dd>

<dt>James W. Cooley, John W. Tukey (1965):</dt>
<dd> <b>An algorithm for the machine calculation of complex Fourier series</b>.
     Math. Comput. 19: 297–301. doi:10.2307/2003354.
     <br>&nbsp;
     </dd>

<dt>Martin R. Kuhn, Martin Otter, Tim Giese (2015):</dt>
<dd> <b>Model Based Specifications in Aircraft Systems Design</b>.
     Modelica 2015 Conference, Versailles, France,
     pp. 491-500, Sept.23-25, 2015.
     Download from:
     <a href=\"http://www.ep.liu.se/ecp/118/053/ecp15118491.pdf\">http://www.ep.liu.se/ecp/118/053/ecp15118491.pdf</a>
     </dd>
</dl>
</html>",
      revisions="<html>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td valign=\"top\"> Nov. 29, 2015 </td>
    <td valign=\"top\">
     Initial version implemented by
     Martin R. Kuhn and Martin Otter
     (<a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>.</td></tr>
</table>
</html>"), Icon(graphics={
        Line(points={{-60,20},{-60,-80}}, color={95,95,95}),
        Line(points={{-20,60},{-20,-80}}, color={95,95,95}),
        Line(points={{20,40},{20,-80}}, color={95,95,95}),
        Line(points={{60,-20},{60,-80}},color={95,95,95})}));
end FastFourierTransform;
