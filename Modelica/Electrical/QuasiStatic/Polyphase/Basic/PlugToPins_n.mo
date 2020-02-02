within Modelica.Electrical.QuasiStatic.Polyphase.Basic;
model PlugToPins_n "Connect all (negative) pins"
  parameter Integer m(final min=1) = 3 "Number of phases" annotation(Evaluate=true);
  Interfaces.NegativePlug plug_n(final m=m) annotation (Placement(
        transformation(extent={{-30,-10},{-10,10}})));
  QuasiStatic.SinglePhase.Interfaces.NegativePin pin_n[m]
    annotation (Placement(transformation(extent={{10,-10},{30,10}})));
  PlugToPin_n plugToPin_n[m](each final m=m, final k={j for j in 1:m})
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  for j in 1:m loop
    /*
    Connections.branch(plug_n.reference, pin_n[j].reference);
    plug_n.reference.gamma = pin_n[j].reference.gamma;
    plug_n.pin[j].v = pin_n[j].v;
    plug_n.pin[j].i = -pin_n[j].i;
*/
    connect(plug_n, plugToPin_n[j].plug_n);
    connect(plugToPin_n[j].pin_n, pin_n[j]);
  end for;
  annotation (defaultComponentName="plugToPins", Icon(graphics={
        Rectangle(
          extent={{-20,20},{40,-20}},
          fillColor={170,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-40,20},{0,-20}},
          fillColor={170,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-150,50},{150,90}},
          textString="%name",
          textColor={0,0,255})}), Documentation(info="<html>
<p>
Connects all <code>m</code> single-phase (negative) pins of the polyphase (negative) plug to an array of <code>m</code> single-phase (negative) pins.
</p>
<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.PlugToPin_p\">PlugToPin_p</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.PlugToPin_n\">PlugToPin_n</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.PlugToPins_p\">PlugToPins_p</a>
</p>
</html>"));
end PlugToPins_n;
