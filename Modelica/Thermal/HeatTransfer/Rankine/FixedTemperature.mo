within Modelica.Thermal.HeatTransfer.Rankine;
model FixedTemperature "Fixed temperature boundary condition in degRankine"
  extends HeatTransfer.Icons.FixedTemperature;
  parameter Modelica.Units.NonSI.Temperature_degRk T
    "Fixed Temperature at the port";
  Interfaces.HeatPort_b port annotation (Placement(transformation(extent={{
            90,-10},{110,10}})));
equation
  port.T = Modelica.Units.Conversions.from_degRk(T);
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Text(
          extent={{-118,165},{122,105}},
          textString="%name",
          textColor={0,0,255}),
        Text(
          extent={{-150,-110},{150,-150}},
          textString="T=%T"),
        Text(
          extent={{-100,-40},{-40,-100}},
          textColor={64,64,64},
          textString="degRk")}),
    Documentation(info="<html>
<p>
This model defines a fixed temperature T at its port in degree Rankine,
[degRk], i.e., it defines a fixed temperature as a boundary condition.
</p>
</html>"));
end FixedTemperature;
