within Modelica.Blocks.Examples;
model FilterWithDifferentiation
  "Demonstrates the use of low pass filters to determine derivatives of filters"
  extends Modelica.Icons.Example;
  parameter SI.Frequency f_cut=2 "Cut-off frequency";

  Modelica.Blocks.Sources.Step step(startTime=0.1, offset=0.1)
    annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
  Modelica.Blocks.Continuous.Filter Bessel(
    f_cut=f_cut,
    filterType=Modelica.Blocks.Types.FilterType.LowPass,
    order=3,
    analogFilter=Modelica.Blocks.Types.AnalogFilter.Bessel)
    annotation (Placement(transformation(extent={{-40,40},{-20,60}})));

  Continuous.Der der1
    annotation (Placement(transformation(extent={{-6,40},{14,60}})));
  Continuous.Der der2
    annotation (Placement(transformation(extent={{30,40},{50,60}})));
  Continuous.Der der3
    annotation (Placement(transformation(extent={{62,40},{82,60}})));
equation
  connect(step.y, Bessel.u) annotation (Line(
      points={{-59,50},{-42,50}}, color={0,0,127}));
  connect(Bessel.y, der1.u) annotation (Line(
      points={{-19,50},{-8,50}}, color={0,0,127}));
  connect(der1.y, der2.u) annotation (Line(
      points={{15,50},{28,50}}, color={0,0,127}));
  connect(der2.y, der3.u) annotation (Line(
      points={{51,50},{60,50}}, color={0,0,127}));
  annotation (
    experiment(StopTime=0.9),
    Documentation(info="<html>

<p>
This example demonstrates that the output of the
<a href=\"modelica://Modelica.Blocks.Continuous.Filter\">Filter</a> block
can be differentiated up to the order of the filter. This feature can be
used in order to make an inverse model realizable or to \"smooth\" a potential
discontinuous control signal.
</p>

</html>"));
end FilterWithDifferentiation;
