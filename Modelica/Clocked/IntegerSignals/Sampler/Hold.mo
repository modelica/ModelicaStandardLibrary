within Modelica.Clocked.IntegerSignals.Sampler;
block Hold
  "Hold the clocked, Integer input signal and provide it as continuous-time output signal (zero order hold)"
  extends Clocked.IntegerSignals.Interfaces.PartialSISOHold;
  parameter Integer y_start = 0
    "Value of output y before the first tick of the clock associated to input u";

equation
    y = hold(u);

  annotation (
    defaultComponentName="hold1",
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        initialScale=0.06),
                     graphics={
        Ellipse(
          extent={{-70,-28},{-50,-48}},
          lineColor={255,128,0},
          fillColor={255,128,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-30,28},{-10,8}},
          lineColor={255,128,0},
          fillColor={255,128,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{10,70},{30,50}},
          lineColor={255,128,0},
          fillColor={255,128,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{52,12},{72,-8}},
          lineColor={255,128,0},
          fillColor={255,128,0},
          fillPattern=FillPattern.Solid)}),
    Documentation(info="<html>
<p>
This block for Integer signals works similarly as the corresponding block for Real signals (see <a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.Hold\">RealSignals.Sampler.Hold</a>).
</p>

<p>
Analog to the corresponding Real signal block example there exists an elementary
<a href=\"modelica://Modelica.Clocked.Examples.Elementary.IntegerSignals.Hold\">example</a> for this Integer block.
</p>
</html>"));
end Hold;
