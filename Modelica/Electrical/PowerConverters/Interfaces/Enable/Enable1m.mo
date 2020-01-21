within Modelica.Electrical.PowerConverters.Interfaces.Enable;
partial model Enable1m
  "Partial model providing enable parameter and optional enable input for m firing signals"
  parameter Boolean useConstantEnable=true
    "Disable boolean input and use constantEnable, if true"
    annotation (Dialog(tab="Enable"));
  parameter Boolean constantEnable=true
    "Constant enabling of firing signals"
    annotation (Dialog(tab="Enable", enable=useConstantEnable));
  parameter Integer m(final min=3) = 3 "Number of phases" annotation(Evaluate=true);
  Modelica.Blocks.Logical.And andCondition_p[m]
    "And condition for m positive firing signals" annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=270,
        origin={-60,-80})));
  Modelica.Blocks.Interfaces.BooleanInput fire_p[m]
    "Firing signals of positive potential transistors" annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-60,-120})));
  PowerConverters.Enable.EnableLogic enableLogic(
    final useConstantEnable=useConstantEnable,
    final constantEnable=constantEnable,
    final m=m) "Enabling logic"
    annotation (Placement(transformation(extent={{80,-90},{100,-70}})));
  Modelica.Blocks.Interfaces.BooleanInput enable if not useConstantEnable
    "Enables fire and notFire" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={100,-120})));
equation
  connect(andCondition_p.u1, fire_p) annotation (Line(
      points={{-60,-92},{-60,-120}}, color={255,0,255}));
  connect(enableLogic.enable, enable) annotation (Line(
      points={{100,-92},{100,-120}}, color={255,0,255}));
  connect(enableLogic.internalEnable, andCondition_p.u2) annotation (Line(
      points={{79,-80},{76,-80},{76,-96},{40,-96},{40,-76},{-40,-76},{-40,-100},
          {-52,-100},{-52,-92}}, color={255,0,255}));
  annotation (Documentation(info="<html>
<p>This partial model provides the enabling logic for <code>m</code> firing signal.</p>
</html>"));
end Enable1m;
