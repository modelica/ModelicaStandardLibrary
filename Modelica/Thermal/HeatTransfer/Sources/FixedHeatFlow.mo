within Modelica.Thermal.HeatTransfer.Sources;
model FixedHeatFlow "Fixed heat flow boundary condition"
  parameter SI.HeatFlowRate Q_flow
    "Fixed heat flow rate at port";
  parameter SI.Temperature T_ref=293.15
    "Reference temperature";
  parameter SI.LinearTemperatureCoefficient alpha=0
    "Temperature coefficient of heat flow rate";
  Interfaces.HeatPort_b port annotation (Placement(transformation(extent={{90,
            -10},{110,10}})));
equation
  port.Q_flow = -Q_flow*(1 + alpha*(port.T - T_ref));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Text(
          extent={{-150,100},{150,60}},
          textString="%name",
          textColor={0,0,255}),
        Text(
          extent={{-150,-55},{150,-85}},
          textString="Q_flow=%Q_flow"),
        Line(
          points={{-100,-20},{48,-20}},
          color={191,0,0},
          thickness=0.5),
        Line(
          points={{-100,20},{46,20}},
          color={191,0,0},
          thickness=0.5),
        Polygon(
          points={{40,0},{40,40},{70,20},{40,0}},
          lineColor={191,0,0},
          fillColor={191,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{40,-40},{40,0},{70,-20},{40,-40}},
          lineColor={191,0,0},
          fillColor={191,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{70,40},{90,-40}},
          lineColor={191,0,0},
          fillColor={191,0,0},
          fillPattern=FillPattern.Solid)}),
    Documentation(info="<html>
<p>
This model allows a specified amount of heat flow rate to be \"injected\"
into a thermal system at a given port.  The constant amount of heat
flow rate Q_flow is given as a parameter. The heat flows into the
component to which the component FixedHeatFlow is connected,
if parameter Q_flow is positive.
</p>
<p>
If parameter alpha is &lt;&gt; 0, the heat flow is multiplied by (1 + alpha*(port.T - T_ref))
in order to simulate temperature dependent losses (which are given with respect to reference temperature T_ref).
</p>
</html>"));
end FixedHeatFlow;
