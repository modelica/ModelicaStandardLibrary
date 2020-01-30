within Modelica.Electrical.Polyphase.Interfaces;
partial model ConditionalHeatPort
  "Partial model to include conditional HeatPorts in order to describe the power loss via a thermal network"
  parameter Integer mh(min=1) = 3 "Number of heatPorts=number of phases";
  parameter Boolean useHeatPort=false
    "= true, if all heat ports are enabled" annotation (
    Evaluate=true,
    HideResult=true,
    choices(checkBox=true));
  parameter SI.Temperature T[mh]=fill(293.15, mh)
    "Fixed device temperatures if useHeatPort = false"
    annotation (Dialog(enable=not useHeatPort));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort[mh] if
    useHeatPort "Conditional heat ports" annotation (Placement(
        transformation(extent={{-10,-110},{10,-90}}), iconTransformation(
          extent={{-10,-110},{10,-90}})));
  annotation (Documentation(revisions="<html>
<ul>
<li><em>August 26, 2009 </em>by Anton Haumer initially implemented</li>
</ul>
</html>",
      info="<html>
<p>
This partial model provides conditional heat ports for the connection to a thermal network.
</p>
<ul>
<li> If <strong>useHeatPort</strong> is set to <strong>false</strong> (default), no heat port is available, and the thermal
     loss power flows internally to the ground. In this case, the parameter <strong>T</strong> specifies
     the fixed device temperatures.</li>
<li> If <strong>useHeatPort</strong> is set to <strong>true</strong>, all heat ports are available.</li>
</ul>
</html>"));
end ConditionalHeatPort;
