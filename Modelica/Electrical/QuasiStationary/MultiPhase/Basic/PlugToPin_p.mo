within Modelica.Electrical.QuasiStationary.MultiPhase.Basic;
model PlugToPin_p "Connect one (positive) pin"
  parameter Integer m(final min=1) = 3 "number of phases";
  parameter Integer k(
    final min=1,
    final max=m) = 1 "phase index";
  Interfaces.PositivePlug plug_p(final m=m) 
    annotation (Placement(transformation(extent={{-30,-10},{-10,10}}, rotation=
            0)));
  SinglePhase.Interfaces.PositivePin pin_p 
    annotation (Placement(transformation(extent={{10,-10},{30,10}}, rotation=0)));
equation
  Connections.branch(plug_p.reference, pin_p.reference);
  plug_p.reference.gamma = pin_p.reference.gamma;
  pin_p.v = plug_p.pin[k].v;
  for j in 1:m loop
    plug_p.pin[j].i = if j == k then -pin_p.i else Complex(0);
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
          textString =                        "k = %k")}),
                                            Diagram(graphics),
  Documentation(info="<html>
<p>
Connects the single phase (positive) pin <i>k</i> of the multi phase (positive) plug to a single phase (positive) pin. 
</p>
<h4>See also</h4>
<p>
<a href=Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.PlugToPin_n>PlugToPin_n</a>,
<a href=Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.PlugToPins_p>PlutToPins_p</a>,
<a href=Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.PlugToPins_n>PlugToPins_n</a>
</p> 
</html>"));
end PlugToPin_p;
