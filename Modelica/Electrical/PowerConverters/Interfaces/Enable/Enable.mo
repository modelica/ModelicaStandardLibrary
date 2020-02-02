within Modelica.Electrical.PowerConverters.Interfaces.Enable;
partial model Enable
  "Partial model providing enable parameter and optional enable input"
  parameter Boolean useConstantEnable=true
    "Disable boolean input and use constantEnable, if true"
    annotation (Dialog(tab="Enable"));
  parameter Boolean constantEnable=true
    "Constant enabling of firing signals"
    annotation (Dialog(tab="Enable", enable=useConstantEnable));
  parameter Integer m(final min=1) = 3 "Number of phases" annotation(Evaluate=true);
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
  connect(enableLogic.enable, enable) annotation (Line(
      points={{100,-92},{100,-120}}, color={255,0,255}));
  annotation (Documentation(info="<html>
<p>
This partial model provides parameters and the conditional input signal for the enabling models:</p>
<ul>
<li><a href=\"modelica://Modelica.Electrical.PowerConverters.Interfaces.Enable.Enable1\">Enable1</a></li>
<li><a href=\"modelica://Modelica.Electrical.PowerConverters.Interfaces.Enable.Enable2\">Enable2</a></li>
<li><a href=\"modelica://Modelica.Electrical.PowerConverters.Interfaces.Enable.Enable1m\">Enable1m</a></li>
<li><a href=\"modelica://Modelica.Electrical.PowerConverters.Interfaces.Enable.Enable2m\">Enable2m</a></li>
</ul>
</html>"));
end Enable;
