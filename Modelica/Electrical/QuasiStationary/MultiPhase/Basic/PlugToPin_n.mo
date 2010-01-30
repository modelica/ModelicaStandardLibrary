within Modelica.Electrical.QuasiStationary.MultiPhase.Basic;
model PlugToPin_n "Connect one (negative) pin"
  parameter Integer m(final min=1) = 3 "number of phases";
  parameter Integer k(
    final min=1,
    final max=m) = 1 "phase index";
  Interfaces.NegativePlug plug_n(final m=m) 
    annotation (Placement(transformation(extent={{-30,-10},{-10,10}}, rotation=
            0)));
  SinglePhase.Interfaces.NegativePin pin_n 
    annotation (Placement(transformation(extent={{10,-10},{30,10}}, rotation=0)));
equation
  Connections.branch(plug_n.reference, pin_n.reference);
  plug_n.reference.gamma = pin_n.reference.gamma;
  pin_n.v = plug_n.pin[k].v;
  for j in 1:m loop
    plug_n.pin[j].i.re = if j == k then -pin_n.i.re else 0;
    plug_n.pin[j].i.im = if j == k then -pin_n.i.im else 0;
  end for;
  annotation (Icon(graphics={
        Rectangle(
          extent={{-20,20},{40,-20}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-40,20},{0,-20}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Text(extent={{-100,100},{100,40}}, textString=
                                            "%name"),
        Text(
          extent={{-100,-60},{100,-100}},
          lineColor={0,0,0},
          textString=                         "k = %k")}),
                                            Diagram(graphics),
  Documentation(info="<html>
<p>
Connects the single phase (negative) pin <i>k</i> of the multi phase (negative) plug to a single phase (negative) pin. 
</p>
<h4>See also</h4>
<p>
<a href=Modelica://Modelica_QuasiStationary.MultiPhase.Basic.PlugToPin_p>PlugToPin_p</a>,
<a href=Modelica://Modelica_QuasiStationary.MultiPhase.Basic.PlugToPins_p>PlutToPins_p</a>,
<a href=Modelica://Modelica_QuasiStationary.MultiPhase.Basic.PlugToPins_n>PlugToPins_n</a>
</p> 
</html>"));
end PlugToPin_n;
