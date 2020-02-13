within Modelica.Electrical.Analog.Interfaces;
partial model ConditionalHeatPort
  "Partial model to include a conditional HeatPort in order to describe the power loss via a thermal network"

  parameter Boolean useHeatPort = false "= true, if heatPort is enabled"
  annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter SI.Temperature T=293.15
    "Fixed device temperature if useHeatPort = false" annotation(Dialog(enable=not useHeatPort));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort(final T=T_heatPort, final Q_flow=-LossPower) if useHeatPort
    "Conditional heat port"
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}}),
        iconTransformation(extent={{-10,-110},{10,-90}})));
  SI.Power LossPower "Loss power leaving component via heatPort";
  SI.Temperature T_heatPort "Temperature of heatPort";
equation
  if not useHeatPort then
     T_heatPort = T;
  end if;

  annotation (Documentation(revisions="<html>
<ul>
<li><em>February 17, 2009</em>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>",
        info="<html>
<p>
This partial model provides a conditional heating port for the connection to a thermal network.
</p>
<ul>
<li> If <strong>useHeatPort</strong> is set to <strong>false</strong> (default), no heat port is available, and the thermal
     loss power flows internally to the ground. In this case, the parameter <strong>T</strong> specifies
     the fixed device temperature (the default for T = 20<sup>o</sup>C).</li>
<li> If <strong>useHeatPort</strong> is set to <strong>true</strong>, a heat port is available.</li>
</ul>

<p>
If this model is used, the loss power has to be provided by an equation in the model which inherits from
ConditionalHeatingPort model (<strong>lossPower = ...</strong>). As device temperature
<strong>T_heatPort</strong> can be used to describe the influence of the device temperature
on the model behaviour.
</p>
</html>"));
end ConditionalHeatPort;
