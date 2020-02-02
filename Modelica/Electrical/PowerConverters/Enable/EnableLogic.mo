within Modelica.Electrical.PowerConverters.Enable;
model EnableLogic
  "Partial model providing enable parameter and optional enable input"
  parameter Boolean useConstantEnable=true
    "Disable boolean input and use constantEnable, if true";
  parameter Boolean constantEnable=true
    "Constant enabling of firing signals"
    annotation (Dialog(enable=useConstantEnable));
  parameter Integer m(final min=1) = 3 "Number of phases" annotation(Evaluate=true);
  Modelica.Blocks.Sources.BooleanConstant enableConstantSource(final k=
        constantEnable) if useConstantEnable
    "Constant enable signal of fire and notFire" annotation (Placement(
        transformation(
        extent={{-10,10.5},{10,-10.5}},
        rotation=180,
        origin={69.5,0})));
  Modelica.Blocks.Interfaces.BooleanInput enable if not useConstantEnable
    "Enables fire and notFire" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={100,-120})));
  Modelica.Blocks.Routing.BooleanReplicator booleanReplicator(final nout=m)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput internalEnable[m]
    "m replicated enable signals" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-110,0})));
equation
  connect(internalEnable, booleanReplicator.y) annotation (Line(
      points={{-110,0},{-11,0}}, color={255,0,255}));
  connect(enable, booleanReplicator.u) annotation (Line(
      points={{100,-120},{100,-80},{40,-80},{40,-40},{40,0},{26,
          0},{12,0}}, color={255,0,255}));
  connect(enableConstantSource.y, booleanReplicator.u) annotation (Line(
      points={{58.5,0},{12,0}}, color={255,0,255}));
  annotation (defaultComponentName="enable",
    Documentation(info="<html>
<p>This model provides an internal enable signal derived either from a parameter or an optional signal input.
For <code>useConstantEnable = true</code> the internal signal <code>internalEnable</code> is equal to the parameter <code>constantEnable</code>.
For <code>useConstantEnable = false</code> the internal signal
<code>internalEnable</code> is equal to the external signal input <code>enable</code>.</p>
</html>"),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics={Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={255,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Text(
          extent={{-58,60},{58,-60}},
          textColor={255,0,255},
          textString="enable")}));
end EnableLogic;
