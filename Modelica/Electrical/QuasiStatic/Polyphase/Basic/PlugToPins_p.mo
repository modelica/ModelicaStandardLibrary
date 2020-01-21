within Modelica.Electrical.QuasiStatic.Polyphase.Basic;
model PlugToPins_p "Connect all (positive) pins"
  parameter Integer m(final min=1) = 3 "Number of phases" annotation(Evaluate=true);
  Interfaces.PositivePlug plug_p(final m=m) annotation (Placement(
        transformation(extent={{-30,-10},{-10,10}})));
  QuasiStatic.SinglePhase.Interfaces.PositivePin pin_p[m]
    annotation (Placement(transformation(extent={{10,-10},{30,10}})));
  PlugToPin_p plugToPin_p[m](each final m=m, final k={j for j in 1:m})
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  for j in 1:m loop
    /*
    Connections.branch(plug_p.reference, pin_p[j].reference);
    plug_p.reference.gamma = pin_p[j].reference.gamma;
    plug_p.pin[j].v = pin_p[j].v;
    plug_p.pin[j].i = -pin_p[j].i;
*/
    connect(plug_p, plugToPin_p[j].plug_p);
    connect(plugToPin_p[j].pin_p, pin_p[j]);
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
Connects all <code>m</code> single-phase (positive) pins of the polyphase (positive) plug to an array of <code>m</code> single-phase (positive) pins.
</p>
<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.PlugToPin_p\">PlugToPin_p</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.PlugToPin_n\">PlugToPin_n</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.PlugToPins_n\">PlugToPins_n</a>
</p>
</html>"));
end PlugToPins_p;
