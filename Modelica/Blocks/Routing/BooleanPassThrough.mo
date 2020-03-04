within Modelica.Blocks.Routing;
model BooleanPassThrough "Pass a Boolean signal through without modification"
  extends Modelica.Blocks.Interfaces.BooleanSISO;
equation
  y = u;
  annotation (Documentation(info="<html>
<p>Passes a Boolean signal through without modification.  Enables signals to be read out of one bus, have their name changed and be sent back to a bus.</p>
</html>"),
    Icon(
      coordinateSystem(preserveAspectRatio=true,
          extent={{-100.0,-100.0},{100.0,100.0}}),
          graphics={
      Line(
        points={{-100.0,0.0},{100.0,0.0}},
        color={255,0,255})}));
end BooleanPassThrough;
