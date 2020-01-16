within Modelica.Mechanics.Translational.Components;
model Spring "Linear 1D translational spring"
  extends Translational.Interfaces.PartialCompliant;
  parameter SI.TranslationalSpringConstant c(final min=0, start=1)
    "Spring constant";
  parameter SI.Distance s_rel0=0 "Unstretched spring length";

equation
  f = c*(s_rel - s_rel0);
  annotation (
    Documentation(info="<html>
<p>
A <em>linear 1D translational spring</em>. The component can be connected either
between two sliding masses, or between
a sliding mass and the housing (model Fixed), to describe
a coupling of the sliding mass with the housing via a spring.
</p>

</html>"),
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Line(points={{-60,-90},{20,-90}}, color={95,127,95}),
        Polygon(
          points={{50,-90},{20,-80},{20,-100},{50,-90}},
          lineColor={95,127,95},
          fillColor={95,127,95},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-150,90},{150,50}},
          textString="%name",
          textColor={0,0,255}),
        Line(points={{-98,0},{-60,0},{-44,-30},{-16,30},{14,-30},{44,30},{
              60,0},{100,0}}, color={0,127,0}),
        Text(
          extent={{-150,-45},{150,-75}},
          textString="c=%c")}));
end Spring;
