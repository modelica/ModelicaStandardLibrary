within Modelica.Mechanics.Translational.Components;
model Mass "Sliding mass with inertia"
  parameter SI.Mass m(min=0, start=1) "Mass of the sliding mass";
  parameter StateSelect stateSelect=StateSelect.default
    "Priority to use s and v as states" annotation (Dialog(tab="Advanced"));
  extends Translational.Interfaces.PartialRigid(L=0, s(start=0, stateSelect=
          stateSelect));
  SI.Velocity v(start=0, stateSelect=stateSelect)
    "Absolute velocity of component";
  SI.Acceleration a(start=0) "Absolute acceleration of component";

equation
  v = der(s);
  a = der(v);
  m*a = flange_a.f + flange_b.f;
  annotation (
    Documentation(info="<html>
<p>
Sliding mass with <em>inertia, without friction</em> and two rigidly connected flanges.
</p>
<p>
The sliding mass has the length L, the position coordinate s is in the middle.
Sign convention: A positive force at flange flange_a moves the sliding mass in the positive direction.
A negative force at flange flange_a moves the sliding mass to the negative direction.
</p>

</html>"),
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Line(points={{-100,0},{100,0}}, color={0,127,0}),
        Rectangle(
          extent={{-55,-30},{56,30}},
          fillPattern=FillPattern.Sphere,
          fillColor={160,215,160},
          lineColor={0,127,0}),
        Polygon(
          points={{50,-90},{20,-80},{20,-100},{50,-90}},
          lineColor={95,127,95},
          fillColor={95,127,95},
          fillPattern=FillPattern.Solid),
        Line(points={{-60,-90},{20,-90}}, color={95,127,95}),
        Text(
          extent={{-150,85},{150,45}},
          textString="%name",
          textColor={0,0,255},
          fillColor={110,210,110},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-150,-45},{150,-75}},
          textString="m=%m",
          fillColor={110,221,110},
          fillPattern=FillPattern.Solid,
          fontSize=0)}),
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {100,100}}), graphics={Line(points={{-100,0},{-55,0}}, color={0,127,0}),
          Line(points={{55,0},{100,0}}, color={0,127,0}),Rectangle(
              extent={{-55,-30},{55,30}},
              fillPattern=FillPattern.Sphere,
              fillColor={255,255,255}),Polygon(
              points={{50,-90},{20,-80},{20,-100},{50,-90}},
              lineColor={128,128,128},
              fillColor={128,128,128},
              fillPattern=FillPattern.Solid),Line(points={{-60,-90},{20,-90}}),Line(points={{-100,-29},{-100,-61}}),
          Line(points={{100,-61},{100,-28}}),Line(points={{-98,
          -60},{98,-60}}),Polygon(
              points={{-101,-60},{-96,-59},{-96,-61},{-101,-60}},
              fillPattern=FillPattern.Solid),Polygon(
              points={{100,-60},{95,-61},{95,-59},{100,-60}},
              fillPattern=FillPattern.Solid),Text(
              extent={{-44,-41},{51,-57}},
              textString="Length L",
              textColor={0,0,255}),Line(points={{0,30},{0,53}}),
          Line(points={{-72,40},{1,40}}),Polygon(
              points={{-7,42},{-7,38},{-1,40},{-7,42}},
              fillPattern=FillPattern.Solid),Text(
              extent={{-61,53},{-9,42}},
              textString="Position s",
              textColor={0,0,255})}));
end Mass;
