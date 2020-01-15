within Modelica.Mechanics.Rotational.Components;
model Spring "Linear 1D rotational spring"
  extends Modelica.Mechanics.Rotational.Interfaces.PartialCompliant;
  parameter SI.RotationalSpringConstant c(final min=0, start=1.0e5)
    "Spring constant";
  parameter SI.Angle phi_rel0=0 "Unstretched spring angle";

equation
  tau = c*(phi_rel - phi_rel0);
  annotation (
    Documentation(info="<html>
<p>
A <strong>linear 1D rotational spring</strong>. The component can be connected either
between two inertias/gears to describe the shaft elasticity, or between
a inertia/gear and the housing (component Fixed), to describe
a coupling of the element with the housing via a spring.
</p>

</html>"),
    Icon(
    coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
      graphics={
    Text(extent={{-150,80},{150,40}},
      textString="%name",
      textColor={0,0,255}),
    Text(extent={{-150,-40},{150,-80}},
      textString="c=%c"),
    Line(points={{-100,0},{-58,0},{-43,-30},{-13,30},{17,-30},{47,30},{62,0},{100,0}})}),
    Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Line(points={{-68,0},{-68,65}}, color={128,128,128}),
        Line(points={{72,0},{72,65}}, color={128,128,128}),
        Line(points={{-68,60},{72,60}}, color={128,128,128}),
        Polygon(
          points={{62,63},{72,60},{62,57},{62,63}},
          lineColor={128,128,128},
          fillColor={128,128,128},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-22,62},{18,87}},
          textColor={0,0,255},
          textString="phi_rel"),
        Line(points={{-96,0},{-60,0},{-42,-32},{-12,30},{18,-30},{48,28},{
              62,0},{96,0}}, color={0,0,255})}));
end Spring;
