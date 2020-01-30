within Modelica.Mechanics.Rotational.Components;
model IdealRollingWheel
  "Simple 1-dim. model of an ideal rolling wheel without inertia"

  extends Rotational.Interfaces.PartialElementaryRotationalToTranslational;
  parameter SI.Distance radius(start=0.3) "Wheel radius";

equation
  (flangeR.phi - internalSupportR.phi)*radius = (flangeT.s -
    internalSupportT.s);
  0 = radius*flangeT.f + flangeR.tau;
  annotation (
    Icon(
      coordinateSystem(preserveAspectRatio=true,
        extent={{-100.0,-100.0},{100.0,100.0}}),
        graphics={
      Rectangle(  lineColor={64,64,64},
        fillColor={192,192,192},
        fillPattern=FillPattern.HorizontalCylinder,
        extent={{-100.0,-10.0},{-46.0,10.0}}),
      Ellipse(  lineColor={64,64,64},
        fillColor={255,255,255},
        fillPattern=FillPattern.HorizontalCylinder,
        extent={{-50.0,-80.0},{10.0,80.0}}),
      Rectangle(  lineColor={64,64,64},
        fillColor={255,255,255},
        pattern=LinePattern.None,
        fillPattern=FillPattern.HorizontalCylinder,
        extent={{-20.0,-80.0},{12.0,80.0}}),
      Ellipse(  lineColor={64,64,64},
        fillColor={128,128,128},
        fillPattern=FillPattern.Solid,
        extent={{-16.0,-80.0},{44.0,80.0}}),
      Ellipse(  lineColor={192,192,192},
        fillColor={192,192,192},
        fillPattern=FillPattern.Solid,
        extent={{-2.0,-52.0},{34.0,52.0}}),
      Ellipse(  lineColor={64,64,64},
        fillColor={192,192,192},
        fillPattern=FillPattern.HorizontalCylinder,
        extent={{12.0,-10.0},{20.0,10.0}}),
      Rectangle(  lineColor={64,64,64},
        fillColor={192,192,192},
        pattern=LinePattern.None,
        fillPattern=FillPattern.HorizontalCylinder,
        extent={{16.0,-10.0},{60.0,10.0}}),
      Ellipse(  fillColor={192,192,192},
        fillPattern=FillPattern.Solid,
        extent={{56.0,-10.0},{64.0,10.0}}),
      Text(  textColor={0,0,255},
        extent={{-150.0,90.0},{150.0,130.0}},
        textString="%name"),
      Polygon(  lineColor={0,127,0},
        fillColor={0,127,0},
        fillPattern=FillPattern.Solid,
        points={{80.0,10.0},{80.0,26.0},{60.0,26.0},{60.0,20.0},{70.0,20.0},{70.0,-20.0},{60.0,-20.0},{60.0,-26.0},{80.0,-26.0},{80.0,-10.0},{90.0,-10.0},{90.0,10.0},{80.0,10.0}}),
      Line(  points={{-100.0,-20.0},{-60.0,-20.0}}),
      Line(  points={{-100.0,-20.0},{-100.0,-100.0}}),
      Line(  points={{-100.0,20.0},{-60.0,20.0}}),
      Line(  points={{100.0,-90.0},{-40.0,-90.0}},
        color={0,127,0}),
      Line(  points={{70.0,-26.0},{70.0,-50.0},{100.0,-50.0},{100.0,-100.0}},
        color={0,127,0}),
      Line(  origin={-2.5,80.0},
        points={{-17.5,0.0},{17.5,0.0}},
        color={64,64,64}),
      Line(  origin={-2.5,-80.0},
        points={{-17.5,0.0},{17.5,0.0}},
        color={64,64,64}),
      Line(  origin={38.0,10.0},
        points={{-22.0,0.0},{22.0,0.0}},
        color={64,64,64}),
      Line(  origin={38.0,-10.0},
        points={{-22.0,0.0},{22.0,0.0}},
        color={64,64,64}),
      Text(  extent={{-150,-120},{150,-150}},
          textString="radius=%radius")}),
                             Documentation(info="<html>
<p>
A simple kinematic model of a rolling wheel which has no inertia and
no rolling resistance. This component defines the kinematic constraint:
</p>

<blockquote><pre>
(flangeR.phi - internalSupportR.phi) * radius = (flangeT.s - internalSupportT.s);
</pre></blockquote>
</html>"));
end IdealRollingWheel;
