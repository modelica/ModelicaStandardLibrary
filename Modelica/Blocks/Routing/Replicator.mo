within Modelica.Blocks.Routing;
block Replicator "Signal replicator"
  extends Modelica.Blocks.Interfaces.SIMO;
equation
  y = fill(u, nout);
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}}), graphics={
        Line(points={{-100,0},{-6,0}}, color={0,0,127}),
        Line(points={{100,0},{10,0}}, color={0,0,127}),
        Line(points={{0,0},{100,10}}, color={0,0,127}),
        Line(points={{0,0},{100,-10}}, color={0,0,127}),
        Ellipse(
          extent={{-15,15},{15,-15}},
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid)}),
    Documentation(info="<html>
<p>
This block replicates the input signal to an array of <code>nout</code> identical output signals.
</p>
</html>"));
end Replicator;
