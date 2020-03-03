within Modelica.Blocks.Routing;
block BooleanReplicator "Boolean signal replicator"
  extends Modelica.Blocks.Icons.BooleanBlock;
  parameter Integer nout=1 "Number of outputs";
  Modelica.Blocks.Interfaces.BooleanInput u
    "Connector of Boolean input signal"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.BooleanOutput y[nout]
    "Connector of Boolean output signals"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation

  y = fill(u, nout);
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}}), graphics={
        Line(points={{-100,0},{-6,0}}, color={255,0,255}),
        Line(points={{100,0},{10,0}}, color={255,0,255}),
        Line(points={{0,0},{100,10}}, color={255,0,255}),
        Line(points={{0,0},{100,-10}}, color={255,0,255}),
        Ellipse(
          extent={{-15,15},{15,-15}},
          fillColor={255,0,255},
          fillPattern=FillPattern.Solid)}),
    Documentation(info="<html>
<p>
This block replicates the Boolean input signal to an array of <code>nout</code> identical Boolean output signals.
</p>
</html>"));
end BooleanReplicator;
