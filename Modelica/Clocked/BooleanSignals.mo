within Modelica.Clocked;
package BooleanSignals "Library of clocked blocks for Boolean signals"
  extends Modelica.Icons.Package;
  package Sampler "Library of sampler and hold blocks for Boolean signals"
    extends Modelica.Icons.Package;

    block Sample
      "Sample the continuous-time, Boolean input signal and provide it as clocked output signal (clock is inferred)"
      extends Clocked.BooleanSignals.Interfaces.PartialSISOSampler;

    equation
      y = sample(u);

      annotation (
       defaultComponentName="sample1",
       Icon(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={2,2},
            initialScale=0.06),
                         graphics={
            Text(
              extent={{-200,50},{200,115}},
              lineColor={0,0,255},
              textString="%name")}),
        Diagram(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={2,2},
            initialScale=0.06)),
        Documentation(info="<html>
<p>
This block for Boolean signals works similarly as the corresponding block for Real signals (see <a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.Sample\">RealSignals.Sampler.Sample</a>).
</p>
<p>
Analog to the corresponding Real signal block examples there exist two elementary examples, <a href=\"modelica://Modelica.Clocked.Examples.Elementary.BooleanSignals.Sample1\">Sample1</a> and
<a href=\"modelica://Modelica.Clocked.Examples.Elementary.BooleanSignals.Sample2\">Sample2</a>, for this Boolean block.
</p>
</html>"));
    end Sample;

    block SampleClocked
      "Sample the continuous-time, Boolean input signal and provide it as clocked output signal. The clock is provided as input signal"
      extends Clocked.BooleanSignals.Interfaces.SamplerIcon;
      Clocked.ClockSignals.Interfaces.ClockInput clock
        "Output signal y is associated with this clock input" annotation (
          Placement(transformation(
            extent={{-20,-20},{20,20}},
            rotation=90,
            origin={0,-120})));
      Modelica.Blocks.Interfaces.BooleanInput
                                           u
        "Connector of continuous-time, Boolean input signal"
        annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
      Modelica.Blocks.Interfaces.BooleanOutput
                                            y
        "Connector of clocked, Boolean output signal"
        annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    equation
      y = sample(u,clock);

      annotation (
       defaultComponentName="sample1",
       Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={2,2},
            initialScale=0.06),
                         graphics={
            Line(
              points={{0,-100},{0,18}},
              color={175,175,175},
              pattern=LinePattern.Dot,
              thickness=0.5),
            Text(
              extent={{-200,50},{200,115}},
              lineColor={0,0,255},
              textString="%name")}),
        Diagram(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={2,2},
            initialScale=0.06)),
        Documentation(info="<html>
<p>
This block for Boolean signals works similarly as the corresponding block for Real signals (see <a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.SampleClocked\">RealSignals.Sampler.SampleClocked</a>).
</p>
<p>
Analog to the corresponding Real signal block example there exists an elementary <a href=\"modelica://Modelica.Clocked.Examples.Elementary.BooleanSignals.SampleClocked\">example</a> for this Boolean block.
</p>
</html>"));
    end SampleClocked;

    block SampleVectorizedAndClocked
      "Sample the continuous-time, Boolean input signal vector and provide it as clocked output signal vector. The clock is provided as input signal"
      extends Clocked.BooleanSignals.Interfaces.SamplerIcon;
      parameter Integer n(min=1)=1
        "Size of input signal vector u (= size of output signal vector y)";
      Modelica.Blocks.Interfaces.BooleanInput
                                           u[n]
        "Connector of continuous-time, Boolean input signal vector"
        annotation (Placement(transformation(extent={{-140,-20},{-100,20}}), iconTransformation(extent={{-140,-20},{-100,20}})));
      Modelica.Blocks.Interfaces.BooleanOutput
                                            y[n]
        "Connector of clocked, Boolean output signal vector"
        annotation (Placement(transformation(extent={{100,-10},{120,10}})));
      Clocked.ClockSignals.Interfaces.ClockInput clock
        "Output signal vector y is associated with this clock input"
        annotation (Placement(transformation(
            extent={{-20,-20},{20,20}},
            rotation=90,
            origin={0,-120})));
    equation
      y = sample(u,clock);

      annotation (
       defaultComponentName="sample1",
       Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={2,2},
            initialScale=0.06),
                         graphics={
            Line(
              points={{0,-100},{0,18}},
              color={175,175,175},
              pattern=LinePattern.Dot,
              thickness=0.5),
            Text(
              extent={{-200,50},{200,115}},
              lineColor={0,0,255},
              textString="%name"),
            Text(
              extent={{-160,-30},{20,-80}},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              textString="n=%n")}),
        Diagram(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={2,2},
            initialScale=0.06)),
        Documentation(info="<html>
<p>
This block for Boolean signals works similarly as the corresponding block for Real signals (see <a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.SampleVectorizedAndClocked\">RealSignals.Sampler.SampleVectorizedAndClocked</a>).
</p>
<p>
Analog to the corresponding Real signal block example there exists an elementary <a href=\"modelica://Modelica.Clocked.Examples.Elementary.BooleanSignals.SampleVectorizedAndClocked\">example</a> for this Boolean block.
</p>
</html>"));
    end SampleVectorizedAndClocked;

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
            grid={2,2},
            initialScale=0.06),
                         graphics={
            Rectangle(
              extent={{-80,80},{80,-80}},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None),
                                   Line(points={{-80,-60},{-40,-60},{-40,0},{0,0},{0,
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
              extent={{-200,-80},{200,-145}},
              textString="%y_start"),
            Text(
              extent={{-200,165},{200,100}},
              lineColor={0,0,255},
              textString="%name")}),
        Documentation(info="<html>
<p>
This block for Boolean signals works similarly as the corresponding block for Real signals (see <a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.Hold\">RealSignals.Sampler.Hold</a>).
</p>

<p>
Analog to the corresponding Real signal block example there exists an elementary
<a href=\"modelica://Modelica.Clocked.Examples.Elementary.BooleanSignals.Hold\">example</a> for this Boolean block.
</p>


</html>
"),     Diagram(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            initialScale=0.06)));
    end Hold;

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
            grid={2,2},
            initialScale=0.06),
            graphics={
            Rectangle(
              extent={{-94,82},{86,-96}},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None),
            Line(
              points={{-100,0},{-80,0},{-80,-60},{60,-60},{60,0},{100,0}},
              pattern=LinePattern.Dot,
              color={255,0,255}),
            Text(
              extent={{-200,165},{200,100}},
              lineColor={0,0,255},
              textString="%name"),
            Text(visible=not inferFactor,
              extent={{-200,-85},{200,-150}},
              textString="%factor"),
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
        Diagram(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={2,2},
            initialScale=0.06)),
        Documentation(info="<html>
<p>
This block for Boolean signals works similarly as the corresponding block for Real signals (see <a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.SubSample\">RealSignals.Sampler.SubSample</a>).
/p>
<p>
Analog to the corresponding Real signal block example there exists an elementary <a href=\"modelica://Modelica.Clocked.Examples.Elementary.BooleanSignals.SubSample\">example</a> for this Boolean block.
</p>
</html>"));
    end SubSample;

    block SuperSample
      "Super-sample the clocked Boolean input signal and provide it as clocked output signal"
      parameter Boolean inferFactor=true
        "= true, if super-sampling factor is inferred"  annotation(Evaluate=true, choices(checkBox=true));
      parameter Integer factor(min=1)=1
        "Super-sampling factor >= 1 (ignored if inferFactor=true)"
                                                    annotation(Evaluate=true, Dialog(enable=not inferFactor));

      Modelica.Blocks.Interfaces.BooleanInput
                                           u
        "Connector of clocked, Boolean input signal"
        annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
      Modelica.Blocks.Interfaces.BooleanOutput
                                            y
        "Connector of clocked, Boolean output signal (clock of y is faster as clock of u)"
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
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={2,2},
            initialScale=0.06),
                         graphics={
            Rectangle(
              extent={{-88,86},{90,-72}},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None),
                                   Line(points={{-80,-60},{-40,-60},{-40,-60},
                  {0,-60},{0,-60},{0,-60},{0,80},{40,80},{40,80},{80,80},{80,
                  0},{80,0},{80,0},{100,0}},
                                     color={255,0,255},
              pattern=LinePattern.Dot),                Line(
              points={{-80,-60},{-80,0},{-100,0}},
              color={255,0,255},
              pattern=LinePattern.Dot),
            Text(
              extent={{-200,175},{200,110}},
              lineColor={0,0,255},
              textString="%name"),
            Text(visible=not inferFactor,
              extent={{-200,-85},{200,-150}},
              textString="%factor"),
            Ellipse(
              extent={{-95,-45},{-65,-75}},
              lineColor={255,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-83,-57},{-77,-63}},
              lineColor={255,0,255},
              fillColor={255,0,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-15,96},{15,66}},
              lineColor={255,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-3,83},{3,77}},
              lineColor={255,0,255},
              fillColor={255,0,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{65,16},{95,-14}},
              lineColor={255,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{77,3},{83,-3}},
              lineColor={255,0,255},
              fillColor={255,0,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-48,-46},{-18,-76}},
              lineColor={255,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{34,96},{64,66}},
              lineColor={255,0,255},
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
        Diagram(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={2,2},
            initialScale=0.06)),
        Documentation(info="<html>
<p>
This block for Boolean signals works similarly as the corresponding block for Real signals (see <a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.SuperSample\">RealSignals.Sampler.SuperSample</a>).
</p>
<p>
Analog to the corresponding Real signal block example there exists an elementary <a href=\"modelica://Modelica.Clocked.Examples.Elementary.BooleanSignals.SuperSample\">example</a> for this Boolean block.
</p>
</html>"));
    end SuperSample;

    block ShiftSample
      "Shift the clocked Boolean input signal by a fraction of the last interval and and provide it as clocked output signal"
      parameter Integer shiftCounter(min=0)=0 "Numerator of shifting formula"
            annotation(Evaluate=true, Dialog(group="Shift first clock activation for 'shiftCounter/resolution*interval(u)' seconds"));
      parameter Integer resolution(min=1)=1
        "Denominator of shifting formula (ignored if inferShift=true)"
            annotation(Evaluate=true, Dialog(group="Shift first clock activation for 'shiftCounter/resolution*interval(u)' seconds"));

      Modelica.Blocks.Interfaces.BooleanInput
                                           u
        "Connector of clocked, Boolean input signal"
        annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
      Modelica.Blocks.Interfaces.BooleanOutput
                                            y
        "Connector of clocked, Boolean output signal (clock of y is faster als clock of u)"
        annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    equation
      y = shiftSample(u,shiftCounter,resolution);

      annotation (
       defaultComponentName="shiftSample1",
       Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={2,2},
            initialScale=0.06),
                         graphics={
            Rectangle(
              extent={{-94,86},{84,-92}},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None),
                                   Line(points={{20,-50},{60,-50},{60,50}},
                                     color={255,0,255},
              pattern=LinePattern.Dot),
            Text(
              extent={{-200,175},{200,110}},
              lineColor={0,0,255},
              textString="%name"),
            Text(
              extent={{-200,-85},{200,-150}},
              textString="%shiftCounter/%resolution"),
                                   Line(points={{-80,-50},{-40,-50},{-40,50}},
                                     color={255,0,255},
              pattern=LinePattern.Dot),
            Ellipse(
              extent={{10,-40},{30,-60}},
              lineColor={255,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{50,60},{70,40}},
              lineColor={255,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{34,0},{14,20},{14,10},{-16,10},{-16,-10},{14,-10},{14,-20},{34,
                  0}},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid,
              lineColor={95,95,95}),
            Ellipse(
              extent={{-90,-40},{-70,-60}},
              lineColor={255,0,255},
              fillColor={255,0,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-50,60},{-30,40}},
              lineColor={255,0,255},
              fillColor={255,0,255},
              fillPattern=FillPattern.Solid)}),
        Diagram(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={2,2},
            initialScale=0.06)),
        Documentation(info="<html>
<p>
This block for Boolean signals works similarly as the corresponding block for Real signals (see <a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.ShiftSample\">RealSignals.Sampler.ShiftSample</a>).
</p>
<p>
Analog to the corresponding Real signal block example there exists an elementary <a href=\"modelica://Modelica.Clocked.Examples.Elementary.BooleanSignals.ShiftSample\">example</a> for this Boolean block.
</p>
</html>"));
    end ShiftSample;

    block BackSample
      "Shift clock of Boolean input signal backwards in time (and access the most recent value of the input at this new clock)"
      parameter Integer backCounter(min=0)=0 "Numerator of shifting formula"
            annotation(Evaluate=true, Dialog(group="Shift first clock activation backwards in time for 'shiftCounter/resolution*interval(u)' seconds"));
      parameter Integer resolution(min=1)=1 "Denominator of shifting formula"
            annotation(Evaluate=true, Dialog(group="Shift first clock activation backwards in time for 'shiftCounter/resolution*interval(u)' seconds"));
      parameter Boolean y_start=false
        "Value of output y before the first clock tick of the input u";

      Modelica.Blocks.Interfaces.BooleanInput
                                           u(start=y_start)
        "Connector of clocked, Boolean input signal"
        annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
      Modelica.Blocks.Interfaces.BooleanOutput
                                            y
        "Connector of clocked, Boolean output signal (clock of y is faster als clock of u)"
        annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    equation
      y = backSample(u,backCounter,resolution);

      annotation (
       defaultComponentName="backSample1",
       Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={2,2},
            initialScale=0.06),
                         graphics={
            Rectangle(
              extent={{-90,84},{88,-94}},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None),
                                   Line(points={{20,-50},{60,-50},{60,50}},
                                     color={255,0,255},
              pattern=LinePattern.Dot),
            Text(
              extent={{-200,175},{200,110}},
              lineColor={0,0,255},
              textString="%name"),
            Text(
              extent={{-200,-135},{200,-200}},
              textString="%backCounter/%resolution"),
                                   Line(points={{-80,-50},{-40,-50},{-40,50}},
                                     color={255,0,255},
              pattern=LinePattern.Dot),
            Ellipse(
              extent={{-90,-40},{-70,-60}},
              lineColor={255,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-50,60},{-30,40}},
              lineColor={255,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-16,0},{4,20},{4,10},{34,10},{34,-10},{4,-10},{4,-20},{-16,0}},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid,
              lineColor={95,95,95}),
            Ellipse(
              extent={{10,-40},{30,-60}},
              lineColor={255,0,255},
              fillColor={255,0,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{50,60},{70,40}},
              lineColor={255,0,255},
              fillColor={255,0,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-200,-74},{200,-139}},
              textString="y_start=%y_start")}),
        Diagram(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={2,2},
            initialScale=0.06)),
        Documentation(info="<html>
<p>
This block for Boolean signals works similarly as the corresponding block for Real signals (see <a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.BackSample\">RealSignals.Sampler.BackSample</a>).
</p>
<p>
Analog to the corresponding Real signal block example there exists an elementary <a href=\"modelica://Modelica.Clocked.Examples.Elementary.BooleanSignals.BackSample\">example</a> for this Boolean block.
</p>
</html>"));
    end BackSample;

    block AssignClock "Assigns a clock to a clocked Boolean signal"
      Modelica.Blocks.Interfaces.BooleanInput
                                           u
        "Connector of clocked, Boolean input signal"
        annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
      Modelica.Blocks.Interfaces.BooleanOutput
                                            y
        "Connector of clocked, Boolean output signal"
        annotation (Placement(transformation(extent={{100,-10},{120,10}})));
      Clocked.ClockSignals.Interfaces.ClockInput clock annotation (Placement(
            transformation(
            extent={{-20,-20},{20,20}},
            rotation=90,
            origin={0,-120})));
    equation
      when clock then
        y = u;
      end when;

      annotation (
       defaultComponentName="assignClock1",
       Icon(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={2,2},
            initialScale=0.06),
                         graphics={
            Text(
              extent={{-200,100},{200,160}},
              lineColor={0,0,255},
              textString="%name"),
            Rectangle(
              extent={{-90,90},{88,-88}},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None),
                                   Line(points={{-80,-60},{-40,-60},{-40,0},{
                  0,0},{0,0},{0,0},{0,80},{40,80},{40,40},{80,40},{80,0},{80,
                  0},{80,0},{100,0}},color={255,0,255},
              pattern=LinePattern.Dot),                Line(
              points={{-80,-60},{-80,0},{-106,0}},
              color={255,0,255},
              pattern=LinePattern.Dot),
            Ellipse(
              extent={{-90,-50},{-70,-70}},
              lineColor={255,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-50,10},{-30,-10}},
              lineColor={255,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-10,90},{10,70}},
              lineColor={255,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{30,50},{50,30}},
              lineColor={255,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{70,10},{90,-10}},
              lineColor={255,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(
              points={{0,-100},{0,70}},
              color={175,175,175},
              pattern=LinePattern.Dot,
              thickness=0.5)}),
        Diagram(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={2,2},
            initialScale=0.06)),
        Documentation(info="<html>
<p>
This block for Boolean signals works similarly as the corresponding block for Real signals (see <a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.AssignClock\">RealSignals.Sampler.AssignClock</a>).
</p>
<p>
Analog to the corresponding Real signal block example there exists an elementary <a href=\"modelica://Modelica.Clocked.Examples.Elementary.BooleanSignals.AssignClock\">example</a> for this Boolean block.
</p>
</html>"));
    end AssignClock;

    block AssignClockVectorized
      "Assigns a clock to a clocked Boolean signal vector"
      parameter Integer n(min=1)=1
        "Size of input signal vector u (= size of output signal vector y)";
      Modelica.Blocks.Interfaces.BooleanInput
                                           u[n]
        "Connector of clocked, Boolean input signal"
        annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
      Modelica.Blocks.Interfaces.BooleanOutput
                                            y[n]
        "Connector of clocked, Boolean output signal"
        annotation (Placement(transformation(extent={{100,-10},{120,10}})));
      Clocked.ClockSignals.Interfaces.ClockInput clock annotation (Placement(
            transformation(
            extent={{-20,-20},{20,20}},
            rotation=90,
            origin={0,-120})));
    equation
      when clock then
        y = u;
      end when;

      annotation (
       defaultComponentName="assignClock1",
       Icon(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={2,2},
            initialScale=0.06),
                         graphics={
            Text(
              extent={{-196,128},{204,188}},
              lineColor={0,0,255},
              textString="%name"),
            Text(
              extent={{0,-32},{180,-82}},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              textString="n=%n"),  Line(points={{-80,-60},{-40,-60},{-40,0},{
                  0,0},{0,0},{0,0},{0,80},{40,80},{40,40},{80,40},{80,0},{80,
                  0},{80,0},{100,0}},color={255,0,255},
              pattern=LinePattern.Dot),                Line(
              points={{-80,-60},{-80,0},{-106,0}},
              color={255,0,255},
              pattern=LinePattern.Dot),
            Ellipse(
              extent={{-90,-50},{-70,-70}},
              lineColor={255,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-50,10},{-30,-10}},
              lineColor={255,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-10,90},{10,70}},
              lineColor={255,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{30,50},{50,30}},
              lineColor={255,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{70,10},{90,-10}},
              lineColor={255,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(
              points={{0,-100},{0,70}},
              color={175,175,175},
              pattern=LinePattern.Dot,
              thickness=0.5)}),
        Diagram(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={2,2},
            initialScale=0.06)),
        Documentation(info="<html>
<p>
This block for Boolean signals works similarly as the corresponding block for Real signals (see <a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.AssignClockVectorized\">RealSignals.Sampler.AssignClockVectorized</a>).
</p>
<p>
Analog to the corresponding Real signal block example there exists an elementary <a href=\"modelica://Modelica.Clocked.Examples.Elementary.BooleanSignals.AssignClockVectorized\">example</a> for this Boolean block.
</p>
</html>"));
    end AssignClockVectorized;

    package Utilities "Utility components that are usually not directly used"
       extends Modelica.Icons.UtilitiesPackage;

      block UpSample
        "Upsample the clocked Boolean input signal and provide it as clocked output signal"
        parameter Boolean inferFactor=true
          "= true, if upsampling factor is inferred"  annotation(Evaluate=true, choices(checkBox=true));
        parameter Integer factor(min=1)=1
          "Upsampling factor >= 1 (if inferFactor=false)" annotation(Evaluate=true, Dialog(enable=not inferFactor));
        Modelica.Blocks.Interfaces.BooleanInput
                                             u
          "Connector of clocked, Boolean input signal"
          annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
        Modelica.Blocks.Interfaces.BooleanOutput
                                              y
          "Connector of clocked, Boolean output signal (clock of y is faster as clock of u)"
          annotation (Placement(transformation(extent={{100,-10},{120,10}})));
      protected
        Boolean dummy annotation(HideResult=true);
        Boolean b(start=false);
        Boolean b_super(start=false);
        Boolean u_super;
      equation
        when Clock() then // clock of u
           dummy = u;
           b = not previous(b);
        end when;

        when Clock() then // clock of y
           b_super = superSample(b);
           if inferFactor then
              u_super = superSample(u);
           else
              u_super = superSample(u,factor);
           end if;
           y = if b_super <> previous(b_super) then u_super else false;
        end when;

        annotation (
         defaultComponentName="upSample1",
         Icon(coordinateSystem(
              preserveAspectRatio=true,
              extent={{-100,-100},{100,100}},
              grid={2,2},
              initialScale=0.06),
                           graphics={
              Rectangle(
                extent={{-92,90},{88,-90}},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid,
                pattern=LinePattern.None),
              Line(
                points={{-78,-60},{40,-60},{40,0},{40,0}},
                color={215,215,215},
                pattern=LinePattern.Dot), Line(points={{-80,-60},{-40,-60},{-40,-60},{-40,0},
                    {-40,0},{0,0},{40,0},{40,80},{40,80},{40,80},{80,80},{80,0},{80,0},
                    {100,0}},          color={255,0,255},
                pattern=LinePattern.Dot),                Line(
                points={{-80,-60},{-80,0},{-100,0}},
                color={255,0,255},
                pattern=LinePattern.Dot),
              Text(
                extent={{-200,175},{200,110}},
                lineColor={0,0,255},
                textString="%name"),
              Ellipse(
                extent={{-95,-45},{-65,-75}},
                lineColor={255,0,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{-83,-57},{-77,-63}},
                lineColor={255,0,255},
                fillColor={255,0,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{25,96},{55,66}},
                lineColor={255,0,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{37,83},{43,77}},
                lineColor={255,0,255},
                fillColor={255,0,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{-55,16},{-25,-14}},
                lineColor={255,0,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{-6,16},{24,-14}},
                lineColor={255,0,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{64,16},{94,-14}},
                lineColor={255,0,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Text(visible=not inferFactor,
                extent={{-200,-80},{200,-145}},
                textString="%factor"),
              Line(
                points={{80,80},{120,80}},
                color={215,215,215},
                pattern=LinePattern.Dot),
              Polygon(
                points={{25,0},{5,20},{5,10},{-25,10},{-25,-10},{5,-10},{5,-20},
                    {25,0}},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid,
                lineColor={95,95,95},
                origin={-71,52},
                rotation=90)}),
          Diagram(coordinateSystem(
              preserveAspectRatio=false,
              extent={{-100,-100},{100,100}},
              grid={2,2},
              initialScale=0.06)),
          Documentation(info="<html>
<p>
This block for Boolean signals works similarly as the corresponding block for Real signals (see
<a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.Utilities.UpSample\">RealSignals.Sampler.Utilities.UpSample</a>).
</p>
<p>
Analog to the corresponding Real signal block example there exists an elementary <a href=\"modelica://Modelica.Clocked.Examples.Elementary.BooleanSignals.UpSample\">example</a> for this Boolean block.
</p>
</html>"));
      end UpSample;

        block AssignClockToTriggerHold
        "Generate a Boolean continuous-time trigger signal from a clocked Boolean input"
          extends Clocked.ClockSignals.Interfaces.ClockedBlockIcon;
          parameter Boolean y_start=false "Initial value of output signal";
          Modelica.Blocks.Interfaces.BooleanInput
                                               u
            annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
          Modelica.Blocks.Interfaces.BooleanOutput y
          "Connector of Boolean output signal"     annotation (Placement(
                transformation(extent={{100,-10},{120,10}}),
                iconTransformation(extent={{100,-10},{120,10}})));
      protected
          Boolean y2(start=y_start);
          Boolean y3(start=y_start, fixed=true);
          Boolean uu annotation(HideResult=true);
        equation
          when Clock() then
             uu = u "Dummy assignment to relate clock of u with y2";
             y2 = not previous(y2);
          end when;
          y3 = hold(y2);
          y = change(y3);
          annotation (
            defaultComponentName="clockToTrigger",
            Icon(coordinateSystem(
              preserveAspectRatio=true,
              extent={{-100,-100},{100,100}},
              grid={1,1}), graphics={
                Polygon(
                  points={{-80,88},{-88,66},{-72,66},{-80,88}},
                  lineColor={255,0,255},
                  fillColor={255,0,255},
                  fillPattern=FillPattern.Solid),
                Line(points={{-80,66},{-80,-82}}, color={255,0,255}),
                Line(points={{-90,-70},{72,-70}}, color={255,0,255}),
                Polygon(
                  points={{90,-70},{68,-62},{68,-78},{90,-70}},
                  lineColor={255,0,255},
                  fillColor={255,0,255},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{71,7},{85,-7}},
                  lineColor=DynamicSelect({235,235,235}, if y > 0.5 then {0,255,0} else
                            {235,235,235}),
                  fillColor=DynamicSelect({235,235,235}, if y > 0.5 then {0,255,0} else
                            {235,235,235}),
                  fillPattern=FillPattern.Solid),
              Line(points={{-60,-70},{-60,70}}),
              Line(points={{-20,-70},{-20,70}}),
              Line(points={{20,-70},{20,70}}),
              Line(points={{60,-70},{60,70}})}),
            Diagram(coordinateSystem(
              preserveAspectRatio=false,
              extent={{-100,-100},{100,100}},
              grid={1,1})),
            Documentation(info="<html>
<p>
This block for Boolean signals works similarly as the corresponding block for Real signals (see
<a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.Utilities.AssignClockToTriggerHold\">RealSignals.Sampler.Utilities.AssignClockToTriggerHold</a>).
</p>
</html>"));
        end AssignClockToTriggerHold;

        block AssignClockToSquareWaveHold
        "Generate a Boolean continuous-time square signal from a clocked Real input"
          extends Clocked.ClockSignals.Interfaces.ClockedBlockIcon;
          parameter Boolean y_start=false "Initial value of output signal";
          Modelica.Blocks.Interfaces.BooleanInput
                                               u
            annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
          Modelica.Blocks.Interfaces.BooleanOutput y
          "Connector of Boolean output signal"     annotation (Placement(
                transformation(extent={{100,-10},{120,10}}),
                iconTransformation(extent={{100,-10},{120,10}})));
      protected
          Boolean y2(start=y_start);
        equation
          // dummy condition to relate clock of u with y2
          y2 = if u == false then not previous(y2) else not previous(y2);
          y = hold(y2);
          annotation (
            defaultComponentName="clockToSquareWave",
            Icon(coordinateSystem(
              preserveAspectRatio=false,
              extent={{-100,-100},{100,100}},
              grid={1,1}), graphics={
                Polygon(
                  points={{-80,88},{-88,66},{-72,66},{-80,88}},
                  lineColor={255,0,255},
                  fillColor={255,0,255},
                  fillPattern=FillPattern.Solid),
                Line(points={{-80,66},{-80,-82}}, color={255,0,255}),
                Line(points={{-90,-70},{72,-70}}, color={255,0,255}),
                Polygon(
                  points={{90,-70},{68,-62},{68,-78},{90,-70}},
                  lineColor={255,0,255},
                  fillColor={255,0,255},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{71,7},{85,-7}},
                  lineColor=DynamicSelect({235,235,235}, if y > 0.5 then {0,255,0} else
                            {235,235,235}),
                  fillColor=DynamicSelect({235,235,235}, if y > 0.5 then {0,255,0} else
                            {235,235,235}),
                  fillPattern=FillPattern.Solid),
                                       Line(points={{-80,-70},{-40,-70},{-40,44},
                    {0,44},{0,-70},{40,-70},{40,44},{79,44}})}),
            Diagram(coordinateSystem(
              preserveAspectRatio=true,
              extent={{-100,-100},{100,100}},
              grid={1,1})),
            Documentation(info="<html>
<p>
This block for Boolean signals works similarly as the corresponding block for Real signals (see
<a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.Utilities.AssignClockToSquareWaveHold\">RealSignals.Sampler.Utilities.AssignClockToSquareWaveHold</a>).
</p>
</html>"));
        end AssignClockToSquareWaveHold;

      annotation (Documentation(info="<html>
<p>
This package contains utility blocks that are usually not directly utilized
but are used as building blocks for \"higher level\" blocks.
</p>
</html>"));
    end Utilities;

    annotation (Documentation(info="<html>
<p>
This package contains blocks that mark boundaries of a clocked partition
and transform a <b>Boolean</b> signal from one partition to the next. Especially,
the following blocks are provided:<br>&nbsp;
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"3\">
<tr><th align=\"left\"><b>Boundary Type</b></th>
    <th align=\"left\"><b>Block Name</b></th>
    <th align=\"left\"><b>Description</b></th></tr>

<tr><td valign=\"top\" rowspan=\"3\">continuous-time &rarr; clocked</td>
      <td><a href=\"modelica://Modelica.Clocked.BooleanSignals.Sampler.Sample\">Sample</a></td>
      <td>Sample a continuous-time signal.</td>
    </tr>
    <tr>
      <td><a href=\"modelica://Modelica.Clocked.BooleanSignals.Sampler.SampleClocked\">SampleClocked</a></td>
      <td>Sample and associate a clock to the sampled <b>scalar</b> signal.</td>
    </tr>
    <tr>
      <td><a href=\"modelica://Modelica.Clocked.BooleanSignals.Sampler.SampleVectorizedAndClocked\">SampleVectorizedAndClocked</a></td>
      <td>Sample an input vector and associate a clock to the sampled <b>vector</b> signal.</td>
    </tr>

<tr><td valign=\"top\">clocked &rarr; continuous-time</td>
      <td><a href=\"modelica://Modelica.Clocked.BooleanSignals.Sampler.Hold\">Hold</a></td>
      <td>Hold a clocked signal with zero-order hold.</td>
    </tr>

<tr><td valign=\"top\" rowspan=\"4\">clocked &rarr; clocked</td>
      <td><a href=\"modelica://Modelica.Clocked.BooleanSignals.Sampler.SubSample\">SubSample</a></td>
      <td>Sub-sample a signal (output clock is slower as input clock). </td>
    </tr>

    <tr>
      <td><a href=\"modelica://Modelica.Clocked.BooleanSignals.Sampler.SuperSample\">SuperSample</a></td>
      <td>Super-sample a signal (output clock is faster as input clock). </td>
    </tr>

    <tr>
      <td><a href=\"modelica://Modelica.Clocked.BooleanSignals.Sampler.ShiftSample\">ShiftSample</a></td>
      <td>Shift a signal (output clock is delayed with respect to input clock).  </td>
    </tr>

    <tr>
      <td><a href=\"modelica://Modelica.Clocked.BooleanSignals.Sampler.BackSample\">BackSample</a></td>
      <td>Shift a signal and start the output clock before the input clock with a start value.  </td>
    </tr>


<tr><td valign=\"top\" rowspan=\"2\">within clocked partition</td>
      <td><a href=\"modelica://Modelica.Clocked.BooleanSignals.Sampler.AssignClock\">AssignClock</a></td>
      <td>Assign a clock to a clocked <b>scalar</b> signal.</td>
    </tr>
    <tr>
      <td><a href=\"modelica://Modelica.Clocked.BooleanSignals.Sampler.AssignClockVectorized\">AssignClockVectorized</a></td>
      <td>Assign a clock to a clocked <b>vector</b> signal.</td>
    </tr>
</table>

<p>
Additionally, package
<a href=\"modelica://Modelica.Clocked.BooleanSignals.Sampler.Utilities\">Utilities</a></td>
contains utility blocks that are used as building blocks for user-relevant blocks.
</p>
</html>"));
  end Sampler;

  package NonPeriodic
    "Library of blocks that operate on periodically and non-periodically clocked signals"
    extends Modelica.Icons.Package;

    block BooleanChange
      extends Clocked.ClockSignals.Interfaces.ClockedBlockIcon;

      Modelica.Blocks.Interfaces.BooleanInput u
        "Connector of Boolean input signal."
        annotation (Placement(transformation(extent = {{-140,-20},{-100,20}})));
      Modelica.Blocks.Interfaces.BooleanOutput y
        "Connector of Boolean output signal."
        annotation (Placement(transformation(extent = {{100,-10},{120,10}})));

    equation
      if firstTick() then
        y = false;
      else
        y = not
               (u == previous(u));
      end if;

      annotation (
        Icon(graphics={
          Text(
            extent = {{-90,36},{90,-36}},
            lineColor = {160,160,164},
            textString = "change()")}),
        Documentation(info="<html>
    This block is a synchronous version of
    <a href=\"Modelica.Blocks.Math.BooleanChange\">Modelica.Blocks.Math.BooleanChange</a>.
    It uses <code>previous</code> instead of the implicit <code>pre</code> of
    <code>change</code> to set the Boolean output <code>y</code> to
    <code>true</code> when the boolean input <code>u</code> changed. Thus, it's
    logic is:
    <pre><code>
    if firstTick() then
      y = false;
    else
      y = not(u == previous(u));
    end if;</code></pre>
    <p>
    <b>This block might be superfluous and replaced by
    </b><code>Modelica.Blocks.Math.BooleanChange</code><b> when the semantics
    of </b><code>change</code><b> are relaxed and well-defined for
    clocked discrete-time partitions.</b>
    </html>"));
    end BooleanChange;

    block UnitDelay "Delays the clocked input signal for one sample period"
      extends Clocked.BooleanSignals.Interfaces.PartialClockedSISO(u(final
            start=y_start));
      parameter Boolean y_start=false
        "Value of output signal at first clock tick";
    equation
      y = previous(u);
      annotation (defaultComponentName="UnitDelay1",
           Icon(graphics={
            Line(points={{-30,0},{30,0}}, color={255,0,255}),
            Text(
              extent={{-90,10},{90,90}},
              textString="1",
              lineColor={255,0,255},
              pattern=LinePattern.Dot),
            Text(
              extent={{-90,-10},{90,-90}},
              textString="z",
              lineColor={255,0,255}),
            Text(
              extent={{-150,-140},{150,-100}},
              textString="y_start=%y_start")}),
        Documentation(info="<html>
<p>
This block describes a unit delay:
</p>
<pre>
  // Time domain description
     y(ti) = previous(u(ti))

  // Discrete transfer function
             1
     y(z) = --- * u(z)
             z
</pre>

<p>
that is, the output signal y is the input signal u at the
previous clock tick. At the first clock tick, the output
y is set to parameter y_start.
</p>
</html>"));
    end UnitDelay;

    block FractionalDelay
      "Delays the clocked input signal for a fractional multiple of the sample period"
    extends Clocked.BooleanSignals.Interfaces.PartialClockedSISO;

      parameter Integer shift(min=0) = 0
        "Delay = interval() * shift/resolution";
      parameter Integer resolution(min=1) = 1
        "Time quantization resolution of sample interval";
    protected
      parameter Integer n = div(shift,resolution);
      Boolean u_buffer[n+1](each start=false)
        "The previous values of the inputs; u_last[1] = u, u_last[2] = previous(u_last[1]); u_last[3] = previous(u_last[2])";
      Boolean first(start=true) "Used to identify the first clock tick";
    equation
     first = false;
     u_buffer = if previous(first) then fill(u,n+1) else cat(1, {u}, previous(u_buffer[1:n]));
     y = shiftSample(u_buffer[n+1], shift, resolution);

      annotation (Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,
                -100},{100,100}})),
        Icon(graphics={
            Line(
              points={{-100,0},{-80,0},{-80,40},{-20,40},{-20,-40},{40,-40},{40,0},{
                  100,0}},
              color={215,215,215},
              pattern=LinePattern.Dot),
            Line(
              points={{-100,0},{-50,0},{-50,40},{10,40},{10,-40},{70,-40},{70,-0.3125},
                  {100,0}},
              pattern=LinePattern.Dot,
              color={255,0,255}),
            Text(
              extent={{4,-102},{4,-142}},
              textString="%shift/%resolution"),
            Ellipse(
              extent={{-90,50},{-70,30}},
              lineColor={255,0,255},
              fillColor={255,0,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-30,-30},{-10,-50}},
              lineColor={255,0,255},
              fillColor={255,0,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{30,10},{50,-10}},
              lineColor={255,0,255},
              fillColor={255,0,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-60,50},{-40,30}},
              lineColor={255,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{0,-30},{20,-50}},
              lineColor={255,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{60,10},{80,-10}},
              lineColor={255,0,255},
              fillColor={255,0,255},
              fillPattern=FillPattern.Solid)}));
    end FractionalDelay;

    block ClockToBoolean
      "Block to translate clock signals to continuous Boolean events (each time the
   input clock ticks a rising Boolean output edge is produced)."
      extends ClockSignals.Interfaces.ClockedBlockIcon;
      extends Modelica.Blocks.Icons.PartialBooleanBlock;

      ClockSignals.Interfaces.ClockInput u
        "Connector of clock input signal."
        annotation (Placement(transformation(extent = {{-140,-20},{-100,20}})));
      Modelica.Blocks.Interfaces.BooleanOutput y
        "Connector of continuous Boolean output signal."
        annotation (Placement(transformation(extent = {{100,-10},{120,10}})));

      Sampler.SampleClocked input_sample
        annotation (Placement(transformation(
          extent = {{-6,-6},{6,6}},
          rotation = -90,
          origin={-50,14})));
      Modelica.Blocks.MathBoolean.Not input_tick
        annotation (Placement(transformation(extent = {{-26,-6},{-14,6}})));
      Sampler.Hold input_hold(y_start = false)
        annotation (Placement(transformation(extent = {{14,-6},{26,6}})));
      Modelica.Blocks.MathBoolean.ChangingEdge input_ticked
        annotation (Placement(transformation(extent = {{54,-6},{66,6}})));

    equation
      connect(input_sample.y,input_tick. u)
        annotation (Line(
          points = {{-50,7.4},{-50,0},{-28.4,0}},
          color = {255,0,255}));
      connect(input_hold.y,input_sample. u)
        annotation (Line(
          points = {{26.6,0},{40,0},{40,30},{-50,30},{-50,21.2}},
          color = {255,0,255}));
      connect(input_tick.y,input_hold. u)
        annotation (Line(
          points = {{-12.8,0},{12.8,0}},
          color = {255,0,255}));
      connect(input_hold.y,input_ticked. u)
        annotation (Line(
          points = {{26.6,0},{51.6,0}},
          color = {255,0,255}));
      connect(u, input_sample.clock)
        annotation (Line(
          points = {{-120,0},{-80,0},{-80,14},{-57.2,14}},
          color = {175,175,175},
          pattern = LinePattern.Dot,
          thickness = 0.5));
      connect(input_ticked.y, y)
        annotation (Line(
          points = {{67.2,0},{110,0}},
          color = {255,0,255}));

      annotation (Icon(graphics={
        Line(
          points = {{70,60},{-70,60}},
          color = {95,95,95},
          pattern = LinePattern.Dot,
          thickness = 0.5),
        Line(
          points = {{-66,-60},{-30,-60},{-30,-16},{-30,-16},{-30,-60},{68,-60}},
          color = {255,0,255}),
        Line(
          points = {{30,-60},{30,-16}},
          color = {255,0,255}),
        Ellipse(
          extent = {{-71,7},{-85,-7}},
          lineColor = DynamicSelect(
            {235,235,235},
            if u > 0.5 then {0,255,0} else {235,235,235}),
          fillColor = DynamicSelect(
            {235,235,235},
            if u > 0.5 then {0,255,0} else {235,235,235}),
          fillPattern = FillPattern.Solid),
        Ellipse(
          extent = {{71,7},{85,-7}},
          lineColor = DynamicSelect(
            {235,235,235},
            if y > 0.5 then {0,255,0} else {235,235,235}),
          fillColor = DynamicSelect(
            {235,235,235},
            if y > 0.5 then {0,255,0} else {235,235,235}),
          fillPattern = FillPattern.Solid),
        Ellipse(
          extent = {{-40,70},{-20,50}},
          lineColor = {175,175,175},
          fillColor = {255,255,255},
          fillPattern = FillPattern.Solid),
        Ellipse(
          extent = {{22,70},{42,50}},
          lineColor = {175,175,175},
          fillColor = {255,255,255},
          fillPattern = FillPattern.Solid)}));
    end ClockToBoolean;
  end NonPeriodic;

  package TimeBasedSources
    "Package of signal source blocks generating clocked simulation time based Boolean signals"
     extends Modelica.Icons.SourcesPackage;
    block Step "Generate step signal of type Boolean"
      extends BooleanSignals.Interfaces.PartialClockedSO;
      parameter Modelica.SIunits.Time startTime=0 "Time instant of step start";
      parameter Boolean startValue = false "Output before startTime";
    protected
      Modelica.SIunits.Time simTime;
    equation
      simTime = sample(time);
      y = if simTime >= startTime then not startValue else startValue;
      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={
            Text(
              extent={{-150,-150},{150,-110}},
              textString="startTime=%startTime"),
            Polygon(
              points={{-80,88},{-88,66},{-72,66},{-80,88}},
              lineColor={255,0,255},
              fillColor={255,0,255},
              fillPattern=FillPattern.Solid),
            Line(points={{-80,66},{-80,-82}}, color={255,0,255}),
            Line(points={{-90,-70},{72,-70}}, color={255,0,255}),
            Polygon(
              points={{90,-70},{68,-62},{68,-78},{90,-70}},
              lineColor={255,0,255},
              fillColor={255,0,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{71,7},{85,-7}},
              lineColor=DynamicSelect({235,235,235}, if y > 0.5 then {0,255,0} else
                        {235,235,235}),
              fillColor=DynamicSelect({235,235,235}, if y > 0.5 then {0,255,0} else
                        {235,235,235}),
              fillPattern=FillPattern.Solid),
                                           Line(points={{-80,-70},{0,-70},{0,50},{80,
                  50}},   pattern=LinePattern.Dot),
            Ellipse(
              extent={{-86,-64},{-74,-76}},
              lineColor={255,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-6,56},{6,44}},
              lineColor={255,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{74,56},{86,44}},
              lineColor={255,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-46,-64},{-34,-76}},
              lineColor={255,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{34,56},{46,44}},
              lineColor={255,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}),
                              Diagram(coordinateSystem(preserveAspectRatio=true,
              extent={{-100,-100},{100,100}}), graphics={
            Polygon(
              points={{-80,92},{-86,70},{-74,70},{-80,92}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Line(points={{-80,70},{-80,-80}}, color={95,95,95}),
            Line(points={{-92,-70},{68,-70}}, color={95,95,95}),
            Polygon(
              points={{90,-70},{68,-64},{68,-76},{90,-70}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{54,-80},{106,-92}},
              textString="time"),
            Text(
              extent={{-74,92},{-56,74}},
              textString="y"),
          Line(
              points={{-80,-70},{0,-70},{0,50},{80,50}},
              color={255,0,255},
              thickness=0.5,
              pattern=LinePattern.Dot),
          Text(
            extent={{-15,-80},{20,-88}},
            textString="startTime"),
          Polygon(
            points={{-8,50},{-90,50},{-8,50}},
            lineColor={95,95,95},
            fillColor={95,95,95},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-76,62},{-32,48}},
            textString="not startValue"),
          Text(
            extent={{-78,-52},{-46,-66}},
            textString="startValue"),
            Ellipse(
              extent={{-86,-64},{-74,-76}},
              lineColor={255,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-6,56},{6,44}},
              lineColor={255,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-46,-64},{-34,-76}},
              lineColor={255,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{74,56},{86,44}},
              lineColor={255,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{34,56},{46,44}},
              lineColor={255,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}),
        Documentation(info="<html>
<p>The block is similar to the block in <a href=\"modelica://Modelica.Blocks.Sources.BooleanStep\">Modelica.Blocks.Sources.BooleanStep</a>,
but adapted to work in clocked partitions (by internal sampling of the continuous <b>time</b> variable).</p>
<p>
The Boolean output y is a step signal:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/BooleanStep.png\">
</p>

<h4>Example</h4>
<p>
See model <a href=\"Modelica.Clocked.Examples.Elementary.BooleanSignals.TimeBasedStep\">Modelica.Clocked.Examples.Elementary.BooleanSignals.TimeBasedStep</a>.
<br>
</p>
</html>"));
    end Step;

      block Pulse "Generate pulse signal of type Boolean"
        extends BooleanSignals.Interfaces.PartialClockedSO;
        parameter Real width(
          final min=Modelica.Constants.small,
          final max=100) = 50 "Width of pulse in % of period";
        parameter Modelica.SIunits.Time period(final min=Modelica.Constants.small,start=1)
        "Time for one period";
        parameter Modelica.SIunits.Time startTime=0
        "Time instant of first pulse";

    protected
        Modelica.SIunits.Time simTime;
        parameter Modelica.SIunits.Duration Twidth=period*width/100
        "width of one pulse"                                              annotation(HideResult=true);

        Modelica.SIunits.Time next(start=startTime, fixed=true)
        "next = startTime + n*period, for smallest n such that next>simTime";
        Modelica.SIunits.Duration tol = 0.1*interval(simTime) "Tolerance for numeric comparisons";
      equation
          simTime = sample(time);
          next = if (simTime >= previous(next) - tol) then previous(next) + period else previous(next);
          y = simTime >= next - period - tol and simTime < next - period + Twidth - tol;
        annotation (
          Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics={Text(
              extent={{-150,-140},{150,-110}},
              textString="%period"),
              Polygon(
                points={{-80,88},{-88,66},{-72,66},{-80,88}},
                lineColor={255,0,255},
                fillColor={255,0,255},
                fillPattern=FillPattern.Solid),
              Line(points={{-80,66},{-80,-82}}, color={255,0,255}),
              Line(points={{-90,-70},{72,-70}}, color={255,0,255}),
              Polygon(
                points={{90,-70},{68,-62},{68,-78},{90,-70}},
                lineColor={255,0,255},
                fillColor={255,0,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{71,7},{85,-7}},
                lineColor=DynamicSelect({235,235,235}, if y > 0.5 then {0,255,0} else
                          {235,235,235}),
                fillColor=DynamicSelect({235,235,235}, if y > 0.5 then {0,255,0} else
                          {235,235,235}),
                fillPattern=FillPattern.Solid),
                                     Line(points={{-80,-70},{-40,-70},{-40,44},{0,44},
                    {0,-70},{40,-70},{40,44},{79,44}},   pattern=LinePattern.Dot),
              Ellipse(
                extent={{-86,-64},{-74,-76}},
                lineColor={255,0,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{-45,50},{-33,38}},
                lineColor={255,0,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{-6,-64},{6,-76}},
                lineColor={255,0,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{34,49},{46,37}},
                lineColor={255,0,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid)}),
          Diagram(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics={
            Text(
              extent={{-60,-74},{-19,-82}},
              textString="startTime"),
            Line(
              points={{-78,-70},{-40,-70},{-40,20},{20,20},{20,-70},{50,-70},{
                  50,20},{100,20}},
              color={255,0,255},
              thickness=0.5,
              pattern=LinePattern.Dot),
            Line(points={{-40,61},{-40,21}}, color={95,95,95}),
            Line(points={{20,44},{20,20}}, color={95,95,95}),
            Line(points={{50,58},{50,20}}, color={95,95,95}),
            Line(points={{-40,53},{50,53}}, color={95,95,95}),
            Line(points={{-40,35},{20,35}}, color={95,95,95}),
            Text(
              extent={{-18,65},{28,55}},
              textString="period"),
            Text(
              extent={{-33,47},{14,37}},
              textString="width"),
            Line(points={{-70,20},{-41,20}}, color={95,95,95}),
            Polygon(
              points={{-40,35},{-31,37},{-31,33},{-40,35}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{20,35},{12,37},{12,33},{20,35}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-40,53},{-31,55},{-31,51},{-40,53}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{50,53},{42,55},{42,51},{50,53}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-95,26},{-66,17}},
              textString="true"),
            Text(
              extent={{-96,-60},{-75,-69}},
              textString="false"),
              Ellipse(
                extent={{-46,26},{-34,14}},
                lineColor={255,0,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{-16,26},{-4,14}},
                lineColor={255,0,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{14,-63},{26,-75}},
                lineColor={255,0,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{44,25},{56,13}},
                lineColor={255,0,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{74,26},{86,14}},
                lineColor={255,0,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{-76,-64},{-64,-76}},
                lineColor={255,0,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid)}),
          Documentation(info="<html>
<p>The block is similar to the block in <a href=\"modelica://Modelica.Blocks.Sources.BooleanPulse\">Modelica.Blocks.Sources.BooleanPulse</a>,
but adapted to work in clocked partitions (by internal sampling of the continuous <b>time</b> variable).
</p>
<p>
The Boolean output y is a pulse signal:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/Pulse.png\">
</p>
<h4>Example</h4>
<p>
See model <a href=\"Modelica.Clocked.Examples.Elementary.BooleanSignals.TimeBasedPulse\">Modelica.Clocked.Examples.Elementary.BooleanSignals.TimeBasedPulse</a>.
<br>
</p>
</html>"));
      end Pulse;
    annotation (Documentation(info="<html>
<p>
This package provides <b>source</b> components akin to the blocks provided in
<a href=\"Modelica.Blocks.Sources\">Modelica.Blocks.Sources</a>, but with the difference
that they provide a <b>clocked</b> output signal.
</p>
<p>
As an effect it is not necessary to use an intermediate Sample block if the output signal
is connected to a system that requires a clocked input signal. Therefore, it it can be slightly more convenient
to use the blocks provided in this package than to use the blocks offered by <a href=\"Modelica.Blocks.Sources\">Modelica.Blocks.Sources</a>
(since one does not need to add an additional Sample block for the transition from a continuous time signal to a clocked signal).
</p>
</html>"));
  end TimeBasedSources;

  package TickBasedSources
    "Package of signal source blocks generating clocked tick/sample based Boolean signals"
     extends Modelica.Icons.SourcesPackage;
    block Step "Generate step signal of type Boolean"
      extends BooleanSignals.Interfaces.PartialClockedSO;

      parameter Integer startTick = 0
        "Output y = startValue for clock tick < startTick";
      parameter Boolean startValue = false "Output before startTick";

    protected
      Integer counter(start=0);
    equation
      // stop counter after counter = startTick to avoid integer overflow for long running simulations
      counter = if previous(counter) < startTick then previous(counter) + 1 else previous(counter);
      y = if counter >= startTick then not startValue else startValue;
      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={
            Text(
              extent={{-150,-150},{150,-110}},
              textString="startTick=%startTick"),
            Polygon(
              points={{-80,88},{-88,66},{-72,66},{-80,88}},
              lineColor={255,0,255},
              fillColor={255,0,255},
              fillPattern=FillPattern.Solid),
            Line(points={{-80,66},{-80,-82}}, color={255,0,255}),
            Line(points={{-90,-70},{72,-70}}, color={255,0,255}),
            Polygon(
              points={{90,-70},{68,-62},{68,-78},{90,-70}},
              lineColor={255,0,255},
              fillColor={255,0,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{71,7},{85,-7}},
              lineColor=DynamicSelect({235,235,235}, if y > 0.5 then {0,255,0} else
                        {235,235,235}),
              fillColor=DynamicSelect({235,235,235}, if y > 0.5 then {0,255,0} else
                        {235,235,235}),
              fillPattern=FillPattern.Solid),
                                           Line(points={{-80,-70},{0,-70},{0,50},{80,
                  50}},   pattern=LinePattern.Dot),
            Ellipse(
              extent={{-86,-64},{-74,-76}},
              lineColor={255,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-6,56},{6,44}},
              lineColor={255,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{74,56},{86,44}},
              lineColor={255,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-46,-64},{-34,-76}},
              lineColor={255,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{34,56},{46,44}},
              lineColor={255,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}),
                              Diagram(coordinateSystem(preserveAspectRatio=true,
              extent={{-100,-100},{100,100}}), graphics={
            Polygon(
              points={{-80,92},{-86,70},{-74,70},{-80,92}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Line(points={{-80,70},{-80,-80}}, color={95,95,95}),
            Line(points={{-92,-70},{68,-70}}, color={95,95,95}),
            Polygon(
              points={{90,-70},{68,-64},{68,-76},{90,-70}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{54,-80},{106,-92}},
              textString="tick"),
            Text(
              extent={{-74,92},{-56,74}},
              textString="y"),
          Line(
              points={{-80,-70},{0,-70},{0,50},{80,50}},
              color={255,0,255},
              thickness=0.5,
              pattern=LinePattern.Dot),
          Polygon(
            points={{-8,50},{-90,50},{-8,50}},
            lineColor={95,95,95},
            fillColor={95,95,95},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-76,62},{-32,48}},
            textString="not startValue"),
          Text(
            extent={{-78,-52},{-46,-66}},
            textString="startValue"),
            Ellipse(
              extent={{-86,-64},{-74,-76}},
              lineColor={255,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-6,56},{6,44}},
              lineColor={255,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-46,-64},{-34,-76}},
              lineColor={255,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{74,56},{86,44}},
              lineColor={255,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{34,56},{46,44}},
              lineColor={255,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-21,-76},{26,-88}},
              textString="startTick")}),
        Documentation(info="<html>
<p>
The Boolean output y is a step signal. The signal is defined in terms of clock ticks instead of simulation time:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Clocked/BooleanSignals/TickBasedSources_Step.png\">
</p>

<h4>Example</h4>
<p>
See model <a href=\"Modelica.Clocked.Examples.Elementary.BooleanSignals.TickBasedStep\">Modelica.Clocked.Examples.Elementary.BooleanSignals.TickBasedStep</a>.
</p>
</html>"));
    end Step;

      block Pulse "Generate pulse signal of type Boolean"
        extends BooleanSignals.Interfaces.PartialClockedSO;
        parameter Integer widthTicks(min=1,max=periodTicks) = 1
        "Width of one pulse in clock ticks";
        parameter Integer periodTicks(min=1,start=1) = 2
        "Number of clock ticks for one period";
        parameter Integer startTick(min=1)=1
        "Clock tick at which the first pulse starts";

    protected
        Integer counter(start=0);
        Boolean startOutput(start=false)
        "Flag whether counter >= startTick reached once";
      equation
        // restart counter after reaching threshold to avoid integer overflow for long running simulations
        if previous(startOutput) then
            counter = if previous(counter) == (periodTicks-1) then 0 else previous(counter) + 1;
            startOutput = previous(startOutput);
        else
          startOutput = previous(counter) >= (startTick-1);
          counter = if startOutput then 0 else previous(counter) + 1;
        end if;

        y = startOutput and (counter < widthTicks);
        annotation (
          Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics={Text(
              extent={{-150,-140},{150,-110}},
              textString="periodTicks=%periodTicks"),
              Polygon(
                points={{-80,88},{-88,66},{-72,66},{-80,88}},
                lineColor={255,0,255},
                fillColor={255,0,255},
                fillPattern=FillPattern.Solid),
              Line(points={{-80,66},{-80,-82}}, color={255,0,255}),
              Line(points={{-90,-70},{72,-70}}, color={255,0,255}),
              Polygon(
                points={{90,-70},{68,-62},{68,-78},{90,-70}},
                lineColor={255,0,255},
                fillColor={255,0,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{71,7},{85,-7}},
                lineColor=DynamicSelect({235,235,235}, if y > 0.5 then {0,255,0} else
                          {235,235,235}),
                fillColor=DynamicSelect({235,235,235}, if y > 0.5 then {0,255,0} else
                          {235,235,235}),
                fillPattern=FillPattern.Solid),
                Line(points={{-80,-70},{-40,-70},{-40,44},{0,44},
                    {0,-70},{40,-70},{40,44},{79,44}},   pattern=LinePattern.Dot),
              Ellipse(
                extent={{-86,-64},{-74,-76}},
                lineColor={255,0,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{-46,49},{-34,37}},
                lineColor={255,0,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{-6,-64},{6,-76}},
                lineColor={255,0,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{34,49},{46,37}},
                lineColor={255,0,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid)}),
      Diagram(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics={
            Text(
              extent={{-60,-74},{-19,-82}},
              textString="startTick"),
            Line(
                points={{-78,-70},{-40,-70},{-40,20},{20,20},{20,-70},{50,-70},{50,20},
                    {100,20}},
                color={255,0,255},
                thickness=0.5,
                pattern=LinePattern.Dot),
            Line(points={{-40,68},{-40,20}}, color={95,95,95}),
            Line(points={{-10,40},{-10,20}},
                                           color={95,95,95}),
            Line(points={{50,65},{50,27}}, color={95,95,95}),
            Line(points={{-40,60},{50,60}}, color={95,95,95}),
            Line(points={{-40,35},{-10,35}},color={95,95,95}),
            Text(
              extent={{-18,72},{28,62}},
              textString="periodTicks"),
            Text(
              extent={{-37,51},{10,41}},
              textString="widthTicks"),
            Line(points={{-70,20},{-41,20}}, color={95,95,95}),
            Polygon(
              points={{-40,35},{-31,37},{-31,33},{-40,35}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-10,35},{-18,37},{-18,33},{-10,35}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-40,60},{-31,62},{-31,58},{-40,60}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{50,60},{42,62},{42,58},{50,60}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-95,26},{-66,17}},
              textString="true"),
            Text(
              extent={{-96,-60},{-75,-69}},
              textString="false"),
              Ellipse(
                extent={{-46,26},{-34,14}},
                lineColor={255,0,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{-16,26},{-4,14}},
                lineColor={255,0,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{14,-63},{26,-75}},
                lineColor={255,0,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{44,25},{56,13}},
                lineColor={255,0,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{74,26},{86,14}},
                lineColor={255,0,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{-76,-64},{-64,-76}},
                lineColor={255,0,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid)}),
          Documentation(info="<html>
<p>The block is similar to the block in <a href=\"modelica://Modelica.Blocks.Sources.BooleanPulse\">Modelica.Blocks.Sources.BooleanPulse</a>,
but adapted to work in clocked partitions (by internal sampling of the continuous <b>time</b> variable).
</p>
<p>
The Boolean output y is a pulse signal:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Clocked/BooleanSignals/TickBasedSources_Pulse.png\">
</p>
<h4>Example</h4>
<p>
See model <a href=\"Modelica.Clocked.Examples.Elementary.BooleanSignals.TickBasedPulse\">Modelica.Clocked.Examples.Elementary.BooleanSignals.TickBasedPulse</a>.
</p>
</html>"));
      end Pulse;
    annotation (Documentation(info="<html>
<p>This package provides <b>source</b> components akin to the blocks provided in <a href=\"Modelica.Blocks.Sources\">Modelica.Blocks.Sources</a>, but with the difference that they provide </p>
<p><ol>
<li>a <b>clocked</b> output signal and</li>
<li>are parametrized in terms of <b>clock ticks</b> rather than simulation time.</li>
</ol></p>
</html>"));
  end TickBasedSources;

  package Interfaces
    "Library of partial blocks for components with clocked Boolean signals"
    extends Modelica.Icons.InterfacesPackage;

    partial block SamplerIcon
      "Basic graphical layout of block used for sampling of Boolean signals"
      annotation (
        Icon(
          coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            initialScale=0.06),
          graphics={
            Rectangle(
              extent={{-99,40},{99,-40}},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None),
            Line(points={{-100,0},{-45,0}}, color={255,85,255}),
            Ellipse(
              extent={{-25,-10},{-45,10}},
              lineColor={255,85,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{-35,0},{30,35}}, color={255,85,255}),
            Ellipse(
              extent={{45,-10},{25,10}},
              lineColor={255,85,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{45,0},{100,0}}, color={255,85,255})}),
        Diagram(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            initialScale=0.06)));
    end SamplerIcon;

    partial block PartialSISOSampler
      "Basic block used for sampling of Boolean signals"
    extends Clocked.BooleanSignals.Interfaces.SamplerIcon;
      Modelica.Blocks.Interfaces.BooleanInput
                                           u
        "Connector of continuous-time, Real input signal"
        annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
      Modelica.Blocks.Interfaces.BooleanOutput
                                            y
        "Connector of clocked, Real output signal"
        annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    equation

      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}})), Diagram(coordinateSystem(
              preserveAspectRatio=false, extent={{-100,-100},{100,100}})));
    end PartialSISOSampler;

    partial block PartialClockedSISO
      "Block with clocked single input and clocked single output Boolean signals"
      extends Clocked.ClockSignals.Interfaces.ClockedBlockIcon;

      Modelica.Blocks.Interfaces.BooleanInput
                                           u
        "Connector of clocked, Real input signal"
        annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
      Modelica.Blocks.Interfaces.BooleanOutput
                                            y
        "Connector of clocked, Real output signal"
        annotation (Placement(transformation(extent={{100,-10},{120,10}})));

      annotation (Diagram(coordinateSystem(preserveAspectRatio=
                false, extent={{-100,-100},{100,100}})));
    end PartialClockedSISO;

    partial block PartialClockedSO
      "Block with clocked single output Boolean signals"
      extends Clocked.ClockSignals.Interfaces.ClockedBlockIcon;

      Modelica.Blocks.Interfaces.BooleanOutput
                                            y
        "Connector of clocked, Real output signal"
        annotation (Placement(transformation(extent={{100,-10},{120,10}})));

      annotation (Diagram(coordinateSystem(preserveAspectRatio=false,
                       extent={{-100,-100},{100,100}})));
    end PartialClockedSO;
    annotation (Documentation(info="<html>
<p>
This package contains partial blocks that are used to
construct blocks operating on clocked Boolean signals.
</p>
</html>"));
  end Interfaces;
  annotation (Documentation(info="<html>
<p>
This package contains blocks that operate on clocked Boolean signals.
Especially blocks are provided to transform from continuous-time Boolean signals to
clocked Boolean signals (with Sampler blocks) and vice versa
(with Hold blocks), as well as to transform a clocked Boolean signal from
one clock to a different clock in a time-synchronized way.
</p>
</html>"));
end BooleanSignals;