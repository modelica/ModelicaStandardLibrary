within Modelica.Clocked;
package IntegerSignals "Library of clocked blocks for Integer signals"
  extends Modelica.Icons.Package;
  package Sampler "Library of sampler and hold blocks for Integer signals"
    extends Modelica.Icons.Package;

    block Sample
      "Sample the continuous-time, Integer input signal and provide it as clocked output signal (clock is inferred)"
      extends Clocked.IntegerSignals.Interfaces.PartialSISOSampler;

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
This block for Integer signals works similarly as the corresponding block for Real signals
(see <a href=\"modelica://Modelica_Synchronous.RealSignals.Sampler.Sample\">RealSignals.Sampler.Sample</a>).
</p>
<p>
Analog to the corresponding Real signal block examples there exist two elementary examples,
<a href=\"modelica://Modelica_Synchronous.Examples.Elementary.IntegerSignals.Sample1\">Sample1</a> and
<a href=\"modelica://Modelica_Synchronous.Examples.Elementary.IntegerSignals.Sample2\">Sample2</a>, for this Integer block.
</p>
</html>"));
    end Sample;

    block SampleClocked
      "Sample the continuous-time, Integer input signal and provide it as clocked output signal. The clock is provided as input signal"
      extends Clocked.IntegerSignals.Interfaces.SamplerIcon;
      Clocked.ClockSignals.Interfaces.ClockInput clock
        "Output signal y is associated with this clock input" annotation (
          Placement(transformation(
            extent={{-20,-20},{20,20}},
            rotation=90,
            origin={0,-120})));
      Modelica.Blocks.Interfaces.IntegerInput
                                           u
        "Connector of continuous-time, Integer input signal"
        annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
      Modelica.Blocks.Interfaces.IntegerOutput
                                            y
        "Connector of clocked, Integer output signal"
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
This block for Integer signals works similarly as the corresponding block for Real signals (see <a href=\"modelica://Modelica_Synchronous.RealSignals.Sampler.SampleClocked\">RealSignals.Sampler.SampleClocked</a>).
</p>
<p>
Analog to the corresponding Real signal block example there exists an elementary <a href=\"modelica://Modelica_Synchronous.Examples.Elementary.IntegerSignals.SampleClocked\">example</a> for this Integer block.
</p>
</html>"));
    end SampleClocked;

    block SampleVectorizedAndClocked
      "Sample the continuous-time, Integer input signal vector and provide it as clocked output signal vector. The clock is provided as input signal"
      extends Clocked.IntegerSignals.Interfaces.SamplerIcon;
      parameter Integer n(min=1)=1
        "Size of input signal vector u (= size of output signal vector y)";
      Modelica.Blocks.Interfaces.IntegerInput
                                           u[n]
        "Connector of continuous-time, Integer input signal vector"
        annotation (Placement(transformation(extent={{-140,-20},{-100,20}}), iconTransformation(extent={{-140,-20},{-100,20}})));
      Modelica.Blocks.Interfaces.IntegerOutput
                                            y[n]
        "Connector of clocked, Integer output signal vector"
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
This block for Integer signals works similarly as the corresponding block for Real signals (see <a href=\"modelica://Modelica_Synchronous.RealSignals.Sampler.SampleVectorizedAndClocked\">RealSignals.Sampler.SampleVectorizedAndClocked</a>).
</p>
<p>
Analog to the corresponding Real signal block example there exists an elementary <a href=\"modelica://Modelica_Synchronous.Examples.Elementary.IntegerSignals.SampleVectorizedAndClocked\">example</a> for this Integer block.
</p>
</html>"));
    end SampleVectorizedAndClocked;

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
            grid={2,2},
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
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-200,-80},{200,-145}},
              textString="%y_start")}),
        Documentation(info="<html>
<p>
This block for Integer signals works similarly as the corresponding block for Real signals (see <a href=\"modelica://Modelica_Synchronous.RealSignals.Sampler.Hold\">RealSignals.Sampler.Hold</a>).
</p>

<p>
Analog to the corresponding Real signal block example there exists an elementary
<a href=\"modelica://Modelica_Synchronous.Examples.Elementary.IntegerSignals.Hold\">example</a> for this Integer block.
</p>
</html>"),
        Diagram(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            initialScale=0.06)));
    end Hold;

    block SubSample
      "Sub-sample the clocked Integer input signal and provide it as clocked output signal"
      parameter Boolean inferFactor=true
        "= true, if sub-sampling factor is inferred"  annotation(Evaluate=true, choices(checkBox=true));
      parameter Integer factor(min=1)=1
        "Sub-sampling factor >= 1 (ignored if inferFactor=true)"
                                                                annotation(Evaluate=true, Dialog(enable=not inferFactor));

      Modelica.Blocks.Interfaces.IntegerInput
                                           u
        "Connector of clocked, Integer input signal"
        annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
      Modelica.Blocks.Interfaces.IntegerOutput
                                            y
        "Connector of clocked, Integer output signal (clock of y is slower as clock of u)"
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
              color={255,128,0}),
            Text(
              extent={{-200,165},{200,100}},
              lineColor={0,0,255},
              textString="%name"),
            Text(visible=not inferFactor,
              extent={{-200,-85},{200,-150}},
              textString="%factor"),
            Ellipse(
              extent={{-95,-45},{-65,-75}},
              lineColor={255,128,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{45,15},{75,-15}},
              lineColor={255,128,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-46,-20},{-26,-40}},
              lineColor={255,128,0},
              fillColor={255,128,0},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{4,71},{24,51}},
              lineColor={255,128,0},
              fillColor={255,128,0},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-83,-57},{-77,-63}},
              lineColor={255,128,0},
              fillColor={255,128,0},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{57,3},{63,-3}},
              lineColor={255,128,0},
              fillColor={255,128,0},
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
This block for Integer signals works similarly as the corresponding block for Real signals (see <a href=\"modelica://Modelica_Synchronous.RealSignals.Sampler.SubSample\">RealSignals.Sampler.SubSample</a>).
</p>
<p>
Analog to the corresponding Real signal block example there exists an elementary <a href=\"modelica://Modelica_Synchronous.Examples.Elementary.IntegerSignals.SubSample\">example</a> for this Integer block.
</p>
</html>"));
    end SubSample;

    block SuperSample
      "Super-sample the clocked Integer input signal and provide it as clocked output signal"
      parameter Boolean inferFactor=true
        "= true, if super-sampling factor is inferred"  annotation(Evaluate=true, choices(checkBox=true));
      parameter Integer factor(min=1)=1
        "Super-sampling factor >= 1 (ignored if inferFactor=true)"
                                                    annotation(Evaluate=true, Dialog(enable=not inferFactor));

      Modelica.Blocks.Interfaces.IntegerInput
                                           u
        "Connector of clocked, Integer input signal"
        annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
      Modelica.Blocks.Interfaces.IntegerOutput
                                            y
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
                                     color={255,128,0},
              pattern=LinePattern.Dot),                Line(
              points={{-80,-60},{-80,0},{-100,0}},
              color={255,128,0},
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
        Diagram(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={2,2},
            initialScale=0.06)),
        Documentation(info="<html>
<p>
This block for Integer signals works similarly as the corresponding block for Real signals (see <a href=\"modelica://Modelica_Synchronous.RealSignals.Sampler.SuperSample\">RealSignals.Sampler.SuperSample</a>).
</p>
<p>
Analog to the corresponding Real signal block example there exists an elementary <a href=\"modelica://Modelica_Synchronous.Examples.Elementary.IntegerSignals.SuperSample\">example</a> for this Integer block.
</p>
</html>"));
    end SuperSample;

    block ShiftSample
      "Shift the clocked Integer input signal by a fraction of the last interval and and provide it as clocked output signal"
      parameter Integer shiftCounter(min=0)=0 "Numerator of shifting formula"
            annotation(Evaluate=true, Dialog(group="Shift first clock activation for 'shiftCounter/resolution*interval(u)' seconds"));
      parameter Integer resolution(min=1)=1 "Denominator of shifting formula"
            annotation(Evaluate=true, Dialog(group="Shift first clock activation for 'shiftCounter/resolution*interval(u)' seconds"));

      Modelica.Blocks.Interfaces.IntegerInput
                                           u
        "Connector of clocked, Integer input signal"
        annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
      Modelica.Blocks.Interfaces.IntegerOutput
                                            y
        "Connector of clocked, Integer output signal"
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
                                     color={255,128,0},
              pattern=LinePattern.Dot),
            Text(
              extent={{-200,175},{200,110}},
              lineColor={0,0,255},
              textString="%name"),
            Text(
              extent={{-200,-85},{200,-150}},
              textString="%shiftCounter/%resolution"),
                                   Line(points={{-80,-50},{-40,-50},{-40,50}},
                                     color={255,128,0},
              pattern=LinePattern.Dot),
            Ellipse(
              extent={{10,-40},{30,-60}},
              lineColor={255,128,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{50,60},{70,40}},
              lineColor={255,128,0},
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
              lineColor={255,128,0},
              fillColor={255,128,0},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-50,60},{-30,40}},
              lineColor={255,128,0},
              fillColor={255,128,0},
              fillPattern=FillPattern.Solid)}),
        Diagram(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={2,2},
            initialScale=0.06)),
        Documentation(info="<html>
<p>
This block for Integer signals works similarly as the corresponding block for Real signals (see <a href=\"modelica://Modelica_Synchronous.RealSignals.Sampler.ShiftSample\">RealSignals.Sampler.ShiftSample</a>).
</p>
<p>
Analog to the corresponding Real signal block example there exists an elementary <a href=\"modelica://Modelica_Synchronous.Examples.Elementary.IntegerSignals.ShiftSample\">example</a> for this Integer block.
</p>
</html>"));
    end ShiftSample;

    block BackSample
      "Shift clock of Integer input signal backwards in time (and access the most recent value of the input at this new clock)"
      parameter Integer backCounter(min=0)=0 "Numerator of shifting formula"
            annotation(Evaluate = true, Dialog(group="Shift first clock activation backwards in time for 'shiftCounter/resolution*interval(u)' seconds"));
      parameter Integer resolution(min=1)=1 "Denominator of shifting formula"
            annotation(Evaluate = true, Dialog(group="Shift first clock activation backwards in time for 'shiftCounter/resolution*interval(u)' seconds"));
      parameter Integer y_start=0
        "Value of output y before the first clock tick of the input u";

      Modelica.Blocks.Interfaces.IntegerInput
                                           u(start=y_start)
        "Connector of clocked, Integer input signal"
        annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
      Modelica.Blocks.Interfaces.IntegerOutput
                                            y
        "Connector of clocked, Integer output signal (clock of y is faster als clock of u)"
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
                                     color={255,128,0},
              pattern=LinePattern.Dot),
            Text(
              extent={{-200,175},{200,110}},
              lineColor={0,0,255},
              textString="%name"),
            Text(
              extent={{-200,-135},{200,-200}},
              textString="%backCounter/%resolution"),
                                   Line(points={{-80,-50},{-40,-50},{-40,50}},
                                     color={255,128,0},
              pattern=LinePattern.Dot),
            Ellipse(
              extent={{-90,-40},{-70,-60}},
              lineColor={255,128,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-50,60},{-30,40}},
              lineColor={255,128,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-16,0},{4,20},{4,10},{34,10},{34,-10},{4,-10},{4,-20},{-16,0}},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid,
              lineColor={95,95,95}),
            Ellipse(
              extent={{10,-40},{30,-60}},
              lineColor={255,128,0},
              fillColor={255,128,0},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{50,60},{70,40}},
              lineColor={255,128,0},
              fillColor={255,128,0},
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
This block for Integer signals works similarly as the corresponding block for Real signals (see <a href=\"modelica://Modelica_Synchronous.RealSignals.Sampler.BackSample\">RealSignals.Sampler.BackSample</a>).
</p>
<p>
Analog to the corresponding Real signal block example there exists an elementary <a href=\"modelica://Modelica_Synchronous.Examples.Elementary.IntegerSignals.BackSample\">example</a> for this Integer block.
</p>
</html>"));
    end BackSample;

    block AssignClock "Assigns a clock to a clocked Integer signal"
      Modelica.Blocks.Interfaces.IntegerInput
                                           u
        "Connector of clocked, Integer input signal"
        annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
      Modelica.Blocks.Interfaces.IntegerOutput
                                            y
        "Connector of clocked, Integer output signal"
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
                  0},{80,0},{100,0}},color={255,128,0},
              pattern=LinePattern.Dot),                Line(
              points={{-80,-60},{-80,0},{-106,0}},
              color={255,128,0},
              pattern=LinePattern.Dot),
            Ellipse(
              extent={{-90,-50},{-70,-70}},
              lineColor={255,128,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-50,10},{-30,-10}},
              lineColor={255,128,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-10,90},{10,70}},
              lineColor={255,128,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{30,50},{50,30}},
              lineColor={255,128,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{70,10},{90,-10}},
              lineColor={255,128,0},
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
This block for Integer signals works similarly as the corresponding block for Real signals (see <a href=\"modelica://Modelica_Synchronous.RealSignals.Sampler.AssignClock\">RealSignals.Sampler.AssignClock</a>).
</p>
<p>
Analog to the corresponding Real signal block example there exists an elementary <a href=\"modelica://Modelica_Synchronous.Examples.Elementary.IntegerSignals.AssignClock\">example</a> for this Integer block.
</p>
</html>"));
    end AssignClock;

    block AssignClockVectorized
      "Assigns a clock to a clocked Integer signal vector"
      parameter Integer n(min=1)=1
        "Size of input signal vector u (= size of output signal vector y)";
      Modelica.Blocks.Interfaces.IntegerInput
                                           u[n]
        "Connector of clocked, Integer input signal"
        annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
      Modelica.Blocks.Interfaces.IntegerOutput
                                            y[n]
        "Connector of clocked, Integer output signal"
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
                  0},{80,0},{100,0}},color={255,128,0},
              pattern=LinePattern.Dot),                Line(
              points={{-80,-60},{-80,0},{-106,0}},
              color={255,128,0},
              pattern=LinePattern.Dot),
            Ellipse(
              extent={{-90,-50},{-70,-70}},
              lineColor={255,128,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-50,10},{-30,-10}},
              lineColor={255,128,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-10,90},{10,70}},
              lineColor={255,128,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{30,50},{50,30}},
              lineColor={255,128,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{70,10},{90,-10}},
              lineColor={255,128,0},
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
This block for Integer signals works similarly as the corresponding block for Real signals (see <a href=\"modelica://Modelica_Synchronous.RealSignals.Sampler.AssignClockVectorized\">RealSignals.Sampler.AssignClockVectorized</a>).
</p>
<p>
Analog to the corresponding Real signal block example there exists an elementary <a href=\"modelica://Modelica_Synchronous.Examples.Elementary.IntegerSignals.AssignClockVectorized\">example</a> for this Integer block.
</p>
</html>"));
    end AssignClockVectorized;

    package Utilities "Utility components that are usually not directly used"
       extends Modelica.Icons.UtilitiesPackage;

      block UpSample
        "Upsample the clocked Integer input signal and provide it as clocked output signal"
        parameter Boolean inferFactor=true
          "= true, if upsampling factor is inferred"  annotation(Evaluate=true, choices(checkBox=true));
        parameter Integer factor(min=1)=1
          "Upsampling factor >= 1 (if inferFactor=false)" annotation(Evaluate=true, Dialog(enable=not inferFactor));
        Modelica.Blocks.Interfaces.IntegerInput
                                             u
          "Connector of clocked, Integer input signal"
          annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
        Modelica.Blocks.Interfaces.IntegerOutput
                                              y
          "Connector of clocked, Integer output signal (clock of y is faster as clock of u)"
          annotation (Placement(transformation(extent={{100,-10},{120,10}})));
      protected
        Integer dummy annotation(HideResult=true);
        Boolean b(start=false);
        Boolean b_super(start=false);
        Integer u_super;
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
           y = if b_super <> previous(b_super) then u_super else 0;
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
                    {100,0}},          color={255,128,0},
                pattern=LinePattern.Dot),                Line(
                points={{-80,-60},{-80,0},{-100,0}},
                color={255,128,0},
                pattern=LinePattern.Dot),
              Text(
                extent={{-200,175},{200,110}},
                lineColor={0,0,255},
                textString="%name"),
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
                extent={{25,96},{55,66}},
                lineColor={255,128,0},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{37,83},{43,77}},
                lineColor={255,128,0},
                fillColor={255,128,0},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{-55,16},{-25,-14}},
                lineColor={255,128,0},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{-6,16},{24,-14}},
                lineColor={255,128,0},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{64,16},{94,-14}},
                lineColor={255,128,0},
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
This block for Integer signals works similarly as the corresponding block for Real signals (see
<a href=\"modelica://Modelica_Synchronous.RealSignals.Sampler.Utilities.UpSample\">RealSignals.Sampler.Utilities.UpSample</a>).
</p>
<p>
Analog to the corresponding Real signal block example there exists an elementary <a href=\"modelica://Modelica_Synchronous.Examples.Elementary.IntegerSignals.UpSample\">example</a> for this Integer block.
</p>

</html>"));
      end UpSample;

        block AssignClockToTriggerHold
        "Generate a Boolean continuous-time trigger signal from a clocked Integer input"
          extends Clocked.ClockSignals.Interfaces.ClockedBlockIcon;
          parameter Boolean y_start=false "Initial value of output signal";
          Modelica.Blocks.Interfaces.IntegerInput
                                               u
            annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
          Modelica.Blocks.Interfaces.BooleanOutput y
          "Connector of Boolean output signal"     annotation (Placement(
                transformation(extent={{100,-10},{120,10}}),
                iconTransformation(extent={{100,-10},{120,10}})));
      protected
          Boolean y2(start=y_start);
          Boolean y3(start=y_start, fixed=true);
          Real uu annotation(HideResult=true);
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
This block for Integer signals works similar as the corresponding block for Real signals (see
<a href=\"modelica://Modelica_Synchronous.RealSignals.Sampler.Utilities.AssignClockToTriggerHold\">RealSignals.Sampler.Utilities.AssignClockToTriggerHold</a>).
</p>
</html>"));
        end AssignClockToTriggerHold;

        block AssignClockToSquareWaveHold
        "Generate a Boolean continuous-time square signal from a clocked Integer input"
          extends Clocked.ClockSignals.Interfaces.ClockedBlockIcon;
          parameter Boolean y_start=false "Initial value of output signal";
          Modelica.Blocks.Interfaces.IntegerInput
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
          y2 = if u > 0 then not previous(y2) else not previous(y2);
          y = hold(y2);
          annotation (
            defaultComponentName="clockToSquareWave",
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
                                       Line(points={{-80,-70},{-40,-70},{-40,44},{0,44},
                      {0,-70},{40,-70},{40,44},{79,44}})}),
            Diagram(coordinateSystem(
              preserveAspectRatio=false,
              extent={{-100,-100},{100,100}},
              grid={1,1})),
            Documentation(info="<html>
<p>
This block for Integer signals works similar as the corresponding block for Real signals (see
<a href=\"modelica://Modelica_Synchronous.RealSignals.Sampler.Utilities.AssignClockToSquareWaveHold\">RealSignals.Sampler.Utilities.AssignClockToSquareWaveHold</a>).
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
and transform an <b>Integer</b> signal from one partition to the next. Especially,
the following blocks are provided:<br>&nbsp;
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"3\">
<tr><th align=\"left\"><b>Boundary Type</b></th>
    <th align=\"left\"><b>Block Name</b></th>
    <th align=\"left\"><b>Description</b></th></tr>

<tr><td valign=\"top\" rowspan=\"3\">continuous-time &rarr; clocked</td>
      <td><a href=\"modelica://Modelica_Synchronous.IntegerSignals.Sampler.Sample\">Sample</a></td>
      <td>Sample a continuous-time signal.</td>
    </tr>
    <tr>
      <td><a href=\"modelica://Modelica_Synchronous.IntegerSignals.Sampler.SampleClocked\">SampleClocked</a></td>
      <td>Sample and associate a clock to the sampled <b>scalar</b> signal.</td>
    </tr>
    <tr>
      <td><a href=\"modelica://Modelica_Synchronous.IntegerSignals.Sampler.SampleVectorizedAndClocked\">SampleVectorizedAndClocked</a></td>
      <td>Sample an input vector and associate a clock to the sampled <b>vector</b> signal.</td>
    </tr>

<tr><td valign=\"top\">clocked &rarr; continuous-time</td>
      <td><a href=\"modelica://Modelica_Synchronous.IntegerSignals.Sampler.Hold\">Hold</a></td>
      <td>Hold a clocked signal with zero-order hold.</td>
    </tr>

<tr><td valign=\"top\" rowspan=\"4\">clocked &rarr; clocked</td>
      <td><a href=\"modelica://Modelica_Synchronous.IntegerSignals.Sampler.SubSample\">SubSample</a></td>
      <td>Sub-sample a signal (output clock is slower as input clock). </td>
    </tr>

    <tr>
      <td><a href=\"modelica://Modelica_Synchronous.IntegerSignals.Sampler.SuperSample\">SuperSample</a></td>
      <td>Super-sample a signal (output clock is faster as input clock). </td>
    </tr>

    <tr>
      <td><a href=\"modelica://Modelica_Synchronous.IntegerSignals.Sampler.ShiftSample\">ShiftSample</a></td>
      <td>Shift a signal (output clock is delayed with respect to input clock).  </td>
    </tr>

    <tr>
      <td><a href=\"modelica://Modelica_Synchronous.IntegerSignals.Sampler.BackSample\">BackSample</a></td>
      <td>Shift a signal and start the output clock before the input clock with a start value.  </td>
    </tr>


<tr><td valign=\"top\" rowspan=\"2\">within clocked partition</td>
      <td><a href=\"modelica://Modelica_Synchronous.IntegerSignals.Sampler.AssignClock\">AssignClock</a></td>
      <td>Assign a clock to a clocked <b>scalar</b> signal.</td>
    </tr>
    <tr>
      <td><a href=\"modelica://Modelica_Synchronous.IntegerSignals.Sampler.AssignClockVectorized\">AssignClockVectorized</a></td>
      <td>Assign a clock to a clocked <b>vector</b> signal.</td>
    </tr>
</table>

<p>
Additionally, package
<a href=\"modelica://Modelica_Synchronous.IntegerSignals.Sampler.Utilities\">Utilities</a></td>
contains utility blocks that are used as building blocks for user-relevant blocks.
</p>
</html>"));
  end Sampler;

  package NonPeriodic
    "Library of blocks that operate on periodically and non-periodically clocked signals"
    extends Modelica.Icons.Package;

    block IntegerChange
      extends Clocked.ClockSignals.Interfaces.ClockedBlockIcon;

      Modelica.Blocks.Interfaces.IntegerInput u
        "Connector of Integer input signal."
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
    <a href=\"Modelica.Blocks.Math.IntegerChange\">Modelica.Blocks.Math.IntegerChange</a>.
    It uses <code>previous</code> instead of the implicit <code>pre</code> of
    <code>change</code> to set the Boolean output <code>y</code> to
    <code>true</code> when the integer input <code>u</code> changed. Thus, it's
    logic is:
    <pre><code>
    if firstTick() then
      y = false;
    else
      y = not(u == previous(u));
    end if;</code></pre>
    <p>
    <b>This block might be superfluous and replaced by
    </b><code>Modelica.Blocks.Math.IntegerChange</code><b> when the semantics
    of </b><code>change</code><b> are relaxed and well-defined for
    clocked discrete-time partitions.</b>
    </html>"));
    end IntegerChange;

    block UnitDelay "Delays the clocked input signal for one sample period"
      extends Clocked.IntegerSignals.Interfaces.PartialClockedSISO(u(final
            start=y_start));
      parameter Integer y_start=0 "Value of output signal at first clock tick";
    equation
      y = previous(u);
      annotation (defaultComponentName="UnitDelay1",
           Icon(graphics={
            Line(points={{-30,0},{30,0}}, color={255,128,0}),
            Text(
              extent={{-90,10},{90,90}},
              textString="1",
              lineColor={255,128,0}),
            Text(
              extent={{-90,-10},{90,-90}},
              textString="z",
              lineColor={255,128,0}),
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
    extends Clocked.IntegerSignals.Interfaces.PartialClockedSISO;

      parameter Integer shift(min=0) = 0
        "Delay = interval() * shift/resolution";
      parameter Integer resolution(min=1) = 1
        "Time quantization resolution of sample interval";
    protected
      parameter Integer n = div(shift,resolution);
      Integer u_buffer[n+1](each start=0)
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
              color={255,128,0}),
            Text(
              extent={{4,-102},{4,-142}},
              textString="%shift/%resolution"),
            Ellipse(
              extent={{-90,50},{-70,30}},
              lineColor={255,128,0},
              fillColor={255,128,0},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-30,-30},{-10,-50}},
              lineColor={255,128,0},
              fillColor={255,128,0},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{30,10},{50,-10}},
              lineColor={255,128,0},
              fillColor={255,128,0},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-60,50},{-40,30}},
              lineColor={255,128,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{0,-30},{20,-50}},
              lineColor={255,128,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{60,10},{80,-10}},
              lineColor={255,128,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}));
    end FractionalDelay;
  end NonPeriodic;

  package TimeBasedSources
    "Package of signal source blocks generating clocked simulation time based Integer signals"
     extends Modelica.Icons.SourcesPackage;
    block Step "Generate step signal of type Integer"
        extends Interfaces.PartialClockedSO;
      parameter Integer height = 1 "Height of step";
      parameter Integer offset = 0 "Offset of output signal y";
      parameter Modelica.SIunits.Time startTime = 0
        "Output y = offset for time < startTime";
    protected
      Modelica.SIunits.Time simTime;
    equation
      simTime = sample(time);
      y = offset + (if simTime < startTime then 0 else height);
      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={
            Line(points={{-80,68},{-80,-80}}, color={192,192,192}),
            Polygon(
              points={{-80,90},{-88,68},{-72,68},{-80,90}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Line(points={{-90,-70},{82,-70}}, color={192,192,192}),
            Polygon(
              points={{90,-70},{68,-62},{68,-78},{90,-70}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Line(points={{-80,-70},{0,-70},{0,50},{80,50}}, color={255,128,0},
              pattern=LinePattern.Dot),
            Text(
              extent={{-150,-150},{150,-110}},
              textString="startTime=%startTime"),
            Ellipse(
              extent={{-6,56},{6,44}},
              lineColor={255,128,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-86,-64},{-74,-76}},
              lineColor={255,128,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-46,-64},{-34,-76}},
              lineColor={255,128,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{34,56},{46,44}},
              lineColor={255,128,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{74,56},{86,44}},
              lineColor={255,128,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}),
                              Diagram(coordinateSystem(preserveAspectRatio=true,
              extent={{-100,-100},{100,100}}), graphics={
            Polygon(
              points={{-80,88},{-86,68},{-74,68},{-80,88}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Line(points={{-80,68},{-80,-80}}, color={95,95,95}),
            Line(
              points={{-80,-18},{0,-18},{0,50},{72,50}},
              color={255,128,0},
              thickness=0.5,
              pattern=LinePattern.Dot),
            Line(points={{-90,-70},{82,-70}}, color={95,95,95}),
            Polygon(
              points={{90,-70},{70,-66},{70,-74},{90,-70}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{66,-78},{92,-88}},
              textString="time"),
            Text(
              extent={{-21,-76},{26,-88}},
              textString="startTime"),
            Line(points={{0,-17},{0,-71}}, color={95,95,95}),
            Text(
              extent={{-60,-36},{-12,-48}},
              textString="offset"),
            Line(points={{-13,50},{-13,-17}}, color={95,95,95}),
            Polygon(
              points={{2,50},{-19,50},{2,50}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-13,-17},{-16,-4},{-10,-4},{-13,-17},{-13,-17}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-13,50},{-16,37},{-9,37},{-13,50}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-58,22},{-12,10}},
              textString="height"),
            Polygon(
              points={{-13,-69},{-16,-56},{-10,-56},{-13,-69},{-13,-69}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Line(points={{-13,-18},{-13,-70}}, color={95,95,95}),
            Polygon(
              points={{-13,-18},{-16,-31},{-9,-31},{-13,-18}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-78,96},{-44,80}},
              textString="y"),
            Ellipse(
              extent={{-86,-12},{-74,-24}},
              lineColor={255,128,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-6,56},{6,44}},
              lineColor={255,128,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-46,-12},{-34,-24}},
              lineColor={255,128,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{30,56},{42,44}},
              lineColor={255,128,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{66,56},{78,44}},
              lineColor={255,128,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}),
        Documentation(info="<html>
<p>The block is similar to the block in <a href=\"modelica://Modelica.Blocks.Sources.IntegerStep\">Modelica.Blocks.Sources.IntegerStep</a>, but adapted to work in clocked partitions (by internal sampling of the continuous <b>time</b> variable).</p>
<p>
The Integer output y is a step signal:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/IntegerStep.png\">
</p>

<h4>Example</h4>
<p>
See model <a href=\"Modelica_Synchronous.Examples.Elementary.IntegerSignals.TimeBasedStep\">Modelica_Synchronous.Examples.Elementary.IntgerSignals.TimeBasedStep</a>.
<br>
</p>
</html>"));
    end Step;

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
    "Package of signal source blocks generating clocked tick/sample based Integer signals"
     extends Modelica.Icons.SourcesPackage;
    block Step "Generate step signal of type Integer"
        extends Interfaces.PartialClockedSO;
      parameter Integer height = 1 "Height of step";
      parameter Integer offset = 0 "Offset of output signal y";
      parameter Integer startTick(min=1) = 1
        "Output y = offset for clock tick < startTick";
    protected
      Integer counter(start=0);
    equation
      // stop counter after counter = startTick to avoid integer overflow for long running simulations
      counter = if previous(counter) < startTick then previous(counter) + 1 else previous(counter);
      y = offset + (if counter < startTick then 0 else height);
      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={
            Line(points={{-80,68},{-80,-80}}, color={192,192,192}),
            Polygon(
              points={{-80,90},{-88,68},{-72,68},{-80,90}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Line(points={{-90,-70},{82,-70}}, color={192,192,192}),
            Polygon(
              points={{90,-70},{68,-62},{68,-78},{90,-70}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Line(points={{-80,-70},{0,-70},{0,50},{80,50}}, color={255,128,0},
              pattern=LinePattern.Dot),
            Text(
              extent={{-150,-150},{150,-110}},
              textString="startTick=%startTick"),
            Ellipse(
              extent={{-6,56},{6,44}},
              lineColor={255,128,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-86,-64},{-74,-76}},
              lineColor={255,128,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-46,-64},{-34,-76}},
              lineColor={255,128,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{34,56},{46,44}},
              lineColor={255,128,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{74,56},{86,44}},
              lineColor={255,128,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}),
                              Diagram(coordinateSystem(preserveAspectRatio=true,
              extent={{-100,-100},{100,100}}), graphics={
            Polygon(
              points={{-80,88},{-86,68},{-74,68},{-80,88}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Line(points={{-80,68},{-80,-80}}, color={95,95,95}),
            Line(
              points={{-80,-18},{0,-18},{0,50},{72,50}},
              color={255,128,0},
              thickness=0.5,
              pattern=LinePattern.Dot),
            Line(points={{-90,-70},{82,-70}}, color={95,95,95}),
            Polygon(
              points={{90,-70},{70,-66},{70,-74},{90,-70}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{66,-78},{92,-88}},
              textString="tick"),
            Text(
              extent={{-21,-76},{26,-88}},
              textString="startTick"),
            Line(points={{0,-17},{0,-71}}, color={95,95,95}),
            Text(
              extent={{-60,-36},{-12,-48}},
              textString="offset"),
            Line(points={{-13,50},{-13,-17}}, color={95,95,95}),
            Polygon(
              points={{2,50},{-19,50},{2,50}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-13,-17},{-16,-4},{-10,-4},{-13,-17},{-13,-17}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-13,50},{-16,37},{-9,37},{-13,50}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-58,22},{-12,10}},
              textString="height"),
            Polygon(
              points={{-13,-69},{-16,-56},{-10,-56},{-13,-69},{-13,-69}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Line(points={{-13,-18},{-13,-70}}, color={95,95,95}),
            Polygon(
              points={{-13,-18},{-16,-31},{-9,-31},{-13,-18}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-78,96},{-44,80}},
              textString="y"),
            Ellipse(
              extent={{-86,-12},{-74,-24}},
              lineColor={255,128,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-6,56},{6,44}},
              lineColor={255,128,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-46,-12},{-34,-24}},
              lineColor={255,128,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{30,56},{42,44}},
              lineColor={255,128,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{66,56},{78,44}},
              lineColor={255,128,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}),
        Documentation(info="<html>
<p>
The Integer output y is a step signal. The signal is defined in terms of clock ticks instead of simulation time:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Clocked/IntegerSignals/TickBasedSources_Step.png\">
</p>

<h4>Example</h4>
<p>
See model <a href=\"Modelica_Synchronous.Examples.Elementary.IntegerSignals.TickBasedStep\">Modelica_Synchronous.Examples.Elementary.IntgerSignals.TickBasedStep</a>.
<br>
</p>
</html>"));
    end Step;
    annotation (Documentation(info="<html>
<p>This package provides <b>source</b> components akin to the blocks provided in <a href=\"Modelica.Blocks.Sources\">Modelica.Blocks.Sources</a>, but with the difference that they provide </p>
<p><ol>
<li>a <b>clocked</b> output signal and</li>
<li>are parametrized in terms of <b>clock ticks</b> rather than simulation time.</li>
</ol></p>
</html>"));
  end TickBasedSources;

  package Interfaces
    "Library of partial blocks for components with clocked Integer signals"
    extends Modelica.Icons.InterfacesPackage;

    partial block SamplerIcon
      "Basic graphical layout of block used for of Integer signals"
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
            Line(points={{-100,0},{-45,0}}, color={255,128,0}),
            Ellipse(
              extent={{-25,-10},{-45,10}},
              lineColor={255,128,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{-35,0},{30,35}}, color={255,128,0}),
            Ellipse(
              extent={{45,-10},{25,10}},
              lineColor={255,128,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{45,0},{100,0}}, color={255,128,0})}),
        Diagram(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            initialScale=0.06)));
    end SamplerIcon;

    partial block PartialSISOSampler
      "Basic block used for sampling of Integer signals"
    extends Clocked.IntegerSignals.Interfaces.SamplerIcon;
      Modelica.Blocks.Interfaces.IntegerInput
                                           u
        "Connector of continuous-time, Real input signal"
        annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
      Modelica.Blocks.Interfaces.IntegerOutput
                                            y
        "Connector of clocked, Real output signal"
        annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    equation

      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}})));
    end PartialSISOSampler;

    partial block PartialSISOHold
      "Basic block used for zero order hold of Integer signals"
      parameter Integer y_start = 0
        "Value of output y before the first tick of the clock associated to input u";

      Modelica.Blocks.Interfaces.IntegerInput
                                           u(final start=y_start)
        "Connector of clocked, Integer input signal"
        annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
      Modelica.Blocks.Interfaces.IntegerOutput
                                            y
        "Connector of continuous-time, Integer output signal"
        annotation (Placement(transformation(extent={{100,-10},{120,10}})));

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
                                   Line(points={{-60,-40},{-20,-40},{-20,20},{20,20},
                  {20,60},{60,60},{60,0},{100,0},{100,0},{100,0},{100,0},{120,0}},
                                     color={255,128,0}),
                                                       Line(
              points={{-60,-40},{-60,0},{-100,0}},
              color={255,128,0}),
            Text(
              extent={{-200,-80},{200,-145}},
              textString="%y_start"),
            Text(
              extent={{-200,129},{200,64}},
              lineColor={0,0,255},
              textString="%name")}),
        Documentation(info="<HTML>

</HTML>
"),     Diagram(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            initialScale=0.06)));
    end PartialSISOHold;

    partial block PartialClockedSISO
      "Block with clocked single input and clocked single output Integer signals"
      extends Clocked.ClockSignals.Interfaces.ClockedBlockIcon;

      Modelica.Blocks.Interfaces.IntegerInput
                                           u
        "Connector of clocked, Real input signal"
        annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
      Modelica.Blocks.Interfaces.IntegerOutput
                                            y
        "Connector of clocked, Real output signal"
        annotation (Placement(transformation(extent={{100,-10},{120,10}})));

      annotation (Diagram(coordinateSystem(preserveAspectRatio=
                false, extent={{-100,-100},{100,100}})));
    end PartialClockedSISO;

    partial block PartialClockedSO
      "Block with clocked single output Integer signal"
      extends Clocked.ClockSignals.Interfaces.ClockedBlockIcon;

      Modelica.Blocks.Interfaces.IntegerOutput
                                            y
        "Connector of clocked, Real output signal"
        annotation (Placement(transformation(extent={{100,-10},{120,10}})));

      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{
                -100,-100},{100,100}})), Diagram(coordinateSystem(preserveAspectRatio=
                false, extent={{-100,-100},{100,100}})));
    end PartialClockedSO;
    annotation (Documentation(info="<html>
<p>
This package contains partial blocks that are used to
construct blocks operating on clocked Integer signals.
</p>
</html>"));
  end Interfaces;
  annotation (Documentation(info="<html>
<p>
This package contains blocks that operate on clocked Integer signals.
Especially blocks are provided to transform from continuous-time Integer signals to
clocked Integer signals (with Sampler blocks) and vice versa
(with Hold blocks), as well as to transform a clocked Integer signal from
one clock to a different clock in a time-synchronized way.
</p>
</html>"));
end IntegerSignals;