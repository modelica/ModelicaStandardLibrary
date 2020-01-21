within Modelica.Mechanics.Rotational.Components;
model IdealGearR2T
  "Gearbox transforming rotational into translational motion"
  extends Rotational.Interfaces.PartialElementaryRotationalToTranslational;
  parameter Real ratio(final unit="rad/m", start=1)
    "Transmission ratio (flange_a.phi/flange_b.s)";

equation
  (flangeR.phi - internalSupportR.phi) = ratio*(flangeT.s -
    internalSupportT.s);
  0 = ratio*flangeR.tau + flangeT.f;
  annotation (
    Documentation(info="<html>
<p>
This is an ideal mass- and inertialess gearbox which transforms a
1D-rotational into a 1D-translational motion. If elasticity, damping
or backlash has to be considered, this ideal gearbox has to be
connected with corresponding elements.
This component defines the kinematic constraint:
</p>

<blockquote><pre>
(flangeR.phi - internalSupportR.phi) = ratio*(flangeT.s - internalSupportT.s);
</pre></blockquote>
</html>"),
       Icon(
    coordinateSystem(preserveAspectRatio=true,
      extent={{-100.0,-100.0},{100.0,100.0}}),
      graphics={
    Rectangle(origin={133.3333,0.0},
      lineColor={64,64,64},
      fillColor={192,192,192},
      fillPattern=FillPattern.HorizontalCylinder,
      extent={{-233.3333,-10.0},{-163.3333,10.0}}),
    Text(textColor={0,0,255},
      extent={{-150.0,85.0},{150.0,125.0}},
      textString="%name"),
    Rectangle(
      fillColor={131,175,131},
      fillPattern=FillPattern.Solid,
      extent={{95.0,-60.0},{106.0,-10.0}}),
    Rectangle(
      fillColor={131,175,131},
      fillPattern=FillPattern.Solid,
      extent={{-74.411,-80},{106.589,-60}}),
    Text(extent={{-150.0,50.0},{150.0,80.0}},
      textString="ratio=%ratio"),
    Line(points={{-100,16},{-80,16}}),
    Line(points={{-100,-16},{-80,-16}}),
    Line(points={{-100.0,-16.0},{-100.0,-100.0}}),
    Line(points={{100,-80},{100,-100}}, color={0,127,0}),
    Polygon(
          origin={16.875,-50.0},
          fillColor={131,175,131},
          fillPattern=FillPattern.Solid,
          points={{-84.375,-10.0},{-79.375,10.0},{-69.375,10.0},{-64.375,-10.0},{-54.375,-10.0},{-49.375,10.0},{-39.375,10.0},{-34.375,-10.0},{-24.375,-10.0},{-19.375,10.0},{-9.375,10.0},{-4.375,-10.0},
              {5.625,-10.0},{10.625,10.0},{20.625,10.0},{25.625,-10.0},{35.625,-10.0},{40.625,10.0},{50.625,10.0},{55.625,-10.0},{65.625,-10.0},{70.625,10.0},{78.125,10.0},{78.125,-10.0}}),
    Polygon(origin={-20.0,-0.0},
      rotation=10.0,
      fillColor={255,255,255},
      fillPattern=FillPattern.Solid,
      points={{-5.0,45.0},{-10.0,10.0},{-45.0,5.0},{-45.0,-5.0},{-10.0,-10.0},{-5.0,-45.0},{5.0,-45.0},{10.0,-10.0},{45.0,-5.0},{45.0,5.0},{10.0,10.0},{5.0,45.0}}),
    Polygon(origin={-20.0,-0.0},
      rotation=55.0,
      fillColor={255,255,255},
      fillPattern=FillPattern.Solid,
      points={{-5.0,45.0},{-10.0,10.0},{-45.0,5.0},{-45.0,-5.0},{-10.0,-10.0},{-5.0,-45.0},{5.0,-45.0},{10.0,-10.0},{45.0,-5.0},{45.0,5.0},{10.0,10.0},{5.0,45.0}}),
    Ellipse(origin={-20.0,-0.0},
      fillColor={255,255,255},
      fillPattern=FillPattern.Solid,
      extent={{-30.0,-30.0},{30.0,30.0}}),
    Ellipse(origin={-20.0,-0.0},
      fillColor={128,128,128},
      fillPattern=FillPattern.Solid,
      extent={{-10.0,-10.0},{10.0,10.0}})}));
end IdealGearR2T;
