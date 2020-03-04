within Modelica.Blocks.Continuous;
block Filter
  "Continuous low pass, high pass, band pass or band stop IIR-filter of type CriticalDamping, Bessel, Butterworth or ChebyshevI"
  import Modelica.Blocks.Continuous.Internal;

  extends Modelica.Blocks.Interfaces.SISO;

  parameter Modelica.Blocks.Types.AnalogFilter analogFilter=Modelica.Blocks.Types.AnalogFilter.CriticalDamping
    "Analog filter characteristics (CriticalDamping/Bessel/Butterworth/ChebyshevI)";
  parameter Modelica.Blocks.Types.FilterType filterType=Modelica.Blocks.Types.FilterType.LowPass
    "Type of filter (LowPass/HighPass/BandPass/BandStop)";
  parameter Integer order(min=1) = 2 "Order of filter";
  parameter SI.Frequency f_cut "Cut-off frequency";
  parameter Real gain=1.0
    "Gain (= amplitude of frequency response at zero frequency)";
  parameter Real A_ripple(unit="dB") = 0.5
    "Pass band ripple for Chebyshev filter (otherwise not used); > 0 required"
    annotation(Dialog(enable=analogFilter==Modelica.Blocks.Types.AnalogFilter.ChebyshevI));
  parameter SI.Frequency f_min=0
    "Band of band pass/stop filter is f_min (A=-3db*gain) .. f_cut (A=-3db*gain)"
    annotation(Dialog(enable=filterType == Modelica.Blocks.Types.FilterType.BandPass or
                             filterType == Modelica.Blocks.Types.FilterType.BandStop));
  parameter Boolean normalized=true
    "= true, if amplitude at f_cut = -3db, otherwise unmodified filter";
  parameter Modelica.Blocks.Types.Init init=Modelica.Blocks.Types.Init.SteadyState
    "Type of initialization (no init/steady state/initial state/initial output)"
    annotation(Evaluate=true, Dialog(tab="Advanced"));
  final parameter Integer nx = if filterType == Modelica.Blocks.Types.FilterType.LowPass or
                                  filterType == Modelica.Blocks.Types.FilterType.HighPass then
                                  order else 2*order;
  parameter Real x_start[nx] = zeros(nx) "Initial or guess values of states"
    annotation(Dialog(tab="Advanced"));
  parameter Real y_start = 0 "Initial value of output"
    annotation(Dialog(tab="Advanced"));
  parameter Real u_nominal = 1.0
    "Nominal value of input (used for scaling the states)"
  annotation(Dialog(tab="Advanced"));
  Modelica.Blocks.Interfaces.RealOutput x[nx] "Filter states";

protected
  parameter Integer ncr = if analogFilter == Modelica.Blocks.Types.AnalogFilter.CriticalDamping then
                             order else mod(order,2);
  parameter Integer nc0 = if analogFilter == Modelica.Blocks.Types.AnalogFilter.CriticalDamping then
                             0 else integer(order/2);
  parameter Integer na = if filterType == Modelica.Blocks.Types.FilterType.BandPass or
                            filterType == Modelica.Blocks.Types.FilterType.BandStop then order else
                         if analogFilter == Modelica.Blocks.Types.AnalogFilter.CriticalDamping then
                            0 else integer(order/2);
  parameter Integer nr = if filterType == Modelica.Blocks.Types.FilterType.BandPass or
                            filterType == Modelica.Blocks.Types.FilterType.BandStop then 0 else
                         if analogFilter == Modelica.Blocks.Types.AnalogFilter.CriticalDamping then
                            order else mod(order,2);

  // Coefficients of prototype base filter (low pass filter with w_cut = 1 rad/s)
  parameter Real cr[ncr](each fixed=false);
  parameter Real c0[nc0](each fixed=false);
  parameter Real c1[nc0](each fixed=false);

  // Coefficients for differential equations.
  parameter Real r[nr](each fixed=false);
  parameter Real a[na](each fixed=false);
  parameter Real b[na](each fixed=false);
  parameter Real ku[na](each fixed=false);
  parameter Real k1[if filterType == Modelica.Blocks.Types.FilterType.LowPass then 0 else na](
                 each fixed = false);
  parameter Real k2[if filterType == Modelica.Blocks.Types.FilterType.LowPass then 0 else na](
                 each fixed = false);

  // Auxiliary variables
  Real uu[na+nr+1];

