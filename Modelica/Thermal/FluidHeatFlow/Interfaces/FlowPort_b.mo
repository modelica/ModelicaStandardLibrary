within Modelica.Thermal.FluidHeatFlow.Interfaces;
connector FlowPort_b "Hollow flow port (used downstream)"

  extends FluidHeatFlow.Interfaces.FlowPort;
annotation (Documentation(info="<html>
Same as FlowPort, but icon allows to differentiate direction of flow.
</html>"),
  Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={255,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Ellipse(extent={{-98,98},{98,-98}},
            lineColor={0,0,255})}), Diagram(coordinateSystem(
          preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
        graphics={
        Rectangle(
          extent={{-50,50},{50,-50}},
          lineColor={255,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(extent={{-48,48},{48,-48}}, lineColor={0,0,255}),
        Text(
          extent={{-100,110},{100,50}},
          textColor={0,0,255},
          textString="%name")}));
end FlowPort_b;
