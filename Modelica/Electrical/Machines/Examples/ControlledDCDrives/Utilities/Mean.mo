within Modelica.Electrical.Machines.Examples.ControlledDCDrives.Utilities;
block Mean "Calculate mean over period 1/f"
  extends Modelica.Blocks.Interfaces.SISO;
  parameter SI.Frequency f(start=50) "Base frequency";
  parameter Real x0=0 "Start value of integrator state";
  parameter Real y0=0 "Start value of output";
  parameter Boolean yGreaterOrEqualZero=false
    "= true, if output y is guaranteed to be >= 0 for the exact solution"
    annotation (Evaluate=true, Dialog(tab="Advanced"));
protected
  parameter SI.Time t0(fixed=false) "Start time of simulation";
  Real x "Integrator state";
  discrete Real y_last "Last sampled mean value";
initial equation
  t0 = time;
  x = x0;
  y_last = y0;
equation
  der(x) = u;
  when sample(t0 + 1/f, 1/f) then
    y_last = if not yGreaterOrEqualZero then f*pre(x) else max(0.0, f*pre(x));
    reinit(x, 0);
  end when;
  y = y_last;
  annotation (Documentation(info="<html>
<p>
This block calculates the mean of the input signal u over the given period 1/f:
</p>
<blockquote><pre>
1 T
- &int; u(t) dt
T 0
</pre></blockquote>
<p>
Note: The output is updated after each period defined by 1/f.
</p>

<p>
If parameter <strong>yGreaterOrEqualZero</strong> in the Advanced tab is <strong>true</strong> (default = <strong>false</strong>),
then the modeller provides the information that the mean of the input signal is guaranteed
to be &ge; 0 for the exact solution. However, due to inaccuracies in the numerical integration scheme,
the output might be slightly negative. If this parameter is set to true, then the output is
explicitly set to 0.0, if the mean value results in a negative value.
</p>
</html>"),
         Icon(graphics={Text(
          extent={{-80,60},{80,20}},
          textString="mean"), Text(
          extent={{-80,-20},{80,-60}},
          textString="f=%f")}));
end Mean;
