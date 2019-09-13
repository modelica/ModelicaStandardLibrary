within Modelica.Electrical.PowerConverters.Interfaces.Enable;
partial model Enable2
  "Partial model providing enable parameter and optional enable input for two firing signals"
  extends PowerConverters.Interfaces.Enable.Enable1;
  Modelica.Blocks.Logical.And andCondition_n
    "And condition for negative firing signal" annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={60,-80})));
  Modelica.Blocks.Interfaces.BooleanInput fire_n
    "Firing signal of negative potential transistor" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={60,-120})));
equation
  connect(fire_n, andCondition_n.u1) annotation (Line(
      points={{60,-120},{60,-92}}, color={255,0,255}));
  connect(enableLogic.internalEnable[1], andCondition_n.u2) annotation (
      Line(
      points={{79,-80},{76,-80},{76,-96},{52,-96},{52,-92}}, color={255,0,255}));
  annotation (Documentation(info="<html>
<p>This partial model provides the enabling logic for two firing signal.</p>
</html>"));
end Enable2;
