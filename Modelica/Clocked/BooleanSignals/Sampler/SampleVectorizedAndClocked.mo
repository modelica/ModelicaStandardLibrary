within Modelica.Clocked.BooleanSignals.Sampler;
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
        initialScale=0.06),
                     graphics={
        Line(
          points={{0,-100},{0,18}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5),
        Text(
          extent={{-150,90},{150,50}},
          textColor={0,0,255},
          textString="%name"),
        Text(
          extent={{-150,-40},{20,-90}},
          textColor={0,0,0},
          textString="n=%n")}),
    Documentation(info="<html>
<p>
This block for Boolean signals works similarly as the corresponding block for Real signals (see <a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.SampleVectorizedAndClocked\">RealSignals.Sampler.SampleVectorizedAndClocked</a>).
</p>
<p>
Analog to the corresponding Real signal block example there exists an elementary <a href=\"modelica://Modelica.Clocked.Examples.Elementary.BooleanSignals.SampleVectorizedAndClocked\">example</a> for this Boolean block.
</p>
</html>"));
end SampleVectorizedAndClocked;
