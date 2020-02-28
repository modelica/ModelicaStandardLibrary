within Modelica.Thermal.HeatTransfer.Sensors;
model TemperatureSensor "Absolute temperature sensor in Kelvin"

  Modelica.Blocks.Interfaces.RealOutput T(unit="K")
    "Absolute temperature as output signal"
    annotation (Placement(transformation(extent={{100,-10},{120,10}}), iconTransformation(extent={{100,-10},{120,10}})));
  Interfaces.HeatPort_a port annotation (Placement(transformation(extent={{
            -110,-10},{-90,10}})));
equation
  T = port.T;
  port.Q_flow = 0;
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Ellipse(
          extent={{-20,-98},{20,-60}},
          lineThickness=0.5,
          fillColor={191,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-12,40},{12,-68}},
          lineColor={191,0,0},
          fillColor={191,0,0},
          fillPattern=FillPattern.Solid),
        Line(points={{12,0},{100,0}},color={0,0,127}),
        Line(points={{-90,0},{-12,0}}, color={191,0,0}),
        Polygon(
          points={{-12,40},{-12,80},{-10,86},{-6,88},{0,90},{6,88},{10,86},
              {12,80},{12,40},{-12,40}},
          lineThickness=0.5),
        Line(
          points={{-12,40},{-12,-64}},
          thickness=0.5),
        Line(
          points={{12,40},{12,-64}},
          thickness=0.5),
        Line(points={{-40,-20},{-12,-20}}),
        Line(points={{-40,20},{-12,20}}),
        Line(points={{-40,60},{-12,60}}),
        Text(
          extent={{-150,140},{150,100}},
          textString="%name",
          textColor={0,0,255}),
        Text(
          extent={{20,60},{80,0}},
          textColor={64,64,64},
          textString="K")}),
    Documentation(info="<html>
<p>
This is an ideal absolute temperature sensor which returns
the temperature of the connected port in Kelvin as an output
signal.  The sensor itself has no thermal interaction with
whatever it is connected to.  Furthermore, no
thermocouple-like lags are associated with this
sensor model.
</p>
</html>"));
end TemperatureSensor;
