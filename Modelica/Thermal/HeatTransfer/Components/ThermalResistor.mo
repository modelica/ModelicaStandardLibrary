within Modelica.Thermal.HeatTransfer.Components;
model ThermalResistor
  "Lumped thermal element transporting heat without storing it"
  extends Interfaces.Element1D;
  parameter Modelica.SIunits.ThermalResistance R
    "Constant thermal resistance of material";

equation
  dT = R*Q_flow;
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Rectangle(
          extent={{-90,70},{90,-70}},
          pattern=LinePattern.None,
          fillColor={192,192,192},
          fillPattern=FillPattern.Forward),
        Line(
          points={{-90,70},{-90,-70}},
          thickness=0.5),
        Line(
          points={{90,70},{90,-70}},
          thickness=0.5),
        Text(
          extent={{-150,120},{150,78}},
          textString="%name",
          textColor={0,0,255}),
        Text(
          extent={{-150,-80},{150,-110}},
          textString="R=%R")}),
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {100,100}}), graphics={
        Line(
          points={{-80,0},{80,0}},
          color={255,0,0},
          thickness=0.5,
          arrow={Arrow.None,Arrow.Filled}),
        Text(
          extent={{-100,-20},{100,-40}},
          textColor={255,0,0},
          textString="Q_flow"),
        Text(
          extent={{-100,40},{100,20}},
          textString="dT = port_a.T - port_b.T")}),
    Documentation(info="<html>
<p>
This is a model for transport of heat without storing it, same as the
<a href=\"modelica://Modelica.Thermal.HeatTransfer.Components.ThermalConductor\">ThermalConductor</a>
but using the thermal resistance instead of the thermal conductance as a parameter.
This is advantageous for series connections of ThermalResistors,
especially if it shall be allowed that a ThermalResistance is defined to be zero (i.e. no temperature difference).
</p>
</html>"));
end ThermalResistor;
