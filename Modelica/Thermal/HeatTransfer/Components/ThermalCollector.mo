within Modelica.Thermal.HeatTransfer.Components;
model ThermalCollector "Collects m heat flows"
  parameter Integer m(min=1)=3 "Number of collected heat flows";
  Interfaces.HeatPort_a port_a[m]
    annotation (Placement(transformation(extent={{-10,110},{10,90}})));
  Interfaces.HeatPort_b port_b
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));

equation
  port_b.Q_flow + sum(port_a.Q_flow) = 0;
  port_a.T = fill(port_b.T, m);
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Text(
          extent={{-150,-30},{150,-70}},
          textString="%name",
          textColor={0,0,255}),
        Text(
          extent={{-150,80},{150,50}},
          textString="m=%m"),
        Line(
          points={{0,90},{0,40}},
          color={181,0,0}),
        Rectangle(
          extent={{-60,40},{60,30}},
          lineColor={181,0,0},
          fillColor={181,0,0},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-60,30},{0,-30},{0,-90}},
          color={181,0,0}),
        Line(
          points={{0,-30},{-20,30}},
          color={181,0,0}),
        Line(
          points={{0,-30},{20,30}},
          color={181,0,0}),
        Line(
          points={{0,-30},{60,30}},
          color={181,0,0})}),
    Documentation(info="<html>
<p>
This is a model to collect the heat flows from <em>m</em> heatports to one single heatport.
</p>
</html>"));
end ThermalCollector;
