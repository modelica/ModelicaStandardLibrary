within Modelica.ComplexBlocks.Routing;
model ComplexPassThrough
  "Pass a Complex signal through without modification"
  extends Modelica.ComplexBlocks.Interfaces.ComplexSISO;
equation
  y = u;
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={Line(points={{-100,0},{100,0}},
            color={85,170,255})}),
                    Documentation(info="<html>
<p>
Passes a Complex signal through without modification. Enables signals to be read out of one bus, have their name changed and be sent back to a bus.
</p>
</html>"));
end ComplexPassThrough;
