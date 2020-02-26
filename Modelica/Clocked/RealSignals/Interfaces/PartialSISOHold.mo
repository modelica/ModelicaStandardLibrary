within Modelica.Clocked.RealSignals.Interfaces;
partial block PartialSISOHold
  "Basic block used for zero order hold of Real signals"

  parameter Real y_start = 0.0
    "Value of output y before the first tick of the clock associated to input u";

  Modelica.Blocks.Interfaces.RealInput u(final start=y_start)
    "Connector of clocked, Real input signal"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput y
    "Connector of continuous-time, Real output signal"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));

  annotation (
    defaultComponentName="hold1",
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        initialScale=0.06),
                     graphics={Line(points={{-60,-40},{-20,-40},{-20,20},{20,20},
              {20,60},{60,60},{60,0},{100,0},{100,0},{100,0},{100,0},{120,0}},
                                 color={0,0,127}), Line(
          points={{-60,-40},{-60,0},{-100,0}},
          color={0,0,127}),
        Text(
          extent={{-150,130},{150,90}},
          textString="%name",
          textColor={0,0,255}),
        Text(
          extent={{-150,-100},{150,-140}},
          textString="%y_start",
          textColor={0,0,0})}),
    Documentation(info="<html>

</html>"));
end PartialSISOHold;
