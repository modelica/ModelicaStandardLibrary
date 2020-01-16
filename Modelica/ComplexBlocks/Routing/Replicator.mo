within Modelica.ComplexBlocks.Routing;
block Replicator "Signal replicator"
  extends Modelica.ComplexBlocks.Interfaces.ComplexSIMO;
equation
  y = fill(u, nout);
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}}), graphics={
        Line(points={{-100,0},{-6,0}}, color={85,170,255}),
        Line(points={{100,0},{10,0}}, color={85,170,255}),
        Line(points={{0,0},{100,10}}, color={85,170,255}),
        Line(points={{0,0},{100,-10}}, color={85,170,255}),
        Ellipse(
          extent={{-14,16},{16,-14}},
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid)}),
    Documentation(info="<html>
<p>
This block replicates the input signal to an array of <code>nout</code> identical output signals.
</p>
</html>"));
end Replicator;
