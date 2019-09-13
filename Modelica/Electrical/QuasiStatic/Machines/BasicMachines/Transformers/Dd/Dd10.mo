within Modelica.Electrical.QuasiStatic.Machines.BasicMachines.Transformers.Dd;
model Dd10 "Transformer Dd10"

  extends QuasiStatic.Machines.Interfaces.PartialBasicTransformer(final
      VectorGroup="Dd10");
  QuasiStatic.Polyphase.Basic.Delta Delta1(final m=m)
    annotation (Placement(transformation(extent={{-50,-30},{-30,-10}})));
  QuasiStatic.Polyphase.Basic.Delta Delta2(final m=m)
    annotation (Placement(transformation(extent={{30,-30},{50,-10}})));
equation
  connect(r1.plug_p, Delta1.plug_p) annotation (Line(points={{-90,0},{-90,
          -20},{-50,-20}}, color={85,170,255}));
  connect(Delta2.plug_n, r2.plug_n) annotation (Line(points={{50,-20},{
          90,-20},{90,0}}, color={85,170,255}));
  connect(l1sigma.plug_n, core.plug_p1) annotation (Line(points={{-50,0},
          {-50,20},{-10,20},{-10,5}}, color={85,170,255}));
  connect(Delta1.plug_n, core.plug_n1) annotation (Line(points={{-30,-20},
          {-10,-20},{-10,-5}}, color={85,170,255}));
  connect(core.plug_n2, core.plug_p3)
    annotation (Line(points={{10,4},{10,-4}}, color={85,170,255}));
  connect(core.plug_p2, l2sigma.plug_p) annotation (Line(points={{10,10},
          {10,20},{50,20},{50,0}}, color={85,170,255}));
  connect(core.plug_n3, Delta2.plug_p) annotation (Line(points={{10,-10},
          {10,-20},{30,-20}}, color={85,170,255}));
  annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Dd10
<br>Typical parameters see:
<a href=\"modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer\">PartialBasicTransformer</a>
</html>"));
end Dd10;
