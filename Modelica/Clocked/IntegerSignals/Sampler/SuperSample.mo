within Modelica.Clocked.IntegerSignals.Sampler;
block SuperSample
  "Super-sample the clocked Integer input signal and provide it as clocked output signal"
  parameter Boolean inferFactor=true
    "= true, if super-sampling factor is inferred"  annotation(Evaluate=true, choices(checkBox=true));
  parameter Integer factor(min=1)=1
    "Super-sampling factor >= 1 (ignored if inferFactor=true)"
    annotation(Evaluate=true, Dialog(enable=not inferFactor));
  Modelica.Blocks.Interfaces.IntegerInput u
    "Connector of clocked, Integer input signal"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.IntegerOutput y
    "Connector of clocked, Integer output signal (clock of y is faster as clock of u)"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation
  if inferFactor then
     y = superSample(u);
  else
     y = superSample(u,factor);
  end if;

  annotation (
   defaultComponentName="superSample1",
   Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        initialScale=0.06),
                     graphics={Line(points={{-80,-60},{-40,-60},{-40,-60},
              {0,-60},{0,-60},{0,-60},{0,80},{40,80},{40,80},{80,80},{80,
              0},{80,0},{80,0},{100,0}},
                                 color={255,128,0},
          pattern=LinePattern.Dot),                Line(
          points={{-80,-60},{-80,0},{-100,0}},
          color={255,128,0},
          pattern=LinePattern.Dot),
        Text(
          extent={{-150,150},{150,110}},
          textString="%name",
          textColor={0,0,255}),
        Text(
          visible=not inferFactor,
          extent={{-150,-100},{150,-140}},
          textString="%factor"),
        Ellipse(
          extent={{-95,-45},{-65,-75}},
          lineColor={255,128,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-83,-57},{-77,-63}},
          lineColor={255,128,0},
          fillColor={255,128,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-15,96},{15,66}},
          lineColor={255,128,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-3,83},{3,77}},
          lineColor={255,128,0},
          fillColor={255,128,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{65,16},{95,-14}},
          lineColor={255,128,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{77,3},{83,-3}},
          lineColor={255,128,0},
          fillColor={255,128,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-48,-46},{-18,-76}},
          lineColor={255,128,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{34,96},{64,66}},
          lineColor={255,128,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{25,0},{5,20},{5,10},{-25,10},{-25,-10},{5,-10},{5,-20},
              {25,0}},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          lineColor={95,95,95},
          origin={-49,26},
          rotation=90)}),
    Documentation(info="<html>
<p>
This block for Integer signals works similarly as the corresponding block for Real signals (see <a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.SuperSample\">RealSignals.Sampler.SuperSample</a>).
</p>
<p>
Analog to the corresponding Real signal block example there exists an elementary <a href=\"modelica://Modelica.Clocked.Examples.Elementary.IntegerSignals.SuperSample\">example</a> for this Integer block.
</p>
</html>"));
end SuperSample;
