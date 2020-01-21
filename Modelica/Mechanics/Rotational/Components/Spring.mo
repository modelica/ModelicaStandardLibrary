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
    Line(points={{-100,0},{-58,0},{-43,-30},{-13,30},{17,-30},{47,30},{62,0},{100,0}})}));
end Spring;
