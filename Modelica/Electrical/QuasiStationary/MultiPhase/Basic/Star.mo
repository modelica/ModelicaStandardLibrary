within Modelica.Electrical.QuasiStationary.MultiPhase.Basic;
model Star "Star connection"
  parameter Integer m(final min=1) = 3 "number of phases";
  Interfaces.PositivePlug plug_p(final m=m) 
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}}, rotation=
           0)));
  SinglePhase.Interfaces.NegativePin pin_n 
    annotation (Placement(transformation(extent={{90,-10},{110,10}}, rotation=0)));
  PlugToPins_p plugToPins_p annotation (Placement(transformation(extent={{-80,
            -10},{-60,10}}, rotation=0)));
equation
  for j in 1:m loop
    connect(plugToPins_p.pin_p[j], pin_n);
  end for;
  connect(plug_p, plugToPins_p.plug_p) 
    annotation (Line(points={{-100,0},{-93,0},{-93,1.16573e-015},{-86,1.16573e-015},
          {-86,0},{-72,0}},                                  color={85,170,255}));
  annotation (Icon(graphics={
        Text(extent={{-150,60},{150,120}}, textString=
                                              "%name"),
        Line(
          points={{80,0},{0,0}},
          color={0,0,255},
          thickness=0.5),
        Line(
          points={{0,0},{-39,68}},
          color={0,0,255},
          thickness=0.5),
        Line(
          points={{0,0},{-38,-69}},
          color={0,0,255},
          thickness=0.5),
        Text(
          extent={{-100,-110},{100,-70}},
          lineColor={0,0,0},
          textString=                            "m=%m"),
        Line(points={{-90,0},{-40,0}}, color={0,0,255}),
        Line(points={{80,0},{90,0}}, color={0,0,255})}),              Diagram(graphics),
  Documentation(info="<html>
<p>
Star (wye) connection of a multi phase circuit. The potentials at the star points are the same. 
</p>
<h4>See also</h4>
<p>
<a href=Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Delta>Delta</a>
</p> 
</html>"));
end Star;
