within Modelica.Clocked.BooleanSignals.Sampler;
block SubSample
  "Sub-sample the clocked Boolean input signal and provide it as clocked output signal"
  parameter Boolean inferFactor=true
    "= true, if sub-sampling factor is inferred"  annotation(Evaluate=true, choices(checkBox=true));
  parameter Integer factor(min=1)=1
    "Sub-sampling factor >= 1 (ignored if inferFactor=true)"
                                                            annotation(Evaluate=true, Dialog(enable=not inferFactor));

  Modelica.Blocks.Interfaces.BooleanInput
                                       u
    "Connector of clocked, Boolean input signal"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.BooleanOutput
                                        y
    "Connector of clocked, Boolean output signal (clock of y is slower as clock of u)"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation
  if inferFactor then
     y = subSample(u);
  else
     y = subSample(u,factor);
  end if;

  annotation (
   defaultComponentName="subSample1",
   Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        initialScale=0.06),
        graphics={
        Line(
          points={{-100,0},{-80,0},{-80,-60},{60,-60},{60,0},{100,0}},
          pattern=LinePattern.Dot,
          color={255,0,255}),
        Text(
          extent={{-150,150},{150,110}},
          textString="%name",
          textColor={0,0,255}),
        Text(
          visible=not inferFactor,
          extent={{-150,-100},{150,-140}},
          textString="%factor",
          textColor={0,0,0}),
        Ellipse(
          extent={{-95,-45},{-65,-75}},
          lineColor={255,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{45,15},{75,-15}},
          lineColor={255,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-46,-20},{-26,-40}},
          lineColor={255,0,255},
          fillColor={255,0,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{4,71},{24,51}},
          lineColor={255,0,255},
          fillColor={255,0,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-83,-57},{-77,-63}},
          lineColor={255,0,255},
          fillColor={255,0,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{57,3},{63,-3}},
          lineColor={255,0,255},
          fillColor={255,0,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-36,-60},{-36,-30},{14,-30},{14,60},{60,60},{60,0}},
          color={215,215,215},
          pattern=LinePattern.Dot),
        Polygon(
          points={{25,0},{5,20},{5,10},{-25,10},{-25,-10},{5,-10},{5,-20},
              {25,0}},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          lineColor={95,95,95},
          origin={-51,26},
          rotation=-90)}),
    Documentation(info="<html>
<p>
This block for Boolean signals works similarly as the corresponding block for Real signals (see <a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.SubSample\">RealSignals.Sampler.SubSample</a>).
</p>
<p>
Analog to the corresponding Real signal block example there exists an elementary <a href=\"modelica://Modelica.Clocked.Examples.Elementary.BooleanSignals.SubSample\">example</a> for this Boolean block.
</p>
</html>"));
end SubSample;