initial equation
   if analogFilter == Modelica.Blocks.Types.AnalogFilter.CriticalDamping then
      cr = Internal.Filter.base.CriticalDamping(order, normalized);
   elseif analogFilter == Modelica.Blocks.Types.AnalogFilter.Bessel then
      (cr,c0,c1) = Internal.Filter.base.Bessel(order, normalized);
   elseif analogFilter == Modelica.Blocks.Types.AnalogFilter.Butterworth then
      (cr,c0,c1) = Internal.Filter.base.Butterworth(order, normalized);
   elseif analogFilter == Modelica.Blocks.Types.AnalogFilter.ChebyshevI then
      (cr,c0,c1) = Internal.Filter.base.ChebyshevI(order, A_ripple, normalized);
   end if;

   if filterType == Modelica.Blocks.Types.FilterType.LowPass then
      (r,a,b,ku) = Internal.Filter.roots.lowPass(cr,c0,c1,f_cut);
   elseif filterType == Modelica.Blocks.Types.FilterType.HighPass then
      (r,a,b,ku,k1,k2) = Internal.Filter.roots.highPass(cr,c0,c1,f_cut);
   elseif filterType == Modelica.Blocks.Types.FilterType.BandPass then
      (a,b,ku,k1,k2) = Internal.Filter.roots.bandPass(cr,c0,c1,f_min,f_cut);
   elseif filterType == Modelica.Blocks.Types.FilterType.BandStop then
      (a,b,ku,k1,k2) = Internal.Filter.roots.bandStop(cr,c0,c1,f_min,f_cut);
   end if;

   if init == Modelica.Blocks.Types.Init.InitialState then
      x = x_start;
   elseif init == Modelica.Blocks.Types.Init.SteadyState then
      der(x) = zeros(nx);
   elseif init == Modelica.Blocks.Types.Init.InitialOutput then
      y = y_start;
      if nx > 1 then
         der(x[1:nx-1]) = zeros(nx-1);
      end if;
   end if;

