within Modelica.Mechanics.Rotational.Components;
model Damper "Linear 1D rotational damper"
  extends
    Modelica.Mechanics.Rotational.Interfaces.PartialCompliantWithRelativeStates;
  parameter SI.RotationalDampingConstant d(final min=0, start=0)
    "Damping constant";
  extends
    Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPortWithoutT;
equation
  tau = d*w_rel;
  lossPower = tau*w_rel;
  annotation (
    Documentation(info="<html>
<p>
<strong>Linear, velocity dependent damper</strong> element. It can be either connected
between an inertia or gear and the housing (component Fixed), or
between two inertia/gear elements.
</p>

<p>
See also the discussion
<a href=\"modelica://Modelica.Mechanics.Rotational.UsersGuide.StateSelection\">State Selection</a>
in the User's Guide of the Rotational library.
</p>
</html>"),
    Icon(
    coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
    Line(points={{-90,0},{-60,0}}),
    Line(points={{-60,-30},{-60,30}}),
    Line(points={{-60,-30},{60,-30}}),
    Line(points={{-60,30},{60,30}}),
    Rectangle(extent={{-60,30},{30,-30}},
      fillColor={192,192,192},
      fillPattern=FillPattern.Solid),
    Line(points={{30,0},{90,0}}),
    Text(extent={{-150,80},{150,40}},
      textString="%name",
      textColor={0,0,255}),
    Text(extent={{-150,-50},{150,-90}},
      textString="d=%d"),
    Line(visible=useHeatPort,
      points={{-100,-100},{-100,-40},{-20,-40},{-20,0}},
      color={191,0,0},
      pattern=LinePattern.Dot)}));
end Damper;
