within Modelica.Mechanics.Rotational.Interfaces;
partial model PartialTorque
  "Partial model of a torque acting at the flange (accelerates the flange)"
  extends Modelica.Mechanics.Rotational.Interfaces.PartialElementaryOneFlangeAndSupport2;
  SI.Angle phi
    "Angle of flange with respect to support (= flange.phi - support.phi)";

equation
  phi = flange.phi - phi_support;
  annotation (
    Icon(
      coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
      graphics={
        Rectangle(
          extent={{-80,64},{80,-56}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-100,-100},{100,100}},
          lineColor={0,0,0},
          startAngle=40,
          endAngle=150,
          closure=EllipseClosure.None,
          origin={0,0}),
        Polygon(
          points={{90,50},{66,100},{40,74},{90,50}},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-60,-60},{60,60}},
          lineColor={0,0,0},
          startAngle=40,
          endAngle=140,
          closure=EllipseClosure.None,
          origin={0,-120}),
        Line(
          points={{0,-60},{0,-100}}),
        Text(
          extent={{-150,150},{150,110}},
          textColor={0,0,255},
          textString="%name"),
        Polygon(
          points={{-54,-94},{-30,-78},{-44,-66},{-54,-94}},
          fillPattern=FillPattern.Solid),
        Line(
          visible=not useSupport,
          points={{-50,-120},{-30,-100}}),
        Line(
          visible=not useSupport,
          points={{-30,-120},{-10,-100}}),
        Line(
          visible=not useSupport,
          points={{-10,-120},{10,-100}}),
        Line(
          visible=not useSupport,
          points={{10,-120},{30,-100}}),
        Line(
          visible=not useSupport,
          points={{-30,-100},{30,-100}})}),
    Documentation(info="<html>
<p>
Partial model of torque that accelerates the flange.
</p>

<p>
If <em>useSupport=true</em>, the support connector is conditionally enabled
and needs to be connected.<br>
If <em>useSupport=false</em>, the support connector is conditionally disabled
and instead the component is internally fixed to ground.
</p>
</html>"));
end PartialTorque;
