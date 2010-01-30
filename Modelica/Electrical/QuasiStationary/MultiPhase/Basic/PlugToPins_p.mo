within Modelica.Electrical.QuasiStationary.MultiPhase.Basic;
model PlugToPins_p "Connect all (positive) pins"
  parameter Integer m(final min=1) = 3 "number of phases";
  Interfaces.PositivePlug plug_p(final m=m) 
    annotation (Placement(transformation(extent={{-30,-10},{-10,10}}, rotation=
            0)));
  SinglePhase.Interfaces.PositivePin pin_p[m] 
    annotation (Placement(transformation(extent={{10,-10},{30,10}}, rotation=0)));
equation
  for j in 1:m loop
    Connections.branch(plug_p.reference, pin_p[j].reference);
    plug_p.reference.gamma = pin_p[j].reference.gamma;
    plug_p.pin[j].v = pin_p[j].v;
    plug_p.pin[j].i.re = -pin_p[j].i.re;
    plug_p.pin[j].i.im = -pin_p[j].i.im;
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
Connects all <i>m</i> single phase (positive) pins of the multi phase (positive) plug to an array of <i>m</i> single phase (positive) pins. 
</p>
<h4>See also</h4>
<p>
<a href=Modelica://Modelica_QuasiStationary.MultiPhase.Basic.PlugToPin_p>PlugToPin_p</a>,
<a href=Modelica://Modelica_QuasiStationary.MultiPhase.Basic.PlugToPin_n>PlugToPin_n</a>,
<a href=Modelica://Modelica_QuasiStationary.MultiPhase.Basic.PlugToPins_n>PlugToPins_n</a>
</p> 
</html>"));
end PlugToPins_p;
