within Modelica.Electrical.Machines.BasicMachines.Transformers.Yd;
model Yd05 "Transformer Yd5"
  extends Machines.Interfaces.PartialBasicTransformer(final VectorGroup="Yd05");
  Modelica.Electrical.Polyphase.Basic.Star star1(final m=m)
    annotation (Placement(transformation(
        origin={-10,-80},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Interfaces.NegativePin starpoint1
    annotation (Placement(transformation(extent={{-60,-110},{-40,-90}})));
  Modelica.Electrical.Polyphase.Basic.Delta Delta2(final m=m)
    annotation (Placement(transformation(extent={{30,10},{50,30}})));
equation
  connect(star1.pin_n, starpoint1) annotation (Line(points={{-10,-90},{
          -10,-100},{-50,-100}}, color={0,0,255}));
  connect(Delta2.plug_n, r2.plug_p) annotation (Line(points={{50,20},{
          90,20},{90,0}}, color={0,0,255}));
  connect(l1sigma.plug_n, core.plug_p1) annotation (Line(points={{-50,0},
          {-50,20},{-10,20},{-10,5}}, color={0,0,255}));
  connect(core.plug_n1, star1.plug_p) annotation (Line(points={{-10,-5},
          {-10,-70},{-10,-70}}, color={0,0,255}));
  connect(core.plug_n2, core.plug_p3)
    annotation (Line(points={{10,4},{10,-4}}, color={0,0,255}));
  connect(core.plug_n3, l2sigma.plug_n) annotation (Line(points={{10,-10},
          {10,-20},{50,-20},{50,0}}, color={0,0,255}));
  connect(core.plug_p2, Delta2.plug_p) annotation (Line(points={{10,10},
          {10,20},{30,20}}, color={0,0,255}));
  annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Yd5
<br>Typical parameters see:
<a href=\"modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer\">PartialBasicTransformer</a>
</html>"));
end Yd05;
