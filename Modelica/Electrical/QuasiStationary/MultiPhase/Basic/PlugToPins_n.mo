within Modelica.Electrical.QuasiStationary.MultiPhase.Basic;
model PlugToPins_n "Connect all (negative) pins"
  parameter Integer m(final min=1) = 3 "number of phases";
  Interfaces.NegativePlug plug_n(final m=m) 
    annotation (Placement(transformation(extent={{-30,-10},{-10,10}}, rotation=
            0)));
  SinglePhase.Interfaces.NegativePin pin_n[m] 
    annotation (Placement(transformation(extent={{10,-10},{30,10}}, rotation=0)));
equation
  for j in 1:m loop
    Connections.branch(plug_n.reference, pin_n[j].reference);
    plug_n.reference.gamma = pin_n[j].reference.gamma;
    plug_n.pin[j].v = pin_n[j].v;
    plug_n.pin[j].i = -pin_n[j].i;
  end for;
  annotation (Icon(graphics={
        Rectangle(
          extent={{-20,20},{40,-20}},
          lineColor={0,0,0},
          fillColor={170,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-40,20},{0,-20}},
          lineColor={0,0,0},
          fillColor={170,255,255},
          fillPattern=FillPattern.Solid),
        Text(extent={{-100,100},{100,40}}, textString=
                                            "%name")}),Diagram(graphics),
  Documentation(info="<html>
<p>
Connects all <i>m</i> single phase (negative) pins of the multi phase (negative) plug to an array of <i>m</i> single phase (negative) pins. 
</p>
<h4>See also</h4>
<p>
<a href=Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.PlugToPin_p>PlugToPin_p</a>,
<a href=Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.PlugToPin_n>PlugToPin_n</a>,
<a href=Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.PlugToPins_p>PlugToPins_p</a>
</p> 
</html>"));
end PlugToPins_n;
