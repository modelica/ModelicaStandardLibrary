within Modelica.Clocked.BooleanSignals.Sampler;
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
          textString="%name")}),
    Documentation(info="<html>
<p>
This block for Boolean signals works similarly as the corresponding block for Real signals (see <a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.SampleClocked\">RealSignals.Sampler.SampleClocked</a>).
</p>
<p>
Analog to the corresponding Real signal block example there exists an elementary <a href=\"modelica://Modelica.Clocked.Examples.Elementary.BooleanSignals.SampleClocked\">example</a> for this Boolean block.
</p>
</html>"));
end SampleClocked;
