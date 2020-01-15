within Modelica.Mechanics.Translational.Components;
model Rod "Rod without inertia"
  extends Translational.Interfaces.PartialRigid;

equation
  0 = flange_a.f + flange_b.f;
  annotation (
    Documentation(info="<html>
<p>
A translational rod <strong>without inertia</strong> and two rigidly connected flanges.
</p>
</html>"),
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={Line(points={{-100,0},{100,0}}, color={0,127,0}),
                                                        Polygon(
          points={{50,-90},{20,-80},{20,-100},{50,-90}},
          lineColor={95,127,95},
          fillColor={95,127,95},
          fillPattern=FillPattern.Solid),    Line(points={{-60,-90},{20,-90}}, color={95,127,95}),
                                                                               Rectangle(
          extent={{-60,10},{60,-10}},
          lineColor={0,127,0},
          fillColor={160,215,160},
          fillPattern=FillPattern.Solid),    Text(
              extent={{-150,80},{150,40}},
              textString="%name",
              textColor={0,0,255}),Text(
              extent={{-150,-30},{150,-60}},
              textString="L=%L")}),
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {100,100}}), graphics={Line(points={{-100,0},{-55,0}}, color={0,127,0}),
          Line(points={{54,0},{100,0}}, color={0,127,0}),Polygon(
              points={{50,-90},{20,-80},{20,-100},{50,-90}},
              lineColor={128,128,128},
              fillColor={128,128,128},
              fillPattern=FillPattern.Solid),Line(points={{-60,-90},{20,-90}}),Rectangle(
              extent={{-55,3},{53,-4}},
              lineColor={160,160,164},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(points={{-100,-29},{-100,
          -61}}),Line(points={{100,-61},{100,-28}}),
          Line(points={{-98,-60},{98,-60}}),Polygon(
              points={{-101,-60},{-96,-59},{-96,-61},{-101,-60}},
              fillPattern=FillPattern.Solid),Polygon(
              points={{100,-60},{95,-61},{95,-59},{100,-60}},
              fillPattern=FillPattern.Solid),Text(
              extent={{-44,-41},{51,-57}},
              textString="Length L",
              textColor={0,0,255})}));
end Rod;
