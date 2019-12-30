within Modelica.Electrical.Machines.BasicMachines.Transformers.Dy;
model Dy09 "Transformer Dy9"
  extends Machines.Interfaces.PartialBasicTransformer(final VectorGroup="Dy09");
  Modelica.Electrical.Polyphase.Basic.Star star2(final m=m)
    annotation (Placement(transformation(
        origin={10,-80},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Interfaces.NegativePin starpoint2
    annotation (Placement(transformation(extent={{40,-110},{60,-90}})));
  Modelica.Electrical.Polyphase.Basic.Delta Delta1(final m=m)
    annotation (Placement(transformation(extent={{-50,-30},{-30,-10}})));
  Modelica.Electrical.Polyphase.Basic.Delta Rot2(final m=m)
    annotation (Placement(transformation(extent={{30,-30},{50,-10}})));
equation
  connect(star2.pin_n, starpoint2) annotation (Line(points={{10,-90},{
          10,-100},{50,-100}}, color={0,0,255}));
  connect(r1.plug_p, Delta1.plug_p) annotation (Line(points={{-90,0},{-90,
          -20},{-50,-20}}, color={0,0,255}));
  connect(l2sigma.plug_n, Rot2.plug_n)
    annotation (Line(points={{50,0},{50,-20}}, color={0,0,255}));
  connect(l1sigma.plug_n, core.plug_p1) annotation (Line(points={{-50,0},
          {-50,20},{-10,20},{-10,5},{-10,5}}, color={0,0,255}));
  connect(Delta1.plug_n, core.plug_n1) annotation (Line(points={{-30,-20},
          {-10,-20},{-10,-5}}, color={0,0,255}));
  connect(core.plug_n2, core.plug_p3)
    annotation (Line(points={{10,4},{10,-4}}, color={0,0,255}));
  connect(core.plug_n3, Rot2.plug_p) annotation (Line(points={{10,-10},
          {10,-20},{30,-20}}, color={0,0,255}));
  connect(core.plug_p2, star2.plug_p) annotation (Line(points={{10,10},
          {20,10},{20,-70},{10,-70}}, color={0,0,255}));
  annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Dy9
<br>Typical parameters see:
<a href=\"modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer\">PartialBasicTransformer</a>
</html>"));
end Dy09;
