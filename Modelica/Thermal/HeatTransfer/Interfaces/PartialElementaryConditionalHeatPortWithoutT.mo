within Modelica.Thermal.HeatTransfer.Interfaces;
partial model PartialElementaryConditionalHeatPortWithoutT
  "Partial model to include a conditional HeatPort in order to dissipate losses, used for textual modeling, i.e., for elementary models"
  parameter Boolean useHeatPort = false "= true, if heatPort is enabled"
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  HeatTransfer.Interfaces.HeatPort_a heatPort(final Q_flow=-lossPower) if
    useHeatPort
    "Optional port to which dissipated losses are transported in form of heat"
    annotation (Placement(transformation(extent={{-110,-110},{-90,-90}}),
        iconTransformation(extent={{-110,-110},{-90,-90}})));
  SI.Power lossPower
    "Loss power leaving component via heatPort (> 0, if heat is flowing out of component)";
  annotation (Documentation(info="<html>
<p>
This partial model provides a conditional heat port for dissipating losses.
</p>
<ul>
<li>If <strong>useHeatPort</strong> is set to <strong>false</strong> (default), no heat port is available, and the thermal loss power is dissipated internally.</li>
<li>If <strong>useHeatPort</strong> is set to <strong>true</strong>, the heat port is available and must be connected from the outside.</li>
</ul>
<p>
If this model is used, the loss power has to be provided by an equation in the model which inherits from the PartialElementaryConditionalHeatPortWithoutT model
(<strong>lossPower = ...</strong>).
</p>

<p>
Note, this partial model is used in cases, where heatPort.T (that is the device temperature) is not utilized in the model. If this is desired, inherit instead from partial model
<a href=\"modelica://Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPort\">PartialElementaryConditionalHeatPort</a>.
</p>
</html>"));
end PartialElementaryConditionalHeatPortWithoutT;
