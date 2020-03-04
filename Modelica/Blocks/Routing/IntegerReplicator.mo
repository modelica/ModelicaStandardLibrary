within Modelica.Blocks.Routing;
block IntegerReplicator "Integer signal replicator"
  extends Modelica.Blocks.Icons.IntegerBlock;
  parameter Integer nout=1 "Number of outputs";
  Modelica.Blocks.Interfaces.IntegerInput u
    "Connector of Integer input signal"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.IntegerOutput y[nout]
    "Connector of Integer output signals"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation

  y = fill(u, nout);
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}}), graphics={
        Line(points={{-100,0},{-6,0}}, color={255,127,0}),
        Line(points={{100,0},{10,0}}, color={255,127,0}),
        Line(points={{0,0},{100,10}}, color={255,127,0}),
        Line(points={{0,0},{100,-10}}, color={255,127,0}),
        Ellipse(
          extent={{-15,15},{15,-15}},
          fillColor={255,127,0},
          fillPattern=FillPattern.Solid)}),
    Documentation(info="<html>
<p>
This block replicates the Integer input signal to an array of <code>nout</code> identical Integer output signals.
</p>
</html>"));
end IntegerReplicator;
