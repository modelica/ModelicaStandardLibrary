within Modelica.Blocks.Continuous;
block CriticalDamping
  "Output the input signal filtered with an n-th order filter with critical damping"

  import Modelica.Blocks.Types.Init;
  extends Modelica.Blocks.Interfaces.SISO;

  parameter Integer n=2 "Order of filter";
  parameter SI.Frequency f(start=1) "Cut-off frequency";
  parameter Boolean normalized = true
    "= true, if amplitude at f_cut is 3 dB, otherwise unmodified filter";
  parameter Modelica.Blocks.Types.Init initType=Modelica.Blocks.Types.Init.NoInit
    "Type of initialization (1: no init, 2: steady state, 3: initial state, 4: initial output)"
                                                                                    annotation(Evaluate=true,
      Dialog(group="Initialization"));
  parameter Real x_start[n]=zeros(n) "Initial or guess values of states"
    annotation (Dialog(group="Initialization"));
  parameter Real y_start=0.0
    "Initial value of output (remaining states are in steady state)"
    annotation(Dialog(enable=initType == Init.InitialOutput, group=
          "Initialization"));

  output Real x[n](start=x_start) "Filter states";
protected
  parameter Real alpha=if normalized then sqrt(2^(1/n) - 1) else 1.0
    "Frequency correction factor for normalized filter";
  parameter Real w=2*Modelica.Constants.pi*f/alpha;
initial equation
  if initType == Init.SteadyState then
    der(x) = zeros(n);
  elseif initType == Init.InitialState then
    x = x_start;
  elseif initType == Init.InitialOutput then
    y = y_start;
    der(x[1:n-1]) = zeros(n-1);
  end if;
equation
  der(x[1]) = (u - x[1])*w;
  for i in 2:n loop
    der(x[i]) = (x[i - 1] - x[i])*w;
  end for;
  y = x[n];
  annotation (
    Icon(
        coordinateSystem(preserveAspectRatio=true,
          extent={{-100.0,-100.0},{100.0,100.0}}),
          graphics={
        Line(points={{-80.6897,77.6256},{-80.6897,-90.3744}},
          color={192,192,192}),
        Polygon(lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid,
          points={{-79.7044,90.6305},{-87.7044,68.6305},{-71.7044,68.6305},{-79.7044,90.6305}}),
        Line(points={{-90.0,-80.0},{82.0,-80.0}},
          color={192,192,192}),
        Polygon(lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid,
          points={{90.0,-80.0},{68.0,-72.0},{68.0,-88.0},{90.0,-80.0}}),
        Text(textColor={192,192,192},
          extent={{0.0,-60.0},{60.0,0.0}},
          textString="PTn"),
        Line(origin = {-17.976,-6.521},
          points = {{96.962,55.158},{16.42,50.489},{-18.988,18.583},{-32.024,-53.479},{-62.024,-73.479}},
          color = {0,0,127},
          smooth = Smooth.Bezier),
        Text(textColor={192,192,192},
          extent={{-70.0,48.0},{26.0,94.0}},
          textString="%n"),
        Text(extent={{8.0,-146.0},{8.0,-106.0}},
          textString="f=%f")}),
    Documentation(info="<html>
<p>This block defines the transfer function between the
input u and the output y
as an n-th order filter with <em>critical damping</em>
characteristics and cut-off frequency f. It is
implemented as a series of first order filters.
This filter type is especially useful to filter the input of an
inverse model, since the filter does not introduce any transients.
</p>

<p>
If parameter <strong>normalized</strong> = <strong>true</strong> (default), the filter
is normalized such that the amplitude of the filter transfer function
at the cut-off frequency f is 1/sqrt(2) (= 3 dB). Otherwise, the filter
is not normalized, i.e., it is unmodified. A normalized filter is usually
much better for applications, since filters of different orders are
\"comparable\", whereas non-normalized filters usually require to adapt the
cut-off frequency, when the order of the filter is changed.
Figures of the filter step responses are shown below.
Note, in versions before version 3.0 of the Modelica Standard library,
the CriticalDamping filter was provided only in non-normalized form.
</p>

<p>If transients at the simulation start shall be avoided, the filter
should be initialized in steady state (e.g., using option
initType=Modelica.Blocks.Types.Init.SteadyState).
</p>

<p>
The critical damping filter is defined as
</p>

<blockquote><pre>
&alpha; = <strong>if</strong> normalized <strong>then</strong> <strong>sqrt</strong>(2^(1/n) - 1) <strong>else</strong> 1 // frequency correction factor
&omega; = 2*&pi;*f/&alpha;
          1
y = ------------- * u
     (s/w + 1)^n

</pre></blockquote>

<p>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Continuous/CriticalDampingNormalized.png\"
     alt=\"CriticalDampingNormalized.png\">
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Continuous/CriticalDampingNonNormalized.png\"
     alt=\"CriticalDampingNonNormalized.png\">
</p>

</html>"));
end CriticalDamping;
