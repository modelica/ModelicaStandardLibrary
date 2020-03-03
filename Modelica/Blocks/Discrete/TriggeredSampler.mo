within Modelica.Blocks.Discrete;
block TriggeredSampler "Triggered sampling of continuous signals"
  extends Modelica.Blocks.Icons.DiscreteBlock;
  parameter Real y_start=0 "Initial value of output signal";

  Modelica.Blocks.Interfaces.RealInput u "Connector with a Real input signal"
                                                        annotation (Placement(
        transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput y
    "Connector with a Real output signal" annotation (Placement(
        transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.BooleanInput trigger "Trigger input" annotation (Placement(
        transformation(
        origin={0,-118},
        extent={{-20,-20},{20,20}},
        rotation=90)));
equation
  when trigger then
    y = u;
  end when;
initial equation
  y = y_start;
  annotation (
    Icon(
      coordinateSystem(preserveAspectRatio=true,
        extent={{-100.0,-100.0},{100.0,100.0}}),
        graphics={
      Ellipse(lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid,
        extent={{25.0,-10.0},{45.0,10.0}}),
      Line(points={{-100.0,0.0},{-45.0,0.0}},
        color={0,0,127}),
      Line(points={{45.0,0.0},{100.0,0.0}},
        color={0,0,127}),
      Line(points={{0.0,-100.0},{0.0,-26.0}},
        color={255,0,255}),
      Line(points={{-35.0,0.0},{28.0,-48.0}},
        color={0,0,127}),
      Ellipse(lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid,
        extent={{-45.0,-10.0},{-25.0,10.0}})}),
    Documentation(info="<html>
<p>
Samples the continuous input signal whenever the trigger input
signal is rising (i.e., trigger changes from <strong>false</strong> to
<strong>true</strong>) and provides the sampled input signal as output.
Before the first sampling, the output signal is equal to
the initial value defined via parameter <strong>y0</strong>.
</p>
</html>"));
end TriggeredSampler;
