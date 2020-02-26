within Modelica.Clocked.BooleanSignals.Sampler;
block Hold
  "Hold the clocked, Boolean input signal and provide it as continuous-time output signal (zero order hold)"
  parameter Boolean y_start = false
    "Value of output y before the first tick of the clock associated to input u";

  Modelica.Blocks.Interfaces.BooleanInput
                                       u(final start=y_start)
    "Connector of clocked, Boolean input signal"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.BooleanOutput
                                        y
    "Connector of continuous-time, Boolean output signal"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation
    y = hold(u);

  annotation (
    defaultComponentName="hold1",
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        initialScale=0.06),
                     graphics={Line(points={{-80,-60},{-40,-60},{-40,0},{0,0},{0,
              0},{0,0},{0,80},{40,80},{40,40},{80,40},{80,0},{80,0},{80,0},{100,
              0}},               color={255,0,255}),
                                                   Line(
          points={{-80,-60},{-80,0},{-106,0}},
          color={255,0,255}),
        Ellipse(
          extent={{-90,-50},{-70,-70}},
          lineColor={255,0,255},
          fillColor={255,0,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-50,10},{-30,-10}},
          lineColor={255,0,255},
          fillColor={255,0,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-10,90},{10,70}},
          lineColor={255,0,255},
          fillColor={255,0,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{30,50},{50,30}},
          lineColor={255,0,255},
          fillColor={255,0,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{70,10},{90,-10}},
          lineColor={255,0,255},
          fillColor={255,0,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-150,-100},{150,-140}},
          textString="%y_start",
          textColor={0,0,0}),
        Text(
          extent={{-150,130},{150,90}},
          textString="%name",
          textColor={0,0,255})}),
    Documentation(info="<html>
<p>
This block for Boolean signals works similarly as the corresponding block for Real signals (see <a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.Hold\">RealSignals.Sampler.Hold</a>).
</p>

<p>
Analog to the corresponding Real signal block example there exists an elementary
<a href=\"modelica://Modelica.Clocked.Examples.Elementary.BooleanSignals.Hold\">example</a> for this Boolean block.
</p>

</html>"));
end Hold;
