within Modelica.Electrical.Polyphase.Basic;
model PlugToPin_p "Connect one (positive) Pin"
  parameter Integer m(final min=1) = 3 "Number of phases" annotation(Evaluate=true);
  parameter Integer k(
    final min=1,
    final max=m,
    start=1) "Phase index" annotation(Evaluate=true);
  Interfaces.PositivePlug plug_p(final m=m) annotation (Placement(
        transformation(extent={{-30,-10},{-10,10}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin pin_p annotation (
      Placement(transformation(extent={{10,-10},{30,10}})));
equation
  pin_p.v = plug_p.pin[k].v;
  for j in 1:m loop
    plug_p.pin[j].i = if j == k then -pin_p.i else 0;
  end for;
  annotation (defaultComponentName="plugToPin", Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={
        Text(
          extent={{-150,-30},{150,-70}},
          textString="k = %k"),
        Line(points={{-20,20},{40,20},{40,-20},{-20,-20}}),
        Rectangle(
          extent={{-20,20},{40,-20}},
          pattern=LinePattern.None,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,255}),
        Ellipse(
          extent={{-40,20},{0,-20}},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Line(points={{-20,20},{40,20},{40,-20},{-20,-20}}),
        Text(
          extent={{-150,40},{150,80}},
          textString="%name",
          textColor={0,0,255})}),
      Documentation(info="<html>
<p>
Connects pin <em>k</em> of plug_p to pin_p, leaving the other pins of plug_p unconnected.
</p>
</html>"));
end PlugToPin_p;
