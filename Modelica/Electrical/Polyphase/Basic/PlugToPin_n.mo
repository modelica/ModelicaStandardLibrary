within Modelica.Electrical.Polyphase.Basic;
model PlugToPin_n "Connect one (negative) Pin"
  parameter Integer m(final min=1) = 3 "Number of phases" annotation(Evaluate=true);
  parameter Integer k(
    final min=1,
    final max=m,
    start=1) "Phase index" annotation(Evaluate=true);
  Interfaces.NegativePlug plug_n(final m=m) annotation (Placement(
        transformation(extent={{-30,-10},{-10,10}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin pin_n annotation (
      Placement(transformation(extent={{10,-10},{30,10}})));
equation
  pin_n.v = plug_n.pin[k].v;
  for j in 1:m loop
    plug_n.pin[j].i = if j == k then -pin_n.i else 0;
  end for;
  annotation (defaultComponentName="plugToPin", Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={
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
          textColor={0,0,255}),
        Text(
          extent={{-150,-30},{150,-70}},
          textString="k = %k")}),
      Documentation(info="<html>
<p>
Connects pin <em>k</em> of plug_n to pin_n, leaving the other pins of plug_n unconnected.
</p>
</html>"));
end PlugToPin_n;
