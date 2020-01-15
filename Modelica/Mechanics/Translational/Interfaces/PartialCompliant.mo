within Modelica.Mechanics.Translational.Interfaces;
partial model PartialCompliant
  "Compliant connection of two translational 1D flanges"

  extends Translational.Interfaces.PartialTwoFlanges;
  SI.Position s_rel(start=0)
    "Relative distance (= flange_b.s - flange_a.s)";
  SI.Force f
    "Force between flanges (positive in direction of flange axis R)";

equation
  s_rel = flange_b.s - flange_a.s;
  flange_b.f = f;
  flange_a.f = -f;
  annotation (Documentation(info="<html>
<p>
This is a 1D translational component with a <em>compliant</em> connection of two
translational 1D flanges where inertial effects between the two
flanges are not included. The absolute value of the force at the left and the right
flange is the same. It is used to built up springs, dampers etc.
</p>

</html>"),
       Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {100,100}}), graphics={Polygon(
              points={{50,-90},{20,-80},{20,-100},{50,-90}},
              lineColor={128,128,128},
              fillColor={128,128,128},
              fillPattern=FillPattern.Solid),Line(points={{-60,-90},{20,-90}})}));
end PartialCompliant;
