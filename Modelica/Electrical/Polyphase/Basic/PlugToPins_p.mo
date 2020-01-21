within Modelica.Electrical.Polyphase.Basic;
model PlugToPins_p "Connect all (positive) Pins"
  parameter Integer m(final min=1) = 3 "Number of phases" annotation(Evaluate=true);
  Interfaces.PositivePlug plug_p(final m=m) annotation (Placement(
        transformation(extent={{-30,-10},{-10,10}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin pin_p[m] annotation (
      Placement(transformation(extent={{10,-10},{30,10}})));
equation
  pin_p.v = plug_p.pin.v;
  plug_p.pin.i = -pin_p.i;
  annotation (defaultComponentName="plugToPins", Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={
        Line(points={{-20,20},{40,20},{40,-20},{-20,-20}}),
        Rectangle(
          extent={{-20,20},{40,-20}},
          pattern=LinePattern.None,
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,255}),
        Ellipse(
          extent={{-40,20},{0,-20}},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-20,20},{40,20},{40,-20},{-20,-20}}),
        Text(
          extent={{-150,40},{150,80}},
          textString="%name",
          textColor={0,0,255})}),
      Documentation(info="<html>
<p>
Connects all pins of plug_p to the pin array pin_p.
</p>
</html>"));
end PlugToPins_p;
