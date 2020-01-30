within Modelica.Thermal.HeatTransfer.Interfaces;
partial model PartialElementaryConditionalHeatPort
  "Partial model to include a conditional HeatPort in order to dissipate losses, used for textual modeling, i.e., for elementary models"
  parameter Boolean useHeatPort = false "= true, if heatPort is enabled"
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter SI.Temperature T=293.15
    "Fixed device temperature if useHeatPort = false"
    annotation(Dialog(enable=not useHeatPort));
  HeatTransfer.Interfaces.HeatPort_a heatPort(final T=TheatPort, final Q_flow=-
        lossPower) if useHeatPort
    "Optional port to which dissipated losses are transported in form of heat"
    annotation (Placement(transformation(extent={{-110,-110},{-90,-90}}),
        iconTransformation(extent={{-110,-110},{-90,-90}})));
  SI.Power lossPower
    "Loss power leaving component via heatPort (> 0, if heat is flowing out of component)";
  SI.Temperature TheatPort "Temperature of heatPort";
equation
  if not useHeatPort then
     TheatPort = T;
  end if;
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
If this model is used, the loss power has to be provided by an equation in the model which inherits from PartialElementaryConditionalHeatPort model
(<strong>lossPower = ...</strong>). The device temperature <strong>TheatPort</strong> can be used to describe the influence of the device temperature on the model behaviour.
</p>
</html>"));
end PartialElementaryConditionalHeatPort;
