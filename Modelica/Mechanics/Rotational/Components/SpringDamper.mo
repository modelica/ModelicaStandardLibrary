within Modelica.Mechanics.Rotational.Components;
model SpringDamper "Linear 1D rotational spring and damper in parallel"
  parameter SI.RotationalSpringConstant c(final min=0, start=1.0e5)
    "Spring constant";
  parameter SI.RotationalDampingConstant d(final min=0, start=0)
    "Damping constant";
  parameter SI.Angle phi_rel0=0 "Unstretched spring angle";
  extends
    Modelica.Mechanics.Rotational.Interfaces.PartialCompliantWithRelativeStates;
  extends
    Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPortWithoutT;
protected
  SI.Torque tau_c "Spring torque";
  SI.Torque tau_d "Damping torque";
equation
  tau_c = c*(phi_rel - phi_rel0);
  tau_d = d*w_rel;
  tau = tau_c + tau_d;
  lossPower = tau_d*w_rel;
  annotation (
    Documentation(info="<html>
<p>
A <strong>spring</strong> and <strong>damper</strong> element <strong>connected in parallel</strong>.
The component can be
connected either between two inertias/gears to describe the shaft elasticity
and damping, or between an inertia/gear and the housing (component Fixed),
to describe a coupling of the element with the housing via a spring/damper.
</p>

<p>
See also the discussion
<a href=\"modelica://Modelica.Mechanics.Rotational.UsersGuide.StateSelection\">State Selection</a>
in the User's Guide of the Rotational library.
</p>
</html>"),
    Icon(
      coordinateSystem(preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}),
        graphics={
    Line(points={{-80,40},{-60,40},{-45,10},{-15,70},{15,10},{45,70},{60,40},{80,40}}),
    Line(points={{-80,40},{-80,-40}}),
    Line(points={{-80,-40},{-50,-40}}),
    Rectangle(extent={{-50,-10},{40,-70}},
      fillColor={192,192,192},
      fillPattern=FillPattern.Solid),
    Line(points={{-50,-10},{70,-10}}),
    Line(points={{-50,-70},{70,-70}}),
    Line(points={{40,-40},{80,-40}}),
    Line(points={{80,40},{80,-40}}),
    Line(points={{-90,0},{-80,0}}),
    Line(points={{80,0},{90,0}}),
    Text(origin={0,-9},
      extent={{-150,-144},{150,-104}},
      textString="d=%d"),
    Text(extent={{-190,110},{190,70}},
      textColor={0,0,255},
      textString="%name"),
    Text(
      origin={0,-7},
      extent={{-150,-108},{150,-68}},
      textString="c=%c"),
    Line(visible=useHeatPort,
      points={{-100,-100},{-100,-55},{-5,-55}},
      color={191,0,0},
      pattern=LinePattern.Dot)}));
end SpringDamper;
