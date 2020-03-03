within Modelica.Blocks.Routing;
model RealPassThrough "Pass a Real signal through without modification"
  extends Modelica.Blocks.Interfaces.SISO;
equation
  y = u;
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={Line(points={{-100,0},{100,0}},
            color={0,0,127})}),
                    Documentation(info="<html>
<p>
Passes a Real signal through without modification.  Enables signals to be read out of one bus, have their name changed and be sent back to a bus.
</p>
</html>"));
end RealPassThrough;
