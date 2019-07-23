within Modelica.Thermal.HeatTransfer.Celsius;
model FixedTemperature
  "Fixed temperature boundary condition in degree Celsius"
  extends HeatTransfer.Icons.FixedTemperature;
  parameter Modelica.SIunits.Conversions.NonSIunits.Temperature_degC T
    "Fixed Temperature at the port";
  Interfaces.HeatPort_b port annotation (Placement(transformation(extent={{
            90,-10},{110,10}})));
equation
  port.T = Modelica.SIunits.Conversions.from_degC(T);
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Text(
          extent={{-150,150},{150,110}},
          textString="%name",
          textColor={0,0,255}),
        Text(
          extent={{-100,-40},{-40,-100}},
          textColor={64,64,64},
          textString="degC")}),
    Documentation(info="<html>
<p>
This model defines a fixed temperature T at its port in [degC],
i.e., it defines a fixed temperature as a boundary condition.
</p>
</html>"),
       Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {100,100}}), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          pattern=LinePattern.None,
          fillColor={159,159,223},
          fillPattern=FillPattern.Backward),
        Line(
          points={{-42,0},{66,0}},
          color={191,0,0},
          thickness=0.5),
        Polygon(
          points={{52,-20},{52,20},{90,0},{52,-20}},
          lineColor={191,0,0},
          fillColor={191,0,0},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-100,0},{-40,-60}},
          textColor={64,64,64},
          textString="degC")}));
end FixedTemperature;
