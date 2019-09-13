within Modelica.Electrical.PowerConverters.ACDC;
package Control "Control components for rectifiers"
  extends Modelica.Icons.Package;
  annotation (Documentation(info="<html>
<p>
A generic controller with signal input and <code>2*m</code> firing signals is provided in
<a href=\"modelica://Modelica.Electrical.PowerConverters.ACDC.Control.Signal2mPulse\">Signal2mPulse</a>,
where <code>m</code> is the arbitrary number of phases.
Additional topology specific controllers with electrical connectors are also included.
</p>

<h4>Filters</h4>

<p>
Each controller is equipped with an optional
<a href=\"modelica://Modelica.Electrical.PowerConverters.ACDC.Control.Filter\">filter</a>
to filter the input voltages. By default the filter is enabled.
</p>

<p>
Such filter is needed if the electrical grid includes a significant voltage drop across the grid impedance
distorting the input voltage wave form of the rectifier. The filter included in the PowerConverters library is first order filter with additional compensation of the filter specific phase lag.
However, it important to note that the transients of the filters may cause some initial effects which deteriorate after
certain periods.
</p>

<h4>Enable</h4>

<p>
The topology specific controllers allow enabling and disabling of the firing signals. The internal enabling signal of the controllers is either derived from the parameter <code>constantEnable</code>,
if <code>useConstantEnable = true</code>. For if <code>useConstantEnable = false</code> the internal
enabling signal is taken from the optional signal input <code>enable</code>.
</p>
</html>"));
end Control;
