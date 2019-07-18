within Modelica.Electrical.QuasiStatic.SinglePhase.Basic;
model Ground "Electrical ground"

  Interfaces.PositivePin pin annotation (Placement(transformation(extent={{
            -10,90},{10,110}})));
equation
  Connections.potentialRoot(pin.reference, 256);
  if Connections.isRoot(pin.reference) then
    pin.reference.gamma = 0;
  end if;
  pin.v = Complex(0);
  annotation (Icon(graphics={
        Line(points={{-60,50},{60,50}}, color={85,170,255}),
        Line(points={{-40,30},{40,30}}, color={85,170,255}),
        Line(points={{-20,10},{20,10}}, color={85,170,255}),
        Line(points={{0,90},{0,50}}, color={85,170,255}),
        Text(
          extent={{150,-50},{-150,-10}},
          textString="%name",
          textColor={0,0,255})}), Documentation(info="<html>
<p>
Ground of a single-phase circuit. The potential at the ground node is zero.
Every electrical circuit, e.g., a series resonance
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Examples.SeriesResonance\">
          example</a>, has to contain at least one ground object.
</p>

</html>"));
end Ground;
