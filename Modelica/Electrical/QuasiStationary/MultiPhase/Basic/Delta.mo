within Modelica.Electrical.QuasiStationary.MultiPhase.Basic;
model Delta "Delta (polygon) connection"
  parameter Integer m(final min=2) = 3 "number of phases";
  Interfaces.PositivePlug plug_p(final m=m) 
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}}, rotation=
           0)));
  Interfaces.NegativePlug plug_n(final m=m) 
    annotation (Placement(transformation(extent={{90,-10},{110,10}}, rotation=0)));

  PlugToPins_p plugToPins_p annotation (Placement(transformation(extent={{-80,
            -10},{-60,10}}, rotation=0)));
  PlugToPins_n plugToPins_n annotation (Placement(transformation(extent={{80,
            -10},{60,10}}, rotation=0)));
equation
  for j in 1:m loop
    if j<m then
      connect(plugToPins_p.pin_p[j], plugToPins_n.pin_n[j+1]);
    else
      connect(plugToPins_p.pin_p[j], plugToPins_n.pin_n[1]);
    end if;
  end for;
  connect(plug_p, plugToPins_p.plug_p) 
    annotation (Line(points={{-100,5.55112e-016},{-93,5.55112e-016},{-93,
          1.16573e-015},{-86,1.16573e-015},{-86,6.10623e-016},{-72,6.10623e-016}},
        color={85,170,255}));
  connect(plugToPins_n.plug_n, plug_n) 
    annotation (Line(points={{72,6.10623e-016},{79,6.10623e-016},{79,
          1.16573e-015},{86,1.16573e-015},{86,5.55112e-016},{100,5.55112e-016}},
        color={85,170,255}));
  annotation (Icon(graphics={
        Text(
          extent={{-150,60},{150,120}},
          lineColor={0,0,255},
          textString=                         "%name"),
        Line(
          points={{-40,68},{-40,-70},{79,0},{-40,68},{-40,67}},
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
Delta (polygon) connection of a multi phase circuit. 
</p>
<h4>See also</h4>
<p>
<a href=Modelica://Modelica_QuasiStationary.MultiPhase.Basic.Star>Star</a>
</p> 
</html>"));
end Delta;
