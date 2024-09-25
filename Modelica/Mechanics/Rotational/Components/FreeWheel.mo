within Modelica.Mechanics.Rotational.Components;
model FreeWheel "Ideal freewheel"
  extends Modelica.Mechanics.Rotational.Interfaces.PartialCompliant;

  SI.AngularVelocity w_rel(start=0)
    "Relative angular velocity (= der(phi_rel))";
  Boolean free(start=false) "Indicates freewheeling";
  parameter SI.RotationalDampingConstant residualFriction=1e-5 "Residual friction coefficient (free = true)";
  parameter SI.RotationalDampingConstant torqueTransmission=1e5 "Torque transmission coefficient (free = false)";

protected
  Real s(start=0, final unit="1") "Auxilliary variable";
  constant SI.AngularVelocity unitAngularVelocity=1;
  constant SI.Torque unitTorque=1;

equation
  w_rel = der(phi_rel);
  free = w_rel >= 0;
  w_rel = s*unitTorque         *(if free then 1 else 1/torqueTransmission);
  tau   = s*unitAngularVelocity*(if free then residualFriction else 1);
  annotation (
    Icon(graphics={
        Rectangle(
          lineColor={64,64,64},
          fillColor={192,192,192},
          fillPattern=FillPattern.HorizontalCylinder,
          extent={{-100,-10},{-30,10}}),
        Rectangle(
          lineColor={64,64,64},
          fillColor={255,255,255},
          fillPattern=FillPattern.HorizontalCylinder,
          extent={{-30,-60},{-10,60}}),
        Rectangle(
          lineColor={64,64,64},
          fillColor={255,255,255},
          fillPattern=FillPattern.HorizontalCylinder,
          extent={{10,-60},{30,60}}),
        Rectangle(
          lineColor={64,64,64},
          fillColor={192,192,192},
          fillPattern=FillPattern.HorizontalCylinder,
          extent={{30,-10},{100,10}}),
        Rectangle(
          lineColor={64,64,64},
          extent={{-30,-60},{-10,60}}),
        Rectangle(
          lineColor={64,64,64},
          extent={{10,-60},{30,60}}),
        Polygon(
          points={{-10,30},{50,0},{-10,-30},{-10,30}},
          fillPattern=FillPattern.Solid),
        Text(extent={{-152,60},{148,100}},
          textString="%name",
          textColor={0,0,255})}),
    Documentation(info="<html>
<p>
An idealized model of a&nbsp;freewheel. Compared to
<a href=\"modelica://Modelica.Mechanics.Rotational.Components.OneWayClutch\">OneWayClutch</a>
it is modeled in a&nbsp;simplified way referring to
<a href=\"Modelica.Electrical.Analog.Ideal.IdealDiode\">an&nbsp;idealized
model of electrical diode</a>.
This means in particular that there exist two cases indicated
by the variable <code>free</code> and distinguished as follows.
</p>
<ul>
  <li>
    <code>free = false</code>: <code>flange_a</code> is driving <code>flange_b</code>;
    a residual slip (difference of angular velocities) between the two flanges
    is defined by the parameter <code>torqueTransmission</code> by the following equation:<br> 
    <code>tau = w_rel*torqueTransmission</code>.
  </li>
  <li>
    <code>free = true</code>: <code>flange_b</code> is driven such way 
    that it rotates (nearly) independent of <code>flange_a</code>;
    a residual friction torque between the two flanges
    is defined by the parameter <code>residualFriction</code> by the following equation:<br> 
    <code>tau = w_rel*residualFriction</code>.
  </li>
</ul>
</html>"));
end FreeWheel;