equation
   assert(u_nominal > 0, "u_nominal > 0 required");
   assert(filterType == Modelica.Blocks.Types.FilterType.LowPass or
          filterType == Modelica.Blocks.Types.FilterType.HighPass or
          f_min > 0, "f_min > 0 required for band pass and band stop filter");
   assert(A_ripple > 0, "A_ripple > 0 required");
   assert(f_cut > 0, "f_cut > 0 required");

   /* All filters have the same basic differential equations:
        Real poles:
           der(x) = r*x - r*u
        Complex conjugate poles:
           der(x1) = a*x1 - b*x2 + ku*u;
           der(x2) = b*x1 + a*x2;
   */
   uu[1] = u/u_nominal;
   for i in 1:nr loop
      der(x[i]) = r[i]*(x[i] - uu[i]);
   end for;
   for i in 1:na loop
      der(x[nr+2*i-1]) = a[i]*x[nr+2*i-1] - b[i]*x[nr+2*i] + ku[i]*uu[nr+i];
      der(x[nr+2*i])   = b[i]*x[nr+2*i-1] + a[i]*x[nr+2*i];
   end for;

   // The output equation is different for the different filter types
   if filterType == Modelica.Blocks.Types.FilterType.LowPass then
      /* Low pass filter
           Real poles             :  y = x
           Complex conjugate poles:  y = x2
      */
      for i in 1:nr loop
         uu[i+1] = x[i];
      end for;
      for i in 1:na loop
         uu[nr+i+1] = x[nr+2*i];
      end for;

   elseif filterType == Modelica.Blocks.Types.FilterType.HighPass then
      /* High pass filter
           Real poles             :  y = -x + u;
           Complex conjugate poles:  y = k1*x1 + k2*x2 + u;
      */
      for i in 1:nr loop
         uu[i+1] = -x[i] + uu[i];
      end for;
      for i in 1:na loop
         uu[nr+i+1] = k1[i]*x[nr+2*i-1] + k2[i]*x[nr+2*i] + uu[nr+i];
      end for;

   elseif filterType == Modelica.Blocks.Types.FilterType.BandPass then
      /* Band pass filter
           Complex conjugate poles:  y = k1*x1 + k2*x2;
      */
      for i in 1:na loop
         uu[nr+i+1] = k1[i]*x[nr+2*i-1] + k2[i]*x[nr+2*i];
      end for;

   elseif filterType == Modelica.Blocks.Types.FilterType.BandStop then
      /* Band pass filter
           Complex conjugate poles:  y = k1*x1 + k2*x2 + u;
      */
      for i in 1:na loop
         uu[nr+i+1] = k1[i]*x[nr+2*i-1] + k2[i]*x[nr+2*i] + uu[nr+i];
      end for;

   else
      assert(false, "filterType (= " + String(filterType) + ") is unknown");
      uu = zeros(na+nr+1);
   end if;

   y = (gain*u_nominal)*uu[nr+na+1];

  annotation (
    Icon(
      coordinateSystem(preserveAspectRatio=true,
        extent={{-100.0,-100.0},{100.0,100.0}}),
        graphics={
      Line(points={{-80.0,80.0},{-80.0,-88.0}},
        color={192,192,192}),
      Polygon(lineColor={192,192,192},
        fillColor={192,192,192},
        fillPattern=FillPattern.Solid,
        points={{-80.0,92.0},{-88.0,70.0},{-72.0,70.0},{-80.0,92.0}}),
      Line(points={{-90.0,-78.0},{82.0,-78.0}},
        color={192,192,192}),
      Polygon(lineColor={192,192,192},
        fillColor={192,192,192},
        fillPattern=FillPattern.Solid,
        points={{90.0,-78.0},{68.0,-70.0},{68.0,-86.0},{90.0,-78.0}}),
      Text(textColor={192,192,192},
        extent={{-66.0,52.0},{88.0,90.0}},
        textString="%order"),
      Text(
        extent={{-138.0,-140.0},{162.0,-110.0}},
        textString="f_cut=%f_cut"),
      Rectangle(lineColor={160,160,164},
        fillColor={255,255,255},
        fillPattern=FillPattern.Backward,
        extent={{-80.0,-78.0},{22.0,10.0}}),
      Line(origin = {3.333,-6.667}, points = {{-83.333,34.667},{24.667,34.667},{42.667,-71.333}}, color = {0,0,127}, smooth = Smooth.Bezier)}),
    Documentation(info="<html>

<p>
This blocks models various types of filters:
</p>

<blockquote>
<strong>low pass, high pass, band pass, and band stop filters</strong>
</blockquote>

<p>
using various filter characteristics:
</p>

<blockquote>
<strong>CriticalDamping, Bessel, Butterworth, Chebyshev Type I filters</strong>
</blockquote>

<p>
By default, a filter block is initialized in <strong>steady-state</strong>, in order to
avoid unwanted oscillations at the beginning. In special cases, it might be
useful to select one of the other initialization options under tab
\"Advanced\".
</p>

<p>
Typical frequency responses for the 4 supported low pass filter types
are shown in the next figure:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Continuous/LowPassOrder4Filters.png\"
     alt=\"LowPassOrder4Filters.png\">
</blockquote>

<p>
The step responses of the same low pass filters are shown in the next figure,
starting from a steady state initial filter with initial input = 0.2:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Continuous/LowPassOrder4FiltersStepResponse.png\"
     alt=\"LowPassOrder4FiltersStepResponse.png\">
</blockquote>

<p>
Obviously, the frequency responses give a somewhat wrong impression
of the filter characteristics: Although Butterworth and Chebyshev
filters have a significantly steeper magnitude as the
CriticalDamping and Bessel filters, the step responses of
the latter ones are much better. This means for example, that
a CriticalDamping or a Bessel filter should be selected,
if a filter is mainly used to make a non-linear inverse model
realizable.
</p>

<p>
Typical frequency responses for the 4 supported high pass filter types
are shown in the next figure:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Continuous/HighPassOrder4Filters.png\"
     alt=\"HighPassOrder4Filters.png\">
</blockquote>

<p>
The corresponding step responses of these high pass filters are
shown in the next figure:
</p>
<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Continuous/HighPassOrder4FiltersStepResponse.png\"
     alt=\"HighPassOrder4FiltersStepResponse.png\">
</blockquote>

<p>
All filters are available in <strong>normalized</strong> (default) and non-normalized form.
In the normalized form, the amplitude of the filter transfer function
at the cut-off frequency f_cut is -3 dB (= 10^(-3/20) = 0.70794..).
Note, when comparing the filters of this function with other software systems,
the setting of \"normalized\" has to be selected appropriately. For example, the signal processing
toolbox of MATLAB provides the filters in non-normalized form and
therefore a comparison makes only sense, if normalized = <strong>false</strong>
is set. A normalized filter is usually better suited for applications,
since filters of different orders are \"comparable\",
whereas non-normalized filters usually require to adapt the
cut-off frequency, when the order of the filter is changed.
See a comparison of \"normalized\" and \"non-normalized\" filters at hand of
CriticalDamping filters of order 1,2,3:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Continuous/CriticalDampingNormalized.png\"
     alt=\"CriticalDampingNormalized.png\">
</blockquote>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Continuous/CriticalDampingNonNormalized.png\"
     alt=\"CriticalDampingNonNormalized.png\">
</blockquote>

<h4>Implementation</h4>

<p>
The filters are implemented in the following, reliable way:
</p>

<ol>
<li> A prototype low pass filter with a cut-off angular frequency of 1 rad/s is constructed
     from the desired analogFilter and the desired normalization.</li>

<li> This prototype low pass filter is transformed to the desired filterType and the
     desired cut-off frequency f_cut using a transformation on the Laplace variable \"s\".</li>

<li> The resulting first and second order transfer functions are implemented in
     state space form, using the \"eigen value\" representation of a transfer function:
     <blockquote><pre>
// second order block with eigen values: a +/- jb
<strong>der</strong>(x1) = a*x1 - b*x2 + (a^2 + b^2)/b*u;
<strong>der</strong>(x2) = b*x1 + a*x2;
     y  = x2;
     </pre></blockquote>
     The dc-gain from the input to the output of this block is one and the selected
     states are in the order of the input (if \"u\" is in the order of \"one\", then the
     states are also in the order of \"one\"). In the \"Advanced\" tab, a \"nominal\" value for
     the input \"u\" can be given. If appropriately selected, the states are in the order of \"one\" and
     then step-size control is always appropriate.</li>
</ol>

<h4>References</h4>

<dl>
<dt>Tietze U., and Schenk C. (2002):</dt>
<dd> <strong>Halbleiter-Schaltungstechnik</strong>.
     Springer Verlag, 12. Auflage, pp. 815-852.</dd>
</dl>

</html>",
        revisions="<html>
<dl>
  <dt><strong>Main Author:</strong></dt>
  <dd><a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>,
      DLR Oberpfaffenhofen.</dd>
</dl>

<h4>Acknowledgement</h4>

<p>
The development of this block was partially funded by BMBF within the
     <a href=\"http://www.eurosyslib.com/\">ITEA2 EUROSYSLIB</a>
      project.
</p>

</html>"));
end Filter;
