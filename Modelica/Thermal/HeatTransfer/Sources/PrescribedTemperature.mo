within Modelica.Thermal.HeatTransfer.Sources;
model PrescribedTemperature
  "Variable temperature boundary condition in Kelvin"

  Interfaces.HeatPort_b port annotation (Placement(transformation(extent={{90,
            -10},{110,10}})));
  Modelica.Blocks.Interfaces.RealInput T(unit="K") annotation (Placement(transformation(
          extent={{-140,-20},{-100,20}})));
equation
  port.T = T;
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          pattern=LinePattern.None,
          fillColor={159,159,223},
          fillPattern=FillPattern.Backward),
        Line(
          points={{-102,0},{64,0}},
          color={191,0,0},
          thickness=0.5),
        Text(
          extent={{0,0},{-100,-100}},
          textString="K"),
        Text(
          extent={{-150,150},{150,110}},
          textString="%name",
          textColor={0,0,255}),
        Polygon(
          points={{50,-20},{50,20},{90,0},{50,-20}},
          lineColor={191,0,0},
          fillColor={191,0,0},
          fillPattern=FillPattern.Solid)}),
    Documentation(info="<html>
<p>
This model represents a variable temperature boundary condition.
The temperature in [K] is given as input signal <strong>T</strong>
to the model. The effect is that an instance of this model acts as
an infinite reservoir able to absorb or generate as much energy
as required to keep the temperature at the specified value.
</p>
</html>"));
end PrescribedTemperature;
