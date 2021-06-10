within Modelica.Mechanics.Translational.Interfaces;
partial model PartialForce
  "Partial model of a force acting at the flange (accelerates the flange)"
  extends PartialElementaryOneFlangeAndSupport2;
  SI.Force f
    "Accelerating force acting at flange (= flange.f)";
equation
  f = flange.f;
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={Rectangle(
              extent={{-96,96},{96,-96}},
              lineColor={255,255,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),Line(points={{0,-60},{0,-100}}, color={0,127,0}),
                                                                             Text(
              extent={{-150,140},{150,100}},
              textColor={0,0,255},
              textString="%name"),Line(points={{-78,80},{51,80}}, color={95,127,95}),
          Polygon(
          points={{81,80},{51,90},{51,70},{81,80}},
          fillColor={95,127,95},
          fillPattern=FillPattern.Solid,
          lineColor={95,127,95}),            Line(points={{-52,-60},{77,-60}}, color={95,127,95}),
                                                                               Polygon(
          points={{-82,-60},{-51,-50},{-51,-70},{-82,-60}},
          fillColor={95,127,95},
          fillPattern=FillPattern.Solid,
          lineColor={95,127,95})}),             Documentation(info="<html>
<p>
Partial model of force that accelerates the flange.
</p>

<p>
If <em>useSupport=true</em>, the support connector is conditionally enabled
and needs to be connected.<br>
If <em>useSupport=false</em>, the support connector is conditionally disabled
and instead the component is internally fixed to ground.
</p>
</html>"));
end PartialForce;
