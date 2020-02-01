within Modelica.Thermal.HeatTransfer.Interfaces;
partial model PartialConditionalHeatPort
  "Partial model to include a conditional HeatPort in order to dissipate losses, used for graphical modeling, i.e., for building models by drag-and-drop"
  parameter Boolean useHeatPort = false "= true, if HeatPort is enabled"
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter SI.Temperature T=293.15
    "Fixed device temperature if useHeatPort = false"
    annotation(Dialog(enable=not useHeatPort));
  HeatTransfer.Interfaces.HeatPort_a heatPort if useHeatPort
    "Optional port to which dissipated losses are transported in form of heat"
    annotation (Placement(transformation(extent={{-110,-110},{-90,-90}}),
        iconTransformation(extent={{-110,-110},{-90,-90}})));
  HeatTransfer.Sources.FixedTemperature fixedTemperature(final T=T) if not
    useHeatPort
    annotation (Placement(transformation(extent={{-60,-90},{-80,-70}})));
protected
  HeatPort_a internalHeatPort
    annotation (Placement(transformation(extent={{-104,-84},{-96,-76}})));
equation
  connect(heatPort, internalHeatPort) annotation (Line(
      points={{-100,-100},{-100,-80}}, color={191,0,0}));
  connect(fixedTemperature.port, internalHeatPort) annotation (Line(
      points={{-80,-80},{-100,-80}}, color={191,0,0}));
  annotation (Documentation(info="<html>
<p>
This partial model provides a conditional heat port for dissipating losses.
</p>
<ul>
<li>If <strong>useHeatPort</strong> is set to <strong>false</strong> (default), no heat port is available, and the thermal loss power is dissipated internally.
In this case, the parameter <strong>T</strong> specifies the fixed device temperature (the default for T = 20&deg;C)</li>
<li>If <strong>useHeatPort</strong> is set to <strong>true</strong>, the heat port is available.</li>
</ul>
<p>
If this model is used, the <strong>internalHeatPort</strong> has to be connected in the model which inherits from PartialElementaryConditionalHeatPort model.
The device temperature <strong>internalHeatPort.T</strong> can be used to describe the influence of the device temperature on the model behaviour.
</p>
</html>"));
end PartialConditionalHeatPort;
