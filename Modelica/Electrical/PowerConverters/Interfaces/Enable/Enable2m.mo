within Modelica.Electrical.PowerConverters.Interfaces.Enable;
partial model Enable2m
  "Partial model providing enable parameter and optional enable input for 2*m firing signals"
  extends Interfaces.Enable.Enable1m;
  Modelica.Blocks.Logical.And andCondition_n[m]
    "And condition for m negative firing signals" annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={60,-80})));
  Modelica.Blocks.Interfaces.BooleanInput fire_n[m]
    "Firing signals of negative potential transistors" annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={60,-120})));
equation
  connect(fire_n, andCondition_n.u1) annotation (Line(
      points={{60,-120},{60,-92}}, color={255,0,255}));
  connect(enableLogic.internalEnable, andCondition_n.u2) annotation (Line(
      points={{79,-80},{76,-80},{76,-96},{52,-96},{52,-92}}, color={255,0,255}));
  annotation (Documentation(info="<html>
<p>This partial model provides the enabling logic for <code>2*m</code> firing signal.</p>
</html>"));
end Enable2m;
