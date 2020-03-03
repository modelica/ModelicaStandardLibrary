within Modelica.Blocks.Examples;
model Filter "Demonstrates the Continuous.Filter block with various options"
  extends Modelica.Icons.Example;
  parameter Integer order=3 "Number of order of filter";
  parameter SI.Frequency f_cut=2 "Cut-off frequency";
  parameter Modelica.Blocks.Types.FilterType filterType=Modelica.Blocks.Types.FilterType.LowPass
    "Type of filter (LowPass/HighPass)";
  parameter Modelica.Blocks.Types.Init init=Modelica.Blocks.Types.Init.SteadyState
    "Type of initialization (no init/steady state/initial state/initial output)";
  parameter Boolean normalized=true "= true, if amplitude at f_cut = -3db, otherwise unmodified filter";

  Modelica.Blocks.Sources.Step step(startTime=0.1, offset=0.1)
    annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
  Modelica.Blocks.Continuous.Filter CriticalDamping(
    analogFilter=Modelica.Blocks.Types.AnalogFilter.CriticalDamping,
    normalized=normalized,
    init=init,
    filterType=filterType,
    order=order,
    f_cut=f_cut,
    f_min=0.8*f_cut)
    annotation (Placement(transformation(extent={{-20,40},{0,60}})));
  Modelica.Blocks.Continuous.Filter Bessel(
    normalized=normalized,
    analogFilter=Modelica.Blocks.Types.AnalogFilter.Bessel,
    init=init,
    filterType=filterType,
    order=order,
    f_cut=f_cut,
    f_min=0.8*f_cut)
    annotation (Placement(transformation(extent={{-20,0},{0,20}})));
  Modelica.Blocks.Continuous.Filter Butterworth(
    normalized=normalized,
    analogFilter=Modelica.Blocks.Types.AnalogFilter.Butterworth,
    init=init,
    filterType=filterType,
    order=order,
    f_cut=f_cut,
    f_min=0.8*f_cut)
    annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
  Modelica.Blocks.Continuous.Filter ChebyshevI(
    normalized=normalized,
    analogFilter=Modelica.Blocks.Types.AnalogFilter.ChebyshevI,
    init=init,
    filterType=filterType,
    order=order,
    f_cut=f_cut,
    f_min=0.8*f_cut)
    annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));

equation
  connect(step.y, CriticalDamping.u) annotation (Line(
      points={{-39,50},{-22,50}}, color={0,0,127}));
  connect(step.y, Bessel.u) annotation (Line(
      points={{-39,50},{-32,50},{-32,10},{-22,10}}, color={0,0,127}));
  connect(Butterworth.u, step.y) annotation (Line(
      points={{-22,-30},{-32,-30},{-32,50},{-39,50}}, color={0,0,127}));
  connect(ChebyshevI.u, step.y) annotation (Line(
      points={{-22,-70},{-32,-70},{-32,50},{-39,50}}, color={0,0,127}));
  annotation (
    experiment(StopTime=0.9),
    Documentation(info="<html>

<p>
This example demonstrates various options of the
<a href=\"modelica://Modelica.Blocks.Continuous.Filter\">Filter</a> block.
A step input starts at 0.1 s with an offset of 0.1, in order to demonstrate
the initialization options. This step input drives 4 filter blocks that
have identical parameters, with the only exception of the used analog filter type
(CriticalDamping, Bessel, Butterworth, Chebyshev of type I). All the main options
can be set via parameters and are then applied to all the 4 filters.
The default setting uses low pass filters of order 3 with a cut-off frequency of
2 Hz resulting in the following outputs:
</p>

<img src=\"modelica://Modelica/Resources/Images/Blocks/Examples/Filter1.png\"
     alt=\"Filter1.png\">
</html>"));
end Filter;
